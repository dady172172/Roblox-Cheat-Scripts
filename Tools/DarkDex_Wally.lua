local EmbeddedModules = {
["Explorer"] = function()
--[[
	Explorer App Module
	
	The main explorer interface
]]

-- Common Locals
local Main,Lib,Apps,Settings -- Main Containers
local Explorer, Properties, ScriptViewer, Notebook -- Major Apps
local API,RMD,env,service,plr,create,createSimple -- Main Locals

local function initDeps(data)
	Main = data.Main
	Lib = data.Lib
	Apps = data.Apps
	Settings = data.Settings

	API = data.API
	RMD = data.RMD
	env = data.env
	service = data.service
	plr = data.plr
	create = data.create
	createSimple = data.createSimple
end

local function initAfterMain()
	Explorer = Apps.Explorer
	Properties = Apps.Properties
	ScriptViewer = Apps.ScriptViewer
	Notebook = Apps.Notebook
end

local function main()
	local Explorer = {}
	local nodes,tree,listEntries,explorerOrders,searchResults,specResults = {},{},{},{},{},{}
	local expanded
	local entryTemplate,treeFrame,toolBar,descendantAddedCon,descendantRemovingCon,itemChangedCon
	local ffa = game.FindFirstAncestorWhichIsA
	local getDescendants = game.GetDescendants
	local getTextSize = service.TextService.GetTextSize
	local updateDebounce,refreshDebounce = false,false
	local nilNode = {Obj = Instance.new("Folder")}
	local idCounter = 0
	local scrollV,scrollH,selection,clipboard
	local renameBox,renamingNode,searchFunc
	local sortingEnabled,autoUpdateSearch
	local table,math = table,math
	local nilMap,nilCons = {},{}
	local connectSignal = game.DescendantAdded.Connect
	local addObject,removeObject,moveObject = nil,nil,nil

	addObject = function(root)
		if nodes[root] then return end

		local isNil = false
		local rootParObj = ffa(root,"Instance")
		local par = nodes[rootParObj]

		-- Nil Handling
		if not par then
			if nilMap[root] then
				nilCons[root] = nilCons[root] or {
					connectSignal(root.ChildAdded,addObject),
					connectSignal(root.AncestryChanged,moveObject),
				}
				par = nilNode
				isNil = true
			else
				return
			end
		elseif nilMap[rootParObj] or par == nilNode then
			nilMap[root] = true
			nilCons[root] = nilCons[root] or {
				connectSignal(root.ChildAdded,addObject),
				connectSignal(root.AncestryChanged,moveObject),
			}
			isNil = true
		end

		local newNode = {Obj = root, Parent = par}
		nodes[root] = newNode

		-- Automatic sorting if expanded
		if sortingEnabled and expanded[par] and par.Sorted then
			local left,right = 1,#par
			local floor = math.floor
			local sorter = Explorer.NodeSorter
			local pos = (right == 0 and 1)

			if not pos then
				while true do
					if left >= right then
						if sorter(newNode,par[left]) then
							pos = left
						else
							pos = left+1
						end
						break
					end

					local mid = floor((left+right)/2)
					if sorter(newNode,par[mid]) then
						right = mid-1
					else
						left = mid+1
					end
				end
			end

			table.insert(par,pos,newNode)
		else
			par[#par+1] = newNode
			par.Sorted = nil
		end

		local insts = getDescendants(root)
		for i = 1,#insts do
			local obj = insts[i]
			if nodes[obj] then continue end -- Deferred
			
			local par = nodes[ffa(obj,"Instance")]
			if not par then continue end
			local newNode = {Obj = obj, Parent = par}
			nodes[obj] = newNode
			par[#par+1] = newNode

			-- Nil Handling
			if isNil then
				nilMap[obj] = true
				nilCons[obj] = nilCons[obj] or {
					connectSignal(obj.ChildAdded,addObject),
					connectSignal(obj.AncestryChanged,moveObject),
				}
			end
		end

		if searchFunc and autoUpdateSearch then
			searchFunc({newNode})
		end

		if not updateDebounce and Explorer.IsNodeVisible(par) then
			if expanded[par] then
				Explorer.PerformUpdate()
			elseif not refreshDebounce then
				Explorer.PerformRefresh()
			end
		end
	end

	removeObject = function(root)
		local node = nodes[root]
		if not node then return end

		-- Nil Handling
		if nilMap[node.Obj] then
			moveObject(node.Obj)
			return
		end

		local par = node.Parent
		if par then
			par.HasDel = true
		end

		local function recur(root)
			for i = 1,#root do
				local node = root[i]
				if not node.Del then
					nodes[node.Obj] = nil
					if #node > 0 then recur(node) end
				end
			end
		end
		recur(node)
		node.Del = true
		nodes[root] = nil

		if par and not updateDebounce and Explorer.IsNodeVisible(par) then
			if expanded[par] then
				Explorer.PerformUpdate()
			elseif not refreshDebounce then
				Explorer.PerformRefresh()
			end
		end
	end

	moveObject = function(obj)
		local node = nodes[obj]
		if not node then return end

		local oldPar = node.Parent
		local newPar = nodes[ffa(obj,"Instance")]
		if oldPar == newPar then return end

		-- Nil Handling
		if not newPar then
			if nilMap[obj] then
				newPar = nilNode
			else
				return
			end
		elseif nilMap[newPar.Obj] or newPar == nilNode then
			nilMap[obj] = true
			nilCons[obj] = nilCons[obj] or {
				connectSignal(obj.ChildAdded,addObject),
				connectSignal(obj.AncestryChanged,moveObject),
			}
		end

		if oldPar then
			local parPos = table.find(oldPar,node)
			if parPos then table.remove(oldPar,parPos) end
		end

		node.Id = nil
		node.Parent = newPar

		if sortingEnabled and expanded[newPar] and newPar.Sorted then
			local left,right = 1,#newPar
			local floor = math.floor
			local sorter = Explorer.NodeSorter
			local pos = (right == 0 and 1)

			if not pos then
				while true do
					if left >= right then
						if sorter(node,newPar[left]) then
							pos = left
						else
							pos = left+1
						end
						break
					end

					local mid = floor((left+right)/2)
					if sorter(node,newPar[mid]) then
						right = mid-1
					else
						left = mid+1
					end
				end
			end

			table.insert(newPar,pos,node)
		else
			newPar[#newPar+1] = node
			newPar.Sorted = nil
		end

		if searchFunc and searchResults[node] then
			local currentNode = node.Parent
			while currentNode and (not searchResults[currentNode] or expanded[currentNode] == 0) do
				expanded[currentNode] = true
				searchResults[currentNode] = true
				currentNode = currentNode.Parent
			end
		end

		if not updateDebounce and (Explorer.IsNodeVisible(newPar) or Explorer.IsNodeVisible(oldPar)) then
			if expanded[newPar] or expanded[oldPar] then
				Explorer.PerformUpdate()
			elseif not refreshDebounce then
				Explorer.PerformRefresh()
			end
		end
	end

	Explorer.ViewWidth = 0
	Explorer.Index = 0
	Explorer.EntryIndent = 20
	Explorer.FreeWidth = 32
	Explorer.GuiElems = {}

	Explorer.InitRenameBox = function()
		renameBox = create({{1,"TextBox",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderColor3=Color3.new(0.062745101749897,0.51764708757401,1),BorderMode=2,ClearTextOnFocus=false,Font=3,Name="RenameBox",PlaceholderColor3=Color3.new(0.69803923368454,0.69803923368454,0.69803923368454),Position=UDim2.new(0,26,0,2),Size=UDim2.new(0,200,0,16),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=0,Visible=false,ZIndex=2}}})

		renameBox.Parent = Explorer.Window.GuiElems.Content.List

		renameBox.FocusLost:Connect(function()
			if not renamingNode then return end

			pcall(function() renamingNode.Obj.Name = renameBox.Text end)
			renamingNode = nil
			Explorer.Refresh()
		end)

		renameBox.Focused:Connect(function()
			renameBox.SelectionStart = 1
			renameBox.CursorPosition = #renameBox.Text + 1
		end)
	end

	Explorer.SetRenamingNode = function(node)
		renamingNode = node
		renameBox.Text = tostring(node.Obj)
		renameBox:CaptureFocus()
		Explorer.Refresh()
	end

	Explorer.SetSortingEnabled = function(val)
		sortingEnabled = val
		Settings.Explorer.Sorting = val
	end

	Explorer.UpdateView = function()
		local maxNodes = math.ceil(treeFrame.AbsoluteSize.Y / 20)
		local maxX = treeFrame.AbsoluteSize.X
		local totalWidth = Explorer.ViewWidth + Explorer.FreeWidth

		scrollV.VisibleSpace = maxNodes
		scrollV.TotalSpace = #tree + 1
		scrollH.VisibleSpace = maxX
		scrollH.TotalSpace = totalWidth

		scrollV.Gui.Visible = #tree + 1 > maxNodes
		scrollH.Gui.Visible = totalWidth > maxX

		local oldSize = treeFrame.Size
		treeFrame.Size = UDim2.new(1,(scrollV.Gui.Visible and -16 or 0),1,(scrollH.Gui.Visible and -39 or -23))
		if oldSize ~= treeFrame.Size then
			Explorer.UpdateView()
		else
			scrollV:Update()
			scrollH:Update()

			renameBox.Size = UDim2.new(0,maxX-100,0,16)

			if scrollV.Gui.Visible and scrollH.Gui.Visible then
				scrollV.Gui.Size = UDim2.new(0,16,1,-39)
				scrollH.Gui.Size = UDim2.new(1,-16,0,16)
				Explorer.Window.GuiElems.Content.ScrollCorner.Visible = true
			else
				scrollV.Gui.Size = UDim2.new(0,16,1,-23)
				scrollH.Gui.Size = UDim2.new(1,0,0,16)
				Explorer.Window.GuiElems.Content.ScrollCorner.Visible = false
			end

			Explorer.Index = scrollV.Index
		end
	end

	Explorer.NodeSorter = function(a,b)
		if a.Del or b.Del then return false end -- Ghost node

		local aClass = a.Class
		local bClass = b.Class
		if not aClass then aClass = a.Obj.ClassName a.Class = aClass end
		if not bClass then bClass = b.Obj.ClassName b.Class = bClass end

		local aOrder = explorerOrders[aClass]
		local bOrder = explorerOrders[bClass]
		if not aOrder then aOrder = RMD.Classes[aClass] and tonumber(RMD.Classes[aClass].ExplorerOrder) or 9999 explorerOrders[aClass] = aOrder end
		if not bOrder then bOrder = RMD.Classes[bClass] and tonumber(RMD.Classes[bClass].ExplorerOrder) or 9999 explorerOrders[bClass] = bOrder end

		if aOrder ~= bOrder then
			return aOrder < bOrder
		else
			local aName,bName = tostring(a.Obj),tostring(b.Obj)
			if aName ~= bName then
				return aName < bName
			elseif aClass ~= bClass then
				return aClass < bClass
			else
				local aId = a.Id if not aId then aId = idCounter idCounter = (idCounter+0.001)%999999999 a.Id = aId end
				local bId = b.Id if not bId then bId = idCounter idCounter = (idCounter+0.001)%999999999 b.Id = bId end
				return aId < bId
			end
		end
	end

	Explorer.Update = function()
		table.clear(tree)
		local maxNameWidth,maxDepth,count = 0,1,1
		local nameCache = {}
		local font = Enum.Font.SourceSans
		local size = Vector2.new(math.huge,20)
		local useNameWidth = Settings.Explorer.UseNameWidth
		local tSort = table.sort
		local sortFunc = Explorer.NodeSorter
		local isSearching = (expanded == Explorer.SearchExpanded)
		local textServ = service.TextService

		local function recur(root,depth)
			if depth > maxDepth then maxDepth = depth end
			depth = depth + 1
			if sortingEnabled and not root.Sorted then
				tSort(root,sortFunc)
				root.Sorted = true
			end
			for i = 1,#root do
				local n = root[i]

				if (isSearching and not searchResults[n]) or n.Del then continue end

				if useNameWidth then
					local nameWidth = n.NameWidth
					if not nameWidth then
						local objName = tostring(n.Obj)
						nameWidth = nameCache[objName]
						if not nameWidth then
							nameWidth = getTextSize(textServ,objName,14,font,size).X
							nameCache[objName] = nameWidth
						end
						n.NameWidth = nameWidth
					end
					if nameWidth > maxNameWidth then
						maxNameWidth = nameWidth
					end
				end

				tree[count] = n
				count = count + 1
				if expanded[n] and #n > 0 then
					recur(n,depth)
				end
			end
		end

		recur(nodes[game],1)

		-- Nil Instances
		if env.getnilinstances then
			if not (isSearching and not searchResults[nilNode]) then
				tree[count] = nilNode
				count = count + 1
				if expanded[nilNode] then
					recur(nilNode,2)
				end
			end
		end

		Explorer.MaxNameWidth = maxNameWidth
		Explorer.MaxDepth = maxDepth
		Explorer.ViewWidth = useNameWidth and Explorer.EntryIndent*maxDepth + maxNameWidth + 26 or Explorer.EntryIndent*maxDepth + 226
		Explorer.UpdateView()
	end

	Explorer.StartDrag = function(offX,offY)
		if Explorer.Dragging then return end
		Explorer.Dragging = true

		local dragTree = treeFrame:Clone()
		dragTree:ClearAllChildren()

		for i,v in pairs(listEntries) do
			local node = tree[i + Explorer.Index]
			if node and selection.Map[node] then
				local clone = v:Clone()
				clone.Active = false
				clone.Indent.Expand.Visible = false
				clone.Parent = dragTree
			end
		end

		local newGui = Instance.new("ScreenGui")
		newGui.DisplayOrder = Main.DisplayOrders.Menu
		dragTree.Parent = newGui
		Lib.ShowGui(newGui)

		local dragOutline = create({
			{1,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name="DragSelect",Size=UDim2.new(1,0,1,0),}},
			{2,"Frame",{BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Name="Line",Parent={1},Size=UDim2.new(1,0,0,1),ZIndex=2,}},
			{3,"Frame",{BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Name="Line",Parent={1},Position=UDim2.new(0,0,1,-1),Size=UDim2.new(1,0,0,1),ZIndex=2,}},
			{4,"Frame",{BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Name="Line",Parent={1},Size=UDim2.new(0,1,1,0),ZIndex=2,}},
			{5,"Frame",{BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Name="Line",Parent={1},Position=UDim2.new(1,-1,0,0),Size=UDim2.new(0,1,1,0),ZIndex=2,}},
		})
		dragOutline.Parent = treeFrame


		local mouse = Main.Mouse or service.Players.LocalPlayer:GetMouse()
		local function move()
			local posX = mouse.X - offX
			local posY = mouse.Y - offY
			dragTree.Position = UDim2.new(0,posX,0,posY)

			for i = 1,#listEntries do
				local entry = listEntries[i]
				if Lib.CheckMouseInGui(entry) then
					dragOutline.Position = UDim2.new(0,entry.Indent.Position.X.Offset-scrollH.Index,0,entry.Position.Y.Offset)
					dragOutline.Size = UDim2.new(0,entry.Size.X.Offset-entry.Indent.Position.X.Offset,0,20)
					dragOutline.Visible = true
					return
				end
			end
			dragOutline.Visible = false
		end
		move()

		local input = service.UserInputService
		local mouseEvent,releaseEvent

		mouseEvent = input.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				move()
			end
		end)

		releaseEvent = input.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				releaseEvent:Disconnect()
				mouseEvent:Disconnect()
				newGui:Destroy()
				dragOutline:Destroy()
				Explorer.Dragging = false

				for i = 1,#listEntries do
					if Lib.CheckMouseInGui(listEntries[i]) then
						local node = tree[i + Explorer.Index]
						if node then
							if selection.Map[node] then return end
							local newPar = node.Obj
							local sList = selection.List
							for i = 1,#sList do
								local n = sList[i]
								pcall(function() n.Obj.Parent = newPar end)
							end
							Explorer.ViewNode(sList[1])
						end
						break
					end
				end
			end
		end)
	end

	Explorer.NewListEntry = function(index)
		local newEntry = entryTemplate:Clone()
		newEntry.Position = UDim2.new(0,0,0,20*(index-1))

		local isRenaming = false

		newEntry.InputBegan:Connect(function(input)
			local node = tree[index + Explorer.Index]
			if not node or selection.Map[node] or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

			newEntry.Indent.BackgroundColor3 = Settings.Theme.Button
			newEntry.Indent.BorderSizePixel = 0
			newEntry.Indent.BackgroundTransparency = 0
		end)

		newEntry.InputEnded:Connect(function(input)
			local node = tree[index + Explorer.Index]
			if not node or selection.Map[node] or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

			newEntry.Indent.BackgroundTransparency = 1
		end)

		newEntry.MouseButton1Down:Connect(function()

		end)

		newEntry.MouseButton1Up:Connect(function()

		end)

		newEntry.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				local releaseEvent,mouseEvent

				local mouse = Main.Mouse or plr:GetMouse()
				local startX = mouse.X
				local startY = mouse.Y

				local listOffsetX = startX - treeFrame.AbsolutePosition.X
				local listOffsetY = startY - treeFrame.AbsolutePosition.Y

				releaseEvent = game:GetService("UserInputService").InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						releaseEvent:Disconnect()
						mouseEvent:Disconnect()
					end
				end)

				mouseEvent = game:GetService("UserInputService").InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						local deltaX = mouse.X - startX
						local deltaY = mouse.Y - startY
						local dist = math.sqrt(deltaX^2 + deltaY^2)

						if dist > 5 then
							releaseEvent:Disconnect()
							mouseEvent:Disconnect()
							isRenaming = false
							Explorer.StartDrag(listOffsetX,listOffsetY)
						end
					end
				end)
			end
		end)

		newEntry.MouseButton2Down:Connect(function()

		end)

		newEntry.Indent.Expand.InputBegan:Connect(function(input)
			local node = tree[index + Explorer.Index]
			if not node or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

			Explorer.MiscIcons:DisplayByKey(newEntry.Indent.Expand.Icon, expanded[node] and "Collapse_Over" or "Expand_Over")
		end)

		newEntry.Indent.Expand.InputEnded:Connect(function(input)
			local node = tree[index + Explorer.Index]
			if not node or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

			Explorer.MiscIcons:DisplayByKey(newEntry.Indent.Expand.Icon, expanded[node] and "Collapse" or "Expand")
		end)

		newEntry.Indent.Expand.MouseButton1Down:Connect(function()
			local node = tree[index + Explorer.Index]
			if not node or #node == 0 then return end

			expanded[node] = not expanded[node]
			Explorer.Update()
			Explorer.Refresh()
		end)

		newEntry.Parent = treeFrame
		return newEntry
	end

	Explorer.Refresh = function()
		local maxNodes = math.max(math.ceil((treeFrame.AbsoluteSize.Y) / 20),0)	
		local renameNodeVisible = false
		local isa = game.IsA

		for i = 1,maxNodes do
			local entry = listEntries[i]
			if not listEntries[i] then entry = Explorer.NewListEntry(i) listEntries[i] = entry Explorer.ClickSystem:Add(entry) end

			local node = tree[i + Explorer.Index]
			if node then
				local obj = node.Obj
				local depth = Explorer.EntryIndent*Explorer.NodeDepth(node)

				entry.Visible = true
				entry.Position = UDim2.new(0,-scrollH.Index,0,entry.Position.Y.Offset)
				entry.Size = UDim2.new(0,Explorer.ViewWidth,0,20)
				entry.Indent.EntryName.Text = tostring(node.Obj)
				entry.Indent.Position = UDim2.new(0,depth,0,0)
				entry.Indent.Size = UDim2.new(1,-depth,1,0)

				entry.Indent.EntryName.TextTruncate = (Settings.Explorer.UseNameWidth and Enum.TextTruncate.None or Enum.TextTruncate.AtEnd)

				if (isa(obj,"LocalScript") or isa(obj,"Script")) and obj.Disabled then
					Explorer.MiscIcons:DisplayByKey(entry.Indent.Icon, isa(obj,"LocalScript") and "LocalScript_Disabled" or "Script_Disabled")
				else
					local rmdEntry = RMD.Classes[obj.ClassName]
					Explorer.ClassIcons:Display(entry.Indent.Icon, rmdEntry and rmdEntry.ExplorerImageIndex or 0)
				end

				if selection.Map[node] then
					entry.Indent.BackgroundColor3 = Settings.Theme.ListSelection
					entry.Indent.BorderSizePixel = 0
					entry.Indent.BackgroundTransparency = 0
				else
					if Lib.CheckMouseInGui(entry) then
						entry.Indent.BackgroundColor3 = Settings.Theme.Button
					else
						entry.Indent.BackgroundTransparency = 1
					end
				end

				if node == renamingNode then
					renameNodeVisible = true
					renameBox.Position = UDim2.new(0,depth+25-scrollH.Index,0,entry.Position.Y.Offset+2)
					renameBox.Visible = true
				end

				if #node > 0 and expanded[node] ~= 0 then
					if Lib.CheckMouseInGui(entry.Indent.Expand) then
						Explorer.MiscIcons:DisplayByKey(entry.Indent.Expand.Icon, expanded[node] and "Collapse_Over" or "Expand_Over")
					else
						Explorer.MiscIcons:DisplayByKey(entry.Indent.Expand.Icon, expanded[node] and "Collapse" or "Expand")
					end
					entry.Indent.Expand.Visible = true
				else
					entry.Indent.Expand.Visible = false
				end
			else
				entry.Visible = false
			end
		end

		if not renameNodeVisible then
			renameBox.Visible = false
		end

		for i = maxNodes+1, #listEntries do
			Explorer.ClickSystem:Remove(listEntries[i])
			listEntries[i]:Destroy()
			listEntries[i] = nil
		end
	end

	Explorer.PerformUpdate = function(instant)
		updateDebounce = true
		Lib.FastWait(not instant and 0.1)
		if not updateDebounce then return end
		updateDebounce = false
		if not Explorer.Window:IsVisible() then return end
		Explorer.Update()
		Explorer.Refresh()
	end

	Explorer.ForceUpdate = function(norefresh)
		updateDebounce = false
		Explorer.Update()
		if not norefresh then Explorer.Refresh() end
	end

	Explorer.PerformRefresh = function()
		refreshDebounce = true
		Lib.FastWait(0.1)
		refreshDebounce = false
		if updateDebounce or not Explorer.Window:IsVisible() then return end
		Explorer.Refresh()
	end

	Explorer.IsNodeVisible = function(node)
		if not node then return end

		local curNode = node.Parent
		while curNode do
			if not expanded[curNode] then return false end
			curNode = curNode.Parent
		end
		return true
	end

	Explorer.NodeDepth = function(node)
		local depth = 0

		if node == nilNode then
			return 1
		end

		local curNode = node.Parent
		while curNode do
			if curNode == nilNode then depth = depth + 1 end
			curNode = curNode.Parent
			depth = depth + 1
		end
		return depth
	end

	Explorer.SetupConnections = function()
		if descendantAddedCon then descendantAddedCon:Disconnect() end
		if descendantRemovingCon then descendantRemovingCon:Disconnect() end
		if itemChangedCon then itemChangedCon:Disconnect() end

		if Main.Elevated then
			descendantAddedCon = game.DescendantAdded:Connect(addObject)
			descendantRemovingCon = game.DescendantRemoving:Connect(removeObject)
		else
			descendantAddedCon = game.DescendantAdded:Connect(function(obj) pcall(addObject,obj) end)
			descendantRemovingCon = game.DescendantRemoving:Connect(function(obj) pcall(removeObject,obj) end)
		end

		if Settings.Explorer.UseNameWidth then
			itemChangedCon = game.ItemChanged:Connect(function(obj,prop)
				if prop == "Parent" and nodes[obj] then
					moveObject(obj)
				elseif prop == "Name" and nodes[obj] then
					nodes[obj].NameWidth = nil
				end
			end)
		else
			itemChangedCon = game.ItemChanged:Connect(function(obj,prop)
				if prop == "Parent" and nodes[obj] then
					moveObject(obj)
				end
			end)
		end
	end

	Explorer.ViewNode = function(node)
		if not node then return end

		Explorer.MakeNodeVisible(node)
		Explorer.ForceUpdate(true)
		local visibleSpace = scrollV.VisibleSpace

		for i,v in next,tree do
			if v == node then
				local relative = i - 1
				if Explorer.Index > relative then
					scrollV.Index = relative
				elseif Explorer.Index + visibleSpace - 1 <= relative then
					scrollV.Index = relative - visibleSpace + 2
				end
			end
		end

		scrollV:Update() Explorer.Index = scrollV.Index
		Explorer.Refresh()
	end

	Explorer.ViewObj = function(obj)
		Explorer.ViewNode(nodes[obj])
	end

	Explorer.MakeNodeVisible = function(node,expandRoot)
		if not node then return end

		local hasExpanded = false

		if expandRoot and not expanded[node] then
			expanded[node] = true
			hasExpanded = true
		end

		local currentNode = node.Parent
		while currentNode do
			hasExpanded = true
			expanded[currentNode] = true
			currentNode = currentNode.Parent
		end

		if hasExpanded and not updateDebounce then
			coroutine.wrap(Explorer.PerformUpdate)(true)
		end
	end

	Explorer.ShowRightClick = function()
		local context = Explorer.RightClickContext
		context:Clear()

		local sList = selection.List
		local sMap = selection.Map
		local emptyClipboard = #clipboard == 0
		local presentClasses = {}
		local apiClasses = API.Classes

		for i = 1,#sList do
			local node = sList[i]
			local class = node.Class
			if not class then class = node.Obj.ClassName node.Class = class end

			local curClass = apiClasses[class]
			while curClass and not presentClasses[curClass.Name] do
				presentClasses[curClass.Name] = true
				curClass = curClass.Superclass
			end
		end

		context:AddRegistered("CUT")
		context:AddRegistered("COPY")
		context:AddRegistered("PASTE",emptyClipboard)
		context:AddRegistered("DUPLICATE")
		context:AddRegistered("DELETE")
		context:AddRegistered("RENAME",#sList ~= 1)

		context:AddDivider()
		context:AddRegistered("GROUP")
		context:AddRegistered("UNGROUP")
		context:AddRegistered("SELECT_CHILDREN")
		context:AddRegistered("JUMP_TO_PARENT")
		context:AddRegistered("EXPAND_ALL")
		context:AddRegistered("COLLAPSE_ALL")

		context:AddDivider()
		if expanded == Explorer.SearchExpanded then
			context:AddRegistered("CLEAR_SEARCH_AND_JUMP_TO")
		end
		if env.setclipboard then
			context:AddRegistered("COPY_PATH")
		end
		context:AddRegistered("INSERT_OBJECT")
		context:AddRegistered("SAVE_INST")
		context:AddRegistered("CALL_FUNCTION")
		context:AddRegistered("VIEW_CONNECTIONS")
		context:AddRegistered("GET_REFERENCES")
		context:AddRegistered("VIEW_API")
		
		context:QueueDivider()

		if presentClasses["BasePart"] or presentClasses["Model"] then
			context:AddRegistered("TELEPORT_TO")
			context:AddRegistered("VIEW_OBJECT")
		end

		if presentClasses["Player"] then
			context:AddRegistered("SELECT_CHARACTER")
		end

		if presentClasses["LuaSourceContainer"] then
			context:AddRegistered("VIEW_SCRIPT")
		end

		if sMap[nilNode] then
			context:AddRegistered("REFRESH_NIL")
			context:AddRegistered("HIDE_NIL")
		end

		Explorer.LastRightClickX,Explorer.LastRightClickY = Main.Mouse.X,Main.Mouse.Y
		context:Show()
	end

	Explorer.InitRightClick = function()
		local context = Lib.ContextMenu.new()

		context:Register("CUT",{Name = "Cut", IconMap = Explorer.MiscIcons, Icon = "Cut", DisabledIcon = "Cut_Disabled", Shortcut = "Ctrl+Z", OnClick = function()
			local destroy,clone = game.Destroy,game.Clone
			local sList,newClipboard = selection.List,{}
			local count = 1
			for i = 1,#sList do
				local inst = sList[i].Obj
				local s,cloned = pcall(clone,inst)
				if s and cloned then
					newClipboard[count] = cloned
					count = count + 1
				end
				pcall(destroy,inst)
			end
			clipboard = newClipboard
			selection:Clear()
		end})

		context:Register("COPY",{Name = "Copy", IconMap = Explorer.MiscIcons, Icon = "Copy", DisabledIcon = "Copy_Disabled", Shortcut = "Ctrl+C", OnClick = function()
			local clone = game.Clone
			local sList,newClipboard = selection.List,{}
			local count = 1
			for i = 1,#sList do
				local inst = sList[i].Obj
				local s,cloned = pcall(clone,inst)
				if s and cloned then
					newClipboard[count] = cloned
					count = count + 1
				end
			end
			clipboard = newClipboard
		end})

		context:Register("PASTE",{Name = "Paste Into", IconMap = Explorer.MiscIcons, Icon = "Paste", DisabledIcon = "Paste_Disabled", Shortcut = "Ctrl+Shift+V", OnClick = function()
			local sList = selection.List
			local newSelection = {}
			local count = 1
			for i = 1,#sList do
				local node = sList[i]
				local inst = node.Obj
				Explorer.MakeNodeVisible(node,true)
				for c = 1,#clipboard do
					local cloned = clipboard[c]:Clone()
					if cloned then
						cloned.Parent = inst
						local clonedNode = nodes[cloned]
						if clonedNode then newSelection[count] = clonedNode count = count + 1 end
					end
				end
			end
			selection:SetTable(newSelection)

			if #newSelection > 0 then
				Explorer.ViewNode(newSelection[1])
			end
		end})

		context:Register("DUPLICATE",{Name = "Duplicate", IconMap = Explorer.MiscIcons, Icon = "Copy", DisabledIcon = "Copy_Disabled", Shortcut = "Ctrl+D", OnClick = function()
			local clone = game.Clone
			local sList = selection.List
			local newSelection = {}
			local count = 1
			for i = 1,#sList do
				local node = sList[i]
				local inst = node.Obj
				local instPar = node.Parent and node.Parent.Obj
				Explorer.MakeNodeVisible(node)
				local s,cloned = pcall(clone,inst)
				if s and cloned then
					cloned.Parent = instPar
					local clonedNode = nodes[cloned]
					if clonedNode then newSelection[count] = clonedNode count = count + 1 end
				end
			end

			selection:SetTable(newSelection)
			if #newSelection > 0 then
				Explorer.ViewNode(newSelection[1])
			end
		end})

		context:Register("DELETE",{Name = "Delete", IconMap = Explorer.MiscIcons, Icon = "Delete", DisabledIcon = "Delete_Disabled", Shortcut = "Del", OnClick = function()
			local destroy = game.Destroy
			local sList = selection.List
			for i = 1,#sList do
				pcall(destroy,sList[i].Obj)
			end
			selection:Clear()
		end})

		context:Register("RENAME",{Name = "Rename", IconMap = Explorer.MiscIcons, Icon = "Rename", DisabledIcon = "Rename_Disabled", Shortcut = "F2", OnClick = function()
			local sList = selection.List
			if sList[1] then
				Explorer.SetRenamingNode(sList[1])
			end
		end})

		context:Register("GROUP",{Name = "Group", IconMap = Explorer.MiscIcons, Icon = "Group", DisabledIcon = "Group_Disabled", Shortcut = "Ctrl+G", OnClick = function()
			local sList = selection.List
			if #sList == 0 then return end

			local model = Instance.new("Model",sList[#sList].Obj.Parent)
			for i = 1,#sList do
				pcall(function() sList[i].Obj.Parent = model end)
			end

			if nodes[model] then
				selection:Set(nodes[model])
				Explorer.ViewNode(nodes[model])
			end
		end})

		context:Register("UNGROUP",{Name = "Ungroup", IconMap = Explorer.MiscIcons, Icon = "Ungroup", DisabledIcon = "Ungroup_Disabled", Shortcut = "Ctrl+U", OnClick = function()
			local newSelection = {}
			local count = 1
			local isa = game.IsA

			local function ungroup(node)
				local par = node.Parent.Obj
				local ch = {}
				local chCount = 1

				for i = 1,#node do
					local n = node[i]
					newSelection[count] = n
					ch[chCount] = n
					count = count + 1
					chCount = chCount + 1
				end

				for i = 1,#ch do
					pcall(function() ch[i].Obj.Parent = par end)
				end

				node.Obj:Destroy()
			end

			for i,v in next,selection.List do
				if isa(v.Obj,"Model") then
					ungroup(v)
				end
			end

			selection:SetTable(newSelection)
			if #newSelection > 0 then
				Explorer.ViewNode(newSelection[1])
			end
		end})

		context:Register("SELECT_CHILDREN",{Name = "Select Children", IconMap = Explorer.MiscIcons, Icon = "SelectChildren", DisabledIcon = "SelectChildren_Disabled", OnClick = function()
			local newSelection = {}
			local count = 1
			local sList = selection.List

			for i = 1,#sList do
				local node = sList[i]
				for ind = 1,#node do
					local cNode = node[ind]
					if ind == 1 then Explorer.MakeNodeVisible(cNode) end

					newSelection[count] = cNode
					count = count + 1
				end
			end

			selection:SetTable(newSelection)
			if #newSelection > 0 then
				Explorer.ViewNode(newSelection[1])
			else
				Explorer.Refresh()
			end
		end})

		context:Register("JUMP_TO_PARENT",{Name = "Jump to Parent", IconMap = Explorer.MiscIcons, Icon = "JumpToParent", OnClick = function()
			local newSelection = {}
			local count = 1
			local sList = selection.List

			for i = 1,#sList do
				local node = sList[i]
				if node.Parent then
					newSelection[count] = node.Parent
					count = count + 1
				end
			end

			selection:SetTable(newSelection)
			if #newSelection > 0 then
				Explorer.ViewNode(newSelection[1])
			else
				Explorer.Refresh()
			end
		end})

		context:Register("TELEPORT_TO",{Name = "Teleport To", IconMap = Explorer.MiscIcons, Icon = "TeleportTo", OnClick = function()
			local sList = selection.List
			local isa = game.IsA

			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if not hrp then return end

			for i = 1,#sList do
				local node = sList[i]

				if isa(node.Obj,"BasePart") then
					hrp.CFrame = node.Obj.CFrame + Settings.Explorer.TeleportToOffset
					break
				elseif isa(node.Obj,"Model") then
					if node.Obj.PrimaryPart then
						hrp.CFrame = node.Obj.PrimaryPart.CFrame + Settings.Explorer.TeleportToOffset
						break
					else
						local part = node.Obj:FindFirstChildWhichIsA("BasePart",true)
						if part and nodes[part] then
							hrp.CFrame = nodes[part].Obj.CFrame + Settings.Explorer.TeleportToOffset
						end
					end
				end
			end
		end})

		context:Register("EXPAND_ALL",{Name = "Expand All", OnClick = function()
			local sList = selection.List

			local function expand(node)
				expanded[node] = true
				for i = 1,#node do
					if #node[i] > 0 then
						expand(node[i])
					end
				end
			end

			for i = 1,#sList do
				expand(sList[i])
			end

			Explorer.ForceUpdate()
		end})

		context:Register("COLLAPSE_ALL",{Name = "Collapse All", OnClick = function()
			local sList = selection.List

			local function expand(node)
				expanded[node] = nil
				for i = 1,#node do
					if #node[i] > 0 then
						expand(node[i])
					end
				end
			end

			for i = 1,#sList do
				expand(sList[i])
			end

			Explorer.ForceUpdate()
		end})

		context:Register("CLEAR_SEARCH_AND_JUMP_TO",{Name = "Clear Search and Jump to", OnClick = function()
			local newSelection = {}
			local count = 1
			local sList = selection.List

			for i = 1,#sList do
				newSelection[count] = sList[i]
				count = count + 1
			end

			selection:SetTable(newSelection)
			Explorer.ClearSearch()
			if #newSelection > 0 then
				Explorer.ViewNode(newSelection[1])
			end
		end})

		context:Register("COPY_PATH",{Name = "Copy Path", OnClick = function()
			local sList = selection.List
			if #sList == 1 then
				env.setclipboard(Explorer.GetInstancePath(sList[1].Obj))
			elseif #sList > 1 then
				local resList = {"{"}
				local count = 2
				for i = 1,#sList do
					local path = "\t"..Explorer.GetInstancePath(sList[i].Obj)..","
					if #path > 0 then
						resList[count] = path
						count = count+1
					end
				end
				resList[count] = "}"
				env.setclipboard(table.concat(resList,"\n"))
			end
		end})

		context:Register("INSERT_OBJECT",{Name = "Insert Object", IconMap = Explorer.MiscIcons, Icon = "InsertObject", OnClick = function()
			local mouse = Main.Mouse
			local x,y = Explorer.LastRightClickX or mouse.X, Explorer.LastRightClickY or mouse.Y
			Explorer.InsertObjectContext:Show(x,y)
		end})

		context:Register("CALL_FUNCTION",{Name = "Call Function", IconMap = Explorer.ClassIcons, Icon = 66, OnClick = function()

		end})

		context:Register("GET_REFERENCES",{Name = "Get Lua References", IconMap = Explorer.ClassIcons, Icon = 34, OnClick = function()

		end})

		context:Register("SAVE_INST",{Name = "Save to File", IconMap = Explorer.MiscIcons, Icon = "Save", OnClick = function()

		end})

		context:Register("VIEW_CONNECTIONS",{Name = "View Connections", OnClick = function()

		end})

		context:Register("VIEW_API",{Name = "View API Page", IconMap = Explorer.MiscIcons, Icon = "Reference", OnClick = function()

		end})

		context:Register("VIEW_OBJECT",{Name = "View Object (Right click to reset)", IconMap = Explorer.ClassIcons, Icon = 5, OnClick = function()
			local sList = selection.List
			local isa = game.IsA

			for i = 1,#sList do
				local node = sList[i]

				if isa(node.Obj,"BasePart") or isa(node.Obj,"Model") then
					workspace.CurrentCamera.CameraSubject = node.Obj
					break
				end
			end
		end, OnRightClick = function()
			workspace.CurrentCamera.CameraSubject = plr.Character
		end})

		context:Register("VIEW_SCRIPT",{Name = "View Script", IconMap = Explorer.MiscIcons, Icon = "ViewScript", OnClick = function()
			local scr = selection.List[1] and selection.List[1].Obj
			if scr then ScriptViewer.ViewScript(scr) end
		end})

		context:Register("SELECT_CHARACTER",{Name = "Select Character", IconMap = Explorer.ClassIcons, Icon = 9, OnClick = function()
			local newSelection = {}
			local count = 1
			local sList = selection.List
			local isa = game.IsA

			for i = 1,#sList do
				local node = sList[i]
				if isa(node.Obj,"Player") and nodes[node.Obj.Character] then
					newSelection[count] = nodes[node.Obj.Character]
					count = count + 1
				end
			end

			selection:SetTable(newSelection)
			if #newSelection > 0 then
				Explorer.ViewNode(newSelection[1])
			else
				Explorer.Refresh()
			end
		end})

		context:Register("REFRESH_NIL",{Name = "Refresh Nil Instances", OnClick = function()
			Explorer.RefreshNilInstances()
		end})
		
		context:Register("HIDE_NIL",{Name = "Hide Nil Instances", OnClick = function()
			Explorer.HideNilInstances()
		end})

		Explorer.RightClickContext = context
	end

	Explorer.HideNilInstances = function()
		table.clear(nilMap)
		
		local disconnectCon = Instance.new("Folder").ChildAdded:Connect(function() end).Disconnect
		for i,v in next,nilCons do
			disconnectCon(v[1])
			disconnectCon(v[2])
		end
		table.clear(nilCons)

		for i = 1,#nilNode do
			coroutine.wrap(removeObject)(nilNode[i].Obj)
		end

		Explorer.Update()
		Explorer.Refresh()
	end

	Explorer.RefreshNilInstances = function()
		if not env.getnilinstances then return end

		local nilInsts = env.getnilinstances()
		local game = game
		local getDescs = game.GetDescendants
		--local newNilMap = {}
		--local newNilRoots = {}
		--local nilRoots = Explorer.NilRoots
		--local connect = game.DescendantAdded.Connect
		--local disconnect
		--if not nilRoots then nilRoots = {} Explorer.NilRoots = nilRoots end

		for i = 1,#nilInsts do
			local obj = nilInsts[i]
			if obj ~= game then
				nilMap[obj] = true
				--newNilRoots[obj] = true

				local descs = getDescs(obj)
				for j = 1,#descs do
					nilMap[descs[j]] = true
				end
			end
		end

		-- Remove unmapped nil nodes
		--[[for i = 1,#nilNode do
			local node = nilNode[i]
			if not newNilMap[node.Obj] then
				nilMap[node.Obj] = nil
				coroutine.wrap(removeObject)(node)
			end
		end]]

		--nilMap = newNilMap

		for i = 1,#nilInsts do
			local obj = nilInsts[i]
			local node = nodes[obj]
			if not node then coroutine.wrap(addObject)(obj) end
		end

		--[[
		-- Remove old root connections
		for obj in next,nilRoots do
			if not newNilRoots[obj] then
				if not disconnect then disconnect = obj[1].Disconnect end
				disconnect(obj[1])
				disconnect(obj[2])
			end
		end
		
		for obj in next,newNilRoots do
			if not nilRoots[obj] then
				nilRoots[obj] = {
					connect(obj.DescendantAdded,addObject),
					connect(obj.DescendantRemoving,removeObject)
				}
			end
		end]]

		--nilMap = newNilMap
		--Explorer.NilRoots = newNilRoots

		Explorer.Update()
		Explorer.Refresh()
	end

	Explorer.GetInstancePath = function(obj)
		local ffc = game.FindFirstChild
		local getCh = game.GetChildren
		local path = ""
		local curObj = obj
		local ts = tostring
		local match = string.match
		local gsub = string.gsub
		local tableFind = table.find
		local useGetCh = Settings.Explorer.CopyPathUseGetChildren
		local formatLuaString = Lib.FormatLuaString

		while curObj do
			if curObj == game then
				path = "game"..path
				break
			end

			local className = curObj.ClassName
			local curName = ts(curObj)
			local indexName
			if match(curName,"^[%a_][%w_]*$") then
				indexName = "."..curName
			else
				local cleanName = formatLuaString(curName)
				indexName = '["'..cleanName..'"]'
			end

			local parObj = curObj.Parent
			if parObj then
				local fc = ffc(parObj,curName)
				if useGetCh and fc and fc ~= curObj then
					local parCh = getCh(parObj)
					local fcInd = tableFind(parCh,curObj)
					indexName = ":GetChildren()["..fcInd.."]"
				elseif parObj == game and API.Classes[className] and API.Classes[className].Tags.Service then
					indexName = ':GetService("'..className..'")'
				end
			end

			path = indexName..path
			curObj = parObj
		end

		return path
	end

	Explorer.InitInsertObject = function()
		local context = Lib.ContextMenu.new()
		context.SearchEnabled = true
		context.MaxHeight = 400
		context:ApplyTheme({
			ContentColor = Settings.Theme.Main2,
			OutlineColor = Settings.Theme.Outline1,
			DividerColor = Settings.Theme.Outline1,
			TextColor = Settings.Theme.Text,
			HighlightColor = Settings.Theme.ButtonHover
		})

		local classes = {}
		for i,class in next,API.Classes do
			local tags = class.Tags
			if not tags.NotCreatable and not tags.Service then
				local rmdEntry = RMD.Classes[class.Name]
				classes[#classes+1] = {class,rmdEntry and rmdEntry.ClassCategory or "Uncategorized"}
			end
		end
		table.sort(classes,function(a,b)
			if a[2] ~= b[2] then
				return a[2] < b[2]
			else
				return a[1].Name < b[1].Name
			end
		end)

		local function onClick(className)
			local sList = selection.List
			local instNew = Instance.new
			for i = 1,#sList do
				local node = sList[i]
				local obj = node.Obj
				Explorer.MakeNodeVisible(node,true)
				pcall(instNew,className,obj)
			end
		end

		local lastCategory = ""
		for i = 1,#classes do
			local class = classes[i][1]
			local rmdEntry = RMD.Classes[class.Name]
			local iconInd = rmdEntry and tonumber(rmdEntry.ExplorerImageIndex) or 0
			local category = classes[i][2]

			if lastCategory ~= category then
				context:AddDivider(category)
				lastCategory = category
			end
			context:Add({Name = class.Name, IconMap = Explorer.ClassIcons, Icon = iconInd, OnClick = onClick})
		end

		Explorer.InsertObjectContext = context
	end

	--[[
		Headers, Setups, Predicate, ObjectDefs
	]]
	Explorer.SearchFilters = { -- TODO: Use data table (so we can disable some if funcs don't exist)
		Comparison = {
			["isa"] = function(argString)
				local lower = string.lower
				local find = string.find
				local classQuery = string.split(argString)[1]
				if not classQuery then return end
				classQuery = lower(classQuery)

				local className
				for class,_ in pairs(API.Classes) do
					local cName = lower(class)
					if cName == classQuery then
						className = class
						break
					elseif find(cName,classQuery,1,true) then
						className = class
					end
				end
				if not className then return end

				return {
					Headers = {"local isa = game.IsA"},
					Predicate = "isa(obj,'"..className.."')"
				}
			end,
			["remotes"] = function(argString)
				return {
					Headers = {"local isa = game.IsA"},
					Predicate = "isa(obj,'RemoteEvent') or isa(obj,'RemoteFunction')"
				}
			end,
			["bindables"] = function(argString)
				return {
					Headers = {"local isa = game.IsA"},
					Predicate = "isa(obj,'BindableEvent') or isa(obj,'BindableFunction')"
				}
			end,
			["rad"] = function(argString)
				local num = tonumber(argString)
				if not num then return end

				if not service.Players.LocalPlayer.Character or not service.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not service.Players.LocalPlayer.Character.HumanoidRootPart:IsA("BasePart") then return end

				return {
					Headers = {"local isa = game.IsA", "local hrp = service.Players.LocalPlayer.Character.HumanoidRootPart"},
					Setups = {"local hrpPos = hrp.Position"},
					ObjectDefs = {"local isBasePart = isa(obj,'BasePart')"},
					Predicate = "(isBasePart and (obj.Position-hrpPos).Magnitude <= "..num..")"
				}
			end,
		},
		Specific = {
			["players"] = function()
				return function() return service.Players:GetPlayers() end
			end,
			["loadedmodules"] = function()
				return env.getloadedmodules
			end,
		},
		Default = function(argString,caseSensitive)
			local cleanString = argString:gsub("\"","\\\""):gsub("\n","\\n")
			if caseSensitive then
				return {
					Headers = {"local find = string.find"},
					ObjectDefs = {"local objName = tostring(obj)"},
					Predicate = "find(objName,\"" .. cleanString .. "\",1,true)"
				}
			else
				return {
					Headers = {"local lower = string.lower","local find = string.find","local tostring = tostring"},
					ObjectDefs = {"local lowerName = lower(tostring(obj))"},
					Predicate = "find(lowerName,\"" .. cleanString:lower() .. "\",1,true)"
				}
			end
		end,
		SpecificDefault = function(n)
			return {
				Headers = {},
				ObjectDefs = {"local isSpec"..n.." = specResults["..n.."][node]"},
				Predicate = "isSpec"..n
			}
		end,
	}

	Explorer.BuildSearchFunc = function(query)
		local specFilterList,specMap = {},{}
		local finalPredicate = ""
		local rep = string.rep
		local formatQuery = query:gsub("\\.","  "):gsub('".-"',function(str) return rep(" ",#str) end)
		local headers = {}
		local objectDefs = {}
		local setups = {}
		local find = string.find
		local sub = string.sub
		local lower = string.lower
		local match = string.match
		local ops = {
			["("] = "(",
			[")"] = ")",
			["||"] = " or ",
			["&&"] = " and "
		}
		local filterCount = 0
		local compFilters = Explorer.SearchFilters.Comparison
		local specFilters = Explorer.SearchFilters.Specific
		local init = 1
		local lastOp = nil

		local function processFilter(dat)
			if dat.Headers then
				local t = dat.Headers
				for i = 1,#t do
					headers[t[i]] = true
				end
			end

			if dat.ObjectDefs then
				local t = dat.ObjectDefs
				for i = 1,#t do
					objectDefs[t[i]] = true
				end
			end

			if dat.Setups then
				local t = dat.Setups
				for i = 1,#t do
					setups[t[i]] = true
				end
			end

			finalPredicate = finalPredicate..dat.Predicate
		end

		local found = {}
		local foundData = {}
		local find = string.find
		local sub = string.sub

		local function findAll(str,pattern)
			local count = #found+1
			local init = 1
			local sz = #pattern
			local x,y,extra = find(str,pattern,init,true)
			while x do
				found[count] = x
				foundData[x] = {sz,pattern}

				count = count+1
				init = y+1
				x,y,extra = find(str,pattern,init,true)
			end
		end
		local start = tick()
		findAll(formatQuery,'&&')
		findAll(formatQuery,"||")
		findAll(formatQuery,"(")
		findAll(formatQuery,")")
		table.sort(found)
		table.insert(found,#formatQuery+1)

		local function inQuotes(str)
			local len = #str
			if sub(str,1,1) == '"' and sub(str,len,len) == '"' then
				return sub(str,2,len-1)
			end
		end

		for i = 1,#found do
			local nextInd = found[i]
			local nextData = foundData[nextInd] or {1}
			local op = ops[nextData[2]]
			local term = sub(query,init,nextInd-1)
			term = match(term,"^%s*(.-)%s*$") or "" -- Trim

			if #term > 0 then
				if sub(term,1,1) == "!" then
					term = sub(term,2)
					finalPredicate = finalPredicate.."not "
				end

				local qTerm = inQuotes(term)
				if qTerm then
					processFilter(Explorer.SearchFilters.Default(qTerm,true))
				else
					local x,y = find(term,"%S+")
					if x then
						local first = sub(term,x,y)
						local specifier = sub(first,1,1) == "/" and lower(sub(first,2))
						local compFunc = specifier and compFilters[specifier]
						local specFunc = specifier and specFilters[specifier]

						if compFunc then
							local argStr = sub(term,y+2)
							local ret = compFunc(inQuotes(argStr) or argStr)
							if ret then
								processFilter(ret)
							else
								finalPredicate = finalPredicate.."false"
							end
						elseif specFunc then
							local argStr = sub(term,y+2)
							local ret = specFunc(inQuotes(argStr) or argStr)
							if ret then
								if not specMap[term] then
									specFilterList[#specFilterList + 1] = ret
									specMap[term] = #specFilterList
								end
								processFilter(Explorer.SearchFilters.SpecificDefault(specMap[term]))
							else
								finalPredicate = finalPredicate.."false"
							end
						else
							processFilter(Explorer.SearchFilters.Default(term))
						end
					end
				end				
			end

			if op then
				finalPredicate = finalPredicate..op
				if op == "(" and (#term > 0 or lastOp == ")") then -- Handle bracket glitch
					return
				else
					lastOp = op
				end
			end
			init = nextInd+nextData[1]
		end

		local finalSetups = ""
		local finalHeaders = ""
		local finalObjectDefs = ""

		for setup,_ in next,setups do finalSetups = finalSetups..setup.."\n" end
		for header,_ in next,headers do finalHeaders = finalHeaders..header.."\n" end
		for oDef,_ in next,objectDefs do finalObjectDefs = finalObjectDefs..oDef.."\n" end

		local template = [==[
local searchResults = searchResults
local nodes = nodes
local expandTable = Explorer.SearchExpanded
local specResults = specResults
local service = service

%s
local function search(root)	
%s
	
	local expandedpar = false
	for i = 1,#root do
		local node = root[i]
		local obj = node.Obj
		
%s
		
		if %s then
			expandTable[node] = 0
			searchResults[node] = true
			if not expandedpar then
				local parnode = node.Parent
				while parnode and (not searchResults[parnode] or expandTable[parnode] == 0) do
					expandTable[parnode] = true
					searchResults[parnode] = true
					parnode = parnode.Parent
				end
				expandedpar = true
			end
		end
		
		if #node > 0 then search(node) end
	end
end
return search]==]

		local funcStr = template:format(finalHeaders,finalSetups,finalObjectDefs,finalPredicate)
		local s,func = pcall(loadstring,funcStr)
		if not s or not func then return nil,specFilterList end

		local env = setmetatable({["searchResults"] = searchResults, ["nodes"] = nodes, ["Explorer"] = Explorer, ["specResults"] = specResults,
			["service"] = service},{__index = getfenv()})
		setfenv(func,env)

		return func(),specFilterList
	end

	Explorer.DoSearch = function(query)
		table.clear(Explorer.SearchExpanded)
		table.clear(searchResults)
		expanded = (#query == 0 and Explorer.Expanded or Explorer.SearchExpanded)
		searchFunc = nil

		if #query > 0 then	
			local expandTable = Explorer.SearchExpanded
			local specFilters

			local lower = string.lower
			local find = string.find
			local tostring = tostring

			local lowerQuery = lower(query)

			local function defaultSearch(root)
				local expandedpar = false
				for i = 1,#root do
					local node = root[i]
					local obj = node.Obj

					if find(lower(tostring(obj)),lowerQuery,1,true) then
						expandTable[node] = 0
						searchResults[node] = true
						if not expandedpar then
							local parnode = node.Parent
							while parnode and (not searchResults[parnode] or expandTable[parnode] == 0) do
								expanded[parnode] = true
								searchResults[parnode] = true
								parnode = parnode.Parent
							end
							expandedpar = true
						end
					end

					if #node > 0 then defaultSearch(node) end
				end
			end

			if Main.Elevated then
				local start = tick()
				searchFunc,specFilters = Explorer.BuildSearchFunc(query)
				--print("BUILD SEARCH",tick()-start)
			else
				searchFunc = defaultSearch
			end

			if specFilters then
				table.clear(specResults)
				for i = 1,#specFilters do -- Specific search filers that returns list of matches
					local resMap = {}
					specResults[i] = resMap
					local objs = specFilters[i]()
					for c = 1,#objs do
						local node = nodes[objs[c]]
						if node then
							resMap[node] = true
						end
					end
				end
			end

			if searchFunc then
				local start = tick()
				searchFunc(nodes[game])
				searchFunc(nilNode)
				--warn(tick()-start)
			end
		end

		Explorer.ForceUpdate()
	end

	Explorer.ClearSearch = function()
		Explorer.GuiElems.SearchBar.Text = ""
		expanded = Explorer.Expanded
		searchFunc = nil
	end

	Explorer.InitSearch = function()
		local searchBox = Explorer.GuiElems.ToolBar.SearchFrame.SearchBox
		Explorer.GuiElems.SearchBar = searchBox

		Lib.ViewportTextBox.convert(searchBox)

		searchBox.FocusLost:Connect(function()
			Explorer.DoSearch(searchBox.Text)
		end)
	end

	Explorer.InitEntryTemplate = function()
		entryTemplate = create({
			{1,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,BorderColor3=Color3.new(0,0,0),Font=3,Name="Entry",Position=UDim2.new(0,1,0,1),Size=UDim2.new(0,250,0,20),Text="",TextSize=14,}},
			{2,"Frame",{BackgroundColor3=Color3.new(0.04313725605607,0.35294118523598,0.68627452850342),BackgroundTransparency=1,BorderColor3=Color3.new(0.33725491166115,0.49019610881805,0.73725491762161),BorderSizePixel=0,Name="Indent",Parent={1},Position=UDim2.new(0,20,0,0),Size=UDim2.new(1,-20,1,0),}},
			{3,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="EntryName",Parent={2},Position=UDim2.new(0,26,0,0),Size=UDim2.new(1,-26,1,0),Text="Workspace",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
			{4,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,ClipsDescendants=true,Font=3,Name="Expand",Parent={2},Position=UDim2.new(0,-20,0,0),Size=UDim2.new(0,20,0,20),Text="",TextSize=14,}},
			{5,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5642383285"),ImageRectOffset=Vector2.new(144,16),ImageRectSize=Vector2.new(16,16),Name="Icon",Parent={4},Position=UDim2.new(0,2,0,2),ScaleType=4,Size=UDim2.new(0,16,0,16),}},
			{6,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image="rbxasset://textures/ClassImages.png",ImageRectOffset=Vector2.new(304,0),ImageRectSize=Vector2.new(16,16),Name="Icon",Parent={2},Position=UDim2.new(0,4,0,2),ScaleType=4,Size=UDim2.new(0,16,0,16),}},
		})

		local sys = Lib.ClickSystem.new()
		sys.AllowedButtons = {1,2}
		sys.OnDown:Connect(function(item,combo,button)
			local ind = table.find(listEntries,item)
			if not ind then return end
			local node = tree[ind + Explorer.Index]
			if not node then return end

			local entry = listEntries[ind]

			if button == 1 then
				if combo == 2 then
					if node.Obj:IsA("LuaSourceContainer") then
						ScriptViewer.ViewScript(node.Obj)
					elseif #node > 0 and expanded[node] ~= 0 then
						expanded[node] = not expanded[node]
						Explorer.Update()
					end
				end

				if Properties.SelectObject(node.Obj) then
					sys.IsRenaming = false
					return
				end

				sys.IsRenaming = selection.Map[node]

				if Lib.IsShiftDown() then
					if not selection.Piviot then return end

					local fromIndex = table.find(tree,selection.Piviot)
					local toIndex = table.find(tree,node)
					if not fromIndex or not toIndex then return end
					fromIndex,toIndex = math.min(fromIndex,toIndex),math.max(fromIndex,toIndex)

					local sList = selection.List
					for i = #sList,1,-1 do
						local elem = sList[i]
						if selection.ShiftSet[elem] then
							selection.Map[elem] = nil
							table.remove(sList,i)
						end
					end
					selection.ShiftSet = {}
					for i = fromIndex,toIndex do
						local elem = tree[i]
						if not selection.Map[elem] then
							selection.ShiftSet[elem] = true
							selection.Map[elem] = true
							sList[#sList+1] = elem
						end
					end
					selection.Changed:Fire()
				elseif Lib.IsCtrlDown() then
					selection.ShiftSet = {}
					if selection.Map[node] then selection:Remove(node) else selection:Add(node) end
					selection.Piviot = node
					sys.IsRenaming = false
				elseif not selection.Map[node] then
					selection.ShiftSet = {}
					selection:Set(node)
					selection.Piviot = node
				end
			elseif button == 2 then
				if Properties.SelectObject(node.Obj) then
					return
				end

				if not Lib.IsCtrlDown() and not selection.Map[node] then
					selection.ShiftSet = {}
					selection:Set(node)
					selection.Piviot = node
					Explorer.Refresh()
				end
			end

			Explorer.Refresh()
		end)

		sys.OnRelease:Connect(function(item,combo,button)
			local ind = table.find(listEntries,item)
			if not ind then return end
			local node = tree[ind + Explorer.Index]
			if not node then return end

			if button == 1 then
				if selection.Map[node] and not Lib.IsShiftDown() and not Lib.IsCtrlDown() then
					selection.ShiftSet = {}
					selection:Set(node)
					selection.Piviot = node
					Explorer.Refresh()
				end

				local id = sys.ClickId
				Lib.FastWait(sys.ComboTime)
				if combo == 1 and id == sys.ClickId and sys.IsRenaming and selection.Map[node] then
					Explorer.SetRenamingNode(node)
				end
			elseif button == 2 then
				Explorer.ShowRightClick()
			end
		end)
		Explorer.ClickSystem = sys
	end

	Explorer.InitDelCleaner = function()
		coroutine.wrap(function()
			local fw = Lib.FastWait
			while true do
				local processed = false
				local c = 0
				for _,node in next,nodes do
					if node.HasDel then
						local delInd
						for i = 1,#node do
							if node[i].Del then
								delInd = i
								break
							end
						end
						if delInd then
							for i = delInd+1,#node do
								local cn = node[i]
								if not cn.Del then
									node[delInd] = cn
									delInd = delInd+1
								end
							end
							for i = delInd,#node do
								node[i] = nil
							end
						end
						node.HasDel = false
						processed = true
						fw()
					end
					c = c + 1
					if c > 10000 then
						c = 0
						fw()
					end
				end
				if processed and not refreshDebounce then Explorer.PerformRefresh() end
				fw(0.5)
			end
		end)()
	end

	Explorer.UpdateSelectionVisuals = function()
		local holder = Explorer.SelectionVisualsHolder
		local isa = game.IsA
		local clone = game.Clone
		if not holder then
			holder = Instance.new("ScreenGui")
			holder.Name = "ExplorerSelections"
			holder.DisplayOrder = Main.DisplayOrders.Core
			Lib.ShowGui(holder)
			Explorer.SelectionVisualsHolder = holder
			Explorer.SelectionVisualCons = {}

			local guiTemplate = create({
				{1,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Size=UDim2.new(0,100,0,100),}},
				{2,"Frame",{BackgroundColor3=Color3.new(0.04313725605607,0.35294118523598,0.68627452850342),BorderSizePixel=0,Parent={1},Position=UDim2.new(0,-1,0,-1),Size=UDim2.new(1,2,0,1),}},
				{3,"Frame",{BackgroundColor3=Color3.new(0.04313725605607,0.35294118523598,0.68627452850342),BorderSizePixel=0,Parent={1},Position=UDim2.new(0,-1,1,0),Size=UDim2.new(1,2,0,1),}},
				{4,"Frame",{BackgroundColor3=Color3.new(0.04313725605607,0.35294118523598,0.68627452850342),BorderSizePixel=0,Parent={1},Position=UDim2.new(0,-1,0,0),Size=UDim2.new(0,1,1,0),}},
				{5,"Frame",{BackgroundColor3=Color3.new(0.04313725605607,0.35294118523598,0.68627452850342),BorderSizePixel=0,Parent={1},Position=UDim2.new(1,0,0,0),Size=UDim2.new(0,1,1,0),}},
			})
			Explorer.SelectionVisualGui = guiTemplate

			local boxTemplate = Instance.new("SelectionBox")
			boxTemplate.LineThickness = 0.03
			boxTemplate.Color3 = Color3.fromRGB(0, 170, 255)
			Explorer.SelectionVisualBox = boxTemplate
		end
		holder:ClearAllChildren()

		-- Updates theme
		for i,v in pairs(Explorer.SelectionVisualGui:GetChildren()) do
			v.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		end

		local attachCons = Explorer.SelectionVisualCons
		for i = 1,#attachCons do
			attachCons[i].Destroy()
		end
		table.clear(attachCons)

		local partEnabled = Settings.Explorer.PartSelectionBox
		local guiEnabled = Settings.Explorer.GuiSelectionBox
		if not partEnabled and not guiEnabled then return end

		local svg = Explorer.SelectionVisualGui
		local svb = Explorer.SelectionVisualBox
		local attachTo = Lib.AttachTo
		local sList = selection.List
		local count = 1
		local boxCount = 0
		local workspaceNode = nodes[workspace]
		for i = 1,#sList do
			if boxCount > 1000 then break end
			local node = sList[i]
			local obj = node.Obj

			if node ~= workspaceNode then
				if isa(obj,"GuiObject") and guiEnabled then
					local newVisual = clone(svg)
					attachCons[count] = attachTo(newVisual,{Target = obj, Resize = true})
					count = count + 1
					newVisual.Parent = holder
					boxCount = boxCount + 1
				elseif isa(obj,"PVInstance") and partEnabled then
					local newBox = clone(svb)
					newBox.Adornee = obj
					newBox.Parent = holder
					boxCount = boxCount + 1
				end
			end
		end
	end

	Explorer.Init = function()
		Explorer.ClassIcons = Lib.IconMap.newLinear("rbxasset://textures/ClassImages.png",16,16)
		Explorer.MiscIcons = Main.MiscIcons

		clipboard = {}

		selection = Lib.Set.new()
		selection.ShiftSet = {}
		selection.Changed:Connect(Properties.ShowExplorerProps)
		Explorer.Selection = selection

		Explorer.InitRightClick()
		Explorer.InitInsertObject()
		Explorer.SetSortingEnabled(Settings.Explorer.Sorting)
		Explorer.Expanded = setmetatable({},{__mode = "k"})
		Explorer.SearchExpanded = setmetatable({},{__mode = "k"})
		expanded = Explorer.Expanded

		nilNode.Obj.Name = "Nil Instances"
		nilNode.Locked = true

		local explorerItems = create({
			{1,"Folder",{Name="ExplorerItems",}},
			{2,"Frame",{BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderSizePixel=0,Name="ToolBar",Parent={1},Size=UDim2.new(1,0,0,22),}},
			{3,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.1176470592618,0.1176470592618,0.1176470592618),BorderSizePixel=0,Name="SearchFrame",Parent={2},Position=UDim2.new(0,3,0,1),Size=UDim2.new(1,-6,0,18),}},
			{4,"TextBox",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,ClearTextOnFocus=false,Font=3,Name="SearchBox",Parent={3},PlaceholderColor3=Color3.new(0.39215689897537,0.39215689897537,0.39215689897537),PlaceholderText="Search workspace",Position=UDim2.new(0,4,0,0),Size=UDim2.new(1,-24,0,18),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=0,}},
			{5,"UICorner",{CornerRadius=UDim.new(0,2),Parent={3},}},
			{6,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Reset",Parent={3},Position=UDim2.new(1,-17,0,1),Size=UDim2.new(0,16,0,16),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,}},
			{7,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5034718129"),ImageColor3=Color3.new(0.39215686917305,0.39215686917305,0.39215686917305),Parent={6},Size=UDim2.new(0,16,0,16),}},
			{8,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Refresh",Parent={2},Position=UDim2.new(1,-20,0,1),Size=UDim2.new(0,18,0,18),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,Visible=false,}},
			{9,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5642310344"),Parent={8},Position=UDim2.new(0,3,0,3),Size=UDim2.new(0,12,0,12),}},
			{10,"Frame",{BackgroundColor3=Color3.new(0.15686275064945,0.15686275064945,0.15686275064945),BorderSizePixel=0,Name="ScrollCorner",Parent={1},Position=UDim2.new(1,-16,1,-16),Size=UDim2.new(0,16,0,16),Visible=false,}},
			{11,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,ClipsDescendants=true,Name="List",Parent={1},Position=UDim2.new(0,0,0,23),Size=UDim2.new(1,0,1,-23),}},
		})

		toolBar = explorerItems.ToolBar
		treeFrame = explorerItems.List

		Explorer.GuiElems.ToolBar = toolBar
		Explorer.GuiElems.TreeFrame = treeFrame

		scrollV = Lib.ScrollBar.new()		
		scrollV.WheelIncrement = 3
		scrollV.Gui.Position = UDim2.new(1,-16,0,23)
		scrollV:SetScrollFrame(treeFrame)
		scrollV.Scrolled:Connect(function()
			Explorer.Index = scrollV.Index
			Explorer.Refresh()
		end)

		scrollH = Lib.ScrollBar.new(true)
		scrollH.Increment = 5
		scrollH.WheelIncrement = Explorer.EntryIndent
		scrollH.Gui.Position = UDim2.new(0,0,1,-16)
		scrollH.Scrolled:Connect(function()
			Explorer.Refresh()
		end)

		local window = Lib.Window.new()
		Explorer.Window = window
		window:SetTitle("Explorer")
		window.GuiElems.Line.Position = UDim2.new(0,0,0,22)

		Explorer.InitEntryTemplate()
		toolBar.Parent = window.GuiElems.Content
		treeFrame.Parent = window.GuiElems.Content
		explorerItems.ScrollCorner.Parent = window.GuiElems.Content
		scrollV.Gui.Parent = window.GuiElems.Content
		scrollH.Gui.Parent = window.GuiElems.Content

		-- Init stuff that requires the window
		Explorer.InitRenameBox()
		Explorer.InitSearch()
		Explorer.InitDelCleaner()
		selection.Changed:Connect(Explorer.UpdateSelectionVisuals)

		-- Window events
		window.GuiElems.Main:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			if Explorer.Active then
				Explorer.UpdateView()
				Explorer.Refresh()
			end
		end)
		window.OnActivate:Connect(function()
			Explorer.Active = true
			Explorer.UpdateView()
			Explorer.Update()
			Explorer.Refresh()
		end)
		window.OnRestore:Connect(function()
			Explorer.Active = true
			Explorer.UpdateView()
			Explorer.Update()
			Explorer.Refresh()
		end)
		window.OnDeactivate:Connect(function() Explorer.Active = false end)
		window.OnMinimize:Connect(function() Explorer.Active = false end)

		-- Settings
		autoUpdateSearch = Settings.Explorer.AutoUpdateSearch


		-- Fill in nodes
		nodes[game] = {Obj = game}
		expanded[nodes[game]] = true

		-- Nil Instances
		if env.getnilinstances then
			nodes[nilNode.Obj] = nilNode
		end

		Explorer.SetupConnections()

		local insts = getDescendants(game)
		if Main.Elevated then
			for i = 1,#insts do
				local obj = insts[i]
				local par = nodes[ffa(obj,"Instance")]
				if not par then continue end
				local newNode = {
					Obj = obj,
					Parent = par,
				}
				nodes[obj] = newNode
				par[#par+1] = newNode
			end
		else
			for i = 1,#insts do
				local obj = insts[i]
				local s,parObj = pcall(ffa,obj,"Instance")
				local par = nodes[parObj]
				if not par then continue end
				local newNode = {
					Obj = obj,
					Parent = par,
				}
				nodes[obj] = newNode
				par[#par+1] = newNode
			end
		end
	end

	return Explorer
end

return {InitDeps = initDeps, InitAfterMain = initAfterMain, Main = main}
end,["Properties"] = function()
--[[
	Properties App Module
	
	The main properties interface
]]

-- Common Locals
local Main,Lib,Apps,Settings -- Main Containers
local Explorer, Properties, ScriptViewer, Notebook -- Major Apps
local API,RMD,env,service,plr,create,createSimple -- Main Locals

local function initDeps(data)
	Main = data.Main
	Lib = data.Lib
	Apps = data.Apps
	Settings = data.Settings

	API = data.API
	RMD = data.RMD
	env = data.env
	service = data.service
	plr = data.plr
	create = data.create
	createSimple = data.createSimple
end

local function initAfterMain()
	Explorer = Apps.Explorer
	Properties = Apps.Properties
	ScriptViewer = Apps.ScriptViewer
	Notebook = Apps.Notebook
end

local function main()
	local Properties = {}

	local window, toolBar, propsFrame
	local scrollV, scrollH
	local categoryOrder
	local props,viewList,expanded,indexableProps,propEntries,autoUpdateObjs = {},{},{},{},{},{}
	local inputBox,inputTextBox,inputProp
	local checkboxes,propCons = {},{}
	local table,string = table,string
	local getPropChangedSignal = game.GetPropertyChangedSignal
	local getAttributeChangedSignal = game.GetAttributeChangedSignal
	local isa = game.IsA
	local getAttribute = game.GetAttribute
	local setAttribute = game.SetAttribute

	Properties.GuiElems = {}
	Properties.Index = 0
	Properties.ViewWidth = 0
	Properties.MinInputWidth = 100
	Properties.EntryIndent = 16
	Properties.EntryOffset = 4
	Properties.NameWidthCache = {}
	Properties.SubPropCache = {}
	Properties.ClassLists = {}
	Properties.SearchText = ""

	Properties.AddAttributeProp = {Category = "Attributes", Class = "", Name = "", SpecialRow = "AddAttribute", Tags = {}}
	Properties.SoundPreviewProp = {Category = "Data", ValueType = {Name = "SoundPlayer"}, Class = "Sound", Name = "Preview", Tags = {}}

	Properties.IgnoreProps = {
		["DataModel"] = {
			["PrivateServerId"] = true,
			["PrivateServerOwnerId"] = true,
			["VIPServerId"] = true,
			["VIPServerOwnerId"] = true
		}
	}

	Properties.ExpandableTypes = {
		["Vector2"] = true,
		["Vector3"] = true,
		["UDim"] = true,
		["UDim2"] = true,
		["CFrame"] = true,
		["Rect"] = true,
		["PhysicalProperties"] = true,
		["Ray"] = true,
		["NumberRange"] = true,
		["Faces"] = true,
		["Axes"] = true,
	}

	Properties.ExpandableProps = {
		["Sound.SoundId"] = true
	}

	Properties.CollapsedCategories = {
		["Surface Inputs"] = true,
		["Surface"] = true
	}

	Properties.ConflictSubProps = {
		["Vector2"] = {"X","Y"},
		["Vector3"] = {"X","Y","Z"},
		["UDim"] = {"Scale","Offset"},
		["UDim2"] = {"X","X.Scale","X.Offset","Y","Y.Scale","Y.Offset"},
		["CFrame"] = {"Position","Position.X","Position.Y","Position.Z",
			"RightVector","RightVector.X","RightVector.Y","RightVector.Z",
			"UpVector","UpVector.X","UpVector.Y","UpVector.Z",
			"LookVector","LookVector.X","LookVector.Y","LookVector.Z"},
		["Rect"] = {"Min.X","Min.Y","Max.X","Max.Y"},
		["PhysicalProperties"] = {"Density","Elasticity","ElasticityWeight","Friction","FrictionWeight"},
		["Ray"] = {"Origin","Origin.X","Origin.Y","Origin.Z","Direction","Direction.X","Direction.Y","Direction.Z"},
		["NumberRange"] = {"Min","Max"},
		["Faces"] = {"Back","Bottom","Front","Left","Right","Top"},
		["Axes"] = {"X","Y","Z"}
	}

	Properties.ConflictIgnore = {
		["BasePart"] = {
			["ResizableFaces"] = true
		}
	}

	Properties.RoundableTypes = {
		["float"] = true,
		["double"] = true,
		["Color3"] = true,
		["UDim"] = true,
		["UDim2"] = true,
		["Vector2"] = true,
		["Vector3"] = true,
		["NumberRange"] = true,
		["Rect"] = true,
		["NumberSequence"] = true,
		["ColorSequence"] = true,
		["Ray"] = true,
		["CFrame"] = true
	}

	Properties.TypeNameConvert = {
		["number"] = "double",
		["boolean"] = "bool"
	}

	Properties.ToNumberTypes = {
		["int"] = true,
		["int64"] = true,
		["float"] = true,
		["double"] = true
	}

	Properties.DefaultPropValue = {
		string = "",
		bool = false,
		double = 0,
		UDim = UDim.new(0,0),
		UDim2 = UDim2.new(0,0,0,0),
		BrickColor = BrickColor.new("Medium stone grey"),
		Color3 = Color3.new(1,1,1),
		Vector2 = Vector2.new(0,0),
		Vector3 = Vector3.new(0,0,0),
		NumberSequence = NumberSequence.new(1),
		ColorSequence = ColorSequence.new(Color3.new(1,1,1)),
		NumberRange = NumberRange.new(0),
		Rect = Rect.new(0,0,0,0)
	}

	Properties.AllowedAttributeTypes = {"string","boolean","number","UDim","UDim2","BrickColor","Color3","Vector2","Vector3","NumberSequence","ColorSequence","NumberRange","Rect"}

	Properties.StringToValue = function(prop,str)
		local typeData = prop.ValueType
		local typeName = typeData.Name

		if typeName == "string" or typeName == "Content" then
			return str
		elseif Properties.ToNumberTypes[typeName] then
			return tonumber(str)
		elseif typeName == "Vector2" then
			local vals = str:split(",")
			local x,y = tonumber(vals[1]),tonumber(vals[2])
			if x and y and #vals >= 2 then return Vector2.new(x,y) end
		elseif typeName == "Vector3" then
			local vals = str:split(",")
			local x,y,z = tonumber(vals[1]),tonumber(vals[2]),tonumber(vals[3])
			if x and y and z and #vals >= 3 then return Vector3.new(x,y,z) end
		elseif typeName == "UDim" then
			local vals = str:split(",")
			local scale,offset = tonumber(vals[1]),tonumber(vals[2])
			if scale and offset and #vals >= 2 then return UDim.new(scale,offset) end
		elseif typeName == "UDim2" then
			local vals = str:gsub("[{}]",""):split(",")
			local xScale,xOffset,yScale,yOffset = tonumber(vals[1]),tonumber(vals[2]),tonumber(vals[3]),tonumber(vals[4])
			if xScale and xOffset and yScale and yOffset and #vals >= 4 then return UDim2.new(xScale,xOffset,yScale,yOffset) end
		elseif typeName == "CFrame" then
			local vals = str:split(",")
			local s,result = pcall(CFrame.new,unpack(vals))
			if s and #vals >= 12 then return result end
		elseif typeName == "Rect" then
			local vals = str:split(",")
			local s,result = pcall(Rect.new,unpack(vals))
			if s and #vals >= 4 then return result end
		elseif typeName == "Ray" then
			local vals = str:gsub("[{}]",""):split(",")
			local s,origin = pcall(Vector3.new,unpack(vals,1,3))
			local s2,direction = pcall(Vector3.new,unpack(vals,4,6))
			if s and s2 and #vals >= 6 then return Ray.new(origin,direction) end
		elseif typeName == "NumberRange" then
			local vals = str:split(",")
			local s,result = pcall(NumberRange.new,unpack(vals))
			if s and #vals >= 1 then return result end
		elseif typeName == "Color3" then
			local vals = str:gsub("[{}]",""):split(",")
			local s,result = pcall(Color3.fromRGB,unpack(vals))
			if s and #vals >= 3 then return result end
		end

		return nil
	end

	Properties.ValueToString = function(prop,val)
		local typeData = prop.ValueType
		local typeName = typeData.Name

		if typeName == "Color3" then
			return Lib.ColorToBytes(val)
		elseif typeName == "NumberRange" then
			return val.Min..", "..val.Max
		end

		return tostring(val)
	end

	Properties.GetIndexableProps = function(obj,classData)
		if not Main.Elevated then
			if not pcall(function() return obj.ClassName end) then return nil end
		end

		local ignoreProps = Properties.IgnoreProps[classData.Name] or {}

		local result = {}
		local count = 1
		local props = classData.Properties
		for i = 1,#props do
			local prop = props[i]
			if not ignoreProps[prop.Name] then
				local s = pcall(function() return obj[prop.Name] end)
				if s then
					result[count] = prop
					count = count + 1
				end
			end
		end

		return result
	end

	Properties.FindFirstObjWhichIsA = function(class)
		local classList = Properties.ClassLists[class] or {}
		if classList and #classList > 0 then
			return classList[1]
		end

		return nil
	end

	Properties.ComputeConflicts = function(p)
		local maxConflictCheck = Settings.Properties.MaxConflictCheck
		local sList = Explorer.Selection.List
		local classLists = Properties.ClassLists
		local stringSplit = string.split
		local t_clear = table.clear
		local conflictIgnore = Properties.ConflictIgnore
		local conflictMap = {}
		local propList = p and {p} or props

		if p then
			local gName = p.Class.."."..p.Name
			autoUpdateObjs[gName] = nil
			local subProps = Properties.ConflictSubProps[p.ValueType.Name] or {}
			for i = 1,#subProps do
				autoUpdateObjs[gName.."."..subProps[i]] = nil
			end
		else
			table.clear(autoUpdateObjs)
		end

		if #sList > 0 then
			for i = 1,#propList do
				local prop = propList[i]
				local propName,propClass = prop.Name,prop.Class
				local typeData = prop.RootType or prop.ValueType
				local typeName = typeData.Name
				local attributeName = prop.AttributeName
				local gName = propClass.."."..propName

				local checked = 0
				local subProps = Properties.ConflictSubProps[typeName] or {}
				local subPropCount = #subProps
				local toCheck = subPropCount + 1
				local conflictsFound = 0
				local indexNames = {}
				local ignored = conflictIgnore[propClass] and conflictIgnore[propClass][propName]
				local truthyCheck = (typeName == "PhysicalProperties")
				local isAttribute = prop.IsAttribute
				local isMultiType = prop.MultiType

				t_clear(conflictMap)

				if not isMultiType then
					local firstVal,firstObj,firstSet
					local classList = classLists[prop.Class] or {}
					for c = 1,#classList do
						local obj = classList[c]
						if not firstSet then
							if isAttribute then
								firstVal = getAttribute(obj,attributeName)
								if firstVal ~= nil then
									firstObj = obj
									firstSet = true
								end
							else
								firstVal = obj[propName]
								firstObj = obj
								firstSet = true
							end
							if ignored then break end
						else
							local propVal,skip
							if isAttribute then
								propVal = getAttribute(obj,attributeName)
								if propVal == nil then skip = true end
							else
								propVal = obj[propName]
							end

							if not skip then
								if not conflictMap[1] then
									if truthyCheck then
										if (firstVal and true or false) ~= (propVal and true or false) then
											conflictMap[1] = true
											conflictsFound = conflictsFound + 1
										end
									elseif firstVal ~= propVal then
										conflictMap[1] = true
										conflictsFound = conflictsFound + 1
									end
								end

								if subPropCount > 0 then
									for sPropInd = 1,subPropCount do
										local indexes = indexNames[sPropInd]
										if not indexes then indexes = stringSplit(subProps[sPropInd],".") indexNames[sPropInd] = indexes end

										local firstValSub = firstVal
										local propValSub = propVal

										for j = 1,#indexes do
											if not firstValSub or not propValSub then break end -- PhysicalProperties
											local indexName = indexes[j]
											firstValSub = firstValSub[indexName]
											propValSub = propValSub[indexName]
										end

										local mapInd = sPropInd + 1
										if not conflictMap[mapInd] and firstValSub ~= propValSub then
											conflictMap[mapInd] = true
											conflictsFound = conflictsFound + 1
										end
									end
								end

								if conflictsFound == toCheck then break end
							end
						end

						checked = checked + 1
						if checked == maxConflictCheck then break end
					end

					if not conflictMap[1] then autoUpdateObjs[gName] = firstObj end
					for sPropInd = 1,subPropCount do
						if not conflictMap[sPropInd+1] then
							autoUpdateObjs[gName.."."..subProps[sPropInd]] = firstObj
						end
					end
				end
			end
		end

		if p then
			Properties.Refresh()
		end
	end

	-- Fetches the properties to be displayed based on the explorer selection
	Properties.ShowExplorerProps = function()
		local maxConflictCheck = Settings.Properties.MaxConflictCheck
		local sList = Explorer.Selection.List
		local foundClasses = {}
		local propCount = 1
		local elevated = Main.Elevated
		local showDeprecated,showHidden = Settings.Properties.ShowDeprecated,Settings.Properties.ShowHidden
		local Classes = API.Classes
		local classLists = {}
		local lower = string.lower
		local RMDCustomOrders = RMD.PropertyOrders
		local getAttributes = game.GetAttributes
		local maxAttrs = Settings.Properties.MaxAttributes
		local showingAttrs = Settings.Properties.ShowAttributes
		local foundAttrs = {}
		local attrCount = 0
		local typeof = typeof
		local typeNameConvert = Properties.TypeNameConvert

		table.clear(props)

		for i = 1,#sList do
			local node = sList[i]
			local obj = node.Obj
			local class = node.Class
			if not class then class = obj.ClassName node.Class = class end

			local apiClass = Classes[class]
			while apiClass do
				local APIClassName = apiClass.Name
				if not foundClasses[APIClassName] then
					local apiProps = indexableProps[APIClassName]
					if not apiProps then apiProps = Properties.GetIndexableProps(obj,apiClass) indexableProps[APIClassName] = apiProps end

					for i = 1,#apiProps do
						local prop = apiProps[i]
						local tags = prop.Tags
						if (not tags.Deprecated or showDeprecated) and (not tags.Hidden or showHidden) then
							props[propCount] = prop
							propCount = propCount + 1
						end
					end
					foundClasses[APIClassName] = true
				end

				local classList = classLists[APIClassName]
				if not classList then classList = {} classLists[APIClassName] = classList end
				classList[#classList+1] = obj

				apiClass = apiClass.Superclass
			end

			if showingAttrs and attrCount < maxAttrs then
				local attrs = getAttributes(obj)
				for name,val in pairs(attrs) do
					local typ = typeof(val)
					if not foundAttrs[name] then
						local category = (typ == "Instance" and "Class") or (typ == "EnumItem" and "Enum") or "Other"
						local valType = {Name = typeNameConvert[typ] or typ, Category = category}
						local attrProp = {IsAttribute = true, Name = "ATTR_"..name, AttributeName = name, DisplayName = name, Class = "Instance", ValueType = valType, Category = "Attributes", Tags = {}}
						props[propCount] = attrProp
						propCount = propCount + 1
						attrCount = attrCount + 1
						foundAttrs[name] = {typ,attrProp}
						if attrCount == maxAttrs then break end
					elseif foundAttrs[name][1] ~= typ then
						foundAttrs[name][2].MultiType = true
						foundAttrs[name][2].Tags.ReadOnly = true
						foundAttrs[name][2].ValueType = {Name = "string"}
					end
				end
			end
		end

		table.sort(props,function(a,b)
			if a.Category ~= b.Category then
				return (categoryOrder[a.Category] or 9999) < (categoryOrder[b.Category] or 9999)
			else
				local aOrder = (RMDCustomOrders[a.Class] and RMDCustomOrders[a.Class][a.Name]) or 9999999
				local bOrder = (RMDCustomOrders[b.Class] and RMDCustomOrders[b.Class][b.Name]) or 9999999
				if aOrder ~= bOrder then
					return aOrder < bOrder
				else
					return lower(a.Name) < lower(b.Name)
				end
			end
		end)

		-- Find conflicts and get auto-update instances
		Properties.ClassLists = classLists
		Properties.ComputeConflicts()
		--warn("CONFLICT",tick()-start)
		if #props > 0 then
			props[#props+1] = Properties.AddAttributeProp
		end

		Properties.Update()
		Properties.Refresh()
	end

	Properties.UpdateView = function()
		local maxEntries = math.ceil(propsFrame.AbsoluteSize.Y / 23)
		local maxX = propsFrame.AbsoluteSize.X
		local totalWidth = Properties.ViewWidth + Properties.MinInputWidth

		scrollV.VisibleSpace = maxEntries
		scrollV.TotalSpace = #viewList + 1
		scrollH.VisibleSpace = maxX
		scrollH.TotalSpace = totalWidth

		scrollV.Gui.Visible = #viewList + 1 > maxEntries
		scrollH.Gui.Visible = Settings.Properties.ScaleType == 0 and totalWidth > maxX

		local oldSize = propsFrame.Size
		propsFrame.Size = UDim2.new(1,(scrollV.Gui.Visible and -16 or 0),1,(scrollH.Gui.Visible and -39 or -23))
		if oldSize ~= propsFrame.Size then
			Properties.UpdateView()
		else
			scrollV:Update()
			scrollH:Update()

			if scrollV.Gui.Visible and scrollH.Gui.Visible then
				scrollV.Gui.Size = UDim2.new(0,16,1,-39)
				scrollH.Gui.Size = UDim2.new(1,-16,0,16)
				Properties.Window.GuiElems.Content.ScrollCorner.Visible = true
			else
				scrollV.Gui.Size = UDim2.new(0,16,1,-23)
				scrollH.Gui.Size = UDim2.new(1,0,0,16)
				Properties.Window.GuiElems.Content.ScrollCorner.Visible = false
			end

			Properties.Index = scrollV.Index
		end
	end

	Properties.MakeSubProp = function(prop,subName,valueType,displayName)
		local subProp = {}
		for i,v in pairs(prop) do
			subProp[i] = v
		end
		subProp.RootType = subProp.RootType or subProp.ValueType
		subProp.ValueType = valueType
		subProp.SubName = subProp.SubName and (subProp.SubName..subName) or subName
		subProp.DisplayName = displayName

		return subProp
	end

	Properties.GetExpandedProps = function(prop) -- TODO: Optimize using table
		local result = {}
		local typeData = prop.ValueType
		local typeName = typeData.Name
		local makeSubProp = Properties.MakeSubProp

		if typeName == "Vector2" then
			result[1] = makeSubProp(prop,".X",{Name = "float"})
			result[2] = makeSubProp(prop,".Y",{Name = "float"})
		elseif typeName == "Vector3" then
			result[1] = makeSubProp(prop,".X",{Name = "float"})
			result[2] = makeSubProp(prop,".Y",{Name = "float"})
			result[3] = makeSubProp(prop,".Z",{Name = "float"})
		elseif typeName == "CFrame" then
			result[1] = makeSubProp(prop,".Position",{Name = "Vector3"})
			result[2] = makeSubProp(prop,".RightVector",{Name = "Vector3"})
			result[3] = makeSubProp(prop,".UpVector",{Name = "Vector3"})
			result[4] = makeSubProp(prop,".LookVector",{Name = "Vector3"})
		elseif typeName == "UDim" then
			result[1] = makeSubProp(prop,".Scale",{Name = "float"})
			result[2] = makeSubProp(prop,".Offset",{Name = "int"})
		elseif typeName == "UDim2" then
			result[1] = makeSubProp(prop,".X",{Name = "UDim"})
			result[2] = makeSubProp(prop,".Y",{Name = "UDim"})
		elseif typeName == "Rect" then
			result[1] = makeSubProp(prop,".Min.X",{Name = "float"},"X0")
			result[2] = makeSubProp(prop,".Min.Y",{Name = "float"},"Y0")
			result[3] = makeSubProp(prop,".Max.X",{Name = "float"},"X1")
			result[4] = makeSubProp(prop,".Max.Y",{Name = "float"},"Y1")
		elseif typeName == "PhysicalProperties" then
			result[1] = makeSubProp(prop,".Density",{Name = "float"})
			result[2] = makeSubProp(prop,".Elasticity",{Name = "float"})
			result[3] = makeSubProp(prop,".ElasticityWeight",{Name = "float"})
			result[4] = makeSubProp(prop,".Friction",{Name = "float"})
			result[5] = makeSubProp(prop,".FrictionWeight",{Name = "float"})
		elseif typeName == "Ray" then
			result[1] = makeSubProp(prop,".Origin",{Name = "Vector3"})
			result[2] = makeSubProp(prop,".Direction",{Name = "Vector3"})
		elseif typeName == "NumberRange" then
			result[1] = makeSubProp(prop,".Min",{Name = "float"})
			result[2] = makeSubProp(prop,".Max",{Name = "float"})
		elseif typeName == "Faces" then
			result[1] = makeSubProp(prop,".Back",{Name = "bool"})
			result[2] = makeSubProp(prop,".Bottom",{Name = "bool"})
			result[3] = makeSubProp(prop,".Front",{Name = "bool"})
			result[4] = makeSubProp(prop,".Left",{Name = "bool"})
			result[5] = makeSubProp(prop,".Right",{Name = "bool"})
			result[6] = makeSubProp(prop,".Top",{Name = "bool"})
		elseif typeName == "Axes" then
			result[1] = makeSubProp(prop,".X",{Name = "bool"})
			result[2] = makeSubProp(prop,".Y",{Name = "bool"})
			result[3] = makeSubProp(prop,".Z",{Name = "bool"})
		end

		if prop.Name == "SoundId" and prop.Class == "Sound" then
			result[1] = Properties.SoundPreviewProp
		end

		return result
	end

	Properties.Update = function()
		table.clear(viewList)

		local nameWidthCache = Properties.NameWidthCache
		local lastCategory
		local count = 1
		local maxWidth,maxDepth = 0,1

		local textServ = service.TextService
		local getTextSize = textServ.GetTextSize
		local font = Enum.Font.SourceSans
		local size = Vector2.new(math.huge,20)
		local stringSplit = string.split
		local entryIndent = Properties.EntryIndent
		local isFirstScaleType = Settings.Properties.ScaleType == 0
		local find,lower = string.find,string.lower
		local searchText = (#Properties.SearchText > 0 and lower(Properties.SearchText))

		local function recur(props,depth)
			for i = 1,#props do
				local prop = props[i]
				local propName = prop.Name
				local subName = prop.SubName
				local category = prop.Category

				local visible
				if searchText and depth == 1 then
					if find(lower(propName),searchText,1,true) then
						visible = true
					end
				else
					visible = true
				end

				if visible and lastCategory ~= category then
					viewList[count] = {CategoryName = category}
					count = count + 1
					lastCategory = category
				end

				if (expanded["CAT_"..category] and visible) or prop.SpecialRow then
					if depth > 1 then prop.Depth = depth if depth > maxDepth then maxDepth = depth end end

					if isFirstScaleType then
						local nameArr = subName and stringSplit(subName,".")
						local displayName = prop.DisplayName or (nameArr and nameArr[#nameArr]) or propName

						local nameWidth = nameWidthCache[displayName]
						if not nameWidth then nameWidth = getTextSize(textServ,displayName,14,font,size).X nameWidthCache[displayName] = nameWidth end

						local totalWidth = nameWidth + entryIndent*depth
						if totalWidth > maxWidth then
							maxWidth = totalWidth
						end
					end

					viewList[count] = prop
					count = count + 1

					local fullName = prop.Class.."."..prop.Name..(prop.SubName or "")
					if expanded[fullName] then
						local nextDepth = depth+1
						local expandedProps = Properties.GetExpandedProps(prop)
						if #expandedProps > 0 then
							recur(expandedProps,nextDepth)
						end
					end
				end
			end
		end
		recur(props,1)

		inputProp = nil
		Properties.ViewWidth = maxWidth + 9 + Properties.EntryOffset
		Properties.UpdateView()
	end

	Properties.NewPropEntry = function(index)
		local newEntry = Properties.EntryTemplate:Clone()
		local nameFrame = newEntry.NameFrame
		local valueFrame = newEntry.ValueFrame
		local newCheckbox = Lib.Checkbox.new(1)
		newCheckbox.Gui.Position = UDim2.new(0,3,0,3)
		newCheckbox.Gui.Parent = valueFrame
		newCheckbox.OnInput:Connect(function()
			local prop = viewList[index + Properties.Index]
			if not prop then return end

			if prop.ValueType.Name == "PhysicalProperties" then
				Properties.SetProp(prop,newCheckbox.Toggled and true or nil)
			else
				Properties.SetProp(prop,newCheckbox.Toggled)
			end
		end)
		checkboxes[index] = newCheckbox

		local iconFrame = Main.MiscIcons:GetLabel()
		iconFrame.Position = UDim2.new(0,2,0,3)
		iconFrame.Parent = newEntry.ValueFrame.RightButton

		newEntry.Position = UDim2.new(0,0,0,23*(index-1))

		nameFrame.Expand.InputBegan:Connect(function(input)
			local prop = viewList[index + Properties.Index]
			if not prop or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

			local fullName = (prop.CategoryName and "CAT_"..prop.CategoryName) or prop.Class.."."..prop.Name..(prop.SubName or "")

			Main.MiscIcons:DisplayByKey(newEntry.NameFrame.Expand.Icon, expanded[fullName] and "Collapse_Over" or "Expand_Over")
		end)

		nameFrame.Expand.InputEnded:Connect(function(input)
			local prop = viewList[index + Properties.Index]
			if not prop or input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

			local fullName = (prop.CategoryName and "CAT_"..prop.CategoryName) or prop.Class.."."..prop.Name..(prop.SubName or "")

			Main.MiscIcons:DisplayByKey(newEntry.NameFrame.Expand.Icon, expanded[fullName] and "Collapse" or "Expand")
		end)

		nameFrame.Expand.MouseButton1Down:Connect(function()
			local prop = viewList[index + Properties.Index]
			if not prop then return end

			local fullName = (prop.CategoryName and "CAT_"..prop.CategoryName) or prop.Class.."."..prop.Name..(prop.SubName or "")
			if not prop.CategoryName and not Properties.ExpandableTypes[prop.ValueType and prop.ValueType.Name] and not Properties.ExpandableProps[fullName] then return end

			expanded[fullName] = not expanded[fullName]
			Properties.Update()
			Properties.Refresh()
		end)

		nameFrame.PropName.InputBegan:Connect(function(input)
			local prop = viewList[index + Properties.Index]
			if not prop then return end
			if input.UserInputType == Enum.UserInputType.MouseMovement and not nameFrame.PropName.TextFits then
				local fullNameFrame = Properties.FullNameFrame	
				local nameArr = string.split(prop.Class.."."..prop.Name..(prop.SubName or ""),".")
				local dispName = prop.DisplayName or nameArr[#nameArr]
				local sizeX = service.TextService:GetTextSize(dispName,14,Enum.Font.SourceSans,Vector2.new(math.huge,20)).X

				fullNameFrame.TextLabel.Text = dispName
				--fullNameFrame.Position = UDim2.new(0,Properties.EntryIndent*(prop.Depth or 1) + Properties.EntryOffset,0,23*(index-1))
				fullNameFrame.Size = UDim2.new(0,sizeX + 4,0,22)
				fullNameFrame.Visible = true
				Properties.FullNameFrameIndex = index
				Properties.FullNameFrameAttach.SetData(fullNameFrame, {Target = nameFrame})
				Properties.FullNameFrameAttach.Enable()
			end
		end)

		nameFrame.PropName.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement and Properties.FullNameFrameIndex == index then
				Properties.FullNameFrame.Visible = false
				Properties.FullNameFrameAttach.Disable()
			end
		end)

		valueFrame.ValueBox.MouseButton1Down:Connect(function()
			local prop = viewList[index + Properties.Index]
			if not prop then return end

			Properties.SetInputProp(prop,index)
		end)

		valueFrame.ColorButton.MouseButton1Down:Connect(function()
			local prop = viewList[index + Properties.Index]
			if not prop then return end

			Properties.SetInputProp(prop,index,"color")
		end)

		valueFrame.RightButton.MouseButton1Click:Connect(function()
			local prop = viewList[index + Properties.Index]
			if not prop then return end

			local fullName = prop.Class.."."..prop.Name..(prop.SubName or "")
			local inputFullName = inputProp and (inputProp.Class.."."..inputProp.Name..(inputProp.SubName or ""))

			if fullName == inputFullName and inputProp.ValueType.Category == "Class" then
				inputProp = nil
				Properties.SetProp(prop,nil)
			else
				Properties.SetInputProp(prop,index,"right")
			end
		end)

		nameFrame.ToggleAttributes.MouseButton1Click:Connect(function()
			Settings.Properties.ShowAttributes = not Settings.Properties.ShowAttributes
			Properties.ShowExplorerProps()
		end)

		newEntry.RowButton.MouseButton1Click:Connect(function()
			Properties.DisplayAddAttributeWindow()
		end)

		newEntry.EditAttributeButton.MouseButton1Down:Connect(function()
			local prop = viewList[index + Properties.Index]
			if not prop then return end

			Properties.DisplayAttributeContext(prop)
		end)

		valueFrame.SoundPreview.ControlButton.MouseButton1Click:Connect(function()
			if Properties.PreviewSound and Properties.PreviewSound.Playing then
				Properties.SetSoundPreview(false)
			else
				local soundObj = Properties.FindFirstObjWhichIsA("Sound")
				if soundObj then Properties.SetSoundPreview(soundObj) end
			end
		end)

		valueFrame.SoundPreview.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

			local releaseEvent,mouseEvent
			releaseEvent = service.UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
				releaseEvent:Disconnect()
				mouseEvent:Disconnect()
			end)

			local timeLine = newEntry.ValueFrame.SoundPreview.TimeLine
			local soundObj = Properties.FindFirstObjWhichIsA("Sound")
			if soundObj then Properties.SetSoundPreview(soundObj,true) end

			local function update(input)
				local sound = Properties.PreviewSound
				if not sound or sound.TimeLength == 0 then return end

				local mouseX = input.Position.X
				local timeLineSize = timeLine.AbsoluteSize
				local relaX = mouseX - timeLine.AbsolutePosition.X

				if timeLineSize.X <= 1 then return end
				if relaX < 0 then relaX = 0 elseif relaX >= timeLineSize.X then relaX = timeLineSize.X-1 end

				local perc = (relaX/(timeLineSize.X-1))
				sound.TimePosition = perc*sound.TimeLength
				timeLine.Slider.Position = UDim2.new(perc,-4,0,-8)
			end
			update(input)

			mouseEvent = service.UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					update(input)
				end
			end)
		end)

		newEntry.Parent = propsFrame

		return {
			Gui = newEntry,
			GuiElems = {
				NameFrame = nameFrame,
				ValueFrame = valueFrame,
				PropName = nameFrame.PropName,
				ValueBox = valueFrame.ValueBox,
				Expand = nameFrame.Expand,
				ColorButton = valueFrame.ColorButton,
				ColorPreview = valueFrame.ColorButton.ColorPreview,
				Gradient = valueFrame.ColorButton.ColorPreview.UIGradient,
				EnumArrow = valueFrame.EnumArrow,
				Checkbox = valueFrame.Checkbox,
				RightButton = valueFrame.RightButton,
				RightButtonIcon = iconFrame,
				RowButton = newEntry.RowButton,
				EditAttributeButton = newEntry.EditAttributeButton,
				ToggleAttributes = nameFrame.ToggleAttributes,
				SoundPreview = valueFrame.SoundPreview,
				SoundPreviewSlider = valueFrame.SoundPreview.TimeLine.Slider
			}
		}
	end

	Properties.GetSoundPreviewEntry = function()
		for i = 1,#viewList do
			if viewList[i] == Properties.SoundPreviewProp then
				return propEntries[i - Properties.Index]
			end
		end
	end

	Properties.SetSoundPreview = function(soundObj,noplay)
		local sound = Properties.PreviewSound
		if not sound then
			sound = Instance.new("Sound")
			sound.Name = "Preview"
			sound.Paused:Connect(function()
				local entry = Properties.GetSoundPreviewEntry()
				if entry then Main.MiscIcons:DisplayByKey(entry.GuiElems.SoundPreview.ControlButton.Icon, "Play") end
			end)
			sound.Resumed:Connect(function() Properties.Refresh() end)
			sound.Ended:Connect(function()
				local entry = Properties.GetSoundPreviewEntry()
				if entry then entry.GuiElems.SoundPreviewSlider.Position = UDim2.new(0,-4,0,-8) end
				Properties.Refresh()
			end)
			sound.Parent = window.Gui
			Properties.PreviewSound = sound
		end

		if not soundObj then
			sound:Pause()
		else
			local newId = sound.SoundId ~= soundObj.SoundId
			sound.SoundId = soundObj.SoundId
			sound.PlaybackSpeed = soundObj.PlaybackSpeed
			sound.Volume = soundObj.Volume
			if newId then sound.TimePosition = 0 end
			if not noplay then sound:Resume() end

			coroutine.wrap(function()
				local previewTime = tick()
				Properties.SoundPreviewTime = previewTime
				while previewTime == Properties.SoundPreviewTime and sound.Playing do
					local entry = Properties.GetSoundPreviewEntry()
					if entry then
						local tl = sound.TimeLength
						local perc = sound.TimePosition/(tl == 0 and 1 or tl)
						entry.GuiElems.SoundPreviewSlider.Position = UDim2.new(perc,-4,0,-8)
					end
					Lib.FastWait()
				end
			end)()
			Properties.Refresh()
		end
	end

	Properties.DisplayAttributeContext = function(prop)
		local context = Properties.AttributeContext
		if not context then
			context = Lib.ContextMenu.new()
			context.Iconless = true
			context.Width = 80
		end
		context:Clear()

		context:Add({Name = "Edit", OnClick = function()
			Properties.DisplayAddAttributeWindow(prop)
		end})
		context:Add({Name = "Delete", OnClick = function()
			Properties.SetProp(prop,nil,true)
			Properties.ShowExplorerProps()
		end})

		context:Show()
	end

	Properties.DisplayAddAttributeWindow = function(editAttr)
		local win = Properties.AddAttributeWindow
		if not win then
			win = Lib.Window.new()
			win.Alignable = false
			win.Resizable = false
			win:SetTitle("Add Attribute")
			win:SetSize(200,130)

			local saveButton = Lib.Button.new()
			local nameLabel = Lib.Label.new()
			nameLabel.Text = "Name"
			nameLabel.Position = UDim2.new(0,30,0,10)
			nameLabel.Size = UDim2.new(0,40,0,20)
			win:Add(nameLabel)

			local nameBox = Lib.ViewportTextBox.new()
			nameBox.Position = UDim2.new(0,75,0,10)
			nameBox.Size = UDim2.new(0,120,0,20)
			win:Add(nameBox,"NameBox")
			nameBox.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
				saveButton:SetDisabled(#nameBox:GetText() == 0)
			end)

			local typeLabel = Lib.Label.new()
			typeLabel.Text = "Type"
			typeLabel.Position = UDim2.new(0,30,0,40)
			typeLabel.Size = UDim2.new(0,40,0,20)
			win:Add(typeLabel)

			local typeChooser = Lib.DropDown.new()
			typeChooser.CanBeEmpty = false
			typeChooser.Position = UDim2.new(0,75,0,40)
			typeChooser.Size = UDim2.new(0,120,0,20)
			typeChooser:SetOptions(Properties.AllowedAttributeTypes)
			win:Add(typeChooser,"TypeChooser")

			local errorLabel = Lib.Label.new()
			errorLabel.Text = ""
			errorLabel.Position = UDim2.new(0,5,1,-45)
			errorLabel.Size = UDim2.new(1,-10,0,20)
			errorLabel.TextColor3 = Settings.Theme.Important
			win.ErrorLabel = errorLabel
			win:Add(errorLabel,"Error")

			local cancelButton = Lib.Button.new()
			cancelButton.Text = "Cancel"
			cancelButton.Position = UDim2.new(1,-97,1,-25)
			cancelButton.Size = UDim2.new(0,92,0,20)
			cancelButton.OnClick:Connect(function()
				win:Close()
			end)
			win:Add(cancelButton)

			saveButton.Text = "Save"
			saveButton.Position = UDim2.new(0,5,1,-25)
			saveButton.Size = UDim2.new(0,92,0,20)
			saveButton.OnClick:Connect(function()
				local name = nameBox:GetText()
				if #name > 100 then
					errorLabel.Text = "Error: Name over 100 chars"
					return
				elseif name:sub(1,3) == "RBX" then
					errorLabel.Text = "Error: Name begins with 'RBX'"
					return
				end

				local typ = typeChooser.Selected
				local valType = {Name = Properties.TypeNameConvert[typ] or typ, Category = "DataType"}
				local attrProp = {IsAttribute = true, Name = "ATTR_"..name, AttributeName = name, DisplayName = name, Class = "Instance", ValueType = valType, Category = "Attributes", Tags = {}}

				Settings.Properties.ShowAttributes = true
				Properties.SetProp(attrProp,Properties.DefaultPropValue[valType.Name],true,Properties.EditingAttribute)
				Properties.ShowExplorerProps()
				win:Close()
			end)
			win:Add(saveButton,"SaveButton")

			Properties.AddAttributeWindow = win
		end

		Properties.EditingAttribute = editAttr
		win:SetTitle(editAttr and "Edit Attribute "..editAttr.AttributeName or "Add Attribute")
		win.Elements.Error.Text = ""
		win.Elements.NameBox:SetText("")
		win.Elements.SaveButton:SetDisabled(true)
		win.Elements.TypeChooser:SetSelected(1)
		win:Show()
	end

	Properties.IsTextEditable = function(prop)
		local typeData = prop.ValueType
		local typeName = typeData.Name

		return typeName ~= "bool" and typeData.Category ~= "Enum" and typeData.Category ~= "Class" and typeName ~= "BrickColor"
	end

	Properties.DisplayEnumDropdown = function(entryIndex)
		local context = Properties.EnumContext
		if not context then
			context = Lib.ContextMenu.new()
			context.Iconless = true
			context.MaxHeight = 200
			context.ReverseYOffset = 22
			Properties.EnumDropdown = context
		end

		if not inputProp or inputProp.ValueType.Category ~= "Enum" then return end
		local prop = inputProp

		local entry = propEntries[entryIndex]
		local valueFrame = entry.GuiElems.ValueFrame

		local enum = Enum[prop.ValueType.Name]
		if not enum then return end

		local sorted = {}
		for name,enum in next,enum:GetEnumItems() do
			sorted[#sorted+1] = enum
		end
		table.sort(sorted,function(a,b) return a.Name < b.Name end)

		context:Clear()

		local function onClick(name)
			if prop ~= inputProp then return end

			local enumItem = enum[name]
			inputProp = nil
			Properties.SetProp(prop,enumItem)
		end

		for i = 1,#sorted do
			local enumItem = sorted[i]
			context:Add({Name = enumItem.Name, OnClick = onClick})
		end

		context.Width = valueFrame.AbsoluteSize.X
		context:Show(valueFrame.AbsolutePosition.X, valueFrame.AbsolutePosition.Y + 22)
	end

	Properties.DisplayBrickColorEditor = function(prop,entryIndex,col)
		local editor = Properties.BrickColorEditor
		if not editor then
			editor = Lib.BrickColorPicker.new()
			editor.Gui.DisplayOrder = Main.DisplayOrders.Menu
			editor.ReverseYOffset = 22

			editor.OnSelect:Connect(function(col)
				if not editor.CurrentProp or editor.CurrentProp.ValueType.Name ~= "BrickColor" then return end

				if editor.CurrentProp == inputProp then inputProp = nil end
				Properties.SetProp(editor.CurrentProp,BrickColor.new(col))
			end)

			editor.OnMoreColors:Connect(function() -- TODO: Special Case BasePart.BrickColor to BasePart.Color
				editor:Close()
				local colProp
				for i,v in pairs(API.Classes.BasePart.Properties) do
					if v.Name == "Color" then
						colProp = v
						break
					end
				end
				Properties.DisplayColorEditor(colProp,editor.SavedColor.Color)
			end)

			Properties.BrickColorEditor = editor
		end

		local entry = propEntries[entryIndex]
		local valueFrame = entry.GuiElems.ValueFrame

		editor.CurrentProp = prop
		editor.SavedColor = col
		if prop and prop.Class == "BasePart" and prop.Name == "BrickColor" then
			editor:SetMoreColorsVisible(true)
		else
			editor:SetMoreColorsVisible(false)
		end
		editor:Show(valueFrame.AbsolutePosition.X, valueFrame.AbsolutePosition.Y + 22)
	end

	Properties.DisplayColorEditor = function(prop,col)
		local editor = Properties.ColorEditor
		if not editor then
			editor = Lib.ColorPicker.new()

			editor.OnSelect:Connect(function(col)
				if not editor.CurrentProp then return end
				local typeName = editor.CurrentProp.ValueType.Name
				if typeName ~= "Color3" and typeName ~= "BrickColor" then return end

				local colVal = (typeName == "Color3" and col or BrickColor.new(col))

				if editor.CurrentProp == inputProp then inputProp = nil end
				Properties.SetProp(editor.CurrentProp,colVal)
			end)

			Properties.ColorEditor = editor
		end

		editor.CurrentProp = prop
		if col then
			editor:SetColor(col)
		else
			local firstVal = Properties.GetFirstPropVal(prop)
			if firstVal then editor:SetColor(firstVal) end
		end
		editor:Show()
	end

	Properties.DisplayNumberSequenceEditor = function(prop,seq)
		local editor = Properties.NumberSequenceEditor
		if not editor then
			editor = Lib.NumberSequenceEditor.new()

			editor.OnSelect:Connect(function(val)
				if not editor.CurrentProp or editor.CurrentProp.ValueType.Name ~= "NumberSequence" then return end

				if editor.CurrentProp == inputProp then inputProp = nil end
				Properties.SetProp(editor.CurrentProp,val)
			end)

			Properties.NumberSequenceEditor = editor
		end

		editor.CurrentProp = prop
		if seq then
			editor:SetSequence(seq)
		else
			local firstVal = Properties.GetFirstPropVal(prop)
			if firstVal then editor:SetSequence(firstVal) end
		end
		editor:Show()
	end

	Properties.DisplayColorSequenceEditor = function(prop,seq)
		local editor = Properties.ColorSequenceEditor
		if not editor then
			editor = Lib.ColorSequenceEditor.new()

			editor.OnSelect:Connect(function(val)
				if not editor.CurrentProp or editor.CurrentProp.ValueType.Name ~= "ColorSequence" then return end

				if editor.CurrentProp == inputProp then inputProp = nil end
				Properties.SetProp(editor.CurrentProp,val)
			end)

			Properties.ColorSequenceEditor = editor
		end

		editor.CurrentProp = prop
		if seq then
			editor:SetSequence(seq)
		else
			local firstVal = Properties.GetFirstPropVal(prop)
			if firstVal then editor:SetSequence(firstVal) end
		end
		editor:Show()
	end

	Properties.GetFirstPropVal = function(prop)
		local first = Properties.FindFirstObjWhichIsA(prop.Class)
		if first then
			return Properties.GetPropVal(prop,first)
		end
	end

	Properties.GetPropVal = function(prop,obj)
		if prop.MultiType then return "<Multiple Types>" end
		if not obj then return end

		local propVal
		if prop.IsAttribute then
			propVal = getAttribute(obj,prop.AttributeName)
			if propVal == nil then return nil end

			local typ = typeof(propVal)
			local currentType = Properties.TypeNameConvert[typ] or typ
			if prop.RootType then
				if prop.RootType.Name ~= currentType then
					return nil
				end
			elseif prop.ValueType.Name ~= currentType then
				return nil
			end
		else
			propVal = obj[prop.Name]
		end
		if prop.SubName then
			local indexes = string.split(prop.SubName,".")
			for i = 1,#indexes do
				local indexName = indexes[i]
				if #indexName > 0 and propVal then
					propVal = propVal[indexName]
				end
			end
		end

		return propVal
	end

	Properties.SelectObject = function(obj)
		if inputProp and inputProp.ValueType.Category == "Class" then
			local prop = inputProp
			inputProp = nil

			if isa(obj,prop.ValueType.Name) then
				Properties.SetProp(prop,obj)
			else
				Properties.Refresh()
			end

			return true
		end

		return false
	end

	Properties.DisplayProp = function(prop,entryIndex)
		local propName = prop.Name
		local typeData = prop.ValueType
		local typeName = typeData.Name
		local tags = prop.Tags
		local gName = prop.Class.."."..prop.Name..(prop.SubName or "")
		local propObj = autoUpdateObjs[gName]
		local entryData = propEntries[entryIndex]
		local UDim2 = UDim2

		local guiElems = entryData.GuiElems
		local valueFrame = guiElems.ValueFrame
		local valueBox = guiElems.ValueBox
		local colorButton = guiElems.ColorButton
		local colorPreview = guiElems.ColorPreview
		local gradient = guiElems.Gradient
		local enumArrow = guiElems.EnumArrow
		local checkbox = guiElems.Checkbox
		local rightButton = guiElems.RightButton
		local soundPreview = guiElems.SoundPreview

		local propVal = Properties.GetPropVal(prop,propObj)
		local inputFullName = inputProp and (inputProp.Class.."."..inputProp.Name..(inputProp.SubName or ""))

		local offset = 4
		local endOffset = 6

		-- Offsetting the ValueBox for ValueType specific buttons
		if (typeName == "Color3" or typeName == "BrickColor" or typeName == "ColorSequence") then
			colorButton.Visible = true
			enumArrow.Visible = false
			if propVal then
				gradient.Color = (typeName == "Color3" and ColorSequence.new(propVal)) or (typeName == "BrickColor" and ColorSequence.new(propVal.Color)) or propVal
			else
				gradient.Color = ColorSequence.new(Color3.new(1,1,1))
			end
			colorPreview.BorderColor3 = (typeName == "ColorSequence" and Color3.new(1,1,1) or Color3.new(0,0,0))
			offset = 22
			endOffset = 24 + (typeName == "ColorSequence" and 20 or 0)
		elseif typeData.Category == "Enum" then
			colorButton.Visible = false
			enumArrow.Visible = not prop.Tags.ReadOnly
			endOffset = 22
		elseif (gName == inputFullName and typeData.Category == "Class") or typeName == "NumberSequence" then
			colorButton.Visible = false
			enumArrow.Visible = false
			endOffset = 26
		else
			colorButton.Visible = false
			enumArrow.Visible = false
		end

		valueBox.Position = UDim2.new(0,offset,0,0)
		valueBox.Size = UDim2.new(1,-endOffset,1,0)

		-- Right button
		if inputFullName == gName and typeData.Category == "Class" then
			Main.MiscIcons:DisplayByKey(guiElems.RightButtonIcon, "Delete")
			guiElems.RightButtonIcon.Visible = true
			rightButton.Text = ""
			rightButton.Visible = true
		elseif typeName == "NumberSequence" or typeName == "ColorSequence" then
			guiElems.RightButtonIcon.Visible = false
			rightButton.Text = "..."
			rightButton.Visible = true
		else
			rightButton.Visible = false
		end

		-- Displays the correct ValueBox for the ValueType, and sets it to the prop value
		if typeName == "bool" or typeName == "PhysicalProperties" then
			valueBox.Visible = false
			checkbox.Visible = true
			soundPreview.Visible = false
			checkboxes[entryIndex].Disabled = tags.ReadOnly
			if typeName == "PhysicalProperties" and autoUpdateObjs[gName] then
				checkboxes[entryIndex]:SetState(propVal and true or false)
			else
				checkboxes[entryIndex]:SetState(propVal)
			end
		elseif typeName == "SoundPlayer" then
			valueBox.Visible = false
			checkbox.Visible = false
			soundPreview.Visible = true
			local playing = Properties.PreviewSound and Properties.PreviewSound.Playing
			Main.MiscIcons:DisplayByKey(soundPreview.ControlButton.Icon, playing and "Pause" or "Play")
		else
			valueBox.Visible = true
			checkbox.Visible = false
			soundPreview.Visible = false

			if propVal ~= nil then
				if typeName == "Color3" then
					valueBox.Text = "["..Lib.ColorToBytes(propVal).."]"
				elseif typeData.Category == "Enum" then
					valueBox.Text = propVal.Name
				elseif Properties.RoundableTypes[typeName] and Settings.Properties.NumberRounding then
					local rawStr = Properties.ValueToString(prop,propVal)
					valueBox.Text = rawStr:gsub("-?%d+%.%d+",function(num)
						return tostring(tonumber(("%."..Settings.Properties.NumberRounding.."f"):format(num)))
					end)
				else
					valueBox.Text = Properties.ValueToString(prop,propVal)
				end
			else
				valueBox.Text = ""
			end

			valueBox.TextColor3 = tags.ReadOnly and Settings.Theme.PlaceholderText or Settings.Theme.Text
		end
	end

	Properties.Refresh = function()
		local maxEntries = math.max(math.ceil((propsFrame.AbsoluteSize.Y) / 23),0)	
		local maxX = propsFrame.AbsoluteSize.X
		local valueWidth = math.max(Properties.MinInputWidth,maxX-Properties.ViewWidth)
		local inputPropVisible = false
		local isa = game.IsA
		local UDim2 = UDim2
		local stringSplit = string.split
		local scaleType = Settings.Properties.ScaleType

		-- Clear connections
		for i = 1,#propCons do
			propCons[i]:Disconnect()
		end
		table.clear(propCons)

		-- Hide full name viewer
		Properties.FullNameFrame.Visible = false
		Properties.FullNameFrameAttach.Disable()

		for i = 1,maxEntries do
			local entryData = propEntries[i]
			if not propEntries[i] then entryData = Properties.NewPropEntry(i) propEntries[i] = entryData end

			local entry = entryData.Gui
			local guiElems = entryData.GuiElems
			local nameFrame = guiElems.NameFrame
			local propNameLabel = guiElems.PropName
			local valueFrame = guiElems.ValueFrame
			local expand = guiElems.Expand
			local valueBox = guiElems.ValueBox
			local propNameBox = guiElems.PropName
			local rightButton = guiElems.RightButton
			local editAttributeButton = guiElems.EditAttributeButton
			local toggleAttributes = guiElems.ToggleAttributes

			local prop = viewList[i + Properties.Index]
			if prop then
				local entryXOffset = (scaleType == 0 and scrollH.Index or 0)
				entry.Visible = true
				entry.Position = UDim2.new(0,-entryXOffset,0,entry.Position.Y.Offset)
				entry.Size = UDim2.new(scaleType == 0 and 0 or 1, scaleType == 0 and Properties.ViewWidth + valueWidth or 0,0,22)

				if prop.SpecialRow then
					if prop.SpecialRow == "AddAttribute" then
						nameFrame.Visible = false
						valueFrame.Visible = false
						guiElems.RowButton.Visible = true
					end
				else
					-- Revert special row stuff
					nameFrame.Visible = true
					guiElems.RowButton.Visible = false

					local depth = Properties.EntryIndent*(prop.Depth or 1)
					local leftOffset = depth + Properties.EntryOffset
					nameFrame.Position = UDim2.new(0,leftOffset,0,0)
					propNameLabel.Size = UDim2.new(1,-2 - (scaleType == 0 and 0 or 6),1,0)

					local gName = (prop.CategoryName and "CAT_"..prop.CategoryName) or prop.Class.."."..prop.Name..(prop.SubName or "")

					if prop.CategoryName then
						entry.BackgroundColor3 = Settings.Theme.Main1
						valueFrame.Visible = false

						propNameBox.Text = prop.CategoryName
						propNameBox.Font = Enum.Font.SourceSansBold
						expand.Visible = true
						propNameBox.TextColor3 = Settings.Theme.Text
						nameFrame.BackgroundTransparency = 1
						nameFrame.Size = UDim2.new(1,0,1,0)
						editAttributeButton.Visible = false

						local showingAttrs = Settings.Properties.ShowAttributes
						toggleAttributes.Position = UDim2.new(1,-85-leftOffset,0,0)
						toggleAttributes.Text = (showingAttrs and "[Setting: ON]" or "[Setting: OFF]")
						toggleAttributes.TextColor3 = Settings.Theme.Text
						toggleAttributes.Visible = (prop.CategoryName == "Attributes")
					else
						local propName = prop.Name
						local typeData = prop.ValueType
						local typeName = typeData.Name
						local tags = prop.Tags
						local propObj = autoUpdateObjs[gName]

						local attributeOffset = (prop.IsAttribute and 20 or 0)
						editAttributeButton.Visible = (prop.IsAttribute and not prop.RootType)
						toggleAttributes.Visible = false

						-- Moving around the frames
						if scaleType == 0 then
							nameFrame.Size = UDim2.new(0,Properties.ViewWidth - leftOffset - 1,1,0)
							valueFrame.Position = UDim2.new(0,Properties.ViewWidth,0,0)
							valueFrame.Size = UDim2.new(0,valueWidth - attributeOffset,1,0)
						else
							nameFrame.Size = UDim2.new(0.5,-leftOffset - 1,1,0)
							valueFrame.Position = UDim2.new(0.5,0,0,0)
							valueFrame.Size = UDim2.new(0.5,-attributeOffset,1,0)
						end

						local nameArr = stringSplit(gName,".")
						propNameBox.Text = prop.DisplayName or nameArr[#nameArr]
						propNameBox.Font = Enum.Font.SourceSans
						entry.BackgroundColor3 = Settings.Theme.Main2
						valueFrame.Visible = true

						expand.Visible = typeData.Category == "DataType" and Properties.ExpandableTypes[typeName] or Properties.ExpandableProps[gName]
						propNameBox.TextColor3 = tags.ReadOnly and Settings.Theme.PlaceholderText or Settings.Theme.Text

						-- Display property value
						Properties.DisplayProp(prop,i)
						if propObj then
							if prop.IsAttribute then
								propCons[#propCons+1] = getAttributeChangedSignal(propObj,prop.AttributeName):Connect(function()
									Properties.DisplayProp(prop,i)
								end)
							else
								propCons[#propCons+1] = getPropChangedSignal(propObj,propName):Connect(function()
									Properties.DisplayProp(prop,i)
								end)
							end
						end

						-- Position and resize Input Box
						local beforeVisible = valueBox.Visible
						local inputFullName = inputProp and (inputProp.Class.."."..inputProp.Name..(inputProp.SubName or ""))
						if gName == inputFullName then
							nameFrame.BackgroundColor3 = Settings.Theme.ListSelection
							nameFrame.BackgroundTransparency = 0
							if typeData.Category == "Class" or typeData.Category == "Enum" or typeName == "BrickColor" then
								valueFrame.BackgroundColor3 = Settings.Theme.TextBox
								valueFrame.BackgroundTransparency = 0
								valueBox.Visible = true
							else
								inputPropVisible = true
								local scale = (scaleType == 0 and 0 or 0.5)
								local offset = (scaleType == 0 and Properties.ViewWidth-scrollH.Index or 0)
								local endOffset = 0

								if typeName == "Color3" or typeName == "ColorSequence" then
									offset = offset + 22
								end

								if typeName == "NumberSequence" or typeName == "ColorSequence" then
									endOffset = 20
								end

								inputBox.Position = UDim2.new(scale,offset,0,entry.Position.Y.Offset)
								inputBox.Size = UDim2.new(1-scale,-offset-endOffset-attributeOffset,0,22)
								inputBox.Visible = true
								valueBox.Visible = false
							end
						else
							nameFrame.BackgroundColor3 = Settings.Theme.Main1
							nameFrame.BackgroundTransparency = 1
							valueFrame.BackgroundColor3 = Settings.Theme.Main1
							valueFrame.BackgroundTransparency = 1
							valueBox.Visible = beforeVisible
						end
					end

					-- Expand
					if prop.CategoryName or Properties.ExpandableTypes[prop.ValueType and prop.ValueType.Name] or Properties.ExpandableProps[gName] then
						if Lib.CheckMouseInGui(expand) then
							Main.MiscIcons:DisplayByKey(expand.Icon, expanded[gName] and "Collapse_Over" or "Expand_Over")
						else
							Main.MiscIcons:DisplayByKey(expand.Icon, expanded[gName] and "Collapse" or "Expand")
						end
						expand.Visible = true
					else
						expand.Visible = false
					end
				end
				entry.Visible = true
			else
				entry.Visible = false
			end
		end

		if not inputPropVisible then
			inputBox.Visible = false
		end

		for i = maxEntries+1,#propEntries do
			propEntries[i].Gui:Destroy()
			propEntries[i] = nil
			checkboxes[i] = nil
		end
	end

	Properties.SetProp = function(prop,val,noupdate,prevAttribute)
		local sList = Explorer.Selection.List
		local propName = prop.Name
		local subName = prop.SubName
		local propClass = prop.Class
		local typeData = prop.ValueType
		local typeName = typeData.Name
		local attributeName = prop.AttributeName
		local rootTypeData = prop.RootType
		local rootTypeName = rootTypeData and rootTypeData.Name
		local fullName = prop.Class.."."..prop.Name..(prop.SubName or "")
		local Vector3 = Vector3

		for i = 1,#sList do
			local node = sList[i]
			local obj = node.Obj

			if isa(obj,propClass) then
				pcall(function()
					local setVal = val
					local root
					if prop.IsAttribute then
						root = getAttribute(obj,attributeName)
					else
						root = obj[propName]
					end

					if prevAttribute then
						if prevAttribute.ValueType.Name == typeName then
							setVal = getAttribute(obj,prevAttribute.AttributeName) or setVal
						end
						setAttribute(obj,prevAttribute.AttributeName,nil)
					end

					if rootTypeName then
						if rootTypeName == "Vector2" then
							setVal = Vector2.new((subName == ".X" and setVal) or root.X, (subName == ".Y" and setVal) or root.Y)
						elseif rootTypeName == "Vector3" then
							setVal = Vector3.new((subName == ".X" and setVal) or root.X, (subName == ".Y" and setVal) or root.Y, (subName == ".Z" and setVal) or root.Z)
						elseif rootTypeName == "UDim" then
							setVal = UDim.new((subName == ".Scale" and setVal) or root.Scale, (subName == ".Offset" and setVal) or root.Offset)
						elseif rootTypeName == "UDim2" then
							local rootX,rootY = root.X,root.Y
							local X_UDim = (subName == ".X" and setVal) or UDim.new((subName == ".X.Scale" and setVal) or rootX.Scale, (subName == ".X.Offset" and setVal) or rootX.Offset)
							local Y_UDim = (subName == ".Y" and setVal) or UDim.new((subName == ".Y.Scale" and setVal) or rootY.Scale, (subName == ".Y.Offset" and setVal) or rootY.Offset)
							setVal = UDim2.new(X_UDim,Y_UDim)
						elseif rootTypeName == "CFrame" then
							local rootPos,rootRight,rootUp,rootLook = root.Position,root.RightVector,root.UpVector,root.LookVector
							local pos = (subName == ".Position" and setVal) or Vector3.new((subName == ".Position.X" and setVal) or rootPos.X, (subName == ".Position.Y" and setVal) or rootPos.Y, (subName == ".Position.Z" and setVal) or rootPos.Z)
							local rightV = (subName == ".RightVector" and setVal) or Vector3.new((subName == ".RightVector.X" and setVal) or rootRight.X, (subName == ".RightVector.Y" and setVal) or rootRight.Y, (subName == ".RightVector.Z" and setVal) or rootRight.Z)
							local upV = (subName == ".UpVector" and setVal) or Vector3.new((subName == ".UpVector.X" and setVal) or rootUp.X, (subName == ".UpVector.Y" and setVal) or rootUp.Y, (subName == ".UpVector.Z" and setVal) or rootUp.Z)
							local lookV = (subName == ".LookVector" and setVal) or Vector3.new((subName == ".LookVector.X" and setVal) or rootLook.X, (subName == ".RightVector.Y" and setVal) or rootLook.Y, (subName == ".RightVector.Z" and setVal) or rootLook.Z)
							setVal = CFrame.fromMatrix(pos,rightV,upV,-lookV)
						elseif rootTypeName == "Rect" then
							local rootMin,rootMax = root.Min,root.Max
							local min = Vector2.new((subName == ".Min.X" and setVal) or rootMin.X, (subName == ".Min.Y" and setVal) or rootMin.Y)
							local max = Vector2.new((subName == ".Max.X" and setVal) or rootMax.X, (subName == ".Max.Y" and setVal) or rootMax.Y)
							setVal = Rect.new(min,max)
						elseif rootTypeName == "PhysicalProperties" then
							local rootProps = PhysicalProperties.new(obj.Material)
							local density = (subName == ".Density" and setVal) or (root and root.Density) or rootProps.Density
							local friction = (subName == ".Friction" and setVal) or (root and root.Friction) or rootProps.Friction
							local elasticity = (subName == ".Elasticity" and setVal) or (root and root.Elasticity) or rootProps.Elasticity
							local frictionWeight = (subName == ".FrictionWeight" and setVal) or (root and root.FrictionWeight) or rootProps.FrictionWeight
							local elasticityWeight = (subName == ".ElasticityWeight" and setVal) or (root and root.ElasticityWeight) or rootProps.ElasticityWeight
							setVal = PhysicalProperties.new(density,friction,elasticity,frictionWeight,elasticityWeight)
						elseif rootTypeName == "Ray" then
							local rootOrigin,rootDirection = root.Origin,root.Direction
							local origin = (subName == ".Origin" and setVal) or Vector3.new((subName == ".Origin.X" and setVal) or rootOrigin.X, (subName == ".Origin.Y" and setVal) or rootOrigin.Y, (subName == ".Origin.Z" and setVal) or rootOrigin.Z)
							local direction = (subName == ".Direction" and setVal) or Vector3.new((subName == ".Direction.X" and setVal) or rootDirection.X, (subName == ".Direction.Y" and setVal) or rootDirection.Y, (subName == ".Direction.Z" and setVal) or rootDirection.Z)
							setVal = Ray.new(origin,direction)
						elseif rootTypeName == "Faces" then
							local faces = {}
							local faceList = {"Back","Bottom","Front","Left","Right","Top"}
							for _,face in pairs(faceList) do
								local val
								if subName == "."..face then
									val = setVal
								else
									val = root[face]
								end
								if val then faces[#faces+1] = Enum.NormalId[face] end
							end
							setVal = Faces.new(unpack(faces))
						elseif rootTypeName == "Axes" then
							local axes = {}
							local axesList = {"X","Y","Z"}
							for _,axe in pairs(axesList) do
								local val
								if subName == "."..axe then
									val = setVal
								else
									val = root[axe]
								end
								if val then axes[#axes+1] = Enum.Axis[axe] end
							end
							setVal = Axes.new(unpack(axes))
						elseif rootTypeName == "NumberRange" then
							setVal = NumberRange.new(subName == ".Min" and setVal or root.Min, subName == ".Max" and setVal or root.Max)
						end
					end

					if typeName == "PhysicalProperties" and setVal then
						setVal = root or PhysicalProperties.new(obj.Material)
					end

					if prop.IsAttribute then
						setAttribute(obj,attributeName,setVal)
					else
						obj[propName] = setVal
					end
				end)
			end
		end

		if not noupdate then
			Properties.ComputeConflicts(prop)
		end
	end

	Properties.InitInputBox = function()
		inputBox = create({
			{1,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderSizePixel=0,Name="InputBox",Size=UDim2.new(0,200,0,22),Visible=false,ZIndex=2,}},
			{2,"TextBox",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BackgroundTransparency=1,BorderColor3=Color3.new(0.062745101749897,0.51764708757401,1),BorderSizePixel=0,ClearTextOnFocus=false,Font=3,Parent={1},PlaceholderColor3=Color3.new(0.69803923368454,0.69803923368454,0.69803923368454),Position=UDim2.new(0,3,0,0),Size=UDim2.new(1,-6,1,0),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=0,ZIndex=2,}},
		})
		inputTextBox = inputBox.TextBox
		inputBox.BackgroundColor3 = Settings.Theme.TextBox
		inputBox.Parent = Properties.Window.GuiElems.Content.List

		inputTextBox.FocusLost:Connect(function()
			if not inputProp then return end

			local prop = inputProp
			inputProp = nil
			local val = Properties.StringToValue(prop,inputTextBox.Text)
			if val then Properties.SetProp(prop,val) else Properties.Refresh() end
		end)

		inputTextBox.Focused:Connect(function()
			inputTextBox.SelectionStart = 1
			inputTextBox.CursorPosition = #inputTextBox.Text + 1
		end)

		Lib.ViewportTextBox.convert(inputTextBox)
	end

	Properties.SetInputProp = function(prop,entryIndex,special)
		local typeData = prop.ValueType
		local typeName = typeData.Name
		local fullName = prop.Class.."."..prop.Name..(prop.SubName or "")
		local propObj = autoUpdateObjs[fullName]
		local propVal = Properties.GetPropVal(prop,propObj)

		if prop.Tags.ReadOnly then return end

		inputProp = prop
		if special then
			if special == "color" then
				if typeName == "Color3" then
					inputTextBox.Text = propVal and Properties.ValueToString(prop,propVal) or ""
					Properties.DisplayColorEditor(prop,propVal)
				elseif typeName == "BrickColor" then
					Properties.DisplayBrickColorEditor(prop,entryIndex,propVal)
				elseif typeName == "ColorSequence" then
					inputTextBox.Text = propVal and Properties.ValueToString(prop,propVal) or ""
					Properties.DisplayColorSequenceEditor(prop,propVal)
				end
			elseif special == "right" then
				if typeName == "NumberSequence" then
					inputTextBox.Text = propVal and Properties.ValueToString(prop,propVal) or ""
					Properties.DisplayNumberSequenceEditor(prop,propVal)
				elseif typeName == "ColorSequence" then
					inputTextBox.Text = propVal and Properties.ValueToString(prop,propVal) or ""
					Properties.DisplayColorSequenceEditor(prop,propVal)
				end
			end
		else
			if Properties.IsTextEditable(prop) then
				inputTextBox.Text = propVal and Properties.ValueToString(prop,propVal) or ""
				inputTextBox:CaptureFocus()
			elseif typeData.Category == "Enum" then
				Properties.DisplayEnumDropdown(entryIndex)
			elseif typeName == "BrickColor" then
				Properties.DisplayBrickColorEditor(prop,entryIndex,propVal)
			end
		end
		Properties.Refresh()
	end

	Properties.InitSearch = function()
		local searchBox = Properties.GuiElems.ToolBar.SearchFrame.SearchBox

		Lib.ViewportTextBox.convert(searchBox)

		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			Properties.SearchText = searchBox.Text
			Properties.Update()
			Properties.Refresh()
		end)
	end

	Properties.InitEntryStuff = function()
		Properties.EntryTemplate = create({
			{1,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderColor3=Color3.new(0.1294117718935,0.1294117718935,0.1294117718935),Font=3,Name="Entry",Position=UDim2.new(0,1,0,1),Size=UDim2.new(0,250,0,22),Text="",TextSize=14,}},
			{2,"Frame",{BackgroundColor3=Color3.new(0.04313725605607,0.35294118523598,0.68627452850342),BackgroundTransparency=1,BorderColor3=Color3.new(0.33725491166115,0.49019610881805,0.73725491762161),BorderSizePixel=0,Name="NameFrame",Parent={1},Position=UDim2.new(0,20,0,0),Size=UDim2.new(1,-40,1,0),}},
			{3,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="PropName",Parent={2},Position=UDim2.new(0,2,0,0),Size=UDim2.new(1,-2,1,0),Text="Anchored",TextColor3=Color3.new(1,1,1),TextSize=14,TextTransparency=0.10000000149012,TextTruncate=1,TextXAlignment=0,}},
			{4,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,ClipsDescendants=true,Font=3,Name="Expand",Parent={2},Position=UDim2.new(0,-20,0,1),Size=UDim2.new(0,20,0,20),Text="",TextSize=14,Visible=false,}},
			{5,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5642383285"),ImageRectOffset=Vector2.new(144,16),ImageRectSize=Vector2.new(16,16),Name="Icon",Parent={4},Position=UDim2.new(0,2,0,2),ScaleType=4,Size=UDim2.new(0,16,0,16),}},
			{6,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=4,Name="ToggleAttributes",Parent={2},Position=UDim2.new(1,-85,0,0),Size=UDim2.new(0,85,0,22),Text="[SETTING: OFF]",TextColor3=Color3.new(1,1,1),TextSize=14,TextTransparency=0.10000000149012,Visible=false,}},
			{7,"Frame",{BackgroundColor3=Color3.new(0.04313725605607,0.35294118523598,0.68627452850342),BackgroundTransparency=1,BorderColor3=Color3.new(0.33725491166115,0.49019607901573,0.73725491762161),BorderSizePixel=0,Name="ValueFrame",Parent={1},Position=UDim2.new(1,-100,0,0),Size=UDim2.new(0,80,1,0),}},
			{8,"Frame",{BackgroundColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderColor3=Color3.new(0.33725491166115,0.49019610881805,0.73725491762161),BorderSizePixel=0,Name="Line",Parent={7},Position=UDim2.new(0,-1,0,0),Size=UDim2.new(0,1,1,0),}},
			{9,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="ColorButton",Parent={7},Size=UDim2.new(0,20,0,22),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,Visible=false,}},
			{10,"Frame",{BackgroundColor3=Color3.new(1,1,1),BorderColor3=Color3.new(0,0,0),Name="ColorPreview",Parent={9},Position=UDim2.new(0,5,0,6),Size=UDim2.new(0,10,0,10),}},
			{11,"UIGradient",{Parent={10},}},
			{12,"Frame",{BackgroundTransparency=1,Name="EnumArrow",Parent={7},Position=UDim2.new(1,-16,0,3),Size=UDim2.new(0,16,0,16),Visible=false,}},
			{13,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={12},Position=UDim2.new(0,8,0,9),Size=UDim2.new(0,1,0,1),}},
			{14,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={12},Position=UDim2.new(0,7,0,8),Size=UDim2.new(0,3,0,1),}},
			{15,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={12},Position=UDim2.new(0,6,0,7),Size=UDim2.new(0,5,0,1),}},
			{16,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="ValueBox",Parent={7},Position=UDim2.new(0,4,0,0),Size=UDim2.new(1,-8,1,0),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,TextTransparency=0.10000000149012,TextTruncate=1,TextXAlignment=0,}},
			{17,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="RightButton",Parent={7},Position=UDim2.new(1,-20,0,0),Size=UDim2.new(0,20,0,22),Text="...",TextColor3=Color3.new(1,1,1),TextSize=14,Visible=false,}},
			{18,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="SettingsButton",Parent={7},Position=UDim2.new(1,-20,0,0),Size=UDim2.new(0,20,0,22),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,Visible=false,}},
			{19,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name="SoundPreview",Parent={7},Size=UDim2.new(1,0,1,0),Visible=false,}},
			{20,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="ControlButton",Parent={19},Size=UDim2.new(0,20,0,22),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,}},
			{21,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5642383285"),ImageRectOffset=Vector2.new(144,16),ImageRectSize=Vector2.new(16,16),Name="Icon",Parent={20},Position=UDim2.new(0,2,0,3),ScaleType=4,Size=UDim2.new(0,16,0,16),}},
			{22,"Frame",{BackgroundColor3=Color3.new(0.3137255012989,0.3137255012989,0.3137255012989),BorderSizePixel=0,Name="TimeLine",Parent={19},Position=UDim2.new(0,26,0.5,-1),Size=UDim2.new(1,-34,0,2),}},
			{23,"Frame",{BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.1294117718935,0.1294117718935,0.1294117718935),Name="Slider",Parent={22},Position=UDim2.new(0,-4,0,-8),Size=UDim2.new(0,8,0,18),}},
			{24,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="EditAttributeButton",Parent={1},Position=UDim2.new(1,-20,0,0),Size=UDim2.new(0,20,0,22),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,}},
			{25,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5034718180"),ImageTransparency=0.20000000298023,Name="Icon",Parent={24},Position=UDim2.new(0,2,0,3),Size=UDim2.new(0,16,0,16),}},
			{26,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderSizePixel=0,Font=3,Name="RowButton",Parent={1},Size=UDim2.new(1,0,1,0),Text="Add Attribute",TextColor3=Color3.new(1,1,1),TextSize=14,TextTransparency=0.10000000149012,Visible=false,}},
		})

		local fullNameFrame = Lib.Frame.new()
		local label = Lib.Label.new()
		label.Parent = fullNameFrame.Gui
		label.Position = UDim2.new(0,2,0,0)
		label.Size = UDim2.new(1,-4,1,0)
		fullNameFrame.Visible = false
		fullNameFrame.Parent = window.Gui

		Properties.FullNameFrame = fullNameFrame
		Properties.FullNameFrameAttach = Lib.AttachTo(fullNameFrame)
	end

	Properties.Init = function() -- TODO: MAKE BETTER
		local guiItems = create({
			{1,"Folder",{Name="Items",}},
			{2,"Frame",{BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderSizePixel=0,Name="ToolBar",Parent={1},Size=UDim2.new(1,0,0,22),}},
			{3,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.1176470592618,0.1176470592618,0.1176470592618),BorderSizePixel=0,Name="SearchFrame",Parent={2},Position=UDim2.new(0,3,0,1),Size=UDim2.new(1,-6,0,18),}},
			{4,"TextBox",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,ClearTextOnFocus=false,Font=3,Name="SearchBox",Parent={3},PlaceholderColor3=Color3.new(0.39215689897537,0.39215689897537,0.39215689897537),PlaceholderText="Search properties",Position=UDim2.new(0,4,0,0),Size=UDim2.new(1,-24,0,18),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=0,}},
			{5,"UICorner",{CornerRadius=UDim.new(0,2),Parent={3},}},
			{6,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Reset",Parent={3},Position=UDim2.new(1,-17,0,1),Size=UDim2.new(0,16,0,16),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,}},
			{7,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5034718129"),ImageColor3=Color3.new(0.39215686917305,0.39215686917305,0.39215686917305),Parent={6},Size=UDim2.new(0,16,0,16),}},
			{8,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Refresh",Parent={2},Position=UDim2.new(1,-20,0,1),Size=UDim2.new(0,18,0,18),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,Visible=false,}},
			{9,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5642310344"),Parent={8},Position=UDim2.new(0,3,0,3),Size=UDim2.new(0,12,0,12),}},
			{10,"Frame",{BackgroundColor3=Color3.new(0.15686275064945,0.15686275064945,0.15686275064945),BorderSizePixel=0,Name="ScrollCorner",Parent={1},Position=UDim2.new(1,-16,1,-16),Size=UDim2.new(0,16,0,16),Visible=false,}},
			{11,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,ClipsDescendants=true,Name="List",Parent={1},Position=UDim2.new(0,0,0,23),Size=UDim2.new(1,0,1,-23),}},
		})

		-- Vars
		categoryOrder =  API.CategoryOrder
		for category,_ in next,categoryOrder do
			if not Properties.CollapsedCategories[category] then
				expanded["CAT_"..category] = true
			end
		end
		expanded["Sound.SoundId"] = true

		-- Init window
		window = Lib.Window.new()
		Properties.Window = window
		window:SetTitle("Properties")

		toolBar = guiItems.ToolBar
		propsFrame = guiItems.List

		Properties.GuiElems.ToolBar = toolBar
		Properties.GuiElems.PropsFrame = propsFrame

		Properties.InitEntryStuff()

		-- Window events
		window.GuiElems.Main:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			if Properties.Window:IsContentVisible() then
				Properties.UpdateView()
				Properties.Refresh()
			end
		end)
		window.OnActivate:Connect(function()
			Properties.UpdateView()
			Properties.Update()
			Properties.Refresh()
		end)
		window.OnRestore:Connect(function()
			Properties.UpdateView()
			Properties.Update()
			Properties.Refresh()
		end)

		-- Init scrollbars
		scrollV = Lib.ScrollBar.new()		
		scrollV.WheelIncrement = 3
		scrollV.Gui.Position = UDim2.new(1,-16,0,23)
		scrollV:SetScrollFrame(propsFrame)
		scrollV.Scrolled:Connect(function()
			Properties.Index = scrollV.Index
			Properties.Refresh()
		end)

		scrollH = Lib.ScrollBar.new(true)
		scrollH.Increment = 5
		scrollH.WheelIncrement = 20
		scrollH.Gui.Position = UDim2.new(0,0,1,-16)
		scrollH.Scrolled:Connect(function()
			Properties.Refresh()
		end)

		-- Setup Gui
		window.GuiElems.Line.Position = UDim2.new(0,0,0,22)
		toolBar.Parent = window.GuiElems.Content
		propsFrame.Parent = window.GuiElems.Content
		guiItems.ScrollCorner.Parent = window.GuiElems.Content
		scrollV.Gui.Parent = window.GuiElems.Content
		scrollH.Gui.Parent = window.GuiElems.Content
		Properties.InitInputBox()
		Properties.InitSearch()
	end

	return Properties
end

return {InitDeps = initDeps, InitAfterMain = initAfterMain, Main = main}
end,["ScriptViewer"] = function()
--[[
	Script Viewer App Module
	
	A script viewer that is basically a notepad
]]

-- Common Locals
local Main,Lib,Apps,Settings -- Main Containers
local Explorer, Properties, ScriptViewer, Notebook -- Major Apps
local API,RMD,env,service,plr,create,createSimple -- Main Locals

local function initDeps(data)
	Main = data.Main
	Lib = data.Lib
	Apps = data.Apps
	Settings = data.Settings

	API = data.API
	RMD = data.RMD
	env = data.env
	service = data.service
	plr = data.plr
	create = data.create
	createSimple = data.createSimple
end

local function initAfterMain()
	Explorer = Apps.Explorer
	Properties = Apps.Properties
	ScriptViewer = Apps.ScriptViewer
	Notebook = Apps.Notebook
end

local function main()
	local ScriptViewer = {}

	local window,codeFrame

	ScriptViewer.ViewScript = function(scr)
		local s,source = pcall(env.decompile or function() end,scr)
		if not s or not source then
			source = "local test = 5\n\nlocal c = test + tick()\ngame.Workspace.Board:Destroy()\nstring.match('wow\\'f',\"yes\",3.4e-5,true)\ngame. Workspace.Wow\nfunction bar() print(54) end\n string . match() string 4 .match()"
			source = source.."\n"..[==[
			function a.sad() end
			function a.b:sad() end
			function 4.why() end
			function a b() end
			function string.match() end
			function string.match.why() end
			function local() end
			function local.thing() end
			string  . "sad" match
			().magnitude = 3
			a..b
			a..b()
			a...b
			a...b()
			a....b
			a....b()
			string..match()
			string....match()
			]==]
		end

		codeFrame:SetText(source)
		window:Show()
	end

	ScriptViewer.Init = function()
		window = Lib.Window.new()
		window:SetTitle("Script Viewer")
		window:Resize(500,400)
		ScriptViewer.Window = window

		codeFrame = Lib.CodeFrame.new()
		codeFrame.Frame.Position = UDim2.new(0,0,0,20)
		codeFrame.Frame.Size = UDim2.new(1,0,1,-20)
		codeFrame.Frame.Parent = window.GuiElems.Content

		-- TODO: REMOVE AND MAKE BETTER
		local copy = Instance.new("TextButton",window.GuiElems.Content)
		copy.BackgroundTransparency = 1
		copy.Size = UDim2.new(0.5,0,0,20)
		copy.Text = "Copy to Clipboard"
		copy.TextColor3 = Color3.new(1,1,1)

		copy.MouseButton1Click:Connect(function()
			local source = codeFrame:GetText()
			setclipboard(source)
		end)

		local save = Instance.new("TextButton",window.GuiElems.Content)
		save.BackgroundTransparency = 1
		save.Position = UDim2.new(0.5,0,0,0)
		save.Size = UDim2.new(0.5,0,0,20)
		save.Text = "Save to File"
		save.TextColor3 = Color3.new(1,1,1)

		save.MouseButton1Click:Connect(function()
			local source = codeFrame:GetText()
			local filename = "Place_"..game.PlaceId.."_Script_"..os.time()..".txt"

			writefile(filename,source)
			if movefileas then -- TODO: USE ENV
				movefileas(filename,".txt")
			end
		end)
	end

	return ScriptViewer
end

return {InitDeps = initDeps, InitAfterMain = initAfterMain, Main = main}
end,["Lib"] = function()
--[[
	Lib Module
	
	Container for functions and classes
]]

-- Common Locals
local Main,Lib,Apps,Settings -- Main Containers
local Explorer, Properties, ScriptViewer, Notebook -- Major Apps
local API,RMD,env,service,plr,create,createSimple -- Main Locals

local function initDeps(data)
	Main = data.Main
	Lib = data.Lib
	Apps = data.Apps
	Settings = data.Settings

	API = data.API
	RMD = data.RMD
	env = data.env
	service = data.service
	plr = data.plr
	create = data.create
	createSimple = data.createSimple
end

local function initAfterMain()
	Explorer = Apps.Explorer
	Properties = Apps.Properties
	ScriptViewer = Apps.ScriptViewer
	Notebook = Apps.Notebook
end

local function main()
	local Lib = {}

	local renderStepped = service.RunService.RenderStepped
	local signalWait = renderStepped.wait
	local PH = newproxy() -- Placeholder, must be replaced in constructor
	local SIGNAL = newproxy()

	-- Usually for classes that work with a Roblox Object
	local function initObj(props,mt)
		local type = type
		local function copy(t)
			local res = {}
			for i,v in pairs(t) do
				if v == SIGNAL then
					res[i] = Lib.Signal.new()
				elseif type(v) == "table" then
					res[i] = copy(v)
				else
					res[i] = v
				end
			end		
			return res
		end

		local newObj = copy(props)
		return setmetatable(newObj,mt)
	end

	local function getGuiMT(props,funcs)
		return {__index = function(self,ind) if not props[ind] then return funcs[ind] or self.Gui[ind] end end,
		__newindex = function(self,ind,val) if not props[ind] then self.Gui[ind] = val else rawset(self,ind,val) end end}
	end

	-- Functions

	Lib.FormatLuaString = (function()
		local string = string
		local gsub = string.gsub
		local format = string.format
		local char = string.char
		local cleanTable = {['"'] = '\\"', ['\\'] = '\\\\'}
		for i = 0,31 do
			cleanTable[char(i)] = "\\"..format("%03d",i)
		end
		for i = 127,255 do
			cleanTable[char(i)] = "\\"..format("%03d",i)
		end

		return function(str)
			return gsub(str,"[\"\\\0-\31\127-\255]",cleanTable)
		end
	end)()

	Lib.CheckMouseInGui = function(gui)
		if gui == nil then return false end
		local mouse = Main.Mouse
		local guiPosition = gui.AbsolutePosition
		local guiSize = gui.AbsoluteSize	

		return mouse.X >= guiPosition.X and mouse.X < guiPosition.X + guiSize.X and mouse.Y >= guiPosition.Y and mouse.Y < guiPosition.Y + guiSize.Y
	end

	Lib.IsShiftDown = function()
		return service.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or service.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
	end

	Lib.IsCtrlDown = function()
		return service.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or service.UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
	end

	Lib.CreateArrow = function(size,num,dir)
		local max = num
		local arrowFrame = createSimple("Frame",{
			BackgroundTransparency = 1,
			Name = "Arrow",
			Size = UDim2.new(0,size,0,size)
		})
		if dir == "up" then
			for i = 1,num do
				local newLine = createSimple("Frame",{
					BackgroundColor3 = Color3.new(220/255,220/255,220/255),
					BorderSizePixel = 0,
					Position = UDim2.new(0,math.floor(size/2)-(i-1),0,math.floor(size/2)+i-math.floor(max/2)-1),
					Size = UDim2.new(0,i+(i-1),0,1),
					Parent = arrowFrame
				})
			end
			return arrowFrame
		elseif dir == "down" then
			for i = 1,num do
				local newLine = createSimple("Frame",{
					BackgroundColor3 = Color3.new(220/255,220/255,220/255),
					BorderSizePixel = 0,
					Position = UDim2.new(0,math.floor(size/2)-(i-1),0,math.floor(size/2)-i+math.floor(max/2)+1),
					Size = UDim2.new(0,i+(i-1),0,1),
					Parent = arrowFrame
				})
			end
			return arrowFrame
		elseif dir == "left" then
			for i = 1,num do
				local newLine = createSimple("Frame",{
					BackgroundColor3 = Color3.new(220/255,220/255,220/255),
					BorderSizePixel = 0,
					Position = UDim2.new(0,math.floor(size/2)+i-math.floor(max/2)-1,0,math.floor(size/2)-(i-1)),
					Size = UDim2.new(0,1,0,i+(i-1)),
					Parent = arrowFrame
				})
			end
			return arrowFrame
		elseif dir == "right" then
			for i = 1,num do
				local newLine = createSimple("Frame",{
					BackgroundColor3 = Color3.new(220/255,220/255,220/255),
					BorderSizePixel = 0,
					Position = UDim2.new(0,math.floor(size/2)-i+math.floor(max/2)+1,0,math.floor(size/2)-(i-1)),
					Size = UDim2.new(0,1,0,i+(i-1)),
					Parent = arrowFrame
				})
			end
			return arrowFrame
		end
		error("r u ok")
	end

	Lib.ParseXML = (function()
		local func = function()
			-- Only exists to parse RMD
			-- from https://github.com/jonathanpoelen/xmlparser

			local string, print, pairs = string, print, pairs

			-- http://lua-users.org/wiki/StringTrim
			local trim = function(s)
				local from = s:match"^%s*()"
				return from > #s and "" or s:match(".*%S", from)
			end

			local gtchar = string.byte('>', 1)
			local slashchar = string.byte('/', 1)
			local D = string.byte('D', 1)
			local E = string.byte('E', 1)

			function parse(s, evalEntities)
				-- remove comments
				s = s:gsub('<!%-%-(.-)%-%->', '')

				local entities, tentities = {}

				if evalEntities then
					local pos = s:find('<[_%w]')
					if pos then
						s:sub(1, pos):gsub('<!ENTITY%s+([_%w]+)%s+(.)(.-)%2', function(name, q, entity)
							entities[#entities+1] = {name=name, value=entity}
						end)
						tentities = createEntityTable(entities)
						s = replaceEntities(s:sub(pos), tentities)
					end
				end

				local t, l = {}, {}

				local addtext = function(txt)
					txt = txt:match'^%s*(.*%S)' or ''
					if #txt ~= 0 then
						t[#t+1] = {text=txt}
					end    
				end

				s:gsub('<([?!/]?)([-:_%w]+)%s*(/?>?)([^<]*)', function(type, name, closed, txt)
					-- open
					if #type == 0 then
						local a = {}
						if #closed == 0 then
							local len = 0
							for all,aname,_,value,starttxt in string.gmatch(txt, "(.-([-_%w]+)%s*=%s*(.)(.-)%3%s*(/?>?))") do
								len = len + #all
								a[aname] = value
								if #starttxt ~= 0 then
									txt = txt:sub(len+1)
									closed = starttxt
									break
								end
							end
						end
						t[#t+1] = {tag=name, attrs=a, children={}}

						if closed:byte(1) ~= slashchar then
							l[#l+1] = t
							t = t[#t].children
						end

						addtext(txt)
						-- close
					elseif '/' == type then
						t = l[#l]
						l[#l] = nil

						addtext(txt)
						-- ENTITY
					elseif '!' == type then
						if E == name:byte(1) then
							txt:gsub('([_%w]+)%s+(.)(.-)%2', function(name, q, entity)
								entities[#entities+1] = {name=name, value=entity}
							end, 1)
						end
						-- elseif '?' == type then
						--   print('?  ' .. name .. ' // ' .. attrs .. '$$')
						-- elseif '-' == type then
						--   print('comment  ' .. name .. ' // ' .. attrs .. '$$')
						-- else
						--   print('o  ' .. #p .. ' // ' .. name .. ' // ' .. attrs .. '$$')
					end
				end)

				return {children=t, entities=entities, tentities=tentities}
			end

			function parseText(txt)
				return parse(txt)
			end

			function defaultEntityTable()
				return { quot='"', apos='\'', lt='<', gt='>', amp='&', tab='\t', nbsp=' ', }
			end

			function replaceEntities(s, entities)
				return s:gsub('&([^;]+);', entities)
			end

			function createEntityTable(docEntities, resultEntities)
				entities = resultEntities or defaultEntityTable()
				for _,e in pairs(docEntities) do
					e.value = replaceEntities(e.value, entities)
					entities[e.name] = e.value
				end
				return entities
			end

			return parseText
		end
		local newEnv = setmetatable({},{__index = getfenv()})
		setfenv(func,newEnv)
		return func()
	end)()

	Lib.FastWait = function(time)
		if type(time) ~= 'number' then
			return task.wait()
		end
		return task.wait(time)
	end

	Lib.ButtonAnim = function(button,data)
		local holding = false
		local disabled = false
		local mode = data and data.Mode or 1
		local control = {}

		if mode == 2 then
			local lerpTo = data.LerpTo or Color3.new(0,0,0)
			local delta = data.LerpDelta or 0.2
			control.StartColor = data.StartColor or button.BackgroundColor3
			control.PressColor = data.PressColor or control.StartColor:lerp(lerpTo,delta)
			control.HoverColor = data.HoverColor or control.StartColor:lerp(control.PressColor,0.6)
			control.OutlineColor = data.OutlineColor
		end

		button.InputBegan:Connect(function(input)
			if disabled then return end
			if input.UserInputType == Enum.UserInputType.MouseMovement and not holding then
				if mode == 1 then
					button.BackgroundTransparency = 0.4
				elseif mode == 2 then
					button.BackgroundColor3 = control.HoverColor
				end
			elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
				holding = true
				if mode == 1 then
					button.BackgroundTransparency = 0
				elseif mode == 2 then
					button.BackgroundColor3 = control.PressColor
					if control.OutlineColor then button.BorderColor3 = control.PressColor end
				end
			end
		end)

		button.InputEnded:Connect(function(input)
			if disabled then return end
			if input.UserInputType == Enum.UserInputType.MouseMovement and not holding then
				if mode == 1 then
					button.BackgroundTransparency = 1
				elseif mode == 2 then
					button.BackgroundColor3 = control.StartColor
				end
			elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
				holding = false
				if mode == 1 then
					button.BackgroundTransparency = Lib.CheckMouseInGui(button) and 0.4 or 1
				elseif mode == 2 then
					button.BackgroundColor3 = Lib.CheckMouseInGui(button) and control.HoverColor or control.StartColor
					if control.OutlineColor then button.BorderColor3 = control.OutlineColor end
				end
			end
		end)

		control.Disable = function()
			disabled = true
			holding = false

			if mode == 1 then
				button.BackgroundTransparency = 1
			elseif mode == 2 then
				button.BackgroundColor3 = control.StartColor
			end
		end

		control.Enable = function()
			disabled = false
		end

		return control
	end

	Lib.FindAndRemove = function(t,item)
		local pos = table.find(t,item)
		if pos then table.remove(t,pos) end
	end

	Lib.AttachTo = function(obj,data)
		local target,posOffX,posOffY,sizeOffX,sizeOffY,resize,con
		local disabled = false

		local function update()
			if not obj or not target then return end

			local targetPos = target.AbsolutePosition
			local targetSize = target.AbsoluteSize
			obj.Position = UDim2.new(0,targetPos.X + posOffX,0,targetPos.Y + posOffY)
			if resize then obj.Size = UDim2.new(0,targetSize.X + sizeOffX,0,targetSize.Y + sizeOffY) end
		end

		local function setup(o,data)
			obj = o
			data = data or {}
			target = data.Target
			posOffX = data.PosOffX or 0
			posOffY = data.PosOffY or 0
			sizeOffX = data.SizeOffX or 0
			sizeOffY = data.SizeOffY or 0
			resize = data.Resize or false

			if con then con:Disconnect() con = nil end
			if target then
				con = target.Changed:Connect(function(prop)
					if not disabled and prop == "AbsolutePosition" or prop == "AbsoluteSize" then
						update()
					end
				end)
			end

			update()
		end
		setup(obj,data)

		return {
			SetData = function(obj,data)
				setup(obj,data)
			end,
			Enable = function()
				disabled = false
				update()
			end,
			Disable = function()
				disabled = true
			end,
			Destroy = function()
				con:Disconnect()
				con = nil
			end,
		}
	end

	Lib.ProtectedGuis = {}

	Lib.ShowGui = function(gui)
		if env.protectgui then
		--	env.protectgui(gui)
		end
		gui.Parent = Main.GuiHolder
	end

	Lib.ColorToBytes = function(col)
		local round = math.round
		return string.format("%d, %d, %d",round(col.r*255),round(col.g*255),round(col.b*255))
	end

	Lib.ReadFile = function(filename)
		if not env.readfile then return end

		local s,contents = pcall(env.readfile,filename)
		if s and contents then return contents end
	end

	Lib.DeferFunc = task.defer
	
	Lib.LoadCustomAsset = function(filepath)
		if not env.getcustomasset or not env.isfile or not env.isfile(filepath) then return end

		return env.getcustomasset(filepath)
	end

	Lib.FetchCustomAsset = function(url,filepath)
		if not env.writefile then return end

		local s,data = pcall(game.HttpGet,game,url)
		if not s then return end

		env.writefile(filepath,data)
		return Lib.LoadCustomAsset(filepath)
	end

	-- Classes

	Lib.Signal = (function()
		local funcs = {}

		local disconnect = function(con)
			local pos = table.find(con.Signal.Connections,con)
			if pos then table.remove(con.Signal.Connections,pos) end
		end

		funcs.Connect = function(self,func)
			if type(func) ~= "function" then error("Attempt to connect a non-function") end		
			local con = {
				Signal = self,
				Func = func,
				Disconnect = disconnect
			}
			self.Connections[#self.Connections+1] = con
			return con
		end

		funcs.Fire = function(self,...)
			for i,v in next,self.Connections do
				xpcall(coroutine.wrap(v.Func),function(e) warn(e.."\n"..debug.traceback()) end,...)
			end
		end

		local mt = {
			__index = funcs,
			__tostring = function(self)
				return "Signal: " .. tostring(#self.Connections) .. " Connections"
			end
		}

		local function new()
			local obj = {}
			obj.Connections = {}

			return setmetatable(obj,mt)
		end

		return {new = new}
	end)()

	Lib.Set = (function()
		local funcs = {}

		funcs.Add = function(self,obj)
			if self.Map[obj] then return end

			local list = self.List
			list[#list+1] = obj
			self.Map[obj] = true
			self.Changed:Fire()
		end

		funcs.AddTable = function(self,t)
			local changed
			local list,map = self.List,self.Map
			for i = 1,#t do
				local elem = t[i]
				if not map[elem] then
					list[#list+1] = elem
					map[elem] = true
					changed = true
				end
			end
			if changed then self.Changed:Fire() end
		end

		funcs.Remove = function(self,obj)
			if not self.Map[obj] then return end

			local list = self.List
			local pos = table.find(list,obj)
			if pos then table.remove(list,pos) end
			self.Map[obj] = nil
			self.Changed:Fire()
		end

		funcs.RemoveTable = function(self,t)
			local changed
			local list,map = self.List,self.Map
			local removeSet = {}
			for i = 1,#t do
				local elem = t[i]
				map[elem] = nil
				removeSet[elem] = true
			end

			for i = #list,1,-1 do
				local elem = list[i]
				if removeSet[elem] then
					table.remove(list,i)
					changed = true
				end
			end
			if changed then self.Changed:Fire() end
		end

		funcs.Set = function(self,obj)
			if #self.List == 1 and self.List[1] == obj then return end

			self.List = {obj}
			self.Map = {[obj] = true}
			self.Changed:Fire()
		end

		funcs.SetTable = function(self,t)
			local newList,newMap = {},{}
			self.List,self.Map = newList,newMap
			table.move(t,1,#t,1,newList)
			for i = 1,#t do
				newMap[t[i]] = true
			end
			self.Changed:Fire()
		end

		funcs.Clear = function(self)
			if #self.List == 0 then return end
			self.List = {}
			self.Map = {}
			self.Changed:Fire()
		end

		local mt = {__index = funcs}

		local function new()
			local obj = setmetatable({
				List = {},
				Map = {},
				Changed = Lib.Signal.new()
			},mt)

			return obj
		end

		return {new = new}
	end)()

	Lib.IconMap = (function()
		local funcs = {}

		funcs.GetLabel = function(self)
			local label = Instance.new("ImageLabel")
			self:SetupLabel(label)
			return label
		end

		funcs.SetupLabel = function(self,obj)
			obj.BackgroundTransparency = 1
			obj.ImageRectOffset = Vector2.new(0,0)
			obj.ImageRectSize = Vector2.new(self.IconSizeX,self.IconSizeY)
			obj.ScaleType = Enum.ScaleType.Crop
			obj.Size = UDim2.new(0,self.IconSizeX,0,self.IconSizeY)
		end

		funcs.Display = function(self,obj,index)
			obj.Image = self.MapId
			if not self.NumX then
				obj.ImageRectOffset = Vector2.new(self.IconSizeX*index, 0)
			else
				obj.ImageRectOffset = Vector2.new(self.IconSizeX*(index % self.NumX), self.IconSizeY*math.floor(index / self.NumX))	
			end
		end

		funcs.DisplayByKey = function(self,obj,key)
			if self.IndexDict[key] then
				self:Display(obj,self.IndexDict[key])
			end
		end

		funcs.SetDict = function(self,dict)
			self.IndexDict = dict
		end

		local mt = {}
		mt.__index = funcs

		local function new(mapId,mapSizeX,mapSizeY,iconSizeX,iconSizeY)
			local obj = setmetatable({
				MapId = mapId,
				MapSizeX = mapSizeX,
				MapSizeY = mapSizeY,
				IconSizeX = iconSizeX,
				IconSizeY = iconSizeY,
				NumX = mapSizeX/iconSizeX,
				IndexDict = {}
			},mt)
			return obj
		end

		local function newLinear(mapId,iconSizeX,iconSizeY)
			local obj = setmetatable({
				MapId = mapId,
				IconSizeX = iconSizeX,
				IconSizeY = iconSizeY,
				IndexDict = {}
			},mt)
			return obj
		end

		return {new = new, newLinear = newLinear}
	end)()

	Lib.ScrollBar = (function()
		local funcs = {}
		local user = service.UserInputService
		local mouse = plr:GetMouse()
		local checkMouseInGui = Lib.CheckMouseInGui
		local createArrow = Lib.CreateArrow

		local function drawThumb(self)
			local total = self.TotalSpace
			local visible = self.VisibleSpace
			local index = self.Index
			local scrollThumb = self.GuiElems.ScrollThumb
			local scrollThumbFrame = self.GuiElems.ScrollThumbFrame

			if not (self:CanScrollUp()	or self:CanScrollDown()) then
				scrollThumb.Visible = false
			else
				scrollThumb.Visible = true
			end

			if self.Horizontal then
				scrollThumb.Size = UDim2.new(visible/total,0,1,0)
				if scrollThumb.AbsoluteSize.X < 16 then
					scrollThumb.Size = UDim2.new(0,16,1,0)
				end
				local fs = scrollThumbFrame.AbsoluteSize.X
				local bs = scrollThumb.AbsoluteSize.X
				scrollThumb.Position = UDim2.new(self:GetScrollPercent()*(fs-bs)/fs,0,0,0)
			else
				scrollThumb.Size = UDim2.new(1,0,visible/total,0)
				if scrollThumb.AbsoluteSize.Y < 16 then
					scrollThumb.Size = UDim2.new(1,0,0,16)
				end
				local fs = scrollThumbFrame.AbsoluteSize.Y
				local bs = scrollThumb.AbsoluteSize.Y
				scrollThumb.Position = UDim2.new(0,0,self:GetScrollPercent()*(fs-bs)/fs,0)
			end
		end

		local function createFrame(self)
			local newFrame = createSimple("Frame",{Style=0,Active=true,AnchorPoint=Vector2.new(0,0),BackgroundColor3=Color3.new(0.35294118523598,0.35294118523598,0.35294118523598),BackgroundTransparency=0,BorderColor3=Color3.new(0.10588236153126,0.16470588743687,0.20784315466881),BorderSizePixel=0,ClipsDescendants=false,Draggable=false,Position=UDim2.new(1,-16,0,0),Rotation=0,Selectable=false,Size=UDim2.new(0,16,1,0),SizeConstraint=0,Visible=true,ZIndex=1,Name="ScrollBar",})
			local button1 = nil
			local button2 = nil

			if self.Horizontal then
				newFrame.Size = UDim2.new(1,0,0,16)
				button1 = createSimple("ImageButton",{
					Parent = newFrame,
					Name = "Left",
					Size = UDim2.new(0,16,0,16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutoButtonColor = false
				})
				createArrow(16,4,"left").Parent = button1
				button2 = createSimple("ImageButton",{
					Parent = newFrame,
					Name = "Right",
					Position = UDim2.new(1,-16,0,0),
					Size = UDim2.new(0,16,0,16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutoButtonColor = false
				})
				createArrow(16,4,"right").Parent = button2
			else
				newFrame.Size = UDim2.new(0,16,1,0)
				button1 = createSimple("ImageButton",{
					Parent = newFrame,
					Name = "Up",
					Size = UDim2.new(0,16,0,16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutoButtonColor = false
				})
				createArrow(16,4,"up").Parent = button1
				button2 = createSimple("ImageButton",{
					Parent = newFrame,
					Name = "Down",
					Position = UDim2.new(0,0,1,-16),
					Size = UDim2.new(0,16,0,16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					AutoButtonColor = false
				})
				createArrow(16,4,"down").Parent = button2
			end

			local scrollThumbFrame = createSimple("Frame",{
				BackgroundTransparency = 1,
				Parent = newFrame
			})
			if self.Horizontal then
				scrollThumbFrame.Position = UDim2.new(0,16,0,0)
				scrollThumbFrame.Size = UDim2.new(1,-32,1,0)
			else
				scrollThumbFrame.Position = UDim2.new(0,0,0,16)
				scrollThumbFrame.Size = UDim2.new(1,0,1,-32)
			end

			local scrollThumb = createSimple("Frame",{
				BackgroundColor3 = Color3.new(120/255,120/255,120/255),
				BorderSizePixel = 0,
				Parent = scrollThumbFrame
			})

			local markerFrame = createSimple("Frame",{
				BackgroundTransparency = 1,
				Name = "Markers",
				Size = UDim2.new(1,0,1,0),
				Parent = scrollThumbFrame
			})

			local buttonPress = false
			local thumbPress = false
			local thumbFramePress = false

			--local thumbColor = Color3.new(120/255,120/255,120/255)
			--local thumbSelectColor = Color3.new(140/255,140/255,140/255)
			button1.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and not buttonPress and self:CanScrollUp() then button1.BackgroundTransparency = 0.8 end
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not self:CanScrollUp() then return end
				buttonPress = true
				button1.BackgroundTransparency = 0.5
				if self:CanScrollUp() then self:ScrollUp() self.Scrolled:Fire() end
				local buttonTick = tick()
				local releaseEvent
				releaseEvent = user.InputEnded:Connect(function(input)
					if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
					releaseEvent:Disconnect()
					if checkMouseInGui(button1) and self:CanScrollUp() then button1.BackgroundTransparency = 0.8 else button1.BackgroundTransparency = 1 end
					buttonPress = false
				end)
				while buttonPress do
					if tick() - buttonTick >= 0.3 and self:CanScrollUp() then
						self:ScrollUp()
						self.Scrolled:Fire()
					end
					wait()
				end
			end)
			button1.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and not buttonPress then button1.BackgroundTransparency = 1 end
			end)
			button2.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and not buttonPress and self:CanScrollDown() then button2.BackgroundTransparency = 0.8 end
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not self:CanScrollDown() then return end
				buttonPress = true
				button2.BackgroundTransparency = 0.5
				if self:CanScrollDown() then self:ScrollDown() self.Scrolled:Fire() end
				local buttonTick = tick()
				local releaseEvent
				releaseEvent = user.InputEnded:Connect(function(input)
					if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
					releaseEvent:Disconnect()
					if checkMouseInGui(button2) and self:CanScrollDown() then button2.BackgroundTransparency = 0.8 else button2.BackgroundTransparency = 1 end
					buttonPress = false
				end)
				while buttonPress do
					if tick() - buttonTick >= 0.3 and self:CanScrollDown() then
						self:ScrollDown()
						self.Scrolled:Fire()
					end
					wait()
				end
			end)
			button2.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and not buttonPress then button2.BackgroundTransparency = 1 end
			end)

			scrollThumb.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and not thumbPress then scrollThumb.BackgroundTransparency = 0.2 scrollThumb.BackgroundColor3 = self.ThumbSelectColor end
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

				local dir = self.Horizontal and "X" or "Y"
				local lastThumbPos = nil

				buttonPress = false
				thumbFramePress = false			
				thumbPress = true
				scrollThumb.BackgroundTransparency = 0
				local mouseOffset = mouse[dir] - scrollThumb.AbsolutePosition[dir]
				local mouseStart = mouse[dir]
				local releaseEvent
				local mouseEvent
				releaseEvent = user.InputEnded:Connect(function(input)
					if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
					releaseEvent:Disconnect()
					if mouseEvent then mouseEvent:Disconnect() end
					if checkMouseInGui(scrollThumb) then scrollThumb.BackgroundTransparency = 0.2 else scrollThumb.BackgroundTransparency = 0 scrollThumb.BackgroundColor3 = self.ThumbColor end
					thumbPress = false
				end)
				self:Update()

				mouseEvent = user.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement and thumbPress and releaseEvent.Connected then
						local thumbFrameSize = scrollThumbFrame.AbsoluteSize[dir]-scrollThumb.AbsoluteSize[dir]
						local pos = mouse[dir] - scrollThumbFrame.AbsolutePosition[dir] - mouseOffset
						if pos > thumbFrameSize then
							pos = thumbFrameSize
						elseif pos < 0 then
							pos = 0
						end
						if lastThumbPos ~= pos then
							lastThumbPos = pos
							self:ScrollTo(math.floor(0.5+pos/thumbFrameSize*(self.TotalSpace-self.VisibleSpace)))
						end
						wait()
					end
				end)
			end)
			scrollThumb.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and not thumbPress then scrollThumb.BackgroundTransparency = 0 scrollThumb.BackgroundColor3 = self.ThumbColor end
			end)
			scrollThumbFrame.InputBegan:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 or checkMouseInGui(scrollThumb) then return end

				local dir = self.Horizontal and "X" or "Y"
				local scrollDir = 0
				if mouse[dir] >= scrollThumb.AbsolutePosition[dir] + scrollThumb.AbsoluteSize[dir] then
					scrollDir = 1
				end

				local function doTick()
					local scrollSize = self.VisibleSpace - 1
					if scrollDir == 0 and mouse[dir] < scrollThumb.AbsolutePosition[dir] then
						self:ScrollTo(self.Index - scrollSize)
					elseif scrollDir == 1 and mouse[dir] >= scrollThumb.AbsolutePosition[dir] + scrollThumb.AbsoluteSize[dir] then
						self:ScrollTo(self.Index + scrollSize)
					end
				end

				thumbPress = false			
				thumbFramePress = true
				doTick()
				local thumbFrameTick = tick()
				local releaseEvent
				releaseEvent = user.InputEnded:Connect(function(input)
					if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
					releaseEvent:Disconnect()
					thumbFramePress = false
				end)
				while thumbFramePress do
					if tick() - thumbFrameTick >= 0.3 and checkMouseInGui(scrollThumbFrame) then
						doTick()
					end
					wait()
				end
			end)

			newFrame.MouseWheelForward:Connect(function()
				self:ScrollTo(self.Index - self.WheelIncrement)
			end)

			newFrame.MouseWheelBackward:Connect(function()
				self:ScrollTo(self.Index + self.WheelIncrement)
			end)

			self.GuiElems.ScrollThumb = scrollThumb
			self.GuiElems.ScrollThumbFrame = scrollThumbFrame
			self.GuiElems.Button1 = button1
			self.GuiElems.Button2 = button2
			self.GuiElems.MarkerFrame = markerFrame

			return newFrame
		end

		funcs.Update = function(self,nocallback)
			local total = self.TotalSpace
			local visible = self.VisibleSpace
			local index = self.Index
			local button1 = self.GuiElems.Button1
			local button2 = self.GuiElems.Button2

			self.Index = math.clamp(self.Index,0,math.max(0,total-visible))

			if self.LastTotalSpace ~= self.TotalSpace then
				self.LastTotalSpace = self.TotalSpace
				self:UpdateMarkers()
			end

			if self:CanScrollUp() then
				for i,v in pairs(button1.Arrow:GetChildren()) do
					v.BackgroundTransparency = 0
				end
			else
				button1.BackgroundTransparency = 1
				for i,v in pairs(button1.Arrow:GetChildren()) do
					v.BackgroundTransparency = 0.5
				end
			end
			if self:CanScrollDown() then
				for i,v in pairs(button2.Arrow:GetChildren()) do
					v.BackgroundTransparency = 0
				end
			else
				button2.BackgroundTransparency = 1
				for i,v in pairs(button2.Arrow:GetChildren()) do
					v.BackgroundTransparency = 0.5
				end
			end

			drawThumb(self)
		end

		funcs.UpdateMarkers = function(self)
			local markerFrame = self.GuiElems.MarkerFrame
			markerFrame:ClearAllChildren()

			for i,v in pairs(self.Markers) do
				if i < self.TotalSpace then
					createSimple("Frame",{
						BackgroundTransparency = 0,
						BackgroundColor3 = v,
						BorderSizePixel = 0,
						Position = self.Horizontal and UDim2.new(i/self.TotalSpace,0,1,-6) or UDim2.new(1,-6,i/self.TotalSpace,0),
						Size = self.Horizontal and UDim2.new(0,1,0,6) or UDim2.new(0,6,0,1),
						Name = "Marker"..tostring(i),
						Parent = markerFrame
					})
				end
			end
		end

		funcs.AddMarker = function(self,ind,color)
			self.Markers[ind] = color or Color3.new(0,0,0)
		end
		funcs.ScrollTo = function(self,ind,nocallback)
			self.Index = ind
			self:Update()
			if not nocallback then
				self.Scrolled:Fire()
			end
		end
		funcs.ScrollUp = function(self)
			self.Index = self.Index - self.Increment
			self:Update()
		end
		funcs.ScrollDown = function(self)
			self.Index = self.Index + self.Increment
			self:Update()
		end
		funcs.CanScrollUp = function(self)
			return self.Index > 0
		end
		funcs.CanScrollDown = function(self)
			return self.Index + self.VisibleSpace < self.TotalSpace
		end
		funcs.GetScrollPercent = function(self)
			return self.Index/(self.TotalSpace-self.VisibleSpace)
		end
		funcs.SetScrollPercent = function(self,perc)
			self.Index = math.floor(perc*(self.TotalSpace-self.VisibleSpace))
			self:Update()
		end

		funcs.Texture = function(self,data)
			self.ThumbColor = data.ThumbColor or Color3.new(0,0,0)
			self.ThumbSelectColor = data.ThumbSelectColor or Color3.new(0,0,0)
			self.GuiElems.ScrollThumb.BackgroundColor3 = data.ThumbColor or Color3.new(0,0,0)
			self.Gui.BackgroundColor3 = data.FrameColor or Color3.new(0,0,0)
			self.GuiElems.Button1.BackgroundColor3 = data.ButtonColor or Color3.new(0,0,0)
			self.GuiElems.Button2.BackgroundColor3 = data.ButtonColor or Color3.new(0,0,0)
			for i,v in pairs(self.GuiElems.Button1.Arrow:GetChildren()) do
				v.BackgroundColor3 = data.ArrowColor or Color3.new(0,0,0)
			end
			for i,v in pairs(self.GuiElems.Button2.Arrow:GetChildren()) do
				v.BackgroundColor3 = data.ArrowColor or Color3.new(0,0,0)
			end
		end

		funcs.SetScrollFrame = function(self,frame)
			if self.ScrollUpEvent then self.ScrollUpEvent:Disconnect() self.ScrollUpEvent = nil end
			if self.ScrollDownEvent then self.ScrollDownEvent:Disconnect() self.ScrollDownEvent = nil end
			self.ScrollUpEvent = frame.MouseWheelForward:Connect(function() self:ScrollTo(self.Index - self.WheelIncrement) end)
			self.ScrollDownEvent = frame.MouseWheelBackward:Connect(function() self:ScrollTo(self.Index + self.WheelIncrement) end)
		end

		local mt = {}
		mt.__index = funcs

		local function new(hor)
			local obj = setmetatable({
				Index = 0,
				VisibleSpace = 0,
				TotalSpace = 0,
				Increment = 1,
				WheelIncrement = 1,
				Markers = {},
				GuiElems = {},
				Horizontal = hor,
				LastTotalSpace = 0,
				Scrolled = Lib.Signal.new()
			},mt)
			obj.Gui = createFrame(obj)
			obj:Texture({
				ThumbColor = Color3.fromRGB(60,60,60),
				ThumbSelectColor = Color3.fromRGB(75,75,75),
				ArrowColor = Color3.new(1,1,1),
				FrameColor = Color3.fromRGB(40,40,40),
				ButtonColor = Color3.fromRGB(75,75,75)
			})
			return obj
		end

		return {new = new}
	end)()

	Lib.Window = (function()
		local funcs = {}
		local static = {MinWidth = 200, FreeWidth = 200}
		local mouse = plr:GetMouse()
		local sidesGui,alignIndicator
		local visibleWindows = {}
		local leftSide = {Width = 300, Windows = {}, ResizeCons = {}, Hidden = true}
		local rightSide = {Width = 300, Windows = {}, ResizeCons = {}, Hidden = true}

		local displayOrderStart
		local sideDisplayOrder
		local sideTweenInfo = TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
		local tweens = {}
		local isA = game.IsA

		local theme = {
			MainColor1 = Color3.fromRGB(52,52,52),
			MainColor2 = Color3.fromRGB(45,45,45),
			Button = Color3.fromRGB(60,60,60)
		}

		local function stopTweens()
			for i = 1,#tweens do
				tweens[i]:Cancel()
			end
			tweens = {}
		end

		local function resizeHook(self,resizer,dir)
			local guiMain = self.GuiElems.Main
			resizer.InputBegan:Connect(function(input)
				if not self.Dragging and not self.Resizing and self.Resizable and self.ResizableInternal then
					local isH = dir:find("[WE]") and true
					local isV = dir:find("[NS]") and true
					local signX = dir:find("W",1,true) and -1 or 1
					local signY = dir:find("N",1,true) and -1 or 1

					if self.Minimized and isV then return end

					if input.UserInputType == Enum.UserInputType.MouseMovement then
						resizer.BackgroundTransparency = 0.5
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
						local releaseEvent,mouseEvent

						local offX = mouse.X - resizer.AbsolutePosition.X
						local offY = mouse.Y - resizer.AbsolutePosition.Y

						self.Resizing = resizer
						resizer.BackgroundTransparency = 1

						releaseEvent = service.UserInputService.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								releaseEvent:Disconnect()
								mouseEvent:Disconnect()
								self.Resizing = false
								resizer.BackgroundTransparency = 1
							end
						end)

						mouseEvent = service.UserInputService.InputChanged:Connect(function(input)
							if self.Resizable and self.ResizableInternal and input.UserInputType == Enum.UserInputType.MouseMovement then
								self:StopTweens()
								local deltaX = input.Position.X - resizer.AbsolutePosition.X - offX
								local deltaY = input.Position.Y - resizer.AbsolutePosition.Y - offY

								if guiMain.AbsoluteSize.X + deltaX*signX < self.MinX then deltaX = signX*(self.MinX - guiMain.AbsoluteSize.X) end
								if guiMain.AbsoluteSize.Y + deltaY*signY < self.MinY then deltaY = signY*(self.MinY - guiMain.AbsoluteSize.Y) end
								if signY < 0 and guiMain.AbsolutePosition.Y + deltaY < 0 then deltaY = -guiMain.AbsolutePosition.Y end

								guiMain.Position = guiMain.Position + UDim2.new(0,(signX < 0 and deltaX or 0),0,(signY < 0 and deltaY or 0))
								self.SizeX = self.SizeX + (isH and deltaX*signX or 0)
								self.SizeY = self.SizeY + (isV and deltaY*signY or 0)
								guiMain.Size = UDim2.new(0,self.SizeX,0,self.Minimized and 20 or self.SizeY)

								--if isH then self.SizeX = guiMain.AbsoluteSize.X end
								--if isV then self.SizeY = guiMain.AbsoluteSize.Y end
							end
						end)
					end
				end
			end)

			resizer.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and self.Resizing ~= resizer then
					resizer.BackgroundTransparency = 1
				end
			end)
		end

		local updateWindows

		local function moveToTop(window)
			local found = table.find(visibleWindows,window)
			if found then
				table.remove(visibleWindows,found)
				table.insert(visibleWindows,1,window)
				updateWindows()
			end
		end

		local function sideHasRoom(side,neededSize)
			local maxY = sidesGui.AbsoluteSize.Y - (math.max(0,#side.Windows - 1) * 4)
			local inc = 0
			for i,v in pairs(side.Windows) do
				inc = inc + (v.MinY or 100)
				if inc > maxY - neededSize then return false end
			end

			return true
		end

		local function getSideInsertPos(side,curY)
			local pos = #side.Windows + 1
			local range = {0,sidesGui.AbsoluteSize.Y}

			for i,v in pairs(side.Windows) do
				local midPos = v.PosY + v.SizeY/2
				if curY <= midPos then
					pos = i
					range[2] = midPos
					break
				else
					range[1] = midPos
				end
			end

			return pos,range
		end

		local function focusInput(self,obj)
			if isA(obj,"GuiButton") then
				obj.MouseButton1Down:Connect(function()
					moveToTop(self)
				end)
			elseif isA(obj,"TextBox") then
				obj.Focused:Connect(function()
					moveToTop(self)
				end)
			end
		end

		local createGui = function(self)
			local gui = create({
				{1,"ScreenGui",{Name="Window",}},
				{2,"Frame",{Active=true,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="Main",Parent={1},Position=UDim2.new(0.40000000596046,0,0.40000000596046,0),Size=UDim2.new(0,300,0,300),}},
				{3,"Frame",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderSizePixel=0,Name="Content",Parent={2},Position=UDim2.new(0,0,0,20),Size=UDim2.new(1,0,1,-20),ClipsDescendants=true}},
				{4,"Frame",{BackgroundColor3=Color3.fromRGB(33,33,33),BorderSizePixel=0,Name="Line",Parent={3},Size=UDim2.new(1,0,0,1),}},
				{5,"Frame",{BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderSizePixel=0,Name="TopBar",Parent={2},Size=UDim2.new(1,0,0,20),}},
				{6,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={5},Position=UDim2.new(0,5,0,0),Size=UDim2.new(1,-10,0,20),Text="Window",TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=0,}},
				{7,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Close",Parent={5},Position=UDim2.new(1,-18,0,2),Size=UDim2.new(0,16,0,16),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,}},
				{8,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5054663650"),Parent={7},Position=UDim2.new(0,3,0,3),Size=UDim2.new(0,10,0,10),}},
				{9,"UICorner",{CornerRadius=UDim.new(0,4),Parent={7},}},
				{10,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Minimize",Parent={5},Position=UDim2.new(1,-36,0,2),Size=UDim2.new(0,16,0,16),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,}},
				{11,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("5034768003"),Parent={10},Position=UDim2.new(0,3,0,3),Size=UDim2.new(0,10,0,10),}},
				{12,"UICorner",{CornerRadius=UDim.new(0,4),Parent={10},}},
				{13,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Image=Main.GetLocalAsset("1427967925"),Name="Outlines",Parent={2},Position=UDim2.new(0,-5,0,-5),ScaleType=1,Size=UDim2.new(1,10,1,10),SliceCenter=Rect.new(6,6,25,25),TileSize=UDim2.new(0,20,0,20),}},
				{14,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name="ResizeControls",Parent={2},Position=UDim2.new(0,-5,0,-5),Size=UDim2.new(1,10,1,10),}},
				{15,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.27450981736183,0.27450981736183,0.27450981736183),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="North",Parent={14},Position=UDim2.new(0,5,0,0),Size=UDim2.new(1,-10,0,5),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{16,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.27450981736183,0.27450981736183,0.27450981736183),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="South",Parent={14},Position=UDim2.new(0,5,1,-5),Size=UDim2.new(1,-10,0,5),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{17,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.27450981736183,0.27450981736183,0.27450981736183),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="NorthEast",Parent={14},Position=UDim2.new(1,-5,0,0),Size=UDim2.new(0,5,0,5),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{18,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.27450981736183,0.27450981736183,0.27450981736183),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="East",Parent={14},Position=UDim2.new(1,-5,0,5),Size=UDim2.new(0,5,1,-10),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{19,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.27450981736183,0.27450981736183,0.27450981736183),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="West",Parent={14},Position=UDim2.new(0,0,0,5),Size=UDim2.new(0,5,1,-10),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{20,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.27450981736183,0.27450981736183,0.27450981736183),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="SouthEast",Parent={14},Position=UDim2.new(1,-5,1,-5),Size=UDim2.new(0,5,0,5),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{21,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.27450981736183,0.27450981736183,0.27450981736183),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="NorthWest",Parent={14},Size=UDim2.new(0,5,0,5),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{22,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.27450981736183,0.27450981736183,0.27450981736183),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="SouthWest",Parent={14},Position=UDim2.new(0,0,1,-5),Size=UDim2.new(0,5,0,5),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
			})

			local guiMain = gui.Main
			local guiTopBar = guiMain.TopBar
			local guiResizeControls = guiMain.ResizeControls

			self.GuiElems.Main = guiMain
			self.GuiElems.TopBar = guiMain.TopBar
			self.GuiElems.Content = guiMain.Content
			self.GuiElems.Line = guiMain.Content.Line
			self.GuiElems.Outlines = guiMain.Outlines
			self.GuiElems.Title = guiTopBar.Title
			self.GuiElems.Close = guiTopBar.Close
			self.GuiElems.Minimize = guiTopBar.Minimize
			self.GuiElems.ResizeControls = guiResizeControls
			self.ContentPane = guiMain.Content

			guiTopBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Draggable then
					local releaseEvent,mouseEvent

					local maxX = sidesGui.AbsoluteSize.X
					local initX = guiMain.AbsolutePosition.X
					local initY = guiMain.AbsolutePosition.Y
					local offX = mouse.X - initX
					local offY = mouse.Y - initY

					local alignInsertPos,alignInsertSide

					guiDragging = true

					releaseEvent = game:GetService("UserInputService").InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							releaseEvent:Disconnect()
							mouseEvent:Disconnect()
							guiDragging = false
							alignIndicator.Parent = nil
							if alignInsertSide then
								local targetSide = (alignInsertSide == "left" and leftSide) or (alignInsertSide == "right" and rightSide)
								self:AlignTo(targetSide,alignInsertPos)
							end
						end
					end)

					mouseEvent = game:GetService("UserInputService").InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement and self.Draggable and not self.Closed then
							if self.Aligned then
								if leftSide.Resizing or rightSide.Resizing then return end
								local posX,posY = input.Position.X-offX,input.Position.Y-offY
								local delta = math.sqrt((posX-initX)^2 + (posY-initY)^2)
								if delta >= 5 then
									self:SetAligned(false)
								end
							else
								local inputX,inputY = input.Position.X,input.Position.Y
								local posX,posY = inputX-offX,inputY-offY
								if posY < 0 then posY = 0 end
								guiMain.Position = UDim2.new(0,posX,0,posY)

								if self.Resizable and self.Alignable then
									if inputX < 25 then
										if sideHasRoom(leftSide,self.MinY or 100) then
											local insertPos,range = getSideInsertPos(leftSide,inputY)
											alignIndicator.Indicator.Position = UDim2.new(0,-15,0,range[1])
											alignIndicator.Indicator.Size = UDim2.new(0,40,0,range[2]-range[1])
											Lib.ShowGui(alignIndicator)
											alignInsertPos = insertPos
											alignInsertSide = "left"
											return
										end
									elseif inputX >= maxX - 25 then
										if sideHasRoom(rightSide,self.MinY or 100) then
											local insertPos,range = getSideInsertPos(rightSide,inputY)
											alignIndicator.Indicator.Position = UDim2.new(0,maxX-25,0,range[1])
											alignIndicator.Indicator.Size = UDim2.new(0,40,0,range[2]-range[1])
											Lib.ShowGui(alignIndicator)
											alignInsertPos = insertPos
											alignInsertSide = "right"
											return
										end
									end
								end
								alignIndicator.Parent = nil
								alignInsertPos = nil
								alignInsertSide = nil
							end
						end
					end)
				end
			end)

			guiTopBar.Close.MouseButton1Click:Connect(function()
				if self.Closed then return end
				self:Close()
			end)

			guiTopBar.Minimize.MouseButton1Click:Connect(function()
				if self.Closed then return end
				if self.Aligned then
					self:SetAligned(false)
				else
					self:SetMinimized()
				end
			end)

			guiTopBar.Minimize.MouseButton2Click:Connect(function()
				if self.Closed then return end
				if not self.Aligned then
					self:SetMinimized(nil,2)
					guiTopBar.Minimize.BackgroundTransparency = 1
				end
			end)

			guiMain.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and not self.Aligned and not self.Closed then
					moveToTop(self)
				end
			end)

			guiMain:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				local absPos = guiMain.AbsolutePosition
				self.PosX = absPos.X
				self.PosY = absPos.Y
			end)

			resizeHook(self,guiResizeControls.North,"N")
			resizeHook(self,guiResizeControls.NorthEast,"NE")
			resizeHook(self,guiResizeControls.East,"E")
			resizeHook(self,guiResizeControls.SouthEast,"SE")
			resizeHook(self,guiResizeControls.South,"S")
			resizeHook(self,guiResizeControls.SouthWest,"SW")
			resizeHook(self,guiResizeControls.West,"W")
			resizeHook(self,guiResizeControls.NorthWest,"NW")

			guiMain.Size = UDim2.new(0,self.SizeX,0,self.SizeY)

			gui.DescendantAdded:Connect(function(obj) focusInput(self,obj) end)
			local descs = gui:GetDescendants()
			for i = 1,#descs do
				focusInput(self,descs[i])
			end

			self.MinimizeAnim = Lib.ButtonAnim(guiTopBar.Minimize)
			self.CloseAnim = Lib.ButtonAnim(guiTopBar.Close)

			return gui
		end

		local function updateSideFrames(noTween)
			stopTweens()
			leftSide.Frame.Size = UDim2.new(0,leftSide.Width,1,0)
			rightSide.Frame.Size = UDim2.new(0,rightSide.Width,1,0)
			leftSide.Frame.Resizer.Position = UDim2.new(0,leftSide.Width,0,0)
			rightSide.Frame.Resizer.Position = UDim2.new(0,-5,0,0)

			--leftSide.Frame.Visible = (#leftSide.Windows > 0)
			--rightSide.Frame.Visible = (#rightSide.Windows > 0)

			--[[if #leftSide.Windows > 0 and leftSide.Frame.Position == UDim2.new(0,-leftSide.Width-5,0,0) then
				leftSide.Frame:TweenPosition(UDim2.new(0,0,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
			elseif #leftSide.Windows == 0 and leftSide.Frame.Position == UDim2.new(0,0,0,0) then
				leftSide.Frame:TweenPosition(UDim2.new(0,-leftSide.Width-5,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
			end
			local rightTweenPos = (#rightSide.Windows == 0 and UDim2.new(1,5,0,0) or UDim2.new(1,-rightSide.Width,0,0))
			rightSide.Frame:TweenPosition(rightTweenPos,Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)]]
			local leftHidden = #leftSide.Windows == 0 or leftSide.Hidden
			local rightHidden = #rightSide.Windows == 0 or rightSide.Hidden
			local leftPos = (leftHidden and UDim2.new(0,-leftSide.Width-10,0,0) or UDim2.new(0,0,0,0))
			local rightPos = (rightHidden and UDim2.new(1,10,0,0) or UDim2.new(1,-rightSide.Width,0,0))

			sidesGui.LeftToggle.Text = leftHidden and ">" or "<"
			sidesGui.RightToggle.Text = rightHidden and "<" or ">"

			if not noTween then
				local function insertTween(...)
					local tween = service.TweenService:Create(...)
					tweens[#tweens+1] = tween
					tween:Play()
				end
				insertTween(leftSide.Frame,sideTweenInfo,{Position = leftPos})
				insertTween(rightSide.Frame,sideTweenInfo,{Position = rightPos})
				insertTween(sidesGui.LeftToggle,sideTweenInfo,{Position = UDim2.new(0,#leftSide.Windows == 0 and -16 or 0,0,-36)})
				insertTween(sidesGui.RightToggle,sideTweenInfo,{Position = UDim2.new(1,#rightSide.Windows == 0 and 0 or -16,0,-36)})
			else
				leftSide.Frame.Position = leftPos
				rightSide.Frame.Position = rightPos
				sidesGui.LeftToggle.Position = UDim2.new(0,#leftSide.Windows == 0 and -16 or 0,0,-36)
				sidesGui.RightToggle.Position = UDim2.new(1,#rightSide.Windows == 0 and 0 or -16,0,-36)
			end
		end

		local function getSideFramePos(side)
			local leftHidden = #leftSide.Windows == 0 or leftSide.Hidden
			local rightHidden = #rightSide.Windows == 0 or rightSide.Hidden
			if side == leftSide then
				return (leftHidden and UDim2.new(0,-leftSide.Width-10,0,0) or UDim2.new(0,0,0,0))
			else
				return (rightHidden and UDim2.new(1,10,0,0) or UDim2.new(1,-rightSide.Width,0,0))
			end
		end

		local function sideResized(side)
			local currentPos = 0
			local sideFramePos = getSideFramePos(side)
			for i,v in pairs(side.Windows) do
				v.SizeX = side.Width
				v.GuiElems.Main.Size = UDim2.new(0,side.Width,0,v.SizeY)
				v.GuiElems.Main.Position = UDim2.new(sideFramePos.X.Scale,sideFramePos.X.Offset,0,currentPos)
				currentPos = currentPos + v.SizeY+4
			end
		end

		local function sideResizerHook(resizer,dir,side,pos)
			local mouse = Main.Mouse
			local windows = side.Windows

			resizer.InputBegan:Connect(function(input)
				if not side.Resizing then
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						resizer.BackgroundColor3 = theme.MainColor2
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
						local releaseEvent,mouseEvent

						local offX = mouse.X - resizer.AbsolutePosition.X
						local offY = mouse.Y - resizer.AbsolutePosition.Y

						side.Resizing = resizer
						resizer.BackgroundColor3 = theme.MainColor2

						releaseEvent = service.UserInputService.InputEnded:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								releaseEvent:Disconnect()
								mouseEvent:Disconnect()
								side.Resizing = false
								resizer.BackgroundColor3 = theme.Button
							end
						end)

						mouseEvent = service.UserInputService.InputChanged:Connect(function(input)
							if not resizer.Parent then
								releaseEvent:Disconnect()
								mouseEvent:Disconnect()
								side.Resizing = false
								return
							end
							if input.UserInputType == Enum.UserInputType.MouseMovement then
								if dir == "V" then
									local delta = input.Position.Y - resizer.AbsolutePosition.Y - offY

									if delta > 0 then
										local neededSize = delta
										for i = pos+1,#windows do
											local window = windows[i]
											local newSize = math.max(window.SizeY-neededSize,(window.MinY or 100))
											neededSize = neededSize - (window.SizeY - newSize)
											window.SizeY = newSize
										end
										windows[pos].SizeY = windows[pos].SizeY + math.max(0,delta-neededSize)
									else
										local neededSize = -delta
										for i = pos,1,-1 do
											local window = windows[i]
											local newSize = math.max(window.SizeY-neededSize,(window.MinY or 100))
											neededSize = neededSize - (window.SizeY - newSize)
											window.SizeY = newSize
										end
										windows[pos+1].SizeY = windows[pos+1].SizeY + math.max(0,-delta-neededSize)
									end

									updateSideFrames()
									sideResized(side)
								elseif dir == "H" then
									local maxWidth = math.max(300,sidesGui.AbsoluteSize.X-static.FreeWidth)
									local otherSide = (side == leftSide and rightSide or leftSide)
									local delta = input.Position.X - resizer.AbsolutePosition.X - offX
									delta = (side == leftSide and delta or -delta)

									local proposedSize = math.max(static.MinWidth,side.Width + delta)
									if proposedSize + otherSide.Width <= maxWidth then
										side.Width = proposedSize
									else
										local newOtherSize = maxWidth - proposedSize
										if newOtherSize >= static.MinWidth then
											side.Width = proposedSize
											otherSide.Width = newOtherSize
										else
											side.Width = maxWidth - static.MinWidth
											otherSide.Width = static.MinWidth
										end
									end

									updateSideFrames(true)
									sideResized(side)
									sideResized(otherSide)
								end
							end
						end)
					end
				end
			end)

			resizer.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and side.Resizing ~= resizer then
					resizer.BackgroundColor3 = theme.Button
				end
			end)
		end

		local function renderSide(side,noTween) -- TODO: Use existing resizers
			local currentPos = 0
			local sideFramePos = getSideFramePos(side)
			local template = side.WindowResizer:Clone()
			for i,v in pairs(side.ResizeCons) do v:Disconnect() end
			for i,v in pairs(side.Frame:GetChildren()) do if v.Name == "WindowResizer" then v:Destroy() end end
			side.ResizeCons = {}
			side.Resizing = nil

			for i,v in pairs(side.Windows) do
				v.SidePos = i
				local isEnd = i == #side.Windows
				local size = UDim2.new(0,side.Width,0,v.SizeY)
				local pos = UDim2.new(sideFramePos.X.Scale,sideFramePos.X.Offset,0,currentPos)
				Lib.ShowGui(v.Gui)
				--v.GuiElems.Main:TweenSizeAndPosition(size,pos,Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
				if noTween then
					v.GuiElems.Main.Size = size
					v.GuiElems.Main.Position = pos
				else
					local tween = service.TweenService:Create(v.GuiElems.Main,sideTweenInfo,{Size = size, Position = pos})
					tweens[#tweens+1] = tween
					tween:Play()
				end
				currentPos = currentPos + v.SizeY+4

				if not isEnd then
					local newTemplate = template:Clone()
					newTemplate.Position = UDim2.new(1,-side.Width,0,currentPos-4)
					side.ResizeCons[#side.ResizeCons+1] = v.Gui.Main:GetPropertyChangedSignal("Size"):Connect(function()
						newTemplate.Position = UDim2.new(1,-side.Width,0, v.GuiElems.Main.Position.Y.Offset + v.GuiElems.Main.Size.Y.Offset)
					end)
					side.ResizeCons[#side.ResizeCons+1] = v.Gui.Main:GetPropertyChangedSignal("Position"):Connect(function()
						newTemplate.Position = UDim2.new(1,-side.Width,0, v.GuiElems.Main.Position.Y.Offset + v.GuiElems.Main.Size.Y.Offset)
					end)
					sideResizerHook(newTemplate,"V",side,i)
					newTemplate.Parent = side.Frame
				end
			end

			--side.Frame.Back.Position = UDim2.new(0,0,0,0)
			--side.Frame.Back.Size = UDim2.new(0,side.Width,1,0)
		end

		local function updateSide(side,noTween)
			local oldHeight = 0
			local currentPos = 0
			local neededSize = 0
			local windows = side.Windows
			local height = sidesGui.AbsoluteSize.Y - (math.max(0,#windows - 1) * 4)

			for i,v in pairs(windows) do oldHeight = oldHeight + v.SizeY end
			for i,v in pairs(windows) do
				if i == #windows then
					v.SizeY = height-currentPos
					neededSize = math.max(0,(v.MinY or 100)-v.SizeY)
				else
					v.SizeY = math.max(math.floor(v.SizeY/oldHeight*height),v.MinY or 100)
				end
				currentPos = currentPos + v.SizeY
			end

			if neededSize > 0 then
				for i = #windows-1,1,-1 do
					local window = windows[i]
					local newSize = math.max(window.SizeY-neededSize,(window.MinY or 100))
					neededSize = neededSize - (window.SizeY - newSize)
					window.SizeY = newSize
				end
				local lastWindow = windows[#windows]
				lastWindow.SizeY = (lastWindow.MinY or 100)-neededSize
			end
			renderSide(side,noTween)
		end

		updateWindows = function(noTween)
			updateSideFrames(noTween)
			updateSide(leftSide,noTween)
			updateSide(rightSide,noTween)
			local count = 0
			for i = #visibleWindows,1,-1 do
				visibleWindows[i].Gui.DisplayOrder = displayOrderStart + count
				Lib.ShowGui(visibleWindows[i].Gui)
				count = count + 1
			end

			--[[local leftTweenPos = (#leftSide.Windows == 0 and UDim2.new(0,-leftSide.Width-5,0,0) or UDim2.new(0,0,0,0))
			leftSide.Frame:TweenPosition(leftTweenPos,Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
			local rightTweenPos = (#rightSide.Windows == 0 and UDim2.new(1,5,0,0) or UDim2.new(1,-rightSide.Width,0,0))
			rightSide.Frame:TweenPosition(rightTweenPos,Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)]]
		end

		funcs.SetMinimized = function(self,set,mode)
			local oldVal = self.Minimized
			local newVal
			if set == nil then newVal = not self.Minimized else newVal = set end
			self.Minimized = newVal
			if not mode then mode = 1 end

			local resizeControls = self.GuiElems.ResizeControls
			local minimizeControls = {"North","NorthEast","NorthWest","South","SouthEast","SouthWest"}
			for i = 1,#minimizeControls do
				local control = resizeControls:FindFirstChild(minimizeControls[i])
				if control then control.Visible = not newVal end
			end

			if mode == 1 or mode == 2 then
				self:StopTweens()
				if mode == 1 then
					self.GuiElems.Main:TweenSize(UDim2.new(0,self.SizeX,0,newVal and 20 or self.SizeY),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
				else
					local maxY = sidesGui.AbsoluteSize.Y
					local newPos = UDim2.new(0,self.PosX,0,newVal and math.min(maxY-20,self.PosY + self.SizeY - 20) or math.max(0,self.PosY - self.SizeY + 20))

					self.GuiElems.Main:TweenPosition(newPos,Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
					self.GuiElems.Main:TweenSize(UDim2.new(0,self.SizeX,0,newVal and 20 or self.SizeY),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.25,true)
				end
				self.GuiElems.Minimize.ImageLabel.Image = newVal and Main.GetLocalAsset("5060023708") or Main.GetLocalAsset("5034768003")
			end

			if oldVal ~= newVal then
				if newVal then
					self.OnMinimize:Fire()
				else
					self.OnRestore:Fire()
				end
			end
		end

		funcs.Resize = function(self,sizeX,sizeY)
			self.SizeX = sizeX or self.SizeX
			self.SizeY = sizeY or self.SizeY
			self.GuiElems.Main.Size = UDim2.new(0,self.SizeX,0,self.SizeY)
		end

		funcs.SetSize = funcs.Resize

		funcs.SetTitle = function(self,title)
			self.GuiElems.Title.Text = title
		end

		funcs.SetResizable = function(self,val)
			self.Resizable = val
			self.GuiElems.ResizeControls.Visible = self.Resizable and self.ResizableInternal
		end

		funcs.SetResizableInternal = function(self,val)
			self.ResizableInternal = val
			self.GuiElems.ResizeControls.Visible = self.Resizable and self.ResizableInternal
		end

		funcs.SetAligned = function(self,val)
			self.Aligned = val
			self:SetResizableInternal(not val)
			self.GuiElems.Main.Active = not val
			self.GuiElems.Main.Outlines.Visible = not val
			if not val then
				for i,v in pairs(leftSide.Windows) do if v == self then table.remove(leftSide.Windows,i) break end end
				for i,v in pairs(rightSide.Windows) do if v == self then table.remove(rightSide.Windows,i) break end end
				if not table.find(visibleWindows,self) then table.insert(visibleWindows,1,self) end
				self.GuiElems.Minimize.ImageLabel.Image = Main.GetLocalAsset("5034768003")
				self.Side = nil
				updateWindows()
			else
				self:SetMinimized(false,3)
				for i,v in pairs(visibleWindows) do if v == self then table.remove(visibleWindows,i) break end end
				self.GuiElems.Minimize.ImageLabel.Image = Main.GetLocalAsset("5448127505")
			end
		end

		funcs.Add = function(self,obj,name)
			if type(obj) == "table" and obj.Gui and obj.Gui:IsA("GuiObject") then
				obj.Gui.Parent = self.ContentPane
			else
				obj.Parent = self.ContentPane
			end
			if name then self.Elements[name] = obj end
		end

		funcs.GetElement = function(self,obj,name)
			return self.Elements[name]
		end

		funcs.AlignTo = function(self,side,pos,size,silent)
			if table.find(side.Windows,self) or self.Closed then return end

			size = size or self.SizeY
			if size > 0 and size <= 1 then
				local totalSideHeight = 0
				for i,v in pairs(side.Windows) do totalSideHeight = totalSideHeight + v.SizeY end
				self.SizeY = (totalSideHeight > 0 and totalSideHeight * size * 2) or size
			else
				self.SizeY = (size > 0 and size or 100)
			end

			self:SetAligned(true)
			self.Side = side
			self.SizeX = side.Width
			self.Gui.DisplayOrder = sideDisplayOrder + 1
			for i,v in pairs(side.Windows) do v.Gui.DisplayOrder = sideDisplayOrder end
			pos = math.min(#side.Windows+1, pos or 1)
			self.SidePos = pos
			table.insert(side.Windows, pos, self)

			if not silent then
				side.Hidden = false
			end
			updateWindows(silent)
		end

		funcs.Close = function(self)
			self.Closed = true
			self:SetResizableInternal(false)

			Lib.FindAndRemove(leftSide.Windows,self)
			Lib.FindAndRemove(rightSide.Windows,self)
			Lib.FindAndRemove(visibleWindows,self)

			self.MinimizeAnim.Disable()
			self.CloseAnim.Disable()
			self.ClosedSide = self.Side
			self.Side = nil
			self.OnDeactivate:Fire()

			if not self.Aligned then
				self:StopTweens()
				local ti = TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

				local closeTime = tick()
				self.LastClose = closeTime

				self:DoTween(self.GuiElems.Main,ti,{Size = UDim2.new(0,self.SizeX,0,20)})
				self:DoTween(self.GuiElems.Title,ti,{TextTransparency = 1})
				self:DoTween(self.GuiElems.Minimize.ImageLabel,ti,{ImageTransparency = 1})
				self:DoTween(self.GuiElems.Close.ImageLabel,ti,{ImageTransparency = 1})
				Lib.FastWait(0.2)
				if closeTime ~= self.LastClose then return end

				self:DoTween(self.GuiElems.TopBar,ti,{BackgroundTransparency = 1})
				self:DoTween(self.GuiElems.Outlines,ti,{ImageTransparency = 1})
				Lib.FastWait(0.2)
				if closeTime ~= self.LastClose then return end
			end

			self.Aligned = false
			self.Gui.Parent = nil
			updateWindows(true)
		end

		funcs.Hide = funcs.Close

		funcs.IsVisible = function(self)
			return not self.Closed and ((self.Side and not self.Side.Hidden) or not self.Side)
		end

		funcs.IsContentVisible = function(self)
			return self:IsVisible() and not self.Minimized
		end

		funcs.Focus = function(self)
			moveToTop(self)
		end

		funcs.MoveInBoundary = function(self)
			local posX,posY = self.PosX,self.PosY
			local maxX,maxY = sidesGui.AbsoluteSize.X,sidesGui.AbsoluteSize.Y
			posX = math.min(posX,maxX-self.SizeX)
			posY = math.min(posY,maxY-20)
			self.GuiElems.Main.Position = UDim2.new(0,posX,0,posY)
		end

		funcs.DoTween = function(self,...)
			local tween = service.TweenService:Create(...)
			self.Tweens[#self.Tweens+1] = tween
			tween:Play()
		end

		funcs.StopTweens = function(self)
			for i,v in pairs(self.Tweens) do
				v:Cancel()
			end
			self.Tweens = {}
		end

		funcs.Show = function(self,data)
			return static.ShowWindow(self,data)
		end

		funcs.ShowAndFocus = function(self,data)
			static.ShowWindow(self,data)
			service.RunService.RenderStepped:wait()
			self:Focus()
		end

		static.ShowWindow = function(window,data)
			data = data or {}
			local align = data.Align
			local pos = data.Pos
			local size = data.Size
			local targetSide = (align == "left" and leftSide) or (align == "right" and rightSide)

			if not window.Closed then
				if not window.Aligned then
					window:SetMinimized(false)
				elseif window.Side and not data.Silent then
					static.SetSideVisible(window.Side,true)
				end
				return
			end

			window.Closed = false
			window.LastClose = tick()
			window.GuiElems.Title.TextTransparency = 0
			window.GuiElems.Minimize.ImageLabel.ImageTransparency = 0
			window.GuiElems.Close.ImageLabel.ImageTransparency = 0
			window.GuiElems.TopBar.BackgroundTransparency = 0
			window.GuiElems.Outlines.ImageTransparency = 0
			window.GuiElems.Minimize.ImageLabel.Image = Main.GetLocalAsset("5034768003")
			window.GuiElems.Main.Active = true
			window.GuiElems.Main.Outlines.Visible = true
			window:SetMinimized(false,3)
			window:SetResizableInternal(true)
			window.MinimizeAnim.Enable()
			window.CloseAnim.Enable()

			if align then
				window:AlignTo(targetSide,pos,size,data.Silent)
			else
				if align == nil and window.ClosedSide then -- Regular open
					window:AlignTo(window.ClosedSide,window.SidePos,size,true)
					static.SetSideVisible(window.ClosedSide,true)
				else
					if table.find(visibleWindows,window) then return end

					-- TODO: make better
					window.GuiElems.Main.Size = UDim2.new(0,window.SizeX,0,20)
					local ti = TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
					window:StopTweens()
					window:DoTween(window.GuiElems.Main,ti,{Size = UDim2.new(0,window.SizeX,0,window.SizeY)})

					window.SizeY = size or window.SizeY
					table.insert(visibleWindows,1,window)
					updateWindows()
				end
			end

			window.ClosedSide = nil
			window.OnActivate:Fire()
		end

		static.ToggleSide = function(name)
			local side = (name == "left" and leftSide or rightSide)
			side.Hidden = not side.Hidden
			for i,v in pairs(side.Windows) do
				if side.Hidden then
					v.OnDeactivate:Fire()
				else
					v.OnActivate:Fire()
				end
			end
			updateWindows()
		end

		static.SetSideVisible = function(s,vis)
			local side = (type(s) == "table" and s) or (s == "left" and leftSide or rightSide)
			side.Hidden = not vis
			for i,v in pairs(side.Windows) do
				if side.Hidden then
					v.OnDeactivate:Fire()
				else
					v.OnActivate:Fire()
				end
			end
			updateWindows()
		end

		static.Init = function()
			displayOrderStart = Main.DisplayOrders.Window
			sideDisplayOrder = Main.DisplayOrders.SideWindow

			sidesGui = Instance.new("ScreenGui")
			local leftFrame = create({
				{1,"Frame",{Active=true,Name="LeftSide",BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderSizePixel=0,}},
				{2,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2549019753933,0.2549019753933,0.2549019753933),BorderSizePixel=0,Font=3,Name="Resizer",Parent={1},Size=UDim2.new(0,5,1,0),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{3,"Frame",{BackgroundColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderSizePixel=0,Name="Line",Parent={2},Position=UDim2.new(0,0,0,0),Size=UDim2.new(0,1,1,0),}},
				{4,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2549019753933,0.2549019753933,0.2549019753933),BorderSizePixel=0,Font=3,Name="WindowResizer",Parent={1},Position=UDim2.new(1,-300,0,0),Size=UDim2.new(1,0,0,4),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{5,"Frame",{BackgroundColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderSizePixel=0,Name="Line",Parent={4},Size=UDim2.new(1,0,0,1),}},
			})
			leftSide.Frame = leftFrame
			leftFrame.Position = UDim2.new(0,-leftSide.Width-10,0,0)
			leftSide.WindowResizer = leftFrame.WindowResizer
			leftFrame.WindowResizer.Parent = nil
			leftFrame.Parent = sidesGui

			local rightFrame = create({
				{1,"Frame",{Active=true,Name="RightSide",BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderSizePixel=0,}},
				{2,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2549019753933,0.2549019753933,0.2549019753933),BorderSizePixel=0,Font=3,Name="Resizer",Parent={1},Size=UDim2.new(0,5,1,0),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{3,"Frame",{BackgroundColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderSizePixel=0,Name="Line",Parent={2},Position=UDim2.new(0,4,0,0),Size=UDim2.new(0,1,1,0),}},
				{4,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2549019753933,0.2549019753933,0.2549019753933),BorderSizePixel=0,Font=3,Name="WindowResizer",Parent={1},Position=UDim2.new(1,-300,0,0),Size=UDim2.new(1,0,0,4),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
				{5,"Frame",{BackgroundColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderSizePixel=0,Name="Line",Parent={4},Size=UDim2.new(1,0,0,1),}},
			})
			rightSide.Frame = rightFrame
			rightFrame.Position = UDim2.new(1,10,0,0)
			rightSide.WindowResizer = rightFrame.WindowResizer
			rightFrame.WindowResizer.Parent = nil
			rightFrame.Parent = sidesGui

			sideResizerHook(leftFrame.Resizer,"H",leftSide)
			sideResizerHook(rightFrame.Resizer,"H",rightSide)

			alignIndicator = Instance.new("ScreenGui")
			alignIndicator.DisplayOrder = Main.DisplayOrders.Core
			local indicator = Instance.new("Frame",alignIndicator)
			indicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			indicator.BorderSizePixel = 0
			indicator.BackgroundTransparency = 0.8
			indicator.Name = "Indicator"
			local corner = Instance.new("UICorner",indicator)
			corner.CornerRadius = UDim.new(0,10)

			local leftToggle = create({{1,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderMode=2,Font=10,Name="LeftToggle",Position=UDim2.new(0,0,0,-36),Size=UDim2.new(0,16,0,36),Text="<",TextColor3=Color3.new(1,1,1),TextSize=14,}}})
			local rightToggle = leftToggle:Clone()
			rightToggle.Name = "RightToggle"
			rightToggle.Position = UDim2.new(1,-16,0,-36)
			Lib.ButtonAnim(leftToggle,{Mode = 2,PressColor = Color3.fromRGB(32,32,32)})
			Lib.ButtonAnim(rightToggle,{Mode = 2,PressColor = Color3.fromRGB(32,32,32)})

			leftToggle.MouseButton1Click:Connect(function()
				static.ToggleSide("left")
			end)

			rightToggle.MouseButton1Click:Connect(function()
				static.ToggleSide("right")
			end)

			leftToggle.Parent = sidesGui
			rightToggle.Parent = sidesGui

			sidesGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				local maxWidth = math.max(300,sidesGui.AbsoluteSize.X-static.FreeWidth)
				leftSide.Width = math.max(static.MinWidth,math.min(leftSide.Width,maxWidth-rightSide.Width))
				rightSide.Width = math.max(static.MinWidth,math.min(rightSide.Width,maxWidth-leftSide.Width))
				for i = 1,#visibleWindows do
					visibleWindows[i]:MoveInBoundary()
				end
				updateWindows(true)
			end)

			sidesGui.DisplayOrder = sideDisplayOrder - 1
			Lib.ShowGui(sidesGui)
			updateSideFrames()
		end

		local mt = {__index = funcs}
		static.new = function()
			local obj = setmetatable({
				Minimized = false,
				Dragging = false,
				Resizing = false,
				Aligned = false,
				Draggable = true,
				Resizable = true,
				ResizableInternal = true,
				Alignable = true,
				Closed = true,
				SizeX = 300,
				SizeY = 300,
				MinX = 200,
				MinY = 200,
				PosX = 0,
				PosY = 0,
				GuiElems = {},
				Tweens = {},
				Elements = {},
				OnActivate = Lib.Signal.new(),
				OnDeactivate = Lib.Signal.new(),
				OnMinimize = Lib.Signal.new(),
				OnRestore = Lib.Signal.new()
			},mt)
			obj.Gui = createGui(obj)
			return obj
		end

		return static
	end)()

	Lib.ContextMenu = (function()
		local funcs = {}
		local mouse

		local function createGui(self)
			local contextGui = create({
				{1,"ScreenGui",{DisplayOrder=1000000,Name="Context",ZIndexBehavior=1,}},
				{2,"Frame",{Active=true,BackgroundColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),Name="Main",Parent={1},Position=UDim2.new(0.5,-100,0.5,-150),Size=UDim2.new(0,200,0,100),}},
				{3,"UICorner",{CornerRadius=UDim.new(0,4),Parent={2},}},
				{4,"Frame",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),Name="Container",Parent={2},Position=UDim2.new(0,1,0,1),Size=UDim2.new(1,-2,1,-2),}},
				{5,"UICorner",{CornerRadius=UDim.new(0,4),Parent={4},}},
				{6,"ScrollingFrame",{Active=true,BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BackgroundTransparency=1,BorderSizePixel=0,CanvasSize=UDim2.new(0,0,0,0),Name="List",Parent={4},Position=UDim2.new(0,2,0,2),ScrollBarImageColor3=Color3.new(0,0,0),ScrollBarThickness=4,Size=UDim2.new(1,-4,1,-4),VerticalScrollBarInset=1,}},
				{7,"UIListLayout",{Parent={6},SortOrder=2,}},
				{8,"Frame",{BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderSizePixel=0,Name="SearchFrame",Parent={4},Size=UDim2.new(1,0,0,24),Visible=false,}},
				{9,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.1176470592618,0.1176470592618,0.1176470592618),BorderSizePixel=0,Name="SearchContainer",Parent={8},Position=UDim2.new(0,3,0,3),Size=UDim2.new(1,-6,0,18),}},
				{10,"TextBox",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="SearchBox",Parent={9},PlaceholderColor3=Color3.new(0.39215689897537,0.39215689897537,0.39215689897537),PlaceholderText="Search",Position=UDim2.new(0,4,0,0),Size=UDim2.new(1,-8,0,18),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=0,}},
				{11,"UICorner",{CornerRadius=UDim.new(0,2),Parent={9},}},
				{12,"Frame",{BackgroundColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderSizePixel=0,Name="Line",Parent={8},Position=UDim2.new(0,0,1,0),Size=UDim2.new(1,0,0,1),}},
				{13,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BackgroundTransparency=1,BorderColor3=Color3.new(0.33725491166115,0.49019610881805,0.73725491762161),BorderSizePixel=0,Font=3,Name="Entry",Parent={1},Size=UDim2.new(1,0,0,22),Text="",TextSize=14,Visible=false,}},
				{14,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="EntryName",Parent={13},Position=UDim2.new(0,24,0,0),Size=UDim2.new(1,-24,1,0),Text="Duplicate",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{15,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Shortcut",Parent={13},Position=UDim2.new(0,24,0,0),Size=UDim2.new(1,-30,1,0),Text="Ctrl+D",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{16,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,ImageRectOffset=Vector2.new(304,0),ImageRectSize=Vector2.new(16,16),Name="Icon",Parent={13},Position=UDim2.new(0,2,0,3),ScaleType=4,Size=UDim2.new(0,16,0,16),}},
				{17,"UICorner",{CornerRadius=UDim.new(0,4),Parent={13},}},
				{18,"Frame",{BackgroundColor3=Color3.new(0.21568629145622,0.21568629145622,0.21568629145622),BackgroundTransparency=1,BorderSizePixel=0,Name="Divider",Parent={1},Position=UDim2.new(0,0,0,20),Size=UDim2.new(1,0,0,7),Visible=false,}},
				{19,"Frame",{BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderSizePixel=0,Name="Line",Parent={18},Position=UDim2.new(0,0,0.5,0),Size=UDim2.new(1,0,0,1),}},
				{20,"TextLabel",{AnchorPoint=Vector2.new(0,0.5),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="DividerName",Parent={18},Position=UDim2.new(0,2,0.5,0),Size=UDim2.new(1,-4,1,0),Text="Objects",TextColor3=Color3.new(1,1,1),TextSize=14,TextTransparency=0.60000002384186,TextXAlignment=0,Visible=false,}},
			})
			self.GuiElems.Main = contextGui.Main
			self.GuiElems.List = contextGui.Main.Container.List
			self.GuiElems.Entry = contextGui.Entry
			self.GuiElems.Divider = contextGui.Divider
			self.GuiElems.SearchFrame = contextGui.Main.Container.SearchFrame
			self.GuiElems.SearchBar = self.GuiElems.SearchFrame.SearchContainer.SearchBox
			Lib.ViewportTextBox.convert(self.GuiElems.SearchBar)

			self.GuiElems.SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
				local lower,find = string.lower,string.find
				local searchText = lower(self.GuiElems.SearchBar.Text)
				local items = self.Items
				local map = self.ItemToEntryMap

				if searchText ~= "" then
					local results = {}
					local count = 1
					for i = 1,#items do
						local item = items[i]
						local entry = map[item]
						if entry then
							if not item.Divider and find(lower(item.Name),searchText,1,true) then
								results[count] = item
								count = count + 1
							else
								entry.Visible = false
							end
						end
					end
					table.sort(results,function(a,b) return a.Name < b.Name end)
					for i = 1,#results do
						local entry = map[results[i]]
						entry.LayoutOrder = i
						entry.Visible = true
					end
				else
					for i = 1,#items do
						local entry = map[items[i]]
						if entry then entry.LayoutOrder = i entry.Visible = true end
					end
				end

				local toSize = self.GuiElems.List.UIListLayout.AbsoluteContentSize.Y + 6
				self.GuiElems.List.CanvasSize = UDim2.new(0,0,0,toSize-6)
			end)

			return contextGui
		end

		funcs.Add = function(self,item)
			local newItem = {
				Name = item.Name or "Item",
				Icon = item.Icon or "",
				Shortcut = item.Shortcut or "",
				OnClick = item.OnClick,
				OnHover = item.OnHover,
				Disabled = item.Disabled or false,
				DisabledIcon = item.DisabledIcon or "",
				IconMap = item.IconMap,
				OnRightClick = item.OnRightClick
			}
			if self.QueuedDivider then
				local text = self.QueuedDividerText and #self.QueuedDividerText > 0 and self.QueuedDividerText
				self:AddDivider(text)
			end
			self.Items[#self.Items+1] = newItem
			self.Updated = nil
		end

		funcs.AddRegistered = function(self,name,disabled)
			if not self.Registered[name] then error(name.." is not registered") end
			
			if self.QueuedDivider then
				local text = self.QueuedDividerText and #self.QueuedDividerText > 0 and self.QueuedDividerText
				self:AddDivider(text)
			end
			self.Registered[name].Disabled = disabled
			self.Items[#self.Items+1] = self.Registered[name]
			self.Updated = nil
		end

		funcs.Register = function(self,name,item)
			self.Registered[name] = {
				Name = item.Name or "Item",
				Icon = item.Icon or "",
				Shortcut = item.Shortcut or "",
				OnClick = item.OnClick,
				OnHover = item.OnHover,
				DisabledIcon = item.DisabledIcon or "",
				IconMap = item.IconMap,
				OnRightClick = item.OnRightClick
			}
		end

		funcs.UnRegister = function(self,name)
			self.Registered[name] = nil
		end

		funcs.AddDivider = function(self,text)
			self.QueuedDivider = false
			local textWidth = text and service.TextService:GetTextSize(text,14,Enum.Font.SourceSans,Vector2.new(999999999,20)).X or nil
			table.insert(self.Items,{Divider = true, Text = text, TextSize = textWidth and textWidth+4})
			self.Updated = nil
		end
		
		funcs.QueueDivider = function(self,text)
			self.QueuedDivider = true
			self.QueuedDividerText = text or ""
		end

		funcs.Clear = function(self)
			self.Items = {}
			self.Updated = nil
		end

		funcs.Refresh = function(self)
			for i,v in pairs(self.GuiElems.List:GetChildren()) do
				if not v:IsA("UIListLayout") then
					v:Destroy()
				end
			end
			local map = {}
			self.ItemToEntryMap = map

			local dividerFrame = self.GuiElems.Divider
			local contextList = self.GuiElems.List
			local entryFrame = self.GuiElems.Entry
			local items = self.Items

			for i = 1,#items do
				local item = items[i]
				if item.Divider then
					local newDivider = dividerFrame:Clone()
					newDivider.Line.BackgroundColor3 = self.Theme.DividerColor
					if item.Text then
						newDivider.Size = UDim2.new(1,0,0,20)
						newDivider.Line.Position = UDim2.new(0,item.TextSize,0.5,0)
						newDivider.Line.Size = UDim2.new(1,-item.TextSize,0,1)
						newDivider.DividerName.TextColor3 = self.Theme.TextColor
						newDivider.DividerName.Text = item.Text
						newDivider.DividerName.Visible = true
					end
					newDivider.Visible = true
					map[item] = newDivider
					newDivider.Parent = contextList
				else
					local newEntry = entryFrame:Clone()
					newEntry.BackgroundColor3 = self.Theme.HighlightColor
					newEntry.EntryName.TextColor3 = self.Theme.TextColor
					newEntry.EntryName.Text = item.Name
					newEntry.Shortcut.Text = item.Shortcut
					if item.Disabled then
						newEntry.EntryName.TextColor3 = Color3.new(150/255,150/255,150/255)
						newEntry.Shortcut.TextColor3 = Color3.new(150/255,150/255,150/255)
					end

					if self.Iconless then
						newEntry.EntryName.Position = UDim2.new(0,2,0,0)
						newEntry.EntryName.Size = UDim2.new(1,-4,0,20)
						newEntry.Icon.Visible = false
					else
						local iconIndex = item.Disabled and item.DisabledIcon or item.Icon
						if item.IconMap then
							if type(iconIndex) == "number" then
								item.IconMap:Display(newEntry.Icon,iconIndex)
							elseif type(iconIndex) == "string" then
								item.IconMap:DisplayByKey(newEntry.Icon,iconIndex)
							end
						elseif type(iconIndex) == "string" then
							newEntry.Icon.Image = iconIndex
						end
					end

					if not item.Disabled then
						if item.OnClick then
							newEntry.MouseButton1Click:Connect(function()
								item.OnClick(item.Name)
								if not item.NoHide then
									self:Hide()
								end
							end)
						end

						if item.OnRightClick then
							newEntry.MouseButton2Click:Connect(function()
								item.OnRightClick(item.Name)
								if not item.NoHide then
									self:Hide()
								end
							end)
						end
					end

					newEntry.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							newEntry.BackgroundTransparency = 0
						end
					end)

					newEntry.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							newEntry.BackgroundTransparency = 1
						end
					end)

					newEntry.Visible = true
					map[item] = newEntry
					newEntry.Parent = contextList
				end
			end
			self.Updated = true
		end

		funcs.Show = function(self,x,y)
			-- Initialize Gui
			local elems = self.GuiElems
			elems.SearchFrame.Visible = self.SearchEnabled
			elems.List.Position = UDim2.new(0,2,0,2 + (self.SearchEnabled and 24 or 0))
			elems.List.Size = UDim2.new(1,-4,1,-4 - (self.SearchEnabled and 24 or 0))
			if self.SearchEnabled and self.ClearSearchOnShow then elems.SearchBar.Text = "" end
			self.GuiElems.List.CanvasPosition = Vector2.new(0,0)

			if not self.Updated then
				self:Refresh() -- Create entries
			end

			-- Vars
			local reverseY = false
			local x,y = x or mouse.X, y or mouse.Y
			local maxX,maxY = mouse.ViewSizeX,mouse.ViewSizeY

			-- Position and show
			if x + self.Width > maxX then
				x = self.ReverseX and x - self.Width or maxX - self.Width
			end
			elems.Main.Position = UDim2.new(0,x,0,y)
			elems.Main.Size = UDim2.new(0,self.Width,0,0)
			self.Gui.DisplayOrder = Main.DisplayOrders.Menu
			Lib.ShowGui(self.Gui)

			-- Size adjustment
			local toSize = elems.List.UIListLayout.AbsoluteContentSize.Y + 6 -- Padding
			if self.MaxHeight and toSize > self.MaxHeight then
				elems.List.CanvasSize = UDim2.new(0,0,0,toSize-6)
				toSize = self.MaxHeight
			else
				elems.List.CanvasSize = UDim2.new(0,0,0,0)
			end
			if y + toSize > maxY then reverseY = true end

			-- Close event
			local closable
			if self.CloseEvent then self.CloseEvent:Disconnect() end
			self.CloseEvent = service.UserInputService.InputBegan:Connect(function(input)
				if not closable or input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

				if not Lib.CheckMouseInGui(elems.Main) then
					self.CloseEvent:Disconnect()
					self:Hide()
				end
			end)

			-- Resize
			if reverseY then
				elems.Main.Position = UDim2.new(0,x,0,y-(self.ReverseYOffset or 0))
				local newY = y - toSize - (self.ReverseYOffset or 0)
				y = newY >= 0 and newY or 0
				elems.Main:TweenSizeAndPosition(UDim2.new(0,self.Width,0,toSize),UDim2.new(0,x,0,y),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.2,true)
			else
				elems.Main:TweenSize(UDim2.new(0,self.Width,0,toSize),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.2,true)
			end

			-- Close debounce
			Lib.FastWait()
			if self.SearchEnabled and self.FocusSearchOnShow then elems.SearchBar:CaptureFocus() end
			closable = true
		end

		funcs.Hide = function(self)
			self.Gui.Parent = nil
		end

		funcs.ApplyTheme = function(self,data)
			local theme = self.Theme
			theme.ContentColor = data.ContentColor or Settings.Theme.Menu
			theme.OutlineColor = data.OutlineColor or Settings.Theme.Menu
			theme.DividerColor = data.DividerColor or Settings.Theme.Outline2
			theme.TextColor = data.TextColor or Settings.Theme.Text
			theme.HighlightColor = data.HighlightColor or Settings.Theme.Main1

			self.GuiElems.Main.BackgroundColor3 = theme.OutlineColor
			self.GuiElems.Main.Container.BackgroundColor3 = theme.ContentColor
		end

		local mt = {__index = funcs}
		local function new()
			if not mouse then mouse = Main.Mouse or service.Players.LocalPlayer:GetMouse() end

			local obj = setmetatable({
				Width = 200,
				MaxHeight = nil,
				Iconless = false,
				SearchEnabled = false,
				ClearSearchOnShow = true,
				FocusSearchOnShow = true,
				Updated = false,
				QueuedDivider = false,
				QueuedDividerText = "",
				Items = {},
				Registered = {},
				GuiElems = {},
				Theme = {}
			},mt)
			obj.Gui = createGui(obj)
			obj:ApplyTheme({})
			return obj
		end

		return {new = new}
	end)()

	Lib.CodeFrame = (function()
		local funcs = {}

		local typeMap = {
			[1] = "String",
			[2] = "String",
			[3] = "String",
			[4] = "Comment",
			[5] = "Operator",
			[6] = "Number",
			[7] = "Keyword",
			[8] = "BuiltIn",
			[9] = "LocalMethod",
			[10] = "LocalProperty",
			[11] = "Nil",
			[12] = "Bool",
			[13] = "Function",
			[14] = "Local",
			[15] = "Self",
			[16] = "FunctionName",
			[17] = "Bracket"
		}

		local specialKeywordsTypes = {
			["nil"] = 11,
			["true"] = 12,
			["false"] = 12,
			["function"] = 13,
			["local"] = 14,
			["self"] = 15
		}

		local keywords = {
			["and"] = true,
			["break"] = true, 
			["do"] = true,
			["else"] = true,
			["elseif"] = true,
			["end"] = true,
			["false"] = true,
			["for"] = true,
			["function"] = true,
			["if"] = true,
			["in"] = true,
			["local"] = true,
			["nil"] = true,
			["not"] = true,
			["or"] = true,
			["repeat"] = true,
			["return"] = true,
			["then"] = true,
			["true"] = true,
			["until"] = true,
			["while"] = true,
			["plugin"] = true
		}

		local builtIns = {
			["delay"] = true,
			["elapsedTime"] = true,
			["require"] = true,
			["spawn"] = true,
			["tick"] = true,
			["time"] = true,
			["typeof"] = true,
			["UserSettings"] = true,
			["wait"] = true,
			["warn"] = true,
			["game"] = true,
			["shared"] = true,
			["script"] = true,
			["workspace"] = true,
			["assert"] = true,
			["collectgarbage"] = true,
			["error"] = true,
			["getfenv"] = true,
			["getmetatable"] = true,
			["ipairs"] = true,
			["loadstring"] = true,
			["newproxy"] = true,
			["next"] = true,
			["pairs"] = true,
			["pcall"] = true,
			["print"] = true,
			["rawequal"] = true,
			["rawget"] = true,
			["rawset"] = true,
			["select"] = true,
			["setfenv"] = true,
			["setmetatable"] = true,
			["tonumber"] = true,
			["tostring"] = true,
			["type"] = true,
			["unpack"] = true,
			["xpcall"] = true,
			["_G"] = true,
			["_VERSION"] = true,
			["coroutine"] = true,
			["debug"] = true,
			["math"] = true,
			["os"] = true,
			["string"] = true,
			["table"] = true,
			["bit32"] = true,
			["utf8"] = true,
			["Axes"] = true,
			["BrickColor"] = true,
			["CFrame"] = true,
			["Color3"] = true,
			["ColorSequence"] = true,
			["ColorSequenceKeypoint"] = true,
			["DockWidgetPluginGuiInfo"] = true,
			["Enum"] = true,
			["Faces"] = true,
			["Instance"] = true,
			["NumberRange"] = true,
			["NumberSequence"] = true,
			["NumberSequenceKeypoint"] = true,
			["PathWaypoint"] = true,
			["PhysicalProperties"] = true,
			["Random"] = true,
			["Ray"] = true,
			["Rect"] = true,
			["Region3"] = true,
			["Region3int16"] = true,
			["TweenInfo"] = true,
			["UDim"] = true,
			["UDim2"] = true,
			["Vector2"] = true,
			["Vector2int16"] = true,
			["Vector3"] = true,
			["Vector3int16"] = true
		}

		local builtInInited = false

		local richReplace = {
			["'"] = "&apos;",
			["\""] = "&quot;",
			["<"] = "&lt;",
			[">"] = "&gt;",
			["&"] = "&amp;"
		}
		
		local tabSub = "\205"
		local tabReplacement = (" %s%s "):format(tabSub,tabSub)
		
		local tabJumps = {
			[("[^%s] %s"):format(tabSub,tabSub)] = 0,
			[(" %s%s"):format(tabSub,tabSub)] = -1,
			[("%s%s "):format(tabSub,tabSub)] = 2,
			[("%s [^%s]"):format(tabSub,tabSub)] = 1,
		}
		
		local tweenService = service.TweenService
		local lineTweens = {}

		local function initBuiltIn()
			local env = getfenv()
			local type = type
			local tostring = tostring
			for name,_ in next,builtIns do
				local envVal = env[name]
				if type(envVal) == "table" then
					local items = {}
					for i,v in next,envVal do
						items[i] = true
					end
					builtIns[name] = items
				end
			end

			local enumEntries = {}
			local enums = Enum:GetEnums()
			for i = 1,#enums do
				enumEntries[tostring(enums[i])] = true
			end
			builtIns["Enum"] = enumEntries

			builtInInited = true
		end
		
		local function setupEditBox(obj)
			local editBox = obj.GuiElems.EditBox
			
			editBox.Focused:Connect(function()
				obj:ConnectEditBoxEvent()
				obj.Editing = true
			end)
			
			editBox.FocusLost:Connect(function()
				obj:DisconnectEditBoxEvent()
				obj.Editing = false
			end)
			
			editBox:GetPropertyChangedSignal("Text"):Connect(function()
				local text = editBox.Text
				if #text == 0 or obj.EditBoxCopying then return end
				editBox.Text = ""
				obj:AppendText(text)
			end)
		end
		
		local function setupMouseSelection(obj)
			local mouse = plr:GetMouse()
			local codeFrame = obj.GuiElems.LinesFrame
			local lines = obj.Lines
			
			codeFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local fontSizeX,fontSizeY = math.ceil(obj.FontSize/2),obj.FontSize
					
					local relX = mouse.X - codeFrame.AbsolutePosition.X
					local relY = mouse.Y - codeFrame.AbsolutePosition.Y
					local selX = math.round(relX / fontSizeX) + obj.ViewX
					local selY = math.floor(relY / fontSizeY) + obj.ViewY
					local releaseEvent,mouseEvent,scrollEvent
					local scrollPowerV,scrollPowerH = 0,0
					selY = math.min(#lines-1,selY)
					local relativeLine = lines[selY+1] or ""
					selX = math.min(#relativeLine, selX + obj:TabAdjust(selX,selY))

					obj.SelectionRange = {{-1,-1},{-1,-1}}
					obj:MoveCursor(selX,selY)
					obj.FloatCursorX = selX

					local function updateSelection()
						local relX = mouse.X - codeFrame.AbsolutePosition.X
						local relY = mouse.Y - codeFrame.AbsolutePosition.Y
						local sel2X = math.max(0,math.round(relX / fontSizeX) + obj.ViewX)
						local sel2Y = math.max(0,math.floor(relY / fontSizeY) + obj.ViewY)

						sel2Y = math.min(#lines-1,sel2Y)
						local relativeLine = lines[sel2Y+1] or ""
						sel2X = math.min(#relativeLine, sel2X + obj:TabAdjust(sel2X,sel2Y))

						if sel2Y < selY or (sel2Y == selY and sel2X < selX) then
							obj.SelectionRange = {{sel2X,sel2Y},{selX,selY}}
						else						
							obj.SelectionRange = {{selX,selY},{sel2X,sel2Y}}
						end

						obj:MoveCursor(sel2X,sel2Y)
						obj.FloatCursorX = sel2X
						obj:Refresh()
					end

					releaseEvent = service.UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							releaseEvent:Disconnect()
							mouseEvent:Disconnect()
							scrollEvent:Disconnect()
							obj:SetCopyableSelection()
							--updateSelection()
						end
					end)

					mouseEvent = service.UserInputService.InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							local upDelta = mouse.Y - codeFrame.AbsolutePosition.Y
							local downDelta = mouse.Y - codeFrame.AbsolutePosition.Y - codeFrame.AbsoluteSize.Y
							local leftDelta = mouse.X - codeFrame.AbsolutePosition.X
							local rightDelta = mouse.X - codeFrame.AbsolutePosition.X - codeFrame.AbsoluteSize.X
							scrollPowerV = 0
							scrollPowerH = 0
							if downDelta > 0 then
								scrollPowerV = math.floor(downDelta*0.05) + 1
							elseif upDelta < 0 then
								scrollPowerV = math.ceil(upDelta*0.05) - 1
							end
							if rightDelta > 0 then
								scrollPowerH = math.floor(rightDelta*0.05) + 1
							elseif leftDelta < 0 then
								scrollPowerH = math.ceil(leftDelta*0.05) - 1
							end
							updateSelection()
						end
					end)

					scrollEvent = game:GetService("RunService").RenderStepped:Connect(function()
						if scrollPowerV ~= 0 or scrollPowerH ~= 0 then
							obj:ScrollDelta(scrollPowerH,scrollPowerV)
							updateSelection()
						end
					end)

					obj:Refresh()
				end
			end)
		end

		local function makeFrame(obj)
			local frame = create({
				{1,"Frame",{BackgroundColor3=Color3.new(0.15686275064945,0.15686275064945,0.15686275064945),BorderSizePixel = 0,Position=UDim2.new(0.5,-300,0.5,-200),Size=UDim2.new(0,600,0,400),}},
			})
			local elems = {}
			
			local linesFrame = Instance.new("Frame")
			linesFrame.Name = "Lines"
			linesFrame.BackgroundTransparency = 1
			linesFrame.Size = UDim2.new(1,0,1,0)
			linesFrame.ClipsDescendants = true
			linesFrame.Parent = frame
			
			local lineNumbersLabel = Instance.new("TextLabel")
			lineNumbersLabel.Name = "LineNumbers"
			lineNumbersLabel.BackgroundTransparency = 1
			lineNumbersLabel.Font = Enum.Font.Code
			lineNumbersLabel.TextXAlignment = Enum.TextXAlignment.Right
			lineNumbersLabel.TextYAlignment = Enum.TextYAlignment.Top
			lineNumbersLabel.ClipsDescendants = true
			lineNumbersLabel.RichText = true
			lineNumbersLabel.Parent = frame
			
			local cursor = Instance.new("Frame")
			cursor.Name = "Cursor"
			cursor.BackgroundColor3 = Color3.fromRGB(220,220,220)
			cursor.BorderSizePixel = 0
			cursor.Parent = frame
			
			local editBox = Instance.new("TextBox")
			editBox.Name = "EditBox"
			editBox.MultiLine = true
			editBox.Visible = false
			editBox.Parent = frame
			
			lineTweens.Invis = tweenService:Create(cursor,TweenInfo.new(0.4,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency = 1})
			lineTweens.Vis = tweenService:Create(cursor,TweenInfo.new(0.2,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{BackgroundTransparency = 0})
			
			elems.LinesFrame = linesFrame
			elems.LineNumbersLabel = lineNumbersLabel
			elems.Cursor = cursor
			elems.EditBox = editBox
			elems.ScrollCorner = create({{1,"Frame",{BackgroundColor3=Color3.new(0.15686275064945,0.15686275064945,0.15686275064945),BorderSizePixel=0,Name="ScrollCorner",Position=UDim2.new(1,-16,1,-16),Size=UDim2.new(0,16,0,16),Visible=false,}}})
			
			elems.ScrollCorner.Parent = frame
			linesFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					obj:SetEditing(true,input)
				end
			end)
			
			obj.Frame = frame
			obj.Gui = frame
			obj.GuiElems = elems
			setupEditBox(obj)
			setupMouseSelection(obj)
			
			return frame
		end
		
		funcs.GetSelectionText = function(self)
			if not self:IsValidRange() then return "" end
			
			local selectionRange = self.SelectionRange
			local selX,selY = selectionRange[1][1], selectionRange[1][2]
			local sel2X,sel2Y = selectionRange[2][1], selectionRange[2][2]
			local deltaLines = sel2Y-selY
			local lines = self.Lines

			if not lines[selY+1] or not lines[sel2Y+1] then return "" end

			if deltaLines == 0 then
				return self:ConvertText(lines[selY+1]:sub(selX+1,sel2X), false)
			end

			local leftSub = lines[selY+1]:sub(selX+1)
			local rightSub = lines[sel2Y+1]:sub(1,sel2X)

			local result = leftSub.."\n" 
			for i = selY+1,sel2Y-1 do
				result = result..lines[i+1].."\n"
			end
			result = result..rightSub

			return self:ConvertText(result,false)
		end
		
		funcs.SetCopyableSelection = function(self)
			local text = self:GetSelectionText()
			local editBox = self.GuiElems.EditBox
			
			self.EditBoxCopying = true
			editBox.Text = text
			editBox.SelectionStart = 1
			editBox.CursorPosition = #editBox.Text + 1
			self.EditBoxCopying = false
		end
		
		funcs.ConnectEditBoxEvent = function(self)
			if self.EditBoxEvent then
				self.EditBoxEvent:Disconnect()
			end
			
			self.EditBoxEvent = service.UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
				
				local keycodes = Enum.KeyCode
				local keycode = input.KeyCode
				
				local function setupMove(key,func)
					local endCon,finished
					endCon = service.UserInputService.InputEnded:Connect(function(input)
						if input.KeyCode ~= key then return end
						endCon:Disconnect()
						finished = true
					end)
					func()
					Lib.FastWait(0.5)
					while not finished do func() Lib.FastWait(0.03) end
				end
				
				if keycode == keycodes.Down then
					setupMove(keycodes.Down,function()
						self.CursorX = self.FloatCursorX
						self.CursorY = self.CursorY + 1
						self:UpdateCursor()
						self:JumpToCursor()
					end)
				elseif keycode == keycodes.Up then
					setupMove(keycodes.Up,function()
						self.CursorX = self.FloatCursorX
						self.CursorY = self.CursorY - 1
						self:UpdateCursor()
						self:JumpToCursor()
					end)
				elseif keycode == keycodes.Left then
					setupMove(keycodes.Left,function()
						local line = self.Lines[self.CursorY+1] or ""
						self.CursorX = self.CursorX - 1 - (line:sub(self.CursorX-3,self.CursorX) == tabReplacement and 3 or 0)
						if self.CursorX < 0 then
							self.CursorY = self.CursorY - 1
							local line2 = self.Lines[self.CursorY+1] or ""
							self.CursorX = #line2
						end
						self.FloatCursorX = self.CursorX
						self:UpdateCursor()
						self:JumpToCursor()
					end)
				elseif keycode == keycodes.Right then
					setupMove(keycodes.Right,function()
						local line = self.Lines[self.CursorY+1] or ""
						self.CursorX = self.CursorX + 1 + (line:sub(self.CursorX+1,self.CursorX+4) == tabReplacement and 3 or 0)
						if self.CursorX > #line then
							self.CursorY = self.CursorY + 1
							self.CursorX = 0
						end
						self.FloatCursorX = self.CursorX
						self:UpdateCursor()
						self:JumpToCursor()
					end)
				elseif keycode == keycodes.Backspace then
					setupMove(keycodes.Backspace,function()
						local startRange,endRange
						if self:IsValidRange() then
							startRange = self.SelectionRange[1]
							endRange = self.SelectionRange[2]
						else
							endRange = {self.CursorX,self.CursorY}
						end
						
						if not startRange then
							local line = self.Lines[self.CursorY+1] or ""
							self.CursorX = self.CursorX - 1 - (line:sub(self.CursorX-3,self.CursorX) == tabReplacement and 3 or 0)
							if self.CursorX < 0 then
								self.CursorY = self.CursorY - 1
								local line2 = self.Lines[self.CursorY+1] or ""
								self.CursorX = #line2
							end
							self.FloatCursorX = self.CursorX
							self:UpdateCursor()
						
							startRange = startRange or {self.CursorX,self.CursorY}
						end
						
						self:DeleteRange({startRange,endRange},false,true)
						self:ResetSelection(true)
						self:JumpToCursor()
					end)
				elseif keycode == keycodes.Delete then
					setupMove(keycodes.Delete,function()
						local startRange,endRange
						if self:IsValidRange() then
							startRange = self.SelectionRange[1]
							endRange = self.SelectionRange[2]
						else
							startRange = {self.CursorX,self.CursorY}
						end

						if not endRange then
							local line = self.Lines[self.CursorY+1] or ""
							local endCursorX = self.CursorX + 1 + (line:sub(self.CursorX+1,self.CursorX+4) == tabReplacement and 3 or 0)
							local endCursorY = self.CursorY
							if endCursorX > #line then
								endCursorY = endCursorY + 1
								endCursorX = 0
							end
							self:UpdateCursor()

							endRange = endRange or {endCursorX,endCursorY}
						end

						self:DeleteRange({startRange,endRange},false,true)
						self:ResetSelection(true)
						self:JumpToCursor()
					end)
				elseif service.UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
					if keycode == keycodes.A then
						self.SelectionRange = {{0,0},{#self.Lines[#self.Lines],#self.Lines-1}}
						self:SetCopyableSelection()
						self:Refresh()
					end
				end
			end)
		end
		
		funcs.DisconnectEditBoxEvent = function(self)
			if self.EditBoxEvent then
				self.EditBoxEvent:Disconnect()
			end
		end
		
		funcs.ResetSelection = function(self,norefresh)
			self.SelectionRange = {{-1,-1},{-1,-1}}
			if not norefresh then self:Refresh() end
		end
		
		funcs.IsValidRange = function(self,range)
			local selectionRange = range or self.SelectionRange
			local selX,selY = selectionRange[1][1], selectionRange[1][2]
			local sel2X,sel2Y = selectionRange[2][1], selectionRange[2][2]

			if selX == -1 or (selX == sel2X and selY == sel2Y) then return false end

			return true
		end
		
		funcs.DeleteRange = function(self,range,noprocess,updatemouse)
			range = range or self.SelectionRange
			if not self:IsValidRange(range) then return end
			
			local lines = self.Lines
			local selX,selY = range[1][1], range[1][2]
			local sel2X,sel2Y = range[2][1], range[2][2]
			local deltaLines = sel2Y-selY
			
			if not lines[selY+1] or not lines[sel2Y+1] then return end
			
			local leftSub = lines[selY+1]:sub(1,selX)
			local rightSub = lines[sel2Y+1]:sub(sel2X+1)
			lines[selY+1] = leftSub..rightSub
			
			local remove = table.remove
			for i = 1,deltaLines do
				remove(lines,selY+2)
			end
			
			if range == self.SelectionRange then self.SelectionRange = {{-1,-1},{-1,-1}} end
			if updatemouse then
				self.CursorX = selX
				self.CursorY = selY
				self:UpdateCursor()
			end
			
			if not noprocess then
				self:ProcessTextChange()
			end
		end
		
		funcs.AppendText = function(self,text)
			self:DeleteRange(nil,true,true)
			local lines,cursorX,cursorY = self.Lines,self.CursorX,self.CursorY
			local line = lines[cursorY+1]
			local before = line:sub(1,cursorX)
			local after = line:sub(cursorX+1)
			
			text = text:gsub("\r\n","\n")
			text = self:ConvertText(text,true) -- Tab Convert
			
			local textLines = text:split("\n")
			local insert = table.insert
			
			for i = 1,#textLines do
				local linePos = cursorY+i
				if i > 1 then insert(lines,linePos,"") end
				
				local textLine = textLines[i]
				local newBefore = (i == 1 and before or "")
				local newAfter = (i == #textLines and after or "")
			
				lines[linePos] = newBefore..textLine..newAfter
			end
			
			if #textLines > 1 then cursorX = 0 end
			
			self:ProcessTextChange()
			self.CursorX = cursorX + #textLines[#textLines]
			self.CursorY = cursorY + #textLines-1
			self:UpdateCursor()
		end
		
		funcs.ScrollDelta = function(self,x,y)
			self.ScrollV:ScrollTo(self.ScrollV.Index + y)
			self.ScrollH:ScrollTo(self.ScrollH.Index + x)
		end
		
		-- x and y starts at 0
		funcs.TabAdjust = function(self,x,y)
			local lines = self.Lines
			local line = lines[y+1]
			x=x+1
			
			if line then
				local left = line:sub(x-1,x-1)
				local middle = line:sub(x,x)
				local right = line:sub(x+1,x+1)
				local selRange = (#left > 0 and left or " ") .. (#middle > 0 and middle or " ") .. (#right > 0 and right or " ")

				for i,v in pairs(tabJumps) do
					if selRange:find(i) then
						return v
					end
				end
			end
			return 0
		end
		
		funcs.SetEditing = function(self,on,input)			
			self:UpdateCursor(input)
			
			if on then
				if self.Editable then
					self.GuiElems.EditBox.Text = ""
					self.GuiElems.EditBox:CaptureFocus()
				end
			else
				self.GuiElems.EditBox:ReleaseFocus()
			end
		end
		
		funcs.CursorAnim = function(self,on)
			local cursor = self.GuiElems.Cursor
			local animTime = tick()
			self.LastAnimTime = animTime
			
			if not on then return end
			
			lineTweens.Invis:Cancel()
			lineTweens.Vis:Cancel()
			cursor.BackgroundTransparency = 0
			
			coroutine.wrap(function()
				while self.Editable do
					Lib.FastWait(0.5)
					if self.LastAnimTime ~= animTime then return end
					lineTweens.Invis:Play()
					Lib.FastWait(0.4)
					if self.LastAnimTime ~= animTime then return end
					lineTweens.Vis:Play()
					Lib.FastWait(0.2)
				end
			end)()
		end
		
		funcs.MoveCursor = function(self,x,y)
			self.CursorX = x
			self.CursorY = y
			self:UpdateCursor()
			self:JumpToCursor()
		end
		
		funcs.JumpToCursor = function(self)
			self:Refresh()
		end
		
		funcs.UpdateCursor = function(self,input)
			local linesFrame = self.GuiElems.LinesFrame
			local cursor = self.GuiElems.Cursor			
			local hSize = math.max(0,linesFrame.AbsoluteSize.X)
			local vSize = math.max(0,linesFrame.AbsoluteSize.Y)
			local maxLines = math.ceil(vSize / self.FontSize)
			local maxCols = math.ceil(hSize / math.ceil(self.FontSize/2))
			local viewX,viewY = self.ViewX,self.ViewY
			local totalLinesStr = tostring(#self.Lines)
			local fontWidth = math.ceil(self.FontSize / 2)
			local linesOffset = #totalLinesStr*fontWidth + 4*fontWidth
			
			if input then
				local linesFrame = self.GuiElems.LinesFrame
				local frameX,frameY = linesFrame.AbsolutePosition.X,linesFrame.AbsolutePosition.Y
				local mouseX,mouseY = input.Position.X,input.Position.Y
				local fontSizeX,fontSizeY = math.ceil(self.FontSize/2),self.FontSize

				self.CursorX = self.ViewX + math.round((mouseX - frameX) / fontSizeX)
				self.CursorY = self.ViewY + math.floor((mouseY - frameY) / fontSizeY)
			end
			
			local cursorX,cursorY = self.CursorX,self.CursorY
			
			local line = self.Lines[cursorY+1] or ""
			if cursorX > #line then cursorX = #line
			elseif cursorX < 0 then cursorX = 0 end
			
			if cursorY >= #self.Lines then
				cursorY = math.max(0,#self.Lines-1)
			elseif cursorY < 0 then
				cursorY = 0
			end
			
			cursorX = cursorX + self:TabAdjust(cursorX,cursorY)
			
			-- Update modified
			self.CursorX = cursorX
			self.CursorY = cursorY
			
			local cursorVisible = (cursorX >= viewX) and (cursorY >= viewY) and (cursorX <= viewX + maxCols) and (cursorY <= viewY + maxLines)
			if cursorVisible then
				local offX = (cursorX - viewX)
				local offY = (cursorY - viewY)
				cursor.Position = UDim2.new(0,linesOffset + offX*math.ceil(self.FontSize/2) - 1,0,offY*self.FontSize)
				cursor.Size = UDim2.new(0,1,0,self.FontSize+2)
				cursor.Visible = true
				self:CursorAnim(true)
			else
				cursor.Visible = false
			end
		end

		funcs.MapNewLines = function(self)
			local newLines = {}
			local count = 1
			local text = self.Text
			local find = string.find
			local init = 1

			local pos = find(text,"\n",init,true)
			while pos do
				newLines[count] = pos
				count = count + 1
				init = pos + 1
				pos = find(text,"\n",init,true)
			end

			self.NewLines = newLines
		end

		funcs.PreHighlight = function(self)
			local start = tick()
			local text = self.Text:gsub("\\\\","  ")
			--print("BACKSLASH SUB",tick()-start)
			local textLen = #text
			local found = {}
			local foundMap = {}
			local extras = {}
			local find = string.find
			local sub = string.sub
			self.ColoredLines = {}

			local function findAll(str,pattern,typ,raw)
				local count = #found+1
				local init = 1
				local x,y,extra = find(str,pattern,init,raw)
				while x do
					found[count] = x
					foundMap[x] = typ
					if extra then
						extras[x] = extra
					end

					count = count+1
					init = y+1
					x,y,extra = find(str,pattern,init,raw)
				end
			end
			local start = tick()
			findAll(text,'"',1,true)
			findAll(text,"'",2,true)
			findAll(text,"%[(=*)%[",3)
			findAll(text,"--",4,true)
			table.sort(found)

			local newLines = self.NewLines
			local curLine = 0
			local lineTableCount = 1
			local lineStart = 0
			local lineEnd = 0
			local lastEnding = 0
			local foundHighlights = {}

			for i = 1,#found do
				local pos = found[i]
				if pos <= lastEnding then continue end

				local ending = pos
				local typ = foundMap[pos]
				if typ == 1 then
					ending = find(text,'"',pos+1,true)
					while ending and sub(text,ending-1,ending-1) == "\\" do
						ending = find(text,'"',ending+1,true)
					end
					if not ending then ending = textLen end
				elseif typ == 2 then
					ending = find(text,"'",pos+1,true)
					while ending and sub(text,ending-1,ending-1) == "\\" do
						ending = find(text,"'",ending+1,true)
					end
					if not ending then ending = textLen end
				elseif typ == 3 then
					_,ending = find(text,"]"..extras[pos].."]",pos+1,true)
					if not ending then ending = textLen end
				elseif typ == 4 then
					local ahead = foundMap[pos+2]

					if ahead == 3 then
						_,ending = find(text,"]"..extras[pos+2].."]",pos+1,true)
						if not ending then ending = textLen end
					else
						ending = find(text,"\n",pos+1,true) or textLen
					end
				end

				while pos > lineEnd do
					curLine = curLine + 1
					--lineTableCount = 1
					lineEnd = newLines[curLine] or textLen+1
				end
				while true do
					local lineTable = foundHighlights[curLine]
					if not lineTable then lineTable = {} foundHighlights[curLine] = lineTable end
					lineTable[pos] = {typ,ending}
					--lineTableCount = lineTableCount + 1

					if ending > lineEnd then
						curLine = curLine + 1
						lineEnd = newLines[curLine] or textLen+1
					else
						break
					end
				end

				lastEnding = ending
				--if i < 200 then print(curLine) end
			end
			self.PreHighlights = foundHighlights
			--print(tick()-start)
			--print(#found,curLine)
		end

		funcs.HighlightLine = function(self,line)
			local cached = self.ColoredLines[line]
			if cached then return cached end

			local sub = string.sub
			local find = string.find
			local match = string.match
			local highlights = {}
			local preHighlights = self.PreHighlights[line] or {}
			local lineText = self.Lines[line] or ""
			local lineLen = #lineText
			local lastEnding = 0
			local currentType = 0
			local lastWord = nil
			local wordBeginsDotted = false
			local funcStatus = 0
			local lineStart = self.NewLines[line-1] or 0

			local preHighlightMap = {}
			for pos,data in next,preHighlights do
				local relativePos = pos-lineStart
				if relativePos < 1 then
					currentType = data[1]
					lastEnding = data[2] - lineStart
					--warn(pos,data[2])
				else
					preHighlightMap[relativePos] = {data[1],data[2]-lineStart}
				end
			end

			for col = 1,#lineText do
				if col <= lastEnding then highlights[col] = currentType continue end

				local pre = preHighlightMap[col]
				if pre then
					currentType = pre[1]
					lastEnding = pre[2]
					highlights[col] = currentType
					wordBeginsDotted = false
					lastWord = nil
					funcStatus = 0
				else
					local char = sub(lineText,col,col)
					if find(char,"[%a_]") then
						local word = match(lineText,"[%a%d_]+",col)
						local wordType = (keywords[word] and 7) or (builtIns[word] and 8)

						lastEnding = col+#word-1

						if wordType ~= 7 then
							if wordBeginsDotted then
								local prevBuiltIn = lastWord and builtIns[lastWord]
								wordType = (prevBuiltIn and type(prevBuiltIn) == "table" and prevBuiltIn[word] and 8) or 10
							end

							if wordType ~= 8 then
								local x,y,br = find(lineText,"^%s*([%({\"'])",lastEnding+1)
								if x then
									wordType = (funcStatus > 0 and br == "(" and 16) or 9
									funcStatus = 0
								end
							end
						else
							wordType = specialKeywordsTypes[word] or wordType
							funcStatus = (word == "function" and 1 or 0)
						end

						lastWord = word
						wordBeginsDotted = false
						if funcStatus > 0 then funcStatus = 1 end

						if wordType then
							currentType = wordType
							highlights[col] = currentType
						else
							currentType = nil
						end
					elseif find(char,"%p") then
						local isDot = (char == ".")
						local isNum = isDot and find(sub(lineText,col+1,col+1),"%d")
						highlights[col] = (isNum and 6 or 5)

						if not isNum then
							local dotStr = isDot and match(lineText,"%.%.?%.?",col)
							if dotStr and #dotStr > 1 then
								currentType = 5
								lastEnding = col+#dotStr-1
								wordBeginsDotted = false
								lastWord = nil
								funcStatus = 0
							else
								if isDot then
									if wordBeginsDotted then
										lastWord = nil
									else
										wordBeginsDotted = true
									end
								else
									wordBeginsDotted = false
									lastWord = nil
								end

								funcStatus = ((isDot or char == ":") and funcStatus == 1 and 2) or 0
							end
						end
					elseif find(char,"%d") then
						local _,endPos = find(lineText,"%x+",col)
						local endPart = sub(lineText,endPos,endPos+1)
						if (endPart == "e+" or endPart == "e-") and find(sub(lineText,endPos+2,endPos+2),"%d") then
							endPos = endPos + 1
						end
						currentType = 6
						lastEnding = endPos
						highlights[col] = 6
						wordBeginsDotted = false
						lastWord = nil
						funcStatus = 0
					else
						highlights[col] = currentType
						local _,endPos = find(lineText,"%s+",col)
						if endPos then
							lastEnding = endPos
						end
					end
				end
			end

			self.ColoredLines[line] = highlights
			return highlights
		end

		funcs.Refresh = function(self)
			local start = tick()

			local linesFrame = self.Frame.Lines
			local hSize = math.max(0,linesFrame.AbsoluteSize.X)
			local vSize = math.max(0,linesFrame.AbsoluteSize.Y)
			local maxLines = math.ceil(vSize / self.FontSize)
			local maxCols = math.ceil(hSize / math.ceil(self.FontSize/2))
			local gsub = string.gsub
			local sub = string.sub

			local viewX,viewY = self.ViewX,self.ViewY

			local lineNumberStr = ""

			for row = 1,maxLines do
				local lineFrame = self.LineFrames[row]
				if not lineFrame then
					lineFrame = Instance.new("Frame")
					lineFrame.Name = "Line"
					lineFrame.Position = UDim2.new(0,0,0,(row-1)*self.FontSize)
					lineFrame.Size = UDim2.new(1,0,0,self.FontSize)
					lineFrame.BorderSizePixel = 0
					lineFrame.BackgroundTransparency = 1
					
					local selectionHighlight = Instance.new("Frame")
					selectionHighlight.Name = "SelectionHighlight"
					selectionHighlight.BorderSizePixel = 0
					selectionHighlight.BackgroundColor3 = Settings.Theme.Syntax.SelectionBack
					selectionHighlight.Parent = lineFrame
					
					local label = Instance.new("TextLabel")
					label.Name = "Label"
					label.BackgroundTransparency = 1
					label.Font = Enum.Font.Code
					label.TextSize = self.FontSize
					label.Size = UDim2.new(1,0,0,self.FontSize)
					label.RichText = true
					label.TextXAlignment = Enum.TextXAlignment.Left
					label.TextColor3 = self.Colors.Text
					label.ZIndex = 2
					label.Parent = lineFrame
					
					lineFrame.Parent = linesFrame
					self.LineFrames[row] = lineFrame
				end

				local relaY = viewY + row
				local lineText = self.Lines[relaY] or ""
				local resText = ""
				local highlights = self:HighlightLine(relaY)
				local colStart = viewX + 1

				local richTemplates = self.RichTemplates
				local textTemplate = richTemplates.Text
				local selectionTemplate = richTemplates.Selection
				local curType = highlights[colStart]
				local curTemplate = richTemplates[typeMap[curType]] or textTemplate
				
				-- Selection Highlight
				local selectionRange = self.SelectionRange
				local selPos1 = selectionRange[1]
				local selPos2 = selectionRange[2]
				local selRow,selColumn = selPos1[2],selPos1[1]
				local sel2Row,sel2Column = selPos2[2],selPos2[1]
				local selRelaX,selRelaY = viewX,relaY-1
				
				if selRelaY >= selPos1[2] and selRelaY <= selPos2[2] then
					local fontSizeX = math.ceil(self.FontSize/2)
					local posX = (selRelaY == selPos1[2] and selPos1[1] or 0) - viewX
					local sizeX = (selRelaY == selPos2[2] and selPos2[1]-posX-viewX or maxCols+viewX)

					lineFrame.SelectionHighlight.Position = UDim2.new(0,posX*fontSizeX,0,0)
					lineFrame.SelectionHighlight.Size = UDim2.new(0,sizeX*fontSizeX,1,0)
					lineFrame.SelectionHighlight.Visible = true
				else
					lineFrame.SelectionHighlight.Visible = false
				end
				
				-- Selection Text Color for first char
				local inSelection = selRelaY >= selRow and selRelaY <= sel2Row and (selRelaY == selRow and viewX >= selColumn or selRelaY ~= selRow) and (selRelaY == sel2Row and viewX < sel2Column or selRelaY ~= sel2Row)
				if inSelection then
					curType = -999
					curTemplate = selectionTemplate
				end
				
				for col = 2,maxCols do
					local relaX = viewX + col
					local selRelaX = relaX-1
					local posType = highlights[relaX]
					
					-- Selection Text Color
					local inSelection = selRelaY >= selRow and selRelaY <= sel2Row and (selRelaY == selRow and selRelaX >= selColumn or selRelaY ~= selRow) and (selRelaY == sel2Row and selRelaX < sel2Column or selRelaY ~= sel2Row)
					if inSelection then
						posType = -999
					end
					
					if posType ~= curType then
						local template = (inSelection and selectionTemplate) or richTemplates[typeMap[posType]] or textTemplate
						
						if template ~= curTemplate then
							local nextText = gsub(sub(lineText,colStart,relaX-1),"['\"<>&]",richReplace)
							resText = resText .. (curTemplate ~= textTemplate and (curTemplate .. nextText .. "</font>") or nextText)
							colStart = relaX
							curTemplate = template
						end
						curType = posType
					end
				end

				local lastText = gsub(sub(lineText,colStart,viewX+maxCols),"['\"<>&]",richReplace)
				--warn("SUB",colStart,viewX+maxCols-1)
				if #lastText > 0 then
					resText = resText .. (curTemplate ~= textTemplate and (curTemplate .. lastText .. "</font>") or lastText)
				end

				if self.Lines[relaY] then
					lineNumberStr = lineNumberStr .. (relaY == self.CursorY and ("<b>"..relaY.."</b>\n") or relaY .. "\n")
				end

				lineFrame.Label.Text = resText
			end

			for i = maxLines+1,#self.LineFrames do
				self.LineFrames[i]:Destroy()
				self.LineFrames[i] = nil
			end

			self.Frame.LineNumbers.Text = lineNumberStr
			self:UpdateCursor()

			--print("REFRESH TIME",tick()-start)
		end

		funcs.UpdateView = function(self)
			local totalLinesStr = tostring(#self.Lines)
			local fontWidth = math.ceil(self.FontSize / 2)
			local linesOffset = #totalLinesStr*fontWidth + 4*fontWidth

			local linesFrame = self.Frame.Lines
			local hSize = linesFrame.AbsoluteSize.X
			local vSize = linesFrame.AbsoluteSize.Y
			local maxLines = math.ceil(vSize / self.FontSize)
			local totalWidth = self.MaxTextCols*fontWidth
			local scrollV = self.ScrollV
			local scrollH = self.ScrollH

			scrollV.VisibleSpace = maxLines
			scrollV.TotalSpace = #self.Lines + 1
			scrollH.VisibleSpace = math.ceil(hSize/fontWidth)
			scrollH.TotalSpace = self.MaxTextCols + 1

			scrollV.Gui.Visible = #self.Lines + 1 > maxLines
			scrollH.Gui.Visible = totalWidth > hSize

			local oldOffsets = self.FrameOffsets
			self.FrameOffsets = Vector2.new(scrollV.Gui.Visible and -16 or 0, scrollH.Gui.Visible and -16 or 0)
			if oldOffsets ~= self.FrameOffsets then
				self:UpdateView()
			else
				scrollV:ScrollTo(self.ViewY,true)
				scrollH:ScrollTo(self.ViewX,true)

				if scrollV.Gui.Visible and scrollH.Gui.Visible then
					scrollV.Gui.Size = UDim2.new(0,16,1,-16)
					scrollH.Gui.Size = UDim2.new(1,-16,0,16)
					self.GuiElems.ScrollCorner.Visible = true
				else
					scrollV.Gui.Size = UDim2.new(0,16,1,0)
					scrollH.Gui.Size = UDim2.new(1,0,0,16)
					self.GuiElems.ScrollCorner.Visible = false
				end

				self.ViewY = scrollV.Index
				self.ViewX = scrollH.Index
				self.Frame.Lines.Position = UDim2.new(0,linesOffset,0,0)
				self.Frame.Lines.Size = UDim2.new(1,-linesOffset+oldOffsets.X,1,oldOffsets.Y)
				self.Frame.LineNumbers.Position = UDim2.new(0,fontWidth,0,0)
				self.Frame.LineNumbers.Size = UDim2.new(0,#totalLinesStr*fontWidth,1,oldOffsets.Y)
				self.Frame.LineNumbers.TextSize = self.FontSize
			end
		end

		funcs.ProcessTextChange = function(self)
			local maxCols = 0
			local lines = self.Lines
			
			for i = 1,#lines do
				local lineLen = #lines[i]
				if lineLen > maxCols then
					maxCols = lineLen
				end
			end
			
			self.MaxTextCols = maxCols
			self:UpdateView()	
			self.Text = table.concat(self.Lines,"\n")
			self:MapNewLines()
			self:PreHighlight()
			self:Refresh()
			--self.TextChanged:Fire()
		end
		
		funcs.ConvertText = function(self,text,toEditor)
			if toEditor then
				return text:gsub("\t",(" %s%s "):format(tabSub,tabSub))
			else
				return text:gsub((" %s%s "):format(tabSub,tabSub),"\t")
			end
		end

		funcs.GetText = function(self) -- TODO: better (use new tab format)
			local source = table.concat(self.Lines,"\n")
			return self:ConvertText(source,false) -- Tab Convert
		end

		funcs.SetText = function(self,txt)
			txt = self:ConvertText(txt,true) -- Tab Convert
			local lines = self.Lines
			table.clear(lines)
			local count = 1

			for line in txt:gmatch("([^\n\r]*)[\n\r]?") do
				local len = #line
				lines[count] = line
				count = count + 1
			end
			
			self:ProcessTextChange()
		end

		funcs.MakeRichTemplates = function(self)
			local floor = math.floor
			local templates = {}

			for name,color in pairs(self.Colors) do
				templates[name] = ('<font color="rgb(%s,%s,%s)">'):format(floor(color.r*255),floor(color.g*255),floor(color.b*255))
			end

			self.RichTemplates = templates
		end

		funcs.ApplyTheme = function(self)
			local colors = Settings.Theme.Syntax
			self.Colors = colors
			self.Frame.LineNumbers.TextColor3 = colors.Text
			self.Frame.BackgroundColor3 = colors.Background
		end

		local mt = {__index = funcs}

		local function new()
			if not builtInInited then initBuiltIn() end

			local scrollV = Lib.ScrollBar.new()
			local scrollH = Lib.ScrollBar.new(true)
			scrollH.Gui.Position = UDim2.new(0,0,1,-16)
			local obj = setmetatable({
				FontSize = 15,
				ViewX = 0,
				ViewY = 0,
				Colors = Settings.Theme.Syntax,
				ColoredLines = {},
				Lines = {""},
				LineFrames = {},
				Editable = true,
				Editing = false,
				CursorX = 0,
				CursorY = 0,
				FloatCursorX = 0,
				Text = "",
				PreHighlights = {},
				SelectionRange = {{-1,-1},{-1,-1}},
				NewLines = {},
				FrameOffsets = Vector2.new(0,0),
				MaxTextCols = 0,
				ScrollV = scrollV,
				ScrollH = scrollH
			},mt)

			scrollV.WheelIncrement = 3
			scrollH.Increment = 2
			scrollH.WheelIncrement = 7

			scrollV.Scrolled:Connect(function()
				obj.ViewY = scrollV.Index
				obj:Refresh()
			end)

			scrollH.Scrolled:Connect(function()
				obj.ViewX = scrollH.Index
				obj:Refresh()
			end)

			makeFrame(obj)
			obj:MakeRichTemplates()
			obj:ApplyTheme()
			scrollV:SetScrollFrame(obj.Frame.Lines)
			scrollV.Gui.Parent = obj.Frame
			scrollH.Gui.Parent = obj.Frame

			obj:UpdateView()
			obj.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				obj:UpdateView()
				obj:Refresh()
			end)

			return obj
		end

		return {new = new}
	end)()

	Lib.Checkbox = (function()
		local funcs = {}
		local c3 = Color3.fromRGB
		local v2 = Vector2.new
		local ud2s = UDim2.fromScale
		local ud2o = UDim2.fromOffset
		local ud = UDim.new
		local max = math.max
		local new = Instance.new
		local TweenSize = new("Frame").TweenSize
		local ti = TweenInfo.new
		local delay = delay

		local function ripple(object, color)
			local circle = new('Frame')
			circle.BackgroundColor3 = color
			circle.BackgroundTransparency = 0.75
			circle.BorderSizePixel = 0
			circle.AnchorPoint = v2(0.5, 0.5)
			circle.Size = ud2o()
			circle.Position = ud2s(0.5, 0.5)
			circle.Parent = object
			local rounding = new('UICorner')
			rounding.CornerRadius = ud(1)
			rounding.Parent = circle

			local abssz = object.AbsoluteSize
			local size = max(abssz.X, abssz.Y) * 5/3

			TweenSize(circle, ud2o(size, size), "Out", "Quart", 0.4)
			service.TweenService:Create(circle, ti(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()

			service.Debris:AddItem(circle, 0.4)
		end

		local function initGui(self,frame)
			local checkbox = frame or create({
				{1,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="Checkbox",Position=UDim2.new(0,3,0,3),Size=UDim2.new(0,16,0,16),}},
				{2,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="ripples",Parent={1},Size=UDim2.new(1,0,1,0),}},
				{3,"Frame",{BackgroundColor3=Color3.new(0.10196078568697,0.10196078568697,0.10196078568697),BorderSizePixel=0,Name="outline",Parent={1},Size=UDim2.new(0,16,0,16),}},
				{4,"Frame",{BackgroundColor3=Color3.new(0.14117647707462,0.14117647707462,0.14117647707462),BorderSizePixel=0,Name="filler",Parent={3},Position=UDim2.new(0,1,0,1),Size=UDim2.new(0,14,0,14),}},
				{5,"Frame",{BackgroundColor3=Color3.new(0.90196084976196,0.90196084976196,0.90196084976196),BorderSizePixel=0,Name="top",Parent={4},Size=UDim2.new(0,16,0,0),}},
				{6,"Frame",{AnchorPoint=Vector2.new(0,1),BackgroundColor3=Color3.new(0.90196084976196,0.90196084976196,0.90196084976196),BorderSizePixel=0,Name="bottom",Parent={4},Position=UDim2.new(0,0,0,14),Size=UDim2.new(0,16,0,0),}},
				{7,"Frame",{BackgroundColor3=Color3.new(0.90196084976196,0.90196084976196,0.90196084976196),BorderSizePixel=0,Name="left",Parent={4},Size=UDim2.new(0,0,0,16),}},
				{8,"Frame",{AnchorPoint=Vector2.new(1,0),BackgroundColor3=Color3.new(0.90196084976196,0.90196084976196,0.90196084976196),BorderSizePixel=0,Name="right",Parent={4},Position=UDim2.new(0,14,0,0),Size=UDim2.new(0,0,0,16),}},
				{9,"Frame",{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,ClipsDescendants=true,Name="checkmark",Parent={4},Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,0,0,20),}},
				{10,"ImageLabel",{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Image=Main.GetLocalAsset("6234266378"),Parent={9},Position=UDim2.new(0.5,0,0.5,0),ScaleType=3,Size=UDim2.new(0,15,0,11),}},
				{11,"ImageLabel",{AnchorPoint=Vector2.new(0.5,0.5),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("6401617475"),ImageColor3=Color3.new(0.20784313976765,0.69803923368454,0.98431372642517),Name="checkmark2",Parent={4},Position=UDim2.new(0.5,0,0.5,0),Size=UDim2.new(0,12,0,12),Visible=false,}},
				{12,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("6425281788"),ImageTransparency=0.20000000298023,Name="middle",Parent={4},ScaleType=2,Size=UDim2.new(1,0,1,0),TileSize=UDim2.new(0,2,0,2),Visible=false,}},
				{13,"UICorner",{CornerRadius=UDim.new(0,2),Parent={3},}},
			})
			local outline = checkbox.outline
			local filler = outline.filler
			local checkmark = filler.checkmark
			local ripples_container = checkbox.ripples

			-- walls
			local top, bottom, left, right = filler.top, filler.bottom, filler.left, filler.right

			self.Gui = checkbox
			self.GuiElems = {
				Top = top,
				Bottom = bottom,
				Left = left,
				Right = right,
				Outline = outline,
				Filler = filler,
				Checkmark = checkmark,
				Checkmark2 = filler.checkmark2,
				Middle = filler.middle
			}

			checkbox.InputBegan:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 then
					local release
					release = service.UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							release:Disconnect()

							if Lib.CheckMouseInGui(checkbox) then
								if self.Style == 0 then
									ripple(ripples_container, self.Disabled and self.Colors.Disabled or self.Colors.Primary)
								end

								if not self.Disabled then
									self:SetState(not self.Toggled,true)
								else
									self:Paint()
								end

								self.OnInput:Fire()
							end
						end
					end)
				end
			end)

			self:Paint()
		end

		funcs.Collapse = function(self,anim)
			local guiElems = self.GuiElems
			if anim then
				TweenSize(guiElems.Top, ud2o(14, 14), "In", "Quart", 4/15, true)
				TweenSize(guiElems.Bottom, ud2o(14, 14), "In", "Quart", 4/15, true)
				TweenSize(guiElems.Left, ud2o(14, 14), "In", "Quart", 4/15, true)
				TweenSize(guiElems.Right, ud2o(14, 14), "In", "Quart", 4/15, true)
			else
				guiElems.Top.Size = ud2o(14, 14)
				guiElems.Bottom.Size = ud2o(14, 14)
				guiElems.Left.Size = ud2o(14, 14)
				guiElems.Right.Size = ud2o(14, 14)
			end
		end

		funcs.Expand = function(self,anim)
			local guiElems = self.GuiElems
			if anim then
				TweenSize(guiElems.Top, ud2o(14, 0), "InOut", "Quart", 4/15, true)
				TweenSize(guiElems.Bottom, ud2o(14, 0), "InOut", "Quart", 4/15, true)
				TweenSize(guiElems.Left, ud2o(0, 14), "InOut", "Quart", 4/15, true)
				TweenSize(guiElems.Right, ud2o(0, 14), "InOut", "Quart", 4/15, true)
			else
				guiElems.Top.Size = ud2o(14, 0)
				guiElems.Bottom.Size = ud2o(14, 0)
				guiElems.Left.Size = ud2o(0, 14)
				guiElems.Right.Size = ud2o(0, 14)
			end
		end

		funcs.Paint = function(self)
			local guiElems = self.GuiElems

			if self.Style == 0 then
				local color_base = self.Disabled and self.Colors.Disabled
				guiElems.Outline.BackgroundColor3 = color_base or (self.Toggled and self.Colors.Primary) or self.Colors.Secondary
				local walls_color = color_base or self.Colors.Primary
				guiElems.Top.BackgroundColor3 = walls_color
				guiElems.Bottom.BackgroundColor3 = walls_color
				guiElems.Left.BackgroundColor3 = walls_color
				guiElems.Right.BackgroundColor3 = walls_color
			else
				guiElems.Outline.BackgroundColor3 = self.Disabled and self.Colors.Disabled or self.Colors.Secondary
				guiElems.Filler.BackgroundColor3 = self.Disabled and self.Colors.DisabledBackground or self.Colors.Background
				guiElems.Checkmark2.ImageColor3 = self.Disabled and self.Colors.DisabledCheck or self.Colors.Primary
			end
		end

		funcs.SetState = function(self,val,anim)
			self.Toggled = val

			if self.OutlineColorTween then self.OutlineColorTween:Cancel() end
			local setStateTime = tick()
			self.LastSetStateTime = setStateTime

			if self.Toggled then
				if self.Style == 0 then
					if anim then
						self.OutlineColorTween = service.TweenService:Create(self.GuiElems.Outline, ti(4/15, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {BackgroundColor3 = self.Colors.Primary})
						self.OutlineColorTween:Play()
						delay(0.15, function()
							if setStateTime ~= self.LastSetStateTime then return end
							self:Paint()
							TweenSize(self.GuiElems.Checkmark, ud2o(14, 20), "Out", "Bounce", 2/15, true)
						end)
					else
						self.GuiElems.Outline.BackgroundColor3 = self.Colors.Primary
						self:Paint()
						self.GuiElems.Checkmark.Size = ud2o(14, 20)
					end
					self:Collapse(anim)
				else
					self:Paint()
					self.GuiElems.Checkmark2.Visible = true
					self.GuiElems.Middle.Visible = false
				end
			else
				if self.Style == 0 then
					if anim then
						self.OutlineColorTween = service.TweenService:Create(self.GuiElems.Outline, ti(4/15, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {BackgroundColor3 = self.Colors.Secondary})
						self.OutlineColorTween:Play()
						delay(0.15, function()
							if setStateTime ~= self.LastSetStateTime then return end
							self:Paint()
							TweenSize(self.GuiElems.Checkmark, ud2o(0, 20), "Out", "Quad", 1/15, true)
						end)
					else
						self.GuiElems.Outline.BackgroundColor3 = self.Colors.Secondary
						self:Paint()
						self.GuiElems.Checkmark.Size = ud2o(0, 20)
					end
					self:Expand(anim)
				else
					self:Paint()
					self.GuiElems.Checkmark2.Visible = false
					self.GuiElems.Middle.Visible = self.Toggled == nil
				end
			end
		end

		local mt = {__index = funcs}

		local function new(style)
			local obj = setmetatable({
				Toggled = false,
				Disabled = false,
				OnInput = Lib.Signal.new(),
				Style = style or 0,
				Colors = {
					Background = c3(36,36,36),
					Primary = c3(49,176,230),
					Secondary = c3(25,25,25),
					Disabled = c3(64,64,64),
					DisabledBackground = c3(52,52,52),
					DisabledCheck = c3(80,80,80)
				}
			},mt)
			initGui(obj)
			return obj
		end

		local function fromFrame(frame)
			local obj = setmetatable({
				Toggled = false,
				Disabled = false,
				Colors = {
					Background = c3(36,36,36),
					Primary = c3(49,176,230),
					Secondary = c3(25,25,25),
					Disabled = c3(64,64,64),
					DisabledBackground = c3(52,52,52)
				}
			},mt)
			initGui(obj,frame)
			return obj
		end

		return {new = new, fromFrame}
	end)()

	Lib.BrickColorPicker = (function()
		local funcs = {}
		local paletteCount = 0
		local mouse = service.Players.LocalPlayer:GetMouse()
		local hexStartX = 4
		local hexSizeX = 27
		local hexTriangleStart = 1
		local hexTriangleSize = 8

		local bottomColors = {
			Color3.fromRGB(17,17,17),
			Color3.fromRGB(99,95,98),
			Color3.fromRGB(163,162,165),
			Color3.fromRGB(205,205,205),
			Color3.fromRGB(223,223,222),
			Color3.fromRGB(237,234,234),
			Color3.fromRGB(27,42,53),
			Color3.fromRGB(91,93,105),
			Color3.fromRGB(159,161,172),
			Color3.fromRGB(202,203,209),
			Color3.fromRGB(231,231,236),
			Color3.fromRGB(248,248,248)
		}

		local function isMouseInHexagon(hex)
			local relativeX = mouse.X - hex.AbsolutePosition.X
			local relativeY = mouse.Y - hex.AbsolutePosition.Y
			if relativeX >= hexStartX and relativeX < hexStartX + hexSizeX then
				relativeX = relativeX - 4
				local relativeWidth = (13-math.min(relativeX,26 - relativeX))/13
				if relativeY >= hexTriangleStart + hexTriangleSize*relativeWidth and relativeY < hex.AbsoluteSize.Y - hexTriangleStart - hexTriangleSize*relativeWidth then
					return true
				end
			end

			return false
		end

		local function hexInput(self,hex,color)
			hex.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and isMouseInHexagon(hex) then
					self.OnSelect:Fire(color)
					self:Close()
				end
			end)

			hex.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and isMouseInHexagon(hex) then
					self.OnPreview:Fire(color)
				end
			end)
		end

		local function createGui(self)
			local gui = create({
				{1,"ScreenGui",{Name="BrickColor",}},
				{2,"Frame",{Active=true,BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderColor3=Color3.new(0.1294117718935,0.1294117718935,0.1294117718935),Parent={1},Position=UDim2.new(0.40000000596046,0,0.40000000596046,0),Size=UDim2.new(0,337,0,380),}},
				{3,"TextButton",{BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),BorderSizePixel=0,Font=3,Name="MoreColors",Parent={2},Position=UDim2.new(0,5,1,-30),Size=UDim2.new(1,-10,0,25),Text="More Colors",TextColor3=Color3.new(1,1,1),TextSize=14,}},
				{4,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Image=Main.GetLocalAsset("1281023007"),ImageColor3=Color3.new(0.33333334326744,0.33333334326744,0.49803924560547),Name="Hex",Parent={2},Size=UDim2.new(0,35,0,35),Visible=false,}},
			})
			local colorFrame = gui.Frame
			local hex = colorFrame.Hex

			for row = 1,13 do
				local columns = math.min(row,14-row)+6
				for column = 1,columns do
					local nextColor = BrickColor.palette(paletteCount).Color
					local newHex = hex:Clone()
					newHex.Position = UDim2.new(0, (column-1)*25-(columns-7)*13+3*26 + 1, 0, (row-1)*23 + 4)
					newHex.ImageColor3 = nextColor
					newHex.Visible = true
					hexInput(self,newHex,nextColor)
					newHex.Parent = colorFrame
					paletteCount = paletteCount + 1
				end
			end

			for column = 1,12 do
				local nextColor = bottomColors[column]
				local newHex = hex:Clone()
				newHex.Position = UDim2.new(0, (column-1)*25-(12-7)*13+3*26 + 3, 0, 308)
				newHex.ImageColor3 = nextColor
				newHex.Visible = true
				hexInput(self,newHex,nextColor)
				newHex.Parent = colorFrame
				paletteCount = paletteCount + 1
			end

			colorFrame.MoreColors.MouseButton1Click:Connect(function()
				self.OnMoreColors:Fire()
				self:Close()
			end)

			self.Gui = gui
		end

		funcs.SetMoreColorsVisible = function(self,vis)
			local colorFrame = self.Gui.Frame
			colorFrame.Size = UDim2.new(0,337,0,380 - (not vis and 33 or 0))
			colorFrame.MoreColors.Visible = vis
		end

		funcs.Show = function(self,x,y,prevColor)
			self.PrevColor = prevColor or self.PrevColor

			local reverseY = false

			local x,y = x or mouse.X, y or mouse.Y
			local maxX,maxY = mouse.ViewSizeX,mouse.ViewSizeY
			Lib.ShowGui(self.Gui)
			local sizeX,sizeY = self.Gui.Frame.AbsoluteSize.X,self.Gui.Frame.AbsoluteSize.Y

			if x + sizeX > maxX then x = self.ReverseX and x - sizeX or maxX - sizeX end
			if y + sizeY > maxY then reverseY = true end

			local closable = false
			if self.CloseEvent then self.CloseEvent:Disconnect() end
			self.CloseEvent = service.UserInputService.InputBegan:Connect(function(input)
				if not closable or input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

				if not Lib.CheckMouseInGui(self.Gui.Frame) then
					self.CloseEvent:Disconnect()
					self:Close()
				end
			end)

			if reverseY then
				local newY = y - sizeY - (self.ReverseYOffset or 0)
				y = newY >= 0 and newY or 0
			end

			self.Gui.Frame.Position = UDim2.new(0,x,0,y)

			Lib.FastWait()
			closable = true
		end

		funcs.Close = function(self)
			self.Gui.Parent = nil
			self.OnCancel:Fire()
		end

		local mt = {__index = funcs}

		local function new()
			local obj = setmetatable({
				OnPreview = Lib.Signal.new(),
				OnSelect = Lib.Signal.new(),
				OnCancel = Lib.Signal.new(),
				OnMoreColors = Lib.Signal.new(),
				PrevColor = Color3.new(0,0,0)
			},mt)
			createGui(obj)
			return obj
		end

		return {new = new}
	end)()

	Lib.ColorPicker = (function() -- TODO: Convert to newer class model
		local funcs = {}

		local function new()
			local newMt = setmetatable({},{})

			newMt.OnSelect = Lib.Signal.new()
			newMt.OnCancel = Lib.Signal.new()
			newMt.OnPreview = Lib.Signal.new()

			local guiContents = create({
				{1,"Frame",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderSizePixel=0,ClipsDescendants=true,Name="Content",Position=UDim2.new(0,0,0,20),Size=UDim2.new(1,0,1,-20),}},
				{2,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name="BasicColors",Parent={1},Position=UDim2.new(0,5,0,5),Size=UDim2.new(0,180,0,200),}},
				{3,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={2},Position=UDim2.new(0,0,0,-5),Size=UDim2.new(1,0,0,26),Text="Basic Colors",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{4,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Blue",Parent={1},Position=UDim2.new(1,-63,0,255),Size=UDim2.new(0,52,0,16),}},
				{5,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),Font=3,Name="Input",Parent={4},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,50,0,16),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{6,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="ArrowFrame",Parent={5},Position=UDim2.new(1,-16,0,0),Size=UDim2.new(0,16,1,0),}},
				{7,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Up",Parent={6},Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{8,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={7},Size=UDim2.new(0,16,0,8),}},
				{9,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={8},Position=UDim2.new(0,8,0,3),Size=UDim2.new(0,1,0,1),}},
				{10,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={8},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{11,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={8},Position=UDim2.new(0,6,0,5),Size=UDim2.new(0,5,0,1),}},
				{12,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Down",Parent={6},Position=UDim2.new(0,0,0,8),Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{13,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={12},Size=UDim2.new(0,16,0,8),}},
				{14,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={13},Position=UDim2.new(0,8,0,5),Size=UDim2.new(0,1,0,1),}},
				{15,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={13},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{16,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={13},Position=UDim2.new(0,6,0,3),Size=UDim2.new(0,5,0,1),}},
				{17,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={4},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Blue:",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{18,"Frame",{BackgroundColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),BorderSizePixel=0,ClipsDescendants=true,Name="ColorSpaceFrame",Parent={1},Position=UDim2.new(1,-261,0,4),Size=UDim2.new(0,222,0,202),}},
				{19,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),BorderSizePixel=0,Image=Main.GetLocalAsset("1072518406"),Name="ColorSpace",Parent={18},Position=UDim2.new(0,1,0,1),Size=UDim2.new(0,220,0,200),}},
				{20,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="Scope",Parent={19},Position=UDim2.new(0,210,0,190),Size=UDim2.new(0,20,0,20),}},
				{21,"Frame",{BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Name="Line",Parent={20},Position=UDim2.new(0,9,0,0),Size=UDim2.new(0,2,0,20),}},
				{22,"Frame",{BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Name="Line",Parent={20},Position=UDim2.new(0,0,0,9),Size=UDim2.new(0,20,0,2),}},
				{23,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name="CustomColors",Parent={1},Position=UDim2.new(0,5,0,210),Size=UDim2.new(0,180,0,90),}},
				{24,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={23},Size=UDim2.new(1,0,0,20),Text="Custom Colors (RC = Set)",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{25,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Green",Parent={1},Position=UDim2.new(1,-63,0,233),Size=UDim2.new(0,52,0,16),}},
				{26,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),Font=3,Name="Input",Parent={25},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,50,0,16),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{27,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="ArrowFrame",Parent={26},Position=UDim2.new(1,-16,0,0),Size=UDim2.new(0,16,1,0),}},
				{28,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Up",Parent={27},Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{29,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={28},Size=UDim2.new(0,16,0,8),}},
				{30,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={29},Position=UDim2.new(0,8,0,3),Size=UDim2.new(0,1,0,1),}},
				{31,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={29},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{32,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={29},Position=UDim2.new(0,6,0,5),Size=UDim2.new(0,5,0,1),}},
				{33,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Down",Parent={27},Position=UDim2.new(0,0,0,8),Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{34,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={33},Size=UDim2.new(0,16,0,8),}},
				{35,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={34},Position=UDim2.new(0,8,0,5),Size=UDim2.new(0,1,0,1),}},
				{36,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={34},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{37,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={34},Position=UDim2.new(0,6,0,3),Size=UDim2.new(0,5,0,1),}},
				{38,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={25},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Green:",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{39,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Hue",Parent={1},Position=UDim2.new(1,-180,0,211),Size=UDim2.new(0,52,0,16),}},
				{40,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),Font=3,Name="Input",Parent={39},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,50,0,16),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{41,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="ArrowFrame",Parent={40},Position=UDim2.new(1,-16,0,0),Size=UDim2.new(0,16,1,0),}},
				{42,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Up",Parent={41},Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{43,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={42},Size=UDim2.new(0,16,0,8),}},
				{44,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={43},Position=UDim2.new(0,8,0,3),Size=UDim2.new(0,1,0,1),}},
				{45,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={43},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{46,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={43},Position=UDim2.new(0,6,0,5),Size=UDim2.new(0,5,0,1),}},
				{47,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Down",Parent={41},Position=UDim2.new(0,0,0,8),Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{48,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={47},Size=UDim2.new(0,16,0,8),}},
				{49,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={48},Position=UDim2.new(0,8,0,5),Size=UDim2.new(0,1,0,1),}},
				{50,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={48},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{51,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={48},Position=UDim2.new(0,6,0,3),Size=UDim2.new(0,5,0,1),}},
				{52,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={39},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Hue:",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{53,"Frame",{BackgroundColor3=Color3.new(1,1,1),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Name="Preview",Parent={1},Position=UDim2.new(1,-260,0,211),Size=UDim2.new(0,35,1,-245),}},
				{54,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Red",Parent={1},Position=UDim2.new(1,-63,0,211),Size=UDim2.new(0,52,0,16),}},
				{55,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),Font=3,Name="Input",Parent={54},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,50,0,16),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{56,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="ArrowFrame",Parent={55},Position=UDim2.new(1,-16,0,0),Size=UDim2.new(0,16,1,0),}},
				{57,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Up",Parent={56},Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{58,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={57},Size=UDim2.new(0,16,0,8),}},
				{59,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={58},Position=UDim2.new(0,8,0,3),Size=UDim2.new(0,1,0,1),}},
				{60,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={58},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{61,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={58},Position=UDim2.new(0,6,0,5),Size=UDim2.new(0,5,0,1),}},
				{62,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Down",Parent={56},Position=UDim2.new(0,0,0,8),Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{63,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={62},Size=UDim2.new(0,16,0,8),}},
				{64,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={63},Position=UDim2.new(0,8,0,5),Size=UDim2.new(0,1,0,1),}},
				{65,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={63},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{66,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={63},Position=UDim2.new(0,6,0,3),Size=UDim2.new(0,5,0,1),}},
				{67,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={54},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Red:",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{68,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Sat",Parent={1},Position=UDim2.new(1,-180,0,233),Size=UDim2.new(0,52,0,16),}},
				{69,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),Font=3,Name="Input",Parent={68},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,50,0,16),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{70,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="ArrowFrame",Parent={69},Position=UDim2.new(1,-16,0,0),Size=UDim2.new(0,16,1,0),}},
				{71,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Up",Parent={70},Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{72,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={71},Size=UDim2.new(0,16,0,8),}},
				{73,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={72},Position=UDim2.new(0,8,0,3),Size=UDim2.new(0,1,0,1),}},
				{74,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={72},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{75,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={72},Position=UDim2.new(0,6,0,5),Size=UDim2.new(0,5,0,1),}},
				{76,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Down",Parent={70},Position=UDim2.new(0,0,0,8),Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{77,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={76},Size=UDim2.new(0,16,0,8),}},
				{78,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={77},Position=UDim2.new(0,8,0,5),Size=UDim2.new(0,1,0,1),}},
				{79,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={77},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{80,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={77},Position=UDim2.new(0,6,0,3),Size=UDim2.new(0,5,0,1),}},
				{81,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={68},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Sat:",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{82,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Val",Parent={1},Position=UDim2.new(1,-180,0,255),Size=UDim2.new(0,52,0,16),}},
				{83,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),Font=3,Name="Input",Parent={82},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,50,0,16),Text="255",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{84,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="ArrowFrame",Parent={83},Position=UDim2.new(1,-16,0,0),Size=UDim2.new(0,16,1,0),}},
				{85,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Up",Parent={84},Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{86,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={85},Size=UDim2.new(0,16,0,8),}},
				{87,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={86},Position=UDim2.new(0,8,0,3),Size=UDim2.new(0,1,0,1),}},
				{88,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={86},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{89,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={86},Position=UDim2.new(0,6,0,5),Size=UDim2.new(0,5,0,1),}},
				{90,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="Down",Parent={84},Position=UDim2.new(0,0,0,8),Size=UDim2.new(1,0,0,8),Text="",TextSize=14,}},
				{91,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={90},Size=UDim2.new(0,16,0,8),}},
				{92,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={91},Position=UDim2.new(0,8,0,5),Size=UDim2.new(0,1,0,1),}},
				{93,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={91},Position=UDim2.new(0,7,0,4),Size=UDim2.new(0,3,0,1),}},
				{94,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={91},Position=UDim2.new(0,6,0,3),Size=UDim2.new(0,5,0,1),}},
				{95,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={82},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Val:",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{96,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Font=3,Name="Cancel",Parent={1},Position=UDim2.new(1,-105,1,-28),Size=UDim2.new(0,100,0,25),Text="Cancel",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,}},
				{97,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Font=3,Name="Ok",Parent={1},Position=UDim2.new(1,-210,1,-28),Size=UDim2.new(0,100,0,25),Text="OK",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,}},
				{98,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Image=Main.GetLocalAsset("1072518502"),Name="ColorStrip",Parent={1},Position=UDim2.new(1,-30,0,5),Size=UDim2.new(0,13,0,200),}},
				{99,"Frame",{BackgroundColor3=Color3.new(0.3137255012989,0.3137255012989,0.3137255012989),BackgroundTransparency=1,BorderSizePixel=0,Name="ArrowFrame",Parent={1},Position=UDim2.new(1,-16,0,1),Size=UDim2.new(0,5,0,208),}},
				{100,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={99},Position=UDim2.new(0,-2,0,-4),Size=UDim2.new(0,8,0,16),}},
				{101,"Frame",{BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent={100},Position=UDim2.new(0,2,0,8),Size=UDim2.new(0,1,0,1),}},
				{102,"Frame",{BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent={100},Position=UDim2.new(0,3,0,7),Size=UDim2.new(0,1,0,3),}},
				{103,"Frame",{BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent={100},Position=UDim2.new(0,4,0,6),Size=UDim2.new(0,1,0,5),}},
				{104,"Frame",{BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent={100},Position=UDim2.new(0,5,0,5),Size=UDim2.new(0,1,0,7),}},
				{105,"Frame",{BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent={100},Position=UDim2.new(0,6,0,4),Size=UDim2.new(0,1,0,9),}},
			})
			local window = Lib.Window.new()
			window.Resizable = false
			window.Alignable = false
			window:SetTitle("Color Picker")
			window:Resize(450,330)
			for i,v in pairs(guiContents:GetChildren()) do
				v.Parent = window.GuiElems.Content
			end
			newMt.Window = window
			newMt.Gui = window.Gui
			local pickerGui = window.Gui.Main
			local pickerTopBar = pickerGui.TopBar
			local pickerFrame = pickerGui.Content
			local colorSpace = pickerFrame.ColorSpaceFrame.ColorSpace
			local colorStrip = pickerFrame.ColorStrip
			local previewFrame = pickerFrame.Preview
			local basicColorsFrame = pickerFrame.BasicColors
			local customColorsFrame = pickerFrame.CustomColors
			local okButton = pickerFrame.Ok
			local cancelButton = pickerFrame.Cancel
			local closeButton = pickerTopBar.Close

			local colorScope = colorSpace.Scope
			local colorArrow = pickerFrame.ArrowFrame.Arrow

			local hueInput = pickerFrame.Hue.Input
			local satInput = pickerFrame.Sat.Input
			local valInput = pickerFrame.Val.Input

			local redInput = pickerFrame.Red.Input
			local greenInput = pickerFrame.Green.Input
			local blueInput = pickerFrame.Blue.Input

			local user = game:GetService("UserInputService")
			local mouse = game:GetService("Players").LocalPlayer:GetMouse()

			local hue,sat,val = 0,0,1
			local red,green,blue = 1,1,1
			local chosenColor = Color3.new(0,0,0)

			local basicColors = {Color3.new(0,0,0),Color3.new(0.66666668653488,0,0),Color3.new(0,0.33333334326744,0),Color3.new(0.66666668653488,0.33333334326744,0),Color3.new(0,0.66666668653488,0),Color3.new(0.66666668653488,0.66666668653488,0),Color3.new(0,1,0),Color3.new(0.66666668653488,1,0),Color3.new(0,0,0.49803924560547),Color3.new(0.66666668653488,0,0.49803924560547),Color3.new(0,0.33333334326744,0.49803924560547),Color3.new(0.66666668653488,0.33333334326744,0.49803924560547),Color3.new(0,0.66666668653488,0.49803924560547),Color3.new(0.66666668653488,0.66666668653488,0.49803924560547),Color3.new(0,1,0.49803924560547),Color3.new(0.66666668653488,1,0.49803924560547),Color3.new(0,0,1),Color3.new(0.66666668653488,0,1),Color3.new(0,0.33333334326744,1),Color3.new(0.66666668653488,0.33333334326744,1),Color3.new(0,0.66666668653488,1),Color3.new(0.66666668653488,0.66666668653488,1),Color3.new(0,1,1),Color3.new(0.66666668653488,1,1),Color3.new(0.33333334326744,0,0),Color3.new(1,0,0),Color3.new(0.33333334326744,0.33333334326744,0),Color3.new(1,0.33333334326744,0),Color3.new(0.33333334326744,0.66666668653488,0),Color3.new(1,0.66666668653488,0),Color3.new(0.33333334326744,1,0),Color3.new(1,1,0),Color3.new(0.33333334326744,0,0.49803924560547),Color3.new(1,0,0.49803924560547),Color3.new(0.33333334326744,0.33333334326744,0.49803924560547),Color3.new(1,0.33333334326744,0.49803924560547),Color3.new(0.33333334326744,0.66666668653488,0.49803924560547),Color3.new(1,0.66666668653488,0.49803924560547),Color3.new(0.33333334326744,1,0.49803924560547),Color3.new(1,1,0.49803924560547),Color3.new(0.33333334326744,0,1),Color3.new(1,0,1),Color3.new(0.33333334326744,0.33333334326744,1),Color3.new(1,0.33333334326744,1),Color3.new(0.33333334326744,0.66666668653488,1),Color3.new(1,0.66666668653488,1),Color3.new(0.33333334326744,1,1),Color3.new(1,1,1)}
			local customColors = {}

			local function updateColor(noupdate)
				local relativeX,relativeY,relativeStripY = 219 - hue*219, 199 - sat*199, 199 - val*199
				local hsvColor = Color3.fromHSV(hue,sat,val)

				if noupdate == 2 or not noupdate then
					hueInput.Text = tostring(math.ceil(359*hue))
					satInput.Text = tostring(math.ceil(255*sat))
					valInput.Text = tostring(math.floor(255*val))
				end
				if noupdate == 1 or not noupdate then
					redInput.Text = tostring(math.floor(255*red))
					greenInput.Text = tostring(math.floor(255*green))
					blueInput.Text = tostring(math.floor(255*blue))
				end

				chosenColor = Color3.new(red,green,blue)

				colorScope.Position = UDim2.new(0,relativeX-9,0,relativeY-9)
				colorStrip.ImageColor3 = Color3.fromHSV(hue,sat,1)
				colorArrow.Position = UDim2.new(0,-2,0,relativeStripY-4)
				previewFrame.BackgroundColor3 = chosenColor

				newMt.Color = chosenColor
				newMt.OnPreview:Fire(chosenColor)
			end

			local function colorSpaceInput()
				local relativeX = mouse.X - colorSpace.AbsolutePosition.X
				local relativeY = mouse.Y - colorSpace.AbsolutePosition.Y

				if relativeX < 0 then relativeX = 0 elseif relativeX > 219 then relativeX = 219 end
				if relativeY < 0 then relativeY = 0 elseif relativeY > 199 then relativeY = 199 end

				hue = (219 - relativeX)/219
				sat = (199 - relativeY)/199

				local hsvColor = Color3.fromHSV(hue,sat,val)
				red,green,blue = hsvColor.r,hsvColor.g,hsvColor.b

				updateColor()
			end

			local function colorStripInput()
				local relativeY = mouse.Y - colorStrip.AbsolutePosition.Y

				if relativeY < 0 then relativeY = 0 elseif relativeY > 199 then relativeY = 199 end	

				val = (199 - relativeY)/199

				local hsvColor = Color3.fromHSV(hue,sat,val)
				red,green,blue = hsvColor.r,hsvColor.g,hsvColor.b

				updateColor()
			end

			local function hookButtons(frame,func)
				frame.ArrowFrame.Up.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						frame.ArrowFrame.Up.BackgroundTransparency = 0.5
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
						local releaseEvent,runEvent

						local startTime = tick()
						local pressing = true
						local startNum = tonumber(frame.Text)

						if not startNum then return end

						releaseEvent = user.InputEnded:Connect(function(input)
							if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
							releaseEvent:Disconnect()
							pressing = false
						end)

						startNum = startNum + 1
						func(startNum)
						while pressing do
							if tick()-startTime > 0.3 then
								startNum = startNum + 1
								func(startNum)
							end
							wait(0.1)
						end
					end
				end)

				frame.ArrowFrame.Up.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						frame.ArrowFrame.Up.BackgroundTransparency = 1
					end
				end)

				frame.ArrowFrame.Down.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						frame.ArrowFrame.Down.BackgroundTransparency = 0.5
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
						local releaseEvent,runEvent

						local startTime = tick()
						local pressing = true
						local startNum = tonumber(frame.Text)

						if not startNum then return end

						releaseEvent = user.InputEnded:Connect(function(input)
							if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
							releaseEvent:Disconnect()
							pressing = false
						end)

						startNum = startNum - 1
						func(startNum)
						while pressing do
							if tick()-startTime > 0.3 then
								startNum = startNum - 1
								func(startNum)
							end
							wait(0.1)
						end
					end
				end)

				frame.ArrowFrame.Down.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						frame.ArrowFrame.Down.BackgroundTransparency = 1
					end
				end)
			end

			colorSpace.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local releaseEvent,mouseEvent

					releaseEvent = user.InputEnded:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
						releaseEvent:Disconnect()
						mouseEvent:Disconnect()
					end)

					mouseEvent = user.InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							colorSpaceInput()
						end
					end)

					colorSpaceInput()
				end
			end)

			colorStrip.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local releaseEvent,mouseEvent

					releaseEvent = user.InputEnded:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
						releaseEvent:Disconnect()
						mouseEvent:Disconnect()
					end)

					mouseEvent = user.InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement then
							colorStripInput()
						end
					end)

					colorStripInput()
				end
			end)

			local function updateHue(str)
				local num = tonumber(str)
				if num then
					hue = math.clamp(math.floor(num),0,359)/359
					local hsvColor = Color3.fromHSV(hue,sat,val)
					red,green,blue = hsvColor.r,hsvColor.g,hsvColor.b
					hueInput.Text = tostring(hue*359)
					updateColor(1)
				end
			end
			hueInput.FocusLost:Connect(function() updateHue(hueInput.Text) end) hookButtons(hueInput,updateHue)

			local function updateSat(str)
				local num = tonumber(str)
				if num then
					sat = math.clamp(math.floor(num),0,255)/255
					local hsvColor = Color3.fromHSV(hue,sat,val)
					red,green,blue = hsvColor.r,hsvColor.g,hsvColor.b
					satInput.Text = tostring(sat*255)
					updateColor(1)
				end
			end
			satInput.FocusLost:Connect(function() updateSat(satInput.Text) end) hookButtons(satInput,updateSat)

			local function updateVal(str)
				local num = tonumber(str)
				if num then
					val = math.clamp(math.floor(num),0,255)/255
					local hsvColor = Color3.fromHSV(hue,sat,val)
					red,green,blue = hsvColor.r,hsvColor.g,hsvColor.b
					valInput.Text = tostring(val*255)
					updateColor(1)
				end
			end
			valInput.FocusLost:Connect(function() updateVal(valInput.Text) end) hookButtons(valInput,updateVal)

			local function updateRed(str)
				local num = tonumber(str)
				if num then
					red = math.clamp(math.floor(num),0,255)/255
					local newColor = Color3.new(red,green,blue)
					hue,sat,val = Color3.toHSV(newColor)
					redInput.Text = tostring(red*255)
					updateColor(2)
				end
			end
			redInput.FocusLost:Connect(function() updateRed(redInput.Text) end) hookButtons(redInput,updateRed)

			local function updateGreen(str)
				local num = tonumber(str)
				if num then
					green = math.clamp(math.floor(num),0,255)/255
					local newColor = Color3.new(red,green,blue)
					hue,sat,val = Color3.toHSV(newColor)
					greenInput.Text = tostring(green*255)
					updateColor(2)
				end
			end
			greenInput.FocusLost:Connect(function() updateGreen(greenInput.Text) end) hookButtons(greenInput,updateGreen)

			local function updateBlue(str)
				local num = tonumber(str)
				if num then
					blue = math.clamp(math.floor(num),0,255)/255
					local newColor = Color3.new(red,green,blue)
					hue,sat,val = Color3.toHSV(newColor)
					blueInput.Text = tostring(blue*255)
					updateColor(2)
				end
			end
			blueInput.FocusLost:Connect(function() updateBlue(blueInput.Text) end) hookButtons(blueInput,updateBlue)

			local colorChoice = Instance.new("TextButton")
			colorChoice.Name = "Choice"
			colorChoice.Size = UDim2.new(0,25,0,18)
			colorChoice.BorderColor3 = Color3.fromRGB(55,55,55)
			colorChoice.Text = ""
			colorChoice.AutoButtonColor = false

			local row = 0
			local column = 0
			for i,v in pairs(basicColors) do
				local newColor = colorChoice:Clone()
				newColor.BackgroundColor3 = v
				newColor.Position = UDim2.new(0,1 + 30*column,0,21 + 23*row)

				newColor.MouseButton1Click:Connect(function()
					red,green,blue = v.r,v.g,v.b
					local newColor = Color3.new(red,green,blue)
					hue,sat,val = Color3.toHSV(newColor)
					updateColor()
				end)	

				newColor.Parent = basicColorsFrame
				column = column + 1
				if column == 6 then row = row + 1 column = 0 end
			end

			row = 0
			column = 0
			for i = 1,12 do
				local color = customColors[i] or Color3.new(0,0,0)
				local newColor = colorChoice:Clone()
				newColor.BackgroundColor3 = color
				newColor.Position = UDim2.new(0,1 + 30*column,0,20 + 23*row)

				newColor.MouseButton1Click:Connect(function()
					local curColor = customColors[i] or Color3.new(0,0,0)
					red,green,blue = curColor.r,curColor.g,curColor.b
					hue,sat,val = Color3.toHSV(curColor)
					updateColor()
				end)

				newColor.MouseButton2Click:Connect(function()
					customColors[i] = chosenColor
					newColor.BackgroundColor3 = chosenColor
				end)

				newColor.Parent = customColorsFrame
				column = column + 1
				if column == 6 then row = row + 1 column = 0 end
			end

			okButton.MouseButton1Click:Connect(function() newMt.OnSelect:Fire(chosenColor) window:Close() end)
			okButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then okButton.BackgroundTransparency = 0.4 end end)
			okButton.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then okButton.BackgroundTransparency = 0 end end)

			cancelButton.MouseButton1Click:Connect(function() newMt.OnCancel:Fire() window:Close() end)
			cancelButton.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then cancelButton.BackgroundTransparency = 0.4 end end)
			cancelButton.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then cancelButton.BackgroundTransparency = 0 end end)

			updateColor()

			newMt.SetColor = function(self,color)
				red,green,blue = color.r,color.g,color.b
				hue,sat,val = Color3.toHSV(color)
				updateColor()
			end

			newMt.Show = function(self)
				self.Window:Show()
			end

			return newMt
		end

		return {new = new}
	end)()

	Lib.NumberSequenceEditor = (function()
		local function new() -- TODO: Convert to newer class model
			local newMt = setmetatable({},{})
			newMt.OnSelect = Lib.Signal.new()
			newMt.OnCancel = Lib.Signal.new()
			newMt.OnPreview = Lib.Signal.new()

			local guiContents = create({
				{1,"Frame",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderSizePixel=0,ClipsDescendants=true,Name="Content",Position=UDim2.new(0,0,0,20),Size=UDim2.new(1,0,1,-20),}},
				{2,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Time",Parent={1},Position=UDim2.new(0,40,0,210),Size=UDim2.new(0,60,0,20),}},
				{3,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),ClipsDescendants=true,Font=3,Name="Input",Parent={2},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,58,0,20),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{4,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={2},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Time",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{5,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Font=3,Name="Close",Parent={1},Position=UDim2.new(1,-90,0,210),Size=UDim2.new(0,80,0,20),Text="Close",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,}},
				{6,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Font=3,Name="Reset",Parent={1},Position=UDim2.new(1,-180,0,210),Size=UDim2.new(0,80,0,20),Text="Reset",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,}},
				{7,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Font=3,Name="Delete",Parent={1},Position=UDim2.new(0,380,0,210),Size=UDim2.new(0,80,0,20),Text="Delete",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,}},
				{8,"Frame",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Name="NumberLineOutlines",Parent={1},Position=UDim2.new(0,10,0,20),Size=UDim2.new(1,-20,0,170),}},
				{9,"Frame",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),Name="NumberLine",Parent={1},Position=UDim2.new(0,10,0,20),Size=UDim2.new(1,-20,0,170),}},
				{10,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Value",Parent={1},Position=UDim2.new(0,170,0,210),Size=UDim2.new(0,60,0,20),}},
				{11,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={10},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Value",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{12,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),ClipsDescendants=true,Font=3,Name="Input",Parent={10},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,58,0,20),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{13,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Envelope",Parent={1},Position=UDim2.new(0,300,0,210),Size=UDim2.new(0,60,0,20),}},
				{14,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),ClipsDescendants=true,Font=3,Name="Input",Parent={13},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,58,0,20),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{15,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={13},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Envelope",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
			})
			local window = Lib.Window.new()
			window.Resizable = false
			window:Resize(680,265)
			window:SetTitle("NumberSequence Editor")
			newMt.Window = window
			newMt.Gui = window.Gui
			for i,v in pairs(guiContents:GetChildren()) do
				v.Parent = window.GuiElems.Content
			end
			local gui = window.Gui
			local pickerGui = gui.Main
			local pickerTopBar = pickerGui.TopBar
			local pickerFrame = pickerGui.Content
			local numberLine = pickerFrame.NumberLine
			local numberLineOutlines = pickerFrame.NumberLineOutlines
			local timeBox = pickerFrame.Time.Input
			local valueBox = pickerFrame.Value.Input
			local envelopeBox = pickerFrame.Envelope.Input
			local deleteButton = pickerFrame.Delete
			local resetButton = pickerFrame.Reset
			local closeButton = pickerFrame.Close
			local topClose = pickerTopBar.Close

			local points = {{1,0,3},{8,0.05,1},{5,0.6,2},{4,0.7,4},{6,1,4}}
			local lines = {}
			local eLines = {}
			local beginPoint = points[1]
			local endPoint = points[#points]
			local currentlySelected = nil
			local currentPoint = nil
			local resetSequence = nil

			local user = game:GetService("UserInputService")
			local mouse = game:GetService("Players").LocalPlayer:GetMouse()

			for i = 2,10 do
				local newLine = Instance.new("Frame")
				newLine.BackgroundTransparency = 0.5
				newLine.BackgroundColor3 = Color3.new(96/255,96/255,96/255)
				newLine.BorderSizePixel = 0
				newLine.Size = UDim2.new(0,1,1,0)
				newLine.Position = UDim2.new((i-1)/(11-1),0,0,0)
				newLine.Parent = numberLineOutlines
			end

			for i = 2,4 do
				local newLine = Instance.new("Frame")
				newLine.BackgroundTransparency = 0.5
				newLine.BackgroundColor3 = Color3.new(96/255,96/255,96/255)
				newLine.BorderSizePixel = 0
				newLine.Size = UDim2.new(1,0,0,1)
				newLine.Position = UDim2.new(0,0,(i-1)/(5-1),0)
				newLine.Parent = numberLineOutlines
			end

			local lineTemp = Instance.new("Frame")
			lineTemp.BackgroundColor3 = Color3.new(0,0,0)
			lineTemp.BorderSizePixel = 0
			lineTemp.Size = UDim2.new(0,1,0,1)

			local sequenceLine = Instance.new("Frame")
			sequenceLine.BackgroundColor3 = Color3.new(0,0,0)
			sequenceLine.BorderSizePixel = 0
			sequenceLine.Size = UDim2.new(0,1,0,0)

			for i = 1,numberLine.AbsoluteSize.X do
				local line = sequenceLine:Clone()
				eLines[i] = line
				line.Name = "E"..tostring(i)
				line.BackgroundTransparency = 0.5
				line.BackgroundColor3 = Color3.new(199/255,44/255,28/255)
				line.Position = UDim2.new(0,i-1,0,0)
				line.Parent = numberLine
			end

			for i = 1,numberLine.AbsoluteSize.X do
				local line = sequenceLine:Clone()
				lines[i] = line
				line.Name = tostring(i)
				line.Position = UDim2.new(0,i-1,0,0)
				line.Parent = numberLine
			end

			local envelopeDrag = Instance.new("Frame")
			envelopeDrag.BackgroundTransparency = 1
			envelopeDrag.BackgroundColor3 = Color3.new(0,0,0)
			envelopeDrag.BorderSizePixel = 0
			envelopeDrag.Size = UDim2.new(0,7,0,20)
			envelopeDrag.Visible = false
			envelopeDrag.ZIndex = 2
			local envelopeDragLine = Instance.new("Frame",envelopeDrag)
			envelopeDragLine.Name = "Line"
			envelopeDragLine.BackgroundColor3 = Color3.new(0,0,0)
			envelopeDragLine.BorderSizePixel = 0
			envelopeDragLine.Position = UDim2.new(0,3,0,0)
			envelopeDragLine.Size = UDim2.new(0,1,0,20)
			envelopeDragLine.ZIndex = 2

			local envelopeDragTop,envelopeDragBottom = envelopeDrag:Clone(),envelopeDrag:Clone()
			envelopeDragTop.Parent = numberLine
			envelopeDragBottom.Parent = numberLine

			local function buildSequence()
				local newPoints = {}
				for i,v in pairs(points) do
					table.insert(newPoints,NumberSequenceKeypoint.new(v[2],v[1],v[3]))
				end
				newMt.Sequence = NumberSequence.new(newPoints)
				newMt.OnSelect:Fire(newMt.Sequence)
			end

			local function round(num,places)
				local multi = 10^places
				return math.floor(num*multi + 0.5)/multi
			end

			local function updateInputs(point)
				if point then
					currentPoint = point
					local rawT,rawV,rawE = point[2],point[1],point[3]
					timeBox.Text = round(rawT,(rawT < 0.01 and 5) or (rawT < 0.1 and 4) or 3)
					valueBox.Text = round(rawV,(rawV < 0.01 and 5) or (rawV < 0.1 and 4) or (rawV < 1 and 3) or 2)
					envelopeBox.Text = round(rawE,(rawE < 0.01 and 5) or (rawE < 0.1 and 4) or (rawV < 1 and 3) or 2)

					local envelopeDistance = numberLine.AbsoluteSize.Y*(point[3]/10)
					envelopeDragTop.Position = UDim2.new(0,point[4].Position.X.Offset-1,0,point[4].Position.Y.Offset-envelopeDistance-17)
					envelopeDragTop.Visible = true
					envelopeDragBottom.Position = UDim2.new(0,point[4].Position.X.Offset-1,0,point[4].Position.Y.Offset+envelopeDistance+2)
					envelopeDragBottom.Visible = true
				end
			end

			envelopeDragTop.InputBegan:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not currentPoint or Lib.CheckMouseInGui(currentPoint[4].Select) then return end
				local mouseEvent,releaseEvent
				local maxSize = numberLine.AbsoluteSize.Y

				local mouseDelta = math.abs(envelopeDragTop.AbsolutePosition.Y - mouse.Y)

				envelopeDragTop.Line.Position = UDim2.new(0,2,0,0)
				envelopeDragTop.Line.Size = UDim2.new(0,3,0,20)

				releaseEvent = user.InputEnded:Connect(function(input)
					if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
					mouseEvent:Disconnect()
					releaseEvent:Disconnect()
					envelopeDragTop.Line.Position = UDim2.new(0,3,0,0)
					envelopeDragTop.Line.Size = UDim2.new(0,1,0,20)
				end)

				mouseEvent = user.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						local topDiff = (currentPoint[4].AbsolutePosition.Y+2)-(mouse.Y-mouseDelta)-19
						local newEnvelope = 10*(math.max(topDiff,0)/maxSize)
						local maxEnvelope = math.min(currentPoint[1],10-currentPoint[1])
						currentPoint[3] = math.min(newEnvelope,maxEnvelope)
						newMt:Redraw()
						buildSequence()
						updateInputs(currentPoint)
					end
				end)
			end)

			envelopeDragBottom.InputBegan:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not currentPoint or Lib.CheckMouseInGui(currentPoint[4].Select) then return end
				local mouseEvent,releaseEvent
				local maxSize = numberLine.AbsoluteSize.Y

				local mouseDelta = math.abs(envelopeDragBottom.AbsolutePosition.Y - mouse.Y)

				envelopeDragBottom.Line.Position = UDim2.new(0,2,0,0)
				envelopeDragBottom.Line.Size = UDim2.new(0,3,0,20)

				releaseEvent = user.InputEnded:Connect(function(input)
					if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
					mouseEvent:Disconnect()
					releaseEvent:Disconnect()
					envelopeDragBottom.Line.Position = UDim2.new(0,3,0,0)
					envelopeDragBottom.Line.Size = UDim2.new(0,1,0,20)
				end)

				mouseEvent = user.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						local bottomDiff = (mouse.Y+(20-mouseDelta))-(currentPoint[4].AbsolutePosition.Y+2)-19
						local newEnvelope = 10*(math.max(bottomDiff,0)/maxSize)
						local maxEnvelope = math.min(currentPoint[1],10-currentPoint[1])
						currentPoint[3] = math.min(newEnvelope,maxEnvelope)
						newMt:Redraw()
						buildSequence()
						updateInputs(currentPoint)
					end
				end)
			end)

			local function placePoint(point)
				local newPoint = Instance.new("Frame")
				newPoint.Name = "Point"
				newPoint.BorderSizePixel = 0
				newPoint.Size = UDim2.new(0,5,0,5)
				newPoint.Position = UDim2.new(0,math.floor((numberLine.AbsoluteSize.X-1) * point[2])-2,0,numberLine.AbsoluteSize.Y*(10-point[1])/10-2)
				newPoint.BackgroundColor3 = Color3.new(0,0,0)

				local newSelect = Instance.new("Frame")
				newSelect.Name = "Select"
				newSelect.BackgroundTransparency = 1
				newSelect.BackgroundColor3 = Color3.new(199/255,44/255,28/255)
				newSelect.Position = UDim2.new(0,-2,0,-2)
				newSelect.Size = UDim2.new(0,9,0,9)
				newSelect.Parent = newPoint

				newPoint.Parent = numberLine

				newSelect.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						for i,v in pairs(points) do v[4].Select.BackgroundTransparency = 1 end
						newSelect.BackgroundTransparency = 0
						updateInputs(point)
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 and not currentlySelected then
						currentPoint = point
						local mouseEvent,releaseEvent
						currentlySelected = true
						newSelect.BackgroundColor3 = Color3.new(249/255,191/255,59/255)

						local oldEnvelope = point[3]

						releaseEvent = user.InputEnded:Connect(function(input)
							if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
							mouseEvent:Disconnect()
							releaseEvent:Disconnect()
							currentlySelected = nil
							newSelect.BackgroundColor3 = Color3.new(199/255,44/255,28/255)
						end)

						mouseEvent = user.InputChanged:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseMovement then
								local maxX = numberLine.AbsoluteSize.X-1
								local relativeX = mouse.X - numberLine.AbsolutePosition.X
								if relativeX < 0 then relativeX = 0 end
								if relativeX > maxX then relativeX = maxX end
								local maxY = numberLine.AbsoluteSize.Y-1
								local relativeY = mouse.Y - numberLine.AbsolutePosition.Y
								if relativeY < 0 then relativeY = 0 end
								if relativeY > maxY then relativeY = maxY end
								if point ~= beginPoint and point ~= endPoint then
									point[2] = relativeX/maxX
								end
								point[1] = 10-(relativeY/maxY)*10
								local maxEnvelope = math.min(point[1],10-point[1])
								point[3] = math.min(oldEnvelope,maxEnvelope)
								newMt:Redraw()
								updateInputs(point)
								for i,v in pairs(points) do v[4].Select.BackgroundTransparency = 1 end
								newSelect.BackgroundTransparency = 0
								buildSequence()
							end
						end)
					end
				end)

				return newPoint
			end

			local function placePoints()
				for i,v in pairs(points) do
					v[4] = placePoint(v)
				end
			end

			local function redraw(self)
				local numberLineSize = numberLine.AbsoluteSize
				table.sort(points,function(a,b) return a[2] < b[2] end)
				for i,v in pairs(points) do
					v[4].Position = UDim2.new(0,math.floor((numberLineSize.X-1) * v[2])-2,0,(numberLineSize.Y-1)*(10-v[1])/10-2)
				end
				lines[1].Size = UDim2.new(0,1,0,0)
				for i = 1,#points-1 do
					local fromPoint = points[i]
					local toPoint = points[i+1]
					local deltaY = toPoint[4].Position.Y.Offset-fromPoint[4].Position.Y.Offset
					local deltaX = toPoint[4].Position.X.Offset-fromPoint[4].Position.X.Offset
					local slope = deltaY/deltaX

					local fromEnvelope = fromPoint[3]
					local nextEnvelope = toPoint[3]

					local currentRise = math.abs(slope)
					local totalRise = 0
					local maxRise = math.abs(toPoint[4].Position.Y.Offset-fromPoint[4].Position.Y.Offset)

					for lineCount = math.min(fromPoint[4].Position.X.Offset+1,toPoint[4].Position.X.Offset),toPoint[4].Position.X.Offset do
						if deltaX == 0 and deltaY == 0 then return end
						local riseNow = math.floor(currentRise)
						local line = lines[lineCount+3]
						if line then
							if totalRise+riseNow > maxRise then riseNow = maxRise-totalRise end
							if math.sign(slope) == -1 then
								line.Position = UDim2.new(0,lineCount+2,0,fromPoint[4].Position.Y.Offset + -(totalRise+riseNow)+2)
							else
								line.Position = UDim2.new(0,lineCount+2,0,fromPoint[4].Position.Y.Offset + totalRise+2)
							end
							line.Size = UDim2.new(0,1,0,math.max(riseNow,1))
						end
						totalRise = totalRise + riseNow
						currentRise = currentRise - riseNow + math.abs(slope)

						local envPercent = (lineCount-fromPoint[4].Position.X.Offset)/(toPoint[4].Position.X.Offset-fromPoint[4].Position.X.Offset)
						local envLerp = fromEnvelope+(nextEnvelope-fromEnvelope)*envPercent
						local relativeSize = (envLerp/10)*numberLineSize.Y						

						local line = eLines[lineCount + 3]
						if line then
							line.Position = UDim2.new(0,lineCount+2,0,lines[lineCount+3].Position.Y.Offset-math.floor(relativeSize))
							line.Size = UDim2.new(0,1,0,math.floor(relativeSize*2))
						end
					end
				end
			end
			newMt.Redraw = redraw

			local function loadSequence(self,seq)
				resetSequence = seq
				for i,v in pairs(points) do if v[4] then v[4]:Destroy() end end
				points = {}
				for i,v in pairs(seq.Keypoints) do
					local maxEnvelope = math.min(v.Value,10-v.Value)
					local newPoint = {v.Value,v.Time,math.min(v.Envelope,maxEnvelope)}
					newPoint[4] = placePoint(newPoint)
					table.insert(points,newPoint)
				end
				beginPoint = points[1]
				endPoint = points[#points]
				currentlySelected = nil
				redraw()
				envelopeDragTop.Visible = false
				envelopeDragBottom.Visible = false
			end
			newMt.SetSequence = loadSequence

			timeBox.FocusLost:Connect(function()
				local point = currentPoint
				local num = tonumber(timeBox.Text)
				if point and num and point ~= beginPoint and point ~= endPoint then
					num = math.clamp(num,0,1)
					point[2] = num
					redraw()
					buildSequence()
					updateInputs(point)
				end
			end)

			valueBox.FocusLost:Connect(function()
				local point = currentPoint
				local num = tonumber(valueBox.Text)
				if point and num then
					local oldEnvelope = point[3]
					num = math.clamp(num,0,10)
					point[1] = num
					local maxEnvelope = math.min(point[1],10-point[1])
					point[3] = math.min(oldEnvelope,maxEnvelope)
					redraw()
					buildSequence()
					updateInputs(point)
				end
			end)

			envelopeBox.FocusLost:Connect(function()
				local point = currentPoint
				local num = tonumber(envelopeBox.Text)
				if point and num then
					num = math.clamp(num,0,5)
					local maxEnvelope = math.min(point[1],10-point[1])
					point[3] = math.min(num,maxEnvelope)
					redraw()
					buildSequence()
					updateInputs(point)
				end
			end)

			local function buttonAnimations(button,inverse)
				button.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then button.BackgroundTransparency = (inverse and 0.5 or 0.4) end end)
				button.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then button.BackgroundTransparency = (inverse and 1 or 0) end end)
			end

			numberLine.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and #points < 20 then
					if Lib.CheckMouseInGui(envelopeDragTop) or Lib.CheckMouseInGui(envelopeDragBottom) then return end
					for i,v in pairs(points) do
						if Lib.CheckMouseInGui(v[4].Select) then return end
					end
					local maxX = numberLine.AbsoluteSize.X-1
					local relativeX = mouse.X - numberLine.AbsolutePosition.X
					if relativeX < 0 then relativeX = 0 end
					if relativeX > maxX then relativeX = maxX end
					local maxY = numberLine.AbsoluteSize.Y-1
					local relativeY = mouse.Y - numberLine.AbsolutePosition.Y
					if relativeY < 0 then relativeY = 0 end
					if relativeY > maxY then relativeY = maxY end

					local raw = relativeX/maxX
					local newPoint = {10-(relativeY/maxY)*10,raw,0}
					newPoint[4] = placePoint(newPoint)
					table.insert(points,newPoint)
					redraw()
					buildSequence()
				end
			end)

			deleteButton.MouseButton1Click:Connect(function()
				if currentPoint and currentPoint ~= beginPoint and currentPoint ~= endPoint then
					for i,v in pairs(points) do
						if v == currentPoint then
							v[4]:Destroy()
							table.remove(points,i)
							break
						end
					end
					currentlySelected = nil
					redraw()
					buildSequence()
					updateInputs(points[1])
				end
			end)

			resetButton.MouseButton1Click:Connect(function()
				if resetSequence then
					newMt:SetSequence(resetSequence)
					buildSequence()
				end
			end)

			closeButton.MouseButton1Click:Connect(function()
				window:Close()
			end)

			buttonAnimations(deleteButton)
			buttonAnimations(resetButton)
			buttonAnimations(closeButton)

			placePoints()
			redraw()

			newMt.Show = function(self)
				window:Show()
			end

			return newMt
		end

		return {new = new}
	end)()

	Lib.ColorSequenceEditor = (function() -- TODO: Convert to newer class model
		local function new()
			local newMt = setmetatable({},{})
			newMt.OnSelect = Lib.Signal.new()
			newMt.OnCancel = Lib.Signal.new()
			newMt.OnPreview = Lib.Signal.new()
			newMt.OnPickColor = Lib.Signal.new()

			local guiContents = create({
				{1,"Frame",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderSizePixel=0,ClipsDescendants=true,Name="Content",Position=UDim2.new(0,0,0,20),Size=UDim2.new(1,0,1,-20),}},
				{2,"Frame",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Name="ColorLine",Parent={1},Position=UDim2.new(0,10,0,5),Size=UDim2.new(1,-20,0,70),}},
				{3,"Frame",{BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Name="Gradient",Parent={2},Size=UDim2.new(1,0,1,0),}},
				{4,"UIGradient",{Parent={3},}},
				{5,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Name="Arrows",Parent={1},Position=UDim2.new(0,1,0,73),Size=UDim2.new(1,-2,0,16),}},
				{6,"Frame",{BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=0.5,BorderSizePixel=0,Name="Cursor",Parent={1},Position=UDim2.new(0,10,0,0),Size=UDim2.new(0,1,0,80),}},
				{7,"Frame",{BackgroundColor3=Color3.new(0.14901961386204,0.14901961386204,0.14901961386204),BorderColor3=Color3.new(0.12549020349979,0.12549020349979,0.12549020349979),Name="Time",Parent={1},Position=UDim2.new(0,40,0,95),Size=UDim2.new(0,100,0,20),}},
				{8,"TextBox",{BackgroundColor3=Color3.new(0.25098040699959,0.25098040699959,0.25098040699959),BackgroundTransparency=1,BorderColor3=Color3.new(0.37647062540054,0.37647062540054,0.37647062540054),ClipsDescendants=true,Font=3,Name="Input",Parent={7},Position=UDim2.new(0,2,0,0),Size=UDim2.new(0,98,0,20),Text="0",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=0,}},
				{9,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={7},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Time",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{10,"Frame",{BackgroundColor3=Color3.new(1,1,1),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),Name="ColorBox",Parent={1},Position=UDim2.new(0,220,0,95),Size=UDim2.new(0,20,0,20),}},
				{11,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Title",Parent={10},Position=UDim2.new(0,-40,0,0),Size=UDim2.new(0,34,1,0),Text="Color",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,TextXAlignment=1,}},
				{12,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),BorderSizePixel=0,Font=3,Name="Close",Parent={1},Position=UDim2.new(1,-90,0,95),Size=UDim2.new(0,80,0,20),Text="Close",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,}},
				{13,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),BorderSizePixel=0,Font=3,Name="Reset",Parent={1},Position=UDim2.new(1,-180,0,95),Size=UDim2.new(0,80,0,20),Text="Reset",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,}},
				{14,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderColor3=Color3.new(0.21568627655506,0.21568627655506,0.21568627655506),BorderSizePixel=0,Font=3,Name="Delete",Parent={1},Position=UDim2.new(0,280,0,95),Size=UDim2.new(0,80,0,20),Text="Delete",TextColor3=Color3.new(0.86274516582489,0.86274516582489,0.86274516582489),TextSize=14,}},
				{15,"Frame",{BackgroundTransparency=1,Name="Arrow",Parent={1},Size=UDim2.new(0,16,0,16),Visible=false,}},
				{16,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={15},Position=UDim2.new(0,8,0,3),Size=UDim2.new(0,1,0,2),}},
				{17,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={15},Position=UDim2.new(0,7,0,5),Size=UDim2.new(0,3,0,2),}},
				{18,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={15},Position=UDim2.new(0,6,0,7),Size=UDim2.new(0,5,0,2),}},
				{19,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={15},Position=UDim2.new(0,5,0,9),Size=UDim2.new(0,7,0,2),}},
				{20,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={15},Position=UDim2.new(0,4,0,11),Size=UDim2.new(0,9,0,2),}},
			})
			local window = Lib.Window.new()
			window.Resizable = false
			window:Resize(650,150)
			window:SetTitle("ColorSequence Editor")
			newMt.Window = window
			newMt.Gui = window.Gui
			for i,v in pairs(guiContents:GetChildren()) do
				v.Parent = window.GuiElems.Content
			end
			local gui = window.Gui
			local pickerGui = gui.Main
			local pickerTopBar = pickerGui.TopBar
			local pickerFrame = pickerGui.Content
			local colorLine = pickerFrame.ColorLine
			local gradient = colorLine.Gradient.UIGradient
			local arrowFrame = pickerFrame.Arrows
			local arrow = pickerFrame.Arrow
			local cursor = pickerFrame.Cursor
			local timeBox = pickerFrame.Time.Input
			local colorBox = pickerFrame.ColorBox
			local deleteButton = pickerFrame.Delete
			local resetButton = pickerFrame.Reset
			local closeButton = pickerFrame.Close
			local topClose = pickerTopBar.Close

			local user = game:GetService("UserInputService")
			local mouse = game:GetService("Players").LocalPlayer:GetMouse()

			local colors = {{Color3.new(1,0,1),0},{Color3.new(0.2,0.9,0.2),0.2},{Color3.new(0.4,0.5,0.9),0.7},{Color3.new(0.6,1,1),1}}
			local resetSequence = nil

			local beginPoint = colors[1]
			local endPoint = colors[#colors]

			local currentlySelected = nil
			local currentPoint = nil

			local sequenceLine = Instance.new("Frame")
			sequenceLine.BorderSizePixel = 0
			sequenceLine.Size = UDim2.new(0,1,1,0)

			newMt.Sequence = ColorSequence.new(Color3.new(1,1,1))
			local function buildSequence(noupdate)
				local newPoints = {}
				table.sort(colors,function(a,b) return a[2] < b[2] end)
				for i,v in pairs(colors) do
					table.insert(newPoints,ColorSequenceKeypoint.new(v[2],v[1]))
				end
				newMt.Sequence = ColorSequence.new(newPoints)
				if not noupdate then newMt.OnSelect:Fire(newMt.Sequence) end
			end

			local function round(num,places)
				local multi = 10^places
				return math.floor(num*multi + 0.5)/multi
			end

			local function updateInputs(point)
				if point then
					currentPoint = point
					local raw = point[2]
					timeBox.Text = round(raw,(raw < 0.01 and 5) or (raw < 0.1 and 4) or 3)
					colorBox.BackgroundColor3 = point[1]
				end
			end

			local function placeArrow(ind,point)
				local newArrow = arrow:Clone()
				newArrow.Position = UDim2.new(0,ind-1,0,0)
				newArrow.Visible = true
				newArrow.Parent = arrowFrame

				newArrow.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						cursor.Visible = true
						cursor.Position = UDim2.new(0,9 + newArrow.Position.X.Offset,0,0)
					end
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						updateInputs(point)
						if point == beginPoint or point == endPoint or currentlySelected then return end

						local mouseEvent,releaseEvent
						currentlySelected = true

						releaseEvent = user.InputEnded:Connect(function(input)
							if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
							mouseEvent:Disconnect()
							releaseEvent:Disconnect()
							currentlySelected = nil
							cursor.Visible = false
						end)

						mouseEvent = user.InputChanged:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseMovement then
								local maxSize = colorLine.AbsoluteSize.X-1
								local relativeX = mouse.X - colorLine.AbsolutePosition.X
								if relativeX < 0 then relativeX = 0 end
								if relativeX > maxSize then relativeX = maxSize end
								local raw = relativeX/maxSize
								point[2] = relativeX/maxSize
								updateInputs(point)
								cursor.Visible = true
								cursor.Position = UDim2.new(0,9 + newArrow.Position.X.Offset,0,0)
								buildSequence()
								newMt:Redraw()
							end
						end)
					end
				end)

				newArrow.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						cursor.Visible = false
					end
				end)

				return newArrow
			end

			local function placeArrows()
				for i,v in pairs(colors) do
					v[3] = placeArrow(math.floor((colorLine.AbsoluteSize.X-1) * v[2]) + 1,v)
				end
			end

			local function redraw(self)
				gradient.Color = newMt.Sequence or ColorSequence.new(Color3.new(1,1,1))

				for i = 2,#colors do
					local nextColor = colors[i]
					local endPos = math.floor((colorLine.AbsoluteSize.X-1) * nextColor[2]) + 1
					nextColor[3].Position = UDim2.new(0,endPos,0,0)
				end		
			end
			newMt.Redraw = redraw

			local function loadSequence(self,seq)
				resetSequence = seq
				for i,v in pairs(colors) do if v[3] then v[3]:Destroy() end end
				colors = {}
				currentlySelected = nil
				for i,v in pairs(seq.Keypoints) do
					local newPoint = {v.Value,v.Time}
					newPoint[3] = placeArrow(v.Time,newPoint)
					table.insert(colors,newPoint)
				end
				beginPoint = colors[1]
				endPoint = colors[#colors]
				currentlySelected = nil
				updateInputs(colors[1])
				buildSequence(true)
				redraw()
			end
			newMt.SetSequence = loadSequence

			local function buttonAnimations(button,inverse)
				button.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then button.BackgroundTransparency = (inverse and 0.5 or 0.4) end end)
				button.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then button.BackgroundTransparency = (inverse and 1 or 0) end end)
			end

			colorLine.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and #colors < 20 then
					local maxSize = colorLine.AbsoluteSize.X-1
					local relativeX = mouse.X - colorLine.AbsolutePosition.X
					if relativeX < 0 then relativeX = 0 end
					if relativeX > maxSize then relativeX = maxSize end

					local raw = relativeX/maxSize
					local fromColor = nil
					local toColor = nil
					for i,col in pairs(colors) do
						if col[2] >= raw then
							fromColor = colors[math.max(i-1,1)]
							toColor = colors[i]
							break
						end
					end
					local lerpColor = fromColor[1]:lerp(toColor[1],(raw-fromColor[2])/(toColor[2]-fromColor[2]))
					local newPoint = {lerpColor,raw}
					newPoint[3] = placeArrow(newPoint[2],newPoint)
					table.insert(colors,newPoint)
					updateInputs(newPoint)
					buildSequence()
					redraw()
				end
			end)

			colorLine.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					local maxSize = colorLine.AbsoluteSize.X-1
					local relativeX = mouse.X - colorLine.AbsolutePosition.X
					if relativeX < 0 then relativeX = 0 end
					if relativeX > maxSize then relativeX = maxSize end
					cursor.Visible = true
					cursor.Position = UDim2.new(0,10 + relativeX,0,0)
				end
			end)

			colorLine.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					local inArrow = false
					for i,v in pairs(colors) do
						if Lib.CheckMouseInGui(v[3]) then
							inArrow = v[3]
						end
					end
					cursor.Visible = inArrow and true or false
					if inArrow then cursor.Position = UDim2.new(0,9 + inArrow.Position.X.Offset,0,0) end
				end
			end)

			timeBox:GetPropertyChangedSignal("Text"):Connect(function()
				local point = currentPoint
				local num = tonumber(timeBox.Text)
				if point and num and point ~= beginPoint and point ~= endPoint then
					num = math.clamp(num,0,1)
					point[2] = num
					buildSequence()
					redraw()
				end
			end)

			colorBox.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local editor = newMt.ColorPicker
					if not editor then
						editor = Lib.ColorPicker.new()
						editor.Window:SetTitle("ColorSequence Color Picker")

						editor.OnSelect:Connect(function(col)
							if currentPoint then
								currentPoint[1] = col
							end
							buildSequence()
							redraw()
						end)

						newMt.ColorPicker = editor
					end

					editor.Window:ShowAndFocus()
				end
			end)

			deleteButton.MouseButton1Click:Connect(function()
				if currentPoint and currentPoint ~= beginPoint and currentPoint ~= endPoint then
					for i,v in pairs(colors) do
						if v == currentPoint then
							v[3]:Destroy()
							table.remove(colors,i)
							break
						end
					end
					currentlySelected = nil
					updateInputs(colors[1])
					buildSequence()
					redraw()
				end
			end)

			resetButton.MouseButton1Click:Connect(function()
				if resetSequence then
					newMt:SetSequence(resetSequence)
				end
			end)

			closeButton.MouseButton1Click:Connect(function()
				window:Close()
			end)

			topClose.MouseButton1Click:Connect(function()
				window:Close()
			end)

			buttonAnimations(deleteButton)
			buttonAnimations(resetButton)
			buttonAnimations(closeButton)

			placeArrows()
			redraw()

			newMt.Show = function(self)
				window:Show()
			end

			return newMt
		end

		return {new = new}
	end)()

	Lib.ViewportTextBox = (function()
		local textService = game:GetService("TextService")

		local props = {
			OffsetX = 0,
			TextBox = PH,
			CursorPos = -1,
			Gui = PH,
			View = PH
		}
		local funcs = {}
		funcs.Update = function(self)
			local cursorPos = self.CursorPos or -1
			local text = self.TextBox.Text
			if text == "" then self.TextBox.Position = UDim2.new(0,0,0,0) return end
			if cursorPos == -1 then return end

			local cursorText = text:sub(1,cursorPos-1)
			local pos = nil
			local leftEnd = -self.TextBox.Position.X.Offset
			local rightEnd = leftEnd + self.View.AbsoluteSize.X

			local totalTextSize = textService:GetTextSize(text,self.TextBox.TextSize,self.TextBox.Font,Vector2.new(999999999,100)).X
			local cursorTextSize = textService:GetTextSize(cursorText,self.TextBox.TextSize,self.TextBox.Font,Vector2.new(999999999,100)).X

			if cursorTextSize > rightEnd then
				pos = math.max(-1,cursorTextSize - self.View.AbsoluteSize.X + 2)
			elseif cursorTextSize < leftEnd then
				pos = math.max(-1,cursorTextSize-2)
			elseif totalTextSize < rightEnd then
				pos = math.max(-1,totalTextSize - self.View.AbsoluteSize.X + 2)
			end

			if pos then
				self.TextBox.Position = UDim2.new(0,-pos,0,0)
				self.TextBox.Size = UDim2.new(1,pos,1,0)
			end
		end

		funcs.GetText = function(self)
			return self.TextBox.Text
		end

		funcs.SetText = function(self,text)
			self.TextBox.Text = text
		end

		local mt = getGuiMT(props,funcs)

		local function convert(textbox)
			local obj = initObj(props,mt)

			local view = Instance.new("Frame")
			view.BackgroundTransparency = textbox.BackgroundTransparency
			view.BackgroundColor3 = textbox.BackgroundColor3
			view.BorderSizePixel = textbox.BorderSizePixel
			view.BorderColor3 = textbox.BorderColor3
			view.Position = textbox.Position
			view.Size = textbox.Size
			view.ClipsDescendants = true
			view.Name = textbox.Name
			textbox.BackgroundTransparency = 1
			textbox.Position = UDim2.new(0,0,0,0)
			textbox.Size = UDim2.new(1,0,1,0)
			textbox.TextXAlignment = Enum.TextXAlignment.Left
			textbox.Name = "Input"

			obj.TextBox = textbox
			obj.View = view
			obj.Gui = view

			textbox.Changed:Connect(function(prop)
				if prop == "Text" or prop == "CursorPosition" or prop == "AbsoluteSize" then
					local cursorPos = obj.TextBox.CursorPosition
					if cursorPos ~= -1 then obj.CursorPos = cursorPos end
					obj:Update()
				end
			end)

			obj:Update()

			view.Parent = textbox.Parent
			textbox.Parent = view

			return obj
		end

		local function new()
			local textBox = Instance.new("TextBox")
			textBox.Size = UDim2.new(0,100,0,20)
			textBox.BackgroundColor3 = Settings.Theme.TextBox
			textBox.BorderColor3 = Settings.Theme.Outline3
			textBox.ClearTextOnFocus = false
			textBox.TextColor3 = Settings.Theme.Text
			textBox.Font = Enum.Font.SourceSans
			textBox.TextSize = 14
			textBox.Text = ""
			return convert(textBox)
		end

		return {new = new, convert = convert}
	end)()

	Lib.Label = (function()
		local props,funcs = {},{}

		local mt = getGuiMT(props,funcs)

		local function new()
			local label = Instance.new("TextLabel")
			label.BackgroundTransparency = 1
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextColor3 = Settings.Theme.Text
			label.TextTransparency = 0.1
			label.Size = UDim2.new(0,100,0,20)
			label.Font = Enum.Font.SourceSans
			label.TextSize = 14

			local obj = setmetatable({
				Gui = label
			},mt)
			return obj
		end

		return {new = new}
	end)()

	Lib.Frame = (function()
		local props,funcs = {},{}

		local mt = getGuiMT(props,funcs)

		local function new()
			local fr = Instance.new("Frame")
			fr.BackgroundColor3 = Settings.Theme.Main1
			fr.BorderColor3 = Settings.Theme.Outline1
			fr.Size = UDim2.new(0,50,0,50)

			local obj = setmetatable({
				Gui = fr
			},mt)
			return obj
		end

		return {new = new}
	end)()

	Lib.Button = (function()
		local props = {
			Gui = PH,
			Anim = PH,
			Disabled = false,
			OnClick = SIGNAL,
			OnDown = SIGNAL,
			OnUp = SIGNAL,
			AllowedButtons = {1}
		}
		local funcs = {}
		local tableFind = table.find

		funcs.Trigger = function(self,event,button)
			if not self.Disabled and tableFind(self.AllowedButtons,button) then
				self["On"..event]:Fire(button)
			end
		end

		funcs.SetDisabled = function(self,dis)
			self.Disabled = dis

			if dis then
				self.Anim:Disable()
				self.Gui.TextTransparency = 0.5
			else
				self.Anim.Enable()
				self.Gui.TextTransparency = 0
			end
		end

		local mt = getGuiMT(props,funcs)

		local function new()
			local b = Instance.new("TextButton")
			b.AutoButtonColor = false
			b.TextColor3 = Settings.Theme.Text
			b.TextTransparency = 0.1
			b.Size = UDim2.new(0,100,0,20)
			b.Font = Enum.Font.SourceSans
			b.TextSize = 14
			b.BackgroundColor3 = Settings.Theme.Button
			b.BorderColor3 = Settings.Theme.Outline2

			local obj = initObj(props,mt)
			obj.Gui = b
			obj.Anim = Lib.ButtonAnim(b,{Mode = 2, StartColor = Settings.Theme.Button, HoverColor = Settings.Theme.ButtonHover, PressColor = Settings.Theme.ButtonPress, OutlineColor = Settings.Theme.Outline2})

			b.MouseButton1Click:Connect(function() obj:Trigger("Click",1) end)
			b.MouseButton1Down:Connect(function() obj:Trigger("Down",1) end)
			b.MouseButton1Up:Connect(function() obj:Trigger("Up",1) end)

			b.MouseButton2Click:Connect(function() obj:Trigger("Click",2) end)
			b.MouseButton2Down:Connect(function() obj:Trigger("Down",2) end)
			b.MouseButton2Up:Connect(function() obj:Trigger("Up",2) end)

			return obj
		end

		return {new = new}
	end)()

	Lib.DropDown = (function()
		local props = {
			Gui = PH,
			Anim = PH,
			Context = PH,
			Selected = PH,
			Disabled = false,
			CanBeEmpty = true,
			Options = {},
			GuiElems = {},
			OnSelect = SIGNAL
		}
		local funcs = {}

		funcs.Update = function(self)
			local options = self.Options

			if #options > 0 then
				if not self.Selected then
					if not self.CanBeEmpty then
						self.Selected = options[1]
						self.GuiElems.Label.Text = options[1]
					else
						self.GuiElems.Label.Text = "- Select -"
					end
				else
					self.GuiElems.Label.Text = self.Selected
				end
			else
				self.GuiElems.Label.Text = "- Select -"
			end
		end

		funcs.ShowOptions = function(self)
			local context = self.Context

			context.Width = self.Gui.AbsoluteSize.X
			context.ReverseYOffset = self.Gui.AbsoluteSize.Y
			context:Show(self.Gui.AbsolutePosition.X, self.Gui.AbsolutePosition.Y + context.ReverseYOffset)
		end

		funcs.SetOptions = function(self,opts)
			self.Options = opts

			local context = self.Context
			local options = self.Options
			context:Clear()

			local onClick = function(option) self.Selected = option self.OnSelect:Fire(option) self:Update() end

			if self.CanBeEmpty then
				context:Add({Name = "- Select -", OnClick = function() self.Selected = nil self.OnSelect:Fire(nil) self:Update() end})
			end

			for i = 1,#options do
				context:Add({Name = options[i], OnClick = onClick})
			end

			self:Update()
		end

		funcs.SetSelected = function(self,opt)
			self.Selected = type(opt) == "number" and self.Options[opt] or opt
			self:Update()
		end

		local mt = getGuiMT(props,funcs)

		local function new()
			local f = Instance.new("TextButton")
			f.AutoButtonColor = false
			f.Text = ""
			f.Size = UDim2.new(0,100,0,20)
			f.BackgroundColor3 = Settings.Theme.TextBox
			f.BorderColor3 = Settings.Theme.Outline3

			local label = Lib.Label.new()
			label.Position = UDim2.new(0,2,0,0)
			label.Size = UDim2.new(1,-22,1,0)
			label.TextTruncate = Enum.TextTruncate.AtEnd
			label.Parent = f
			local arrow = create({
				{1,"Frame",{BackgroundTransparency=1,Name="EnumArrow",Position=UDim2.new(1,-16,0,2),Size=UDim2.new(0,16,0,16),}},
				{2,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={1},Position=UDim2.new(0,8,0,9),Size=UDim2.new(0,1,0,1),}},
				{3,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={1},Position=UDim2.new(0,7,0,8),Size=UDim2.new(0,3,0,1),}},
				{4,"Frame",{BackgroundColor3=Color3.new(0.86274510622025,0.86274510622025,0.86274510622025),BorderSizePixel=0,Parent={1},Position=UDim2.new(0,6,0,7),Size=UDim2.new(0,5,0,1),}},
			})
			arrow.Parent = f

			local obj = initObj(props,mt)
			obj.Gui = f
			obj.Anim = Lib.ButtonAnim(f,{Mode = 2, StartColor = Settings.Theme.TextBox, LerpTo = Settings.Theme.Button, LerpDelta = 0.15})
			obj.Context = Lib.ContextMenu.new()
			obj.Context.Iconless = true
			obj.Context.MaxHeight = 200
			obj.Selected = nil
			obj.GuiElems = {Label = label}
			f.MouseButton1Down:Connect(function() obj:ShowOptions() end)
			obj:Update()
			return obj
		end

		return {new = new}
	end)()

	Lib.ClickSystem = (function()
		local props = {
			LastItem = PH,
			OnDown = SIGNAL,
			OnRelease = SIGNAL,
			AllowedButtons = {1},
			Combo = 0,
			MaxCombo = 2,
			ComboTime = 0.5,
			Items = {},
			ItemCons = {},
			ClickId = -1,
			LastButton = ""
		}
		local funcs = {}
		local tostring = tostring

		local disconnect = function(con)
			local pos = table.find(con.Signal.Connections,con)
			if pos then table.remove(con.Signal.Connections,pos) end
		end

		funcs.Trigger = function(self,item,button)
			if table.find(self.AllowedButtons,button) then
				if self.LastButton ~= button or self.LastItem ~= item or self.Combo == self.MaxCombo or tick() - self.ClickId > self.ComboTime then
					self.Combo = 0
					self.LastButton = button
					self.LastItem = item
				end
				self.Combo = self.Combo + 1
				self.ClickId = tick()

				local release
				release = service.UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType["MouseButton"..button] then
						release:Disconnect()
						if Lib.CheckMouseInGui(item) and self.LastButton == button and self.LastItem == item then
							self["OnRelease"]:Fire(item,self.Combo,button)
						end
					end
				end)

				self["OnDown"]:Fire(item,self.Combo,button)
			end
		end

		funcs.Add = function(self,item)
			if table.find(self.Items,item) then return end

			local cons = {}
			cons[1] = item.MouseButton1Down:Connect(function() self:Trigger(item,1) end)
			cons[2] = item.MouseButton2Down:Connect(function() self:Trigger(item,2) end)

			self.ItemCons[item] = cons
			self.Items[#self.Items+1] = item
		end

		funcs.Remove = function(self,item)
			local ind = table.find(self.Items,item)
			if not ind then return end

			for i,v in pairs(self.ItemCons[item]) do
				v:Disconnect()
			end
			self.ItemCons[item] = nil
			table.remove(self.Items,ind)
		end

		local mt = {__index = funcs}

		local function new()
			local obj = initObj(props,mt)

			return obj
		end

		return {new = new}
	end)()

	return Lib
end

return {InitDeps = initDeps, InitAfterMain = initAfterMain, Main = main}
end,}
--[[
	Awesome Explorer
	Version: 6.3.0 Beta
	Awesome Explorer is the most awesome explorer ev4r!
]]

-- Main vars
local Main, Explorer, Properties, ScriptViewer, DefaultSettings, Notebook, Serializer, Lib
local API, RMD

-- Default Settings
DefaultSettings = (function()
	local rgb = Color3.fromRGB
	return {
		Explorer = {
			_Recurse = true,
			Sorting = true,
			TeleportToOffset = Vector3.new(0,0,0),
			ClickToRename = true,
			AutoUpdateSearch = true,
			AutoUpdateMode = 0, -- 0 Default, 1 no tree update, 2 no descendant events, 3 frozen
			PartSelectionBox = true,
			GuiSelectionBox = true,
			CopyPathUseGetChildren = true
		},
		Properties = {
			_Recurse = true,
			MaxConflictCheck = 50,
			ShowDeprecated = false,
			ShowHidden = false,
			ClearOnFocus = false,
			LoadstringInput = true,
			NumberRounding = 3,
			ShowAttributes = false,
			MaxAttributes = 50,
			ScaleType = 1 -- 0 Full Name Shown, 1 Equal Halves
		},
		Theme = {
			_Recurse = true,
			Main1 = rgb(52,52,52),
			Main2 = rgb(45,45,45),
			Outline1 = rgb(33,33,33), -- Mainly frames
			Outline2 = rgb(55,55,55), -- Mainly button
			Outline3 = rgb(30,30,30), -- Mainly textbox
			TextBox = rgb(38,38,38),
			Menu = rgb(32,32,32),
			ListSelection = rgb(11,90,175),
			Button = rgb(60,60,60),
			ButtonHover = rgb(68,68,68),
			ButtonPress = rgb(40,40,40),
			Highlight = rgb(75,75,75),
			Text = rgb(255,255,255),
			PlaceholderText = rgb(100,100,100),
			Important = rgb(255,0,0),
			ExplorerIconMap = "",
			MiscIconMap = "",
			Syntax = {
				Text = rgb(204,204,204),
				Background = rgb(36,36,36),
				Selection = rgb(255,255,255),
				SelectionBack = rgb(11,90,175),
				Operator = rgb(204,204,204),
				Number = rgb(255,198,0),
				String = rgb(173,241,149),
				Comment = rgb(102,102,102),
				Keyword = rgb(248,109,124),
				Error = rgb(255,0,0),
				FindBackground = rgb(141,118,0),
				MatchingWord = rgb(85,85,85),
				BuiltIn = rgb(132,214,247),
				CurrentLine = rgb(45,50,65),
				LocalMethod = rgb(253,251,172),
				LocalProperty = rgb(97,161,241),
				Nil = rgb(255,198,0),
				Bool = rgb(255,198,0),
				Function = rgb(248,109,124),
				Local = rgb(248,109,124),
				Self = rgb(248,109,124),
				FunctionName = rgb(253,251,172),
				Bracket = rgb(204,204,204)
			},
		}
	}
end)()

-- Vars
local Settings = {}
local Apps = {}
local env = {}
local service = setmetatable({},{__index = function(self,name)
	local serv = game:GetService(name)
	self[name] = serv
	return serv
end})
local plr = service.Players.LocalPlayer or service.Players.PlayerAdded:wait()

local create = function(data)
	local insts = {}
	for i,v in pairs(data) do insts[v[1]] = Instance.new(v[2]) end
	
	for _,v in pairs(data) do
		for prop,val in pairs(v[3]) do
			if type(val) == "table" then
				insts[v[1]][prop] = insts[val[1]]
			else
				insts[v[1]][prop] = val
			end
		end
	end
	
	return insts[1]
end

local createSimple = function(class,props)
	local inst = Instance.new(class)
	for i,v in next,props do
		inst[i] = v
	end
	return inst
end

Main = (function()
	local Main = {}
	
	Main.ModuleList = {"Explorer","Properties","ScriptViewer"}
	Main.Elevated = false
	Main.MissingEnv = {}
	Main.Version = "Beta 6.3.0"
	Main.Mouse = plr:GetMouse()
	Main.AppControls = {}
	Main.Apps = Apps
	Main.MenuApps = {}

	Main.LocalAssetData = {
		["1072518406"] = "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";
		["1072518502"] = "iVBORw0KGgoAAAANSUhEUgAAAA0AAADICAAAAAAWpTSnAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfhCRsLBQDq5svMAAABvElEQVRIx1XBaWgIAACA0S9klsloE9ZoJrSRETILOUKOWFibNTLahLWJLeQIizUT2qaRI2RbQ5scIUcIC80WE2vItE0mR8iR6+/nPf4af4zfxi/jp/HD+G58M74aX4zPxifjo/HBeG+8M9qMt8Ybo9VoMZqN10aT8cp4abwwnhuNRoPxzHhqPDHqjcfGI6POqDUeGjXGA+O+cc+oNu4ad4zbxi3jpnHDuG5cM64aV4zLxiXjonHBOG+cM84aZ4wqo9I4bZwyThoVRrlRZpQaJ4zjxjHjqHHEOGwcMg4aB4z9Romxzyg2ioxCY6+xx9ht7DIKjJ1GvpFn7DC2G7nGNmOrscXYbGwyNhobjPXGOmOtkWNkG2uM1cYqI8vINDKMlcYKY7mxzEg30oylxhIj1VhsLDIWGilGsrHASDISjQRjvjHPmGvEG3OM2cYsY6Yxw5huTDOmGlOMycYkY6IxwRhvjDPGGnHGGCPWGG2MMkYaI4zhxjAjxhhqDDEGG9FGlDHIGGgMMPobkUY/I8Loa/Qxwo0wo7fRy+hp9DBCjRCju9HNCDa6Gl2MIKOzEWh0MgKMjkYHo73RzvjPP4kOFD+OR3sLAAAAAElFTkSuQmCC";
		["1281023007"] = "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";
		["1427967925"] = "iVBORw0KGgoAAAANSUhEUgAAAB8AAAAfCAQAAAC1p96yAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfiAhAQAwiEUWxXAAAA3klEQVQ4y+2VQXLDIAxFHyA7Ti7R+x+rl6gdG4ksEO6irRvqVWfymWH3kPSZ+YJTCvsd/Pym4gcKiIORSCIRD58oFAxFMQwoAkBEEC4MJNIhrigbdzIZbdUjwpUbEyNC/BE3MisLkRnDavVA4sKN96cde/MRiI4PTB2GTwx1yOjNJ8YOfHSTfc5AQjpwaQY3PBwY9lX79/ZA377zwl/4v8Rrhj0v87DccSV34Bn9xGt6rh34imKUhisbSwe+sNX6gRrTY1fSfjCzkjHx5jMzxr0j561V/+uWKZSTO+6kHqcqYjBTAeekAAAAAElFTkSuQmCC";
		["2764171053"] = "iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAQAAAD2e2DtAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAALiMAAC4jAXilP3YAAAAHdElNRQfjARMRLCbVEDVZAAACnUlEQVR42u3SURHCQBQEwZeoyBXysEVsYAkZQcZ9TLeCrdo5nu+85zcUrbmPZ7k/bB3P7glsde4ewF4CiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQJwA4gQQJ4A4AcQJIE4AcQKIE0CcAOIEECeAOAHECSBOAHECiBNAnADiBBAngDgBxAkgTgBxAogTQNw5a/cENrrO+cy1ewWbvOb+A9n2CmfVqhw8AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDE5LTAxLTE5VDA3OjQ1OjM1LTA2OjAwXSty0QAAACV0RVh0ZGF0ZTptb2RpZnkAMjAxOS0wMS0xOVQwNzo0NTozNS0wNjowMCx2ym0AAAAASUVORK5CYII=";
		["5034718129"] = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAALiMAAC4jAXilP3YAAAAHdElNRQfkBQ4WJRHz1iSgAAAArElEQVQoz6XRMU4CARCF4QeJJXfxCnACEy3oqGhttqGwlmCrlQUdFY0N4h28ACWNHQmJsTIhn8VusutiCInzislM/pl5yXTkdHRzNjDMNvKVokUo9YyduQ1WUqtMVyiq1jXu28Cnj8bUmroqPfTy0ri6THLRNtlvAIMkh98mb3FTLb3EXdtDvOHVxAKMjoGY2uPb1BiPx0BEr8pPmP0F1HrA8hQQC+8inX9/8wdd37npDDIVYQAAAABJRU5ErkJggg==";
		["5034718180"] = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAALiMAAC4jAXilP3YAAAAHdElNRQfkBQ4WJRJq33UaAAAApUlEQVQoz6WRPQ6CQBhEH3oFqcSa83kmDwGVeAG19K82FiZoAlpJngUYJDES42yz3+RtMvNtIN814CdgSk7OtONZn5E4cKXq2mHjYAOMLczc+NLWzMKoBXZ+0l5sMpyoAEiJiUkBqDi+Z1iqN1/TXV3V996a9Yu5D1UTY2MTVR9mfSEPLRBZunDbqVk6aQEMxWFnUWE35BmomHHhyoyqcYDg7998AnBz0O3cohQRAAAAAElFTkSuQmCC";
		["5034768003"] = "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAQAAAAnOwc2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfkBQ4WOTvOGrArAAAAHElEQVQI12P8z4AJmBjoJMjCwMCA7gBGRsqcBABnXwMT/Y7kVQAAAABJRU5ErkJggg==";
		["5054663650"] = "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAQAAAAnOwc2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAALiMAAC4jAXilP3YAAAAHdElNRQfkBRIUGwWxgtfpAAAAPUlEQVQI13WOSw0AMAhDmylBAv7NIOXtNNJkQC8F0o8QgQyBRFBkn5IiHkmMyZZ+uqxtjqbZ5EPQUukrfwGG7Gr7eVHzRQAAAABJRU5ErkJggg==";
		["5060023708"] = "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAQAAAAnOwc2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAALiMAAC4jAXilP3YAAAAHdElNRQfkBRMWLSjGeaniAAAAQUlEQVQI142OQQqAQAwDp8L+J/9/hT+aPailIILNZdLQkpL3HHwsw2q/CCBq5FZUHoiDGKbDedZvqisFOC+s3z03RzU2gRkW0E8AAAAASUVORK5CYII=";
		["5448127505"] = "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKAgMAAADwXCcuAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAADFBMVEUAAAAAAMD///////8J7+S+AAAAA3RSTlMAANx1E1ohAAAAAWJLR0QCZgt8ZAAAAAd0SU1FB+QHGxcYKa35SnoAAAAjSURBVAjXY2AAArFVDQxioQ0MWisbGFQjoTgKRDsAxRxASgCptAhLc8VKhAAAAABJRU5ErkJggg==";
		["5642310344"] = "iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAQAAAD8fJRsAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAADsQAAA7EAZUrDhsAAAAHdElNRQfkCQEWMAetJIqyAAAAtUlEQVQY03WPIWtCYQBFz/e9Fx5DXJItCQsLIggm11zckmBbFAb+BqvF5I94VcFi29LiWFo2zPp0xRXTOAZBUbZTD5d7bwAw454n2lxR8MacPpMAlnhmQME731S4o0rCGBN7rsxtWDa15YeqQ6z56YsJAPjqnkfsurHDAYPRKCm3rPk6iiACRP4hsqDCzR/mtBzAaALnc8vWnTvzOg2/TrlkQPNwsMSIn30488HcpVuX5ra8gB3TtWTL5gOMbgAAAABJRU5ErkJggg==";
		["5642383285"] = "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";
		["6234266378"] = "iVBORw0KGgoAAAANSUhEUgAAAA4AAAALCAQAAADljHTpAAAASElEQVQY03WPwQ3AMAgDr52sndyjOY/UipICvPAJS4dpVqZHtm6qEQ9A9+XUqkbma69QYM4NpXZGB4rKjA+0PPVH5vJyg3fXHZn9qFa5dG7cAAAAAElFTkSuQmCC";
		["6401617475"] = "iVBORw0KGgoAAAANSUhEUgAAA/8AAAPDCAQAAABPs3MLAABhbklEQVR42u3dZ6BcVdmG4XunEUIvUgQREbGgiBWxKyoqqKh8KigqoHQQQgshpIf0QgqhVxXpKCAgIoIgoEiRIiBIb6Gm13Pe70eCQkjmtJlZa8/c1z8FkmfOmdnPXnuveTdIkpSdINaJyTE43hqpo0iSpHoIYpU4JF6ORXFufCy6eQogSVKDC6Jb7BKPRUREa9wR34tVPQGQJKmhBfG+uDn+55kYGOt6AiBJUsMKYpO4Klri9ebFH+JD0dNTAEmSGlAQa8fYmB/La4k74sexmicAkiQ1mCB6xEHxSqzYMzE63hp4CiBJUsMIoogvxwOxcovjd/FJvwkgSVKDCIL4YNwdlbXGPbFHrO4JgCRJDSCITeLc5bb8rdisGBXviMJTAEmSSi2INWJSLGxH+UdELIyr4nPeBJAkqcSC6BE/ixntLP+lNwHuj32itxsBJUkqpSCIHePJDpT/UjNjWmzuCYAkSaUTBPGBuK7D5b/0mwBXx5e9CSBJUskE8Za4LFo7Vf8REQ/Hz+ItngBIklQaQawWg1Yw5a9jNwFOivf4TQBJkkohCGLfeKlL5R8RsSBujM/4TABJkrIXBLFD3N/l8l/qyTgs1nUjoCRJGYulD/b9S5XKPyJiTpwR7/UmgCRJ2QpigziziuUfEbE4ro9vRHdPACRJylAQPWNMLKhy/UdEPBoDYz1vAkiSlJkguscP4tkalP/SmwC/ig95E0CSpIwEQXwp/l2j8l/qptglVvEEQJKkLARBbBVX17T8IyJeiqNjU08AJEnKQBDrxoXterBvV82J8+MD7gKQJCmxIFaNo7o45a/9Fsc98d3o7QmAJEnJBEHsFS/WqfyXmhGDYyNPACRJSiII4tNxV13LPyJifvwmtvMmgCRJdRcE8Z74c93Lf6k74sfRx1MASZLqKJZu+TsxliSq/4gZMdKbAJIk1VEQvWJAzEtW/hERC+OK+IjTACRJqosgesSuNZvy1xGPxF6xhjcBJEmquSA+F/9K3fzLPBOTYgPrX5KkGgqC2DIuj9bUvf9fi+Kq+KLPBJAkqWaCWC9Oq8uUv/ZrjQdj31jLmwCSJNVAED2jb8xN3fcr8EqcEFtFkfonJElSw4kivhczUjf9SrTEH+Ir0dMrAJIkVU0QxCcTTPlrv9b4d/wi1vUmgCRJVRLE5nFl6oZv06yYHu/wBECSpCoIYu2YGAtSt3s7LI7b4iuxmicAkiR1SRC9Mt3ytyKt8Z84Itb2BECSpE4Lolt8Nx5P3eod8lKcG+9zGoAkSZ0UxMfjntR93mGtcUN802cCSJLUCUFsHpdkNuinvZ6Kvn4TQJKkDgpizZhc0vKPiFgY58RHorsnAJIktVMQveMX2Q76aZ/WuD12aeybAA47lCRVTUDB1zmVjVMn6fILeYozOIFXLEpJktoQxIfjttSL9ypZFJfGhxv1mwCe1EiSqiRgQ87g66lzVPEF/YOxXMrixivLxntFkqQkAtajP/vRJ3WSqnqB6ZzFo9alJElvEkT32Ddmp75iXwML4sL4eKN9E8DTGUlSlwV042tMYsvUSWpiCQ8yhKuY0zil2TivRJKUTMB7uZj3ps5RQ7M4mSk82SjF2RivQpKUUMBmjGFXuqdOUlMLuYax3EJLI1Rnt9QBJEnlFtCHg/l2g5c/rMI3OIk96d0IuwAa4RRGkpRMQC/2ZBhvSZ2kTl7kPMbzBFHuAi13eklSUgHwZU7nbamT1NEirmcUN7GkzBVa5uySpMQCPshUPp06R93dz2TOY1Z5S7S8ySVJiQWszel8uym7ZBZncRL/KutLd+ufJKlTAtbkSL7alOUPa3IAU/hUdCvnRsDm/KVJkroooGBfRrNm6iQJtfIsYzmnjM8FLFteSVIGArrxZcbx/tRJkpvLr5jAg2Wr07LllSQlFwBbcC6fTJ0kC0u4kfFcU65xQGXKKknKQsDGjGG3hh/0036PM53TeKk8teqvTpLUIQG96Mfe9EydJCNrsz0b8DAvDkmdpJ3c+S9J6oCAHuzOT1kldZLMrMbenMvXYrVyfBOgLFcpJEkZCIDPcjLvSZ0kU88ymVPLcBMg93ySpGwEwPs5gS+mTpKxmfyegTyS+zMB8k4nScpIwNpM5ofeOK4ouJvRXMKinCs252ySpIwErMbhHE2f1ElK4GlO4nSezbdmc80lScpKAPyEcayfOklJLOBipvB3WvMs2jxTSZKyEgCf40TelzpJiQR3MpbLmZtj1eaYSZKUlQB4JyezQ+okpfMcpzGN5/Kr29zySJKyE7A+o/mJo+I6YTFXMpw7c7sJ4O5NSVJFAb3Yhx9a/p3Sk29xNruxVl7jgPI6GZEkZSag4EeMY4PUSUrtBc7kBJ7Jp3TzSSJJyk4AbM/JfCB1ktKbxw0M57ZcnguYRwpJUoYC4N2cwI6pkzSE4H4mcx6zc6jeHDJIkrIUsBaj2ceuqJpXOJlTeDR9/ab++yVJmQpYhcM5mjVTJ2kowR8ZxY0sSVvA1r8kaQUC4JuczEapkzSghxjHOSxMWcHWvyTpTZY92PcEtk2dpEG9woWM4Kl00wCsf0nScgLg7Uxl59RJGtgS/spw/pTqmwDWvyTpDQJgPUbwU1ZJnaXB3c8pnM6cFFVs/UuS3iCgBwcyit6pkzSBuZzHJO6rfx1b/5Kk1wmA3RjDpqmTNIkl3MxY/ljvjYDWvyTpvwJgG852y18dBc8wnEuYUc9Ktv4lSf8VsCWT+JoPhKuzxZzHaB6o3zcB/AVLkpYJWIMD2cluqLue7MZJ7EyPej0X0NW/JAlY9mDfAxjE2qmTNK2nOJlpvFKParb+JUkse7DvlzmHDVMnaWpzuZRx3FP7mwDWvyQJCNiOaXwkdY6m18rtjOZq5tW2oK1/SRIBmzKFXVLnEABPcSqn8FwtS9r6l6SmF7AOg9jPKX/ZmMsVjOXO2t0EsP4lqckFdOPHTKNP6iR6neCfDONKFtSmqK1/SWpyUbALk9gsdQ69yWymcSJPEdUva+tfkppawHv5JR9OnUMrNI8/MILbrX9JUhUFbMFodqFH6iRaiVbuYjq/ZEF1K9v6l6SmFdCbQRxJ99RJVNErnM4JPFXN0rb+JalJBfRiH4ayTuokatNirmIcN1fvmwDWvyQ1pYCCL3Iam6dOonZ6mOFcwUvVKW7rX5KaUsDHmcj29kCJvMq5TOTRapS3v3ZJakIB6zGV7/lsv5JZwC304w6WdLW+/cVLUtMJWItj+LYdUDq9+QIX8XPWCrr2aGBX/5LUZAJ68CNGs0HqJOqkVziPiTzclRK3/iWpqQR0Y0cmsVXqJOqCFq5lKtd0/iaA9S9JTSVgC87lk6lzqMv+wzgu6Ow3Aax/SWoiAW9hKrt6178hzOQ3jOXRzkwD8A0gSU0joA+HsLPH/gaxFvtyNl9jlY5vA3T1L0lNIqAHezDKLX8N5kkmc2ZHbwJY/5LUFALgM5zKu1MnUdXN4WJG86+OlLr1L0lNIeBdnM32qXOoJhZzD8P5PQvbW+w+5UmSmkDAWxjMTt71b1Dd2ZhP0Z1/M3dIu/4DV/+S1PACVqMfh7Nq6iSqqQVcwFRuJ9oud+tfkhpcQDe+z3g2Tp1EdXA7Y7mc+W0VvPUvSQ0tAL7IdKf8NY3nOInJvGL9S1ITC3gXJ/Kl1DlURwu4jgHcx+KVl7ybQCSpgQWsx3F8IXUO1VVvvs6ZfIfeKx8HZP1LUsMK6M3efMdveTWdgm0ZyzA2jJX+C5KkhhRQsBfHO+WvaS3iSiZw84q+CWD9S1JDCoDtmcqHUydRQsH9jOYi5i9f99a/JDWgANiC07zrL2YyldN5rHjDfQDv/UtSY1qbQ/hc6hDKwFocwwl8Onq9vv+tf0lqOAHdOIyfe4wXAN3YiZPYnVWC104BvPgvSQ0moBvf5gQ2SZ1EWXmV8xjN40ur3/qXpIYSAJ9jOu9NnUTZWcKfGcmNLCmsf0lqJAHwdiaxS+okytSDTORCXrb+JamBBKzOJH5Mz9RJlK1XuIBJToKSpIYR0It9OYTeqZMoY6vyNm5wV6gkNYgA+A5HslrqJMraQk7nZutfkhpCAHyMo3hr6iTKWguXMI1Z1r8kNYp3MIxtU4dQ5u5kAs8UjoSQpEYQsAb78SW/z6WKHqMfd4BT/ySpAQT04AD298G+qmgm4/gzrQXWvySVXkA3vsQvWCN1EmVtEdM5h5al/6NH6jSSpC77OCPZOHUIZe5qTmL2a3eHrH9JKrEA2JTD3PKnNtzMAB7/3/+0/iWp3NbiGEf8qg1PMYl7Xr8v1Hv/klRaAb3YlR/RK3USZW0Ow/jtG/8v61+SyuyrDGbN1CGUtcX8mt+w+I3fCfXivySVUgB8kKPYNHUSZe5ShjJr+f/T1b8kldVmDOKTqUMoc3cxiad50zwoV/+SVDoBsAb7sJNT/lTRE/TnVlbwNrH+JamMerInB7vlTxXN4SSuKWJF/8iL/5JURl/gF275U0XBqZxI64r/ofUvSSUT8AGGsEXqHMrc1Uxh5sr+ofUvSaUSsCH92S51DmXudgbxKCvdHGL9S1KJBKzBEXzXLX+q6BnG83cqvE2sf0kqjYCe7Mae9EydRFmbyygupeI5ovUvSeVR8HmOYb3UMZS1Fi7mHBZWvkBk/UtSSQS8m2N4e+ocytwVDFr5lr/XWP+SVAoBGzGcz3vXXxX9izE8RptvE+tfkkogYA0O5KuWvyp6mkHc0nb5W/+SVAIB3fkOB7Ba6iTK2jxO43KiPeeI1r8kZS6g4FMcybqpkyhrLZzBZBa07wKRl5EkKXMBW/FrPpI6h7IW3MRePNzeYnf1L0lZC9iEo9gmdQ5l7h76tb/8rX9JylpAH/bnhw76UUUzmMTfOnJJ3/qXpGwFdOfb7Env1EmUtblM5jcs6cj9fO/9S1KmAuCTnMdmqZMoa0u4kIN5qWOF7upfkvL1PgbyttQhlLnrOLaj5W/9S1KmAtbmWL7sVVpVtGzKX0dZ/5KUoYBV2Z9veJRWRTMYzQ3tG/TzRr6xJCk7AfBt+rJG6iTK2gJO4wJaOnOBqEfq7JKkNwoo+DRHsn7qJMpaKxczjvmduzvk6l+S8vN2hrJt6hDK3M2M5pXObg2x/iUpKwHr0Y9Pp86hzD3IQO7p/H9u/UtSRgK6cRA/9tasKnqJSdzcleE9vsEkKRvLpvz9lFVTJ1HW5jOVM1ncle+EuvqXpEwEwEcZyuapkyhrS7iU01jYtYEQ1r8k5WML+vPe1CGUuX8wlKe6Og3K+pekLASszhB2Tp1DmXuUYTzU9T/G+pekDASsys/5lkdlVfQKA7mqM1P+lucbTZKSC4BvcKRT/lTRXE7n97RW4zEQ1r8kJRYA23M4G6dOosxdwzhers4zoKx/SUoqAN7GYD6eOokydzujeL5aD4C0/iUptbXpyxdSh1DmnuUw/l69pz9b/5KUUEB39uLn9EydRFl7mdH8rZp/oPUvSckEdGcXDmG11EmUtSWcwRksqt7a3/qXpGQC4EP05+2pkyhrrVzBicyuZvlb/5KUyLItf/34cOokytzdHMej1f5DrX9JSmU1DmWX1CGUuccZyn1debbfiln/kpRAQA9+ys/pnjqJsraAMVxRjSl/y7P+JanuAmAn+jnlTxUt5HTOY0n1y9/6l6S6W/Zg32PYNHUSZe73jOCV2vzR1r8k1VUAvJWj2S51EmXuDibybPXv+i/VI/Wrk6Smswa/4OupQyhzzzOAv9Sm+sHVvyTVWzd+yAH0SR1DWZvJBP5Yy7/A1b8k1c2yLX9HsnrqJMpacBYnsbiWf4X1L0l1EgDbchxbpE6irLVyNdOYVau7/kt58V+S6mLZlL+jnPKnNvyTQfy7tuVv/UtS/fRhX77noB9V9CRj+Eety9/6l6S6COjBT5zypzYsYAoX1WLK3/Ksf0mqj89wDBukDqGsLeZczmRx7cvf+pekOgjYliFO+VMbruV4XqzPX+XOf0mqsYD1OZLPpM6hzN3LaB6r/V3/pVz9S1JNBazJ4XwzdQ5lbgYjuLFe5W/9S1JNBXRjJw5w0I8qmstkLqtf+Vv/klRrX2YIa6YOoay1cgFTWVC/8q/niYYkNZ2Ad/ErPpY6hzJ3LQfwcH0r2dW/JNVIwFsZwLapcyhzDzC83uVv/UtSjQT0Zm9+QM/USZS1ZxnJX+t/Md76l6QaCOjBbhxIr9RJlLUFnMRvWFL/O/HWvyTVxkc4jg1Th1DWWvgNp7AoxTY861+Sqi7g/Qxl89Q5lLlbGcFzaf5q61+SqixgdQ7ny363ShXdw2AeSfUVPIf+SlJVBazOEexq+auil5jEH9N9/97VvyRVUUDBNzjEKX+qaB7TuDDl8B3rX5KqJqDgCxzNOqmTKGut/JYJzE55gcj6l6Rq2pj+bJM6hDL3J45nZtoI1r8kVUnAhgznc971V0VPMIp7U0/dt/4lqSoCevEzvu+WalX0PEPr+WDflbH+JakKAnrwHfahT+okytoizuIcFqcuf+tfkqogALahP5ulTqKstXAxU3Mo//RXHySpAQS8ixPZwWOqKrqT3XgwjzeJq39J6qKAtejL5y1/VfQQ/XgodYjXWP+S1CUBfdiP3d3yp4peZTzXEbmcI1r/ktQFAfBVDmHN1EmUtXmcxPm05FL+3vuXpC4IgI9zqoN+1Iar+TEv5FS5rv4lqSvexmDLX234K0fnVf7WvyR1WsA69ONLqXMoc08ziH+mDrE861+SOiWgB3uyBz1TJ1HWZjCam/K71279S1InBMC3OZw1UidR1lq4iLNZkFv5W/+S1AkB8GGO4K2pkyhrLVzKaGblV/75XY2QpBII2Jwp7OQxVBXdzY/5Z55vElf/ktRBAatzMF+z/FXRowzh3tQhVsb6l6QOCejJ/uxF99RJlLV5TOFKWnM9R7T+JakDAuCL7MfaqZMoawuYzpksyrX8rX9J6oBlU/6Gs0XqJMrcn5jKq/mWv/UvSe0WABvTl4+mTqLM3c4wHsu5/K1/SeqINRnAt1KHUOZmMJzb8i5/61+S2imgB99jD3qnTqKszWEkVy29VJQz61+S2iEAvskAp/ypohbO5uyct/y9xvqXpDYFwPs4lLenTqKsBVcxkVdSx2iPHqkDSFIpbMLxfCp1CGXuAcbySP4rf3D1L0ltCliV/djZI6Yqeo7+/DV1iPbyzSxJFQV056cc6JQ/VTSPKfyeJeVY+1v/klRRAHyWo1gndRJlbTFncBKLUsdoP+/9S1JlH2IEm6cOoczdwGReLsvKH6x/SVqpANiQvmyfOokydzcD+XfqEB3jxX9JWrk+9GXX1CGUuReZzC2U7PnP1r8krVBAd3Zmf6f8qaJ5jObXZSt/61+SVu5rjHTKnypq5SLOYEHZyt97/5K0AgGwFUf4YF+14VqG8XLqEJ3h6l+SVmQTBjnlT214iPE8XL4L/+DqX5KWEwC92Z1ve4RURTM4juvKWf6u/iXpzbqzB0ezauoYytoCzuRSWstZ/ta/JL3ZJzic9VKHUObOYiyLy1r+1r8kvUHAtoxgq9Q5lLmbOIGXUofoCu9sSdIyAbAuB/CZkt7OVb38i4E8UNa7/ku5+pek/1mNX/Ajj4yq6CUmcX25y9/6l6RlArqxMz9zy58qWsQkfln28rf+Jel/Pscg3po6hLIW/J6TmVf28rf+JQmAgLdzLO9NnUOZ+xPH8kLqENVg/UsSAesxhC+kzqHMPc447i//hX+w/iWJgFX5Od/xiKiKZjCQPzZG+Vv/kppeQHe+xSE+208VLeKXXMCSxih/61+SYFsGsHHqEMpacD5jy/hg35Wx/iU1tYB3MJ6tU+dQ5u5iPM+lDlFN1r+kJhawPkewfeocytwDHMXdjXLXfynrX1LTCliVffgxvVInUdZeZRp/bqzyt/4lNa2Agi+zD6unTqKsLeQUzmmcLX+vabTXI0ntEgCf4Gyf7aeKWrman/NM45Wlq39JzWoLBvCu1CGUuVs4kmdSh6gF619SEwpYm6PZ0Sugqugxxpb9wb4rY/1LajoBvdiD/6NH6iTK2qtM4ipaG7H8rX9JTSeg4Nscyzqpkyhri/k1Z7KoMcvf+pfUZALgo/yCDVMnUdaCKxnKrEYt/8a8oSFJKxWwMWfyFY9+qugOfs4djfwmcfUvqYkErMWhfMHyV0WPM5g7U4eoLetfUtMIgP040Cl/qmg20/kj0djniO57ldQkArqxMz9ntdRJlLXFnM5U5jd2+bv6l9QkAmBbhvHO1EmUtVauYRpzG738rX9JzWMTjmKb1CGUufsYxMONX/7Wv6SmENCbY/hO6hzK3LOM5O7UIerD+pfU8AJ6she70zN1EmVtDiO4kJZmWPtb/5IaXgB8haOd8qeKFnIeFzfeg31XxvqX1NAC4AMcwWapkyhrwXUM57lmKX/rX1Lj24CRfC51CGXuX4ziieYpf+tfUkMLWJ0D+LJT/lTRKxzFTalD1Jf1L6lhBcBeHOaUP1X0KuO5vtGn/C3PqX+SGlRAwZc4mDVTJ1HWgt8wjXnNVf6u/iU1qAB4P0PZMnUSZS34E1N4tdnK3/qX1JACYCP6sl3qJMrcw/Tn/tQhUrD+JTWm3hzF7m75U0XPM5zbacq3ifUvqeEE9OL77OGWP1W0gImcT2szlr/1L6nhBMDnOY71UydR1pZwHmeysDnL3/qX1GAC4H0c5YN91YYbGMaM1CHSsf4lNZAA2IABfDF1EmXuQcbzaHPe9V/K+pfUWFZnX77dxEd1tcerDOLqZi5/619SYyn4AX3pnTqGsjaXE/lts035W55T/yQ1iGVb/vqyduokytyFTGRB6hCpufqX1BAC4D0cx3tTJ1HmbmQSLzb3hX+w/iU1jvU5ks+nDqHM/ZuB3G35W/+SGkJAbw7mhx7VVdEMxnOT5Q/Wv6QGENCd/2M/VkmdRFlbwqmcTYvlD9a/pMbwSQawQeoQylorFzPdLX+vsf4llVzAVvTnXalzKHM3MZSnvfD/GutfUqkFrM8x7OhRXRU9yGjut/z/x/qXVGIBfdiX73hUV0WvMqbZp/wtz/qXVFoBBV/lUNZMnURZW8SpXNCsD/ZdGetfUpl9koE+2Fdt+B3jmWP5v5E/D0klFbAFpzvoR224hf0d9PNmrv4llVLAhhzJJ1LnUOb+wxDLf0Wsf0klFNCDH/ATn+2nil5mPNdZ/iti/UsqnYBufJu+rJo6ibK2mLM4kyWW/4r4U5FUOgHbchHvTJ1DWQsu4zAet+ZWzNW/pJIJeC/DeEfqHMrc3xnE46lD5Mv6l1QqAWvwC77u0UsVPcJw7vMS98r5AZJUIgG9+Rnf99ilimZzIlc66KcSP0KSSiOg4CscxdqpkyhriziDsyz/yvzpSCqNgO2YykdT51DWgt+zFzOst8pc/UsqiYC3MpiPpM6hzN3KcF5IHSJ/PVIHkKT2CFiHfnzBa5aqaAZjudVL221z9S+pBAK68RP2YpXUSZS1VxjNVZZ/e7j6l5S9gO7szP6sljqJsraE85nOAsu/PVz9S8pcALybYWyVOomy1srvGMd8y799rH9J+duMYWydOoQy92+G8UjqEOVh/UvKWkAf+vINj1aq6AkGcI93/dvPD5SkjAWsyl7sTs/USZS1uUzlt7RY/u1n/UvKVgB8jiN4S+okytoizuEsFlv+HeFPS1KmAuDDTGX71EmUuZvZjSets45x9S8pXxswhE+kDqHM3c1Rln/HWf+SshSwFn35stcoVdGLDOGW1CHKyPqXlKGAgh+wj1P+VNGrTOJawnPEjnPqn6TsBHRjJ45gndRJlLXgMqYyx/LvDFf/kjITAO+hH1umTqKsBX9gJDMt/86x/iXlZyMGuOVPbXiEwTxk+XeW9S8pKwG9OYhdPTqpoicYxu2pQ5SZHzBJGVn2YN/9nfKnihZzGhewxLV/51n/krIRAF/iCNZNnURZW8zZnOyDfbvG+peUiQDYhmPd8qc23MoEZlj+XWP9S8rHehzOZ1OHUObuZwj/Sh2i/Kx/SVkIWJXD+W7qHMrcq4zieh9Y03XWv6QMBBT8H/uyWuokytpCJnERrZZ/11n/kpILgB3p75Y/VRRcyEnMt/yrwfqXlNiyKX9H8+7USZS5GxnN86lDNApn/ktKKgA2pD+fSp1EmXuUEdzryr9aXP1LSq0Xe/J9B/2oolcYzHWWf/VY/5ISCujOHhxGr9RJlLWFnMrFtKaO0Uisf0nJBMD2HMkGqZMoa62czyTmpo7RWLz3Lyml9zGErVKHUOb+xgSe9cJ/dVn/kpIIgLU5mC+mTqLM/ZuB3JM6ROPx4r+kVHrTlx+lDqHMzWQ81znop/qsf0kJBHRjRw5k9dRJlLWFTOGXln8tWP+S0vgMw53yp4qCq5julr/asP4l1V3AO+jH+1PnUOZuZBDP+Hif2nDrn6S6CoC30I8dUidR5p5gEv+0/GvF1b+keuvFj/iJU/5U0UyGcaXlXzvWv6T66sauHMkqqWMoa4v5Db9iseVfO9a/pDoK+CDHsHHqHMrchQxjfuoQjc36l1Q3Ae9mGO9LnUOZu5PxPO2F/9py65+kugiA1difnVInUeYeYzB3Wv615upfUr2syi/YK3UIZW42J3I5YfnXmvUvqQ4CCnbgUNZInURZa+EUTrH868H6l1Qfn2YIb0kdQpm7hknMtPzrwfqXVHMBG9KXD6XOoczdxkCeSh2iWVj/kmosYH2GsJN7uVTR80zkH275qxfrX1JNBfRkN3Zzyp8qepXhXGr514/1L6mGArqxM31ZM3USZa2FizmbRZZ//Vj/kmrr3RzL5qlDKHOXM4LZln89Wf+SaiZgC8bx4dQ5lLkHGMejqUM0G+tfUo0ErMkBfNHbuarocfpzi3f96836l1QTAb3Ziz3pnTqJsjaXU/k9rZZ/vVn/kmogAD7LYaybOomytojTOZmFln/9+TOXVAMB23A226bOoawFN7MHj1lEKbj6l1R1AW9lENukzqHM3UVfHksdollZ/5KqLGAtDmcnjy+q6DkmcIcXoVPx4ympqgK68132YJXUSZS1mZzAJbRY/qlY/5KqKAB2ZKDP9lNFrVzOKcyz/NOx/iVVTQC8n2N4e+okylrwZwbwsuWfkvUvqZo2YTCfTB1CmXuAwTyROkSzs/4lVUlAH/Z3y5/a8Bwj+Cvh2j8tP6aSqiKgO3txgFP+VNECTnHLXw6sf0lVEFDwOfZlndRJlLUWzmMS8y3/9Kx/SV0WAFszgvenTqKsBTcxgVcs/xxY/5KqYX2OYLvUIZS5BziO+yz/PFj/kroooAf9+L7j21TRS0zglqWXipSe9S+pSwJ6sBs/csufKlrARH7JktQx9JoeqQNIKrMA+CKD2DB1EmVtCZfxSxZ4gSgfrv4ldVoAbEVf3pk6iTJ3C4N53PLPifUvqSvWYSRfSh1CmXuUkTxo+efF+pfUSQGrsj870T11EmVtLgO4JnUILc/6l9QpAQW7cZgP9lVFc5nGlbS69s+N9S+pEwLg0/Rl/dRJlLnfMp6Zln9+rH9JHbZsy99wtk6dRJm7jYnMsPxzZP1L6ox1OYJPpw6hzD1FX/6ROoRWzPqX1EEBPfkFe3j8UEWvMJq/+WDfXPnxldQhAd3Zmf2d8qeKFnMyZzrlL19O/ZPUUZ9nJG9JHUJZa+V3TGeuK/98Wf+S2i0A3sGhvDt1EmXudgbxROoQqsSL/5LaKQDWZSBfS51EmXuCcdyHj4DMmvUvqf1680N2dcqfKprHcC6x/HNn/Utqv10ZwOqpQyhrCziL39Bi+efOe/+S2iEAPs7hbJA6iTJ3GcOZnTqE2ubqX1L7vJsRbJs6hDJ3B5N51gv/ZeDqX1IbAmAd9uMLqZMoc08xkFss/3Jw9S+pbb3Yl33c8qeKZjKVay3/srD+JVUUUPA1DqBP6iTKWiunMo1Fln9ZWP+S2vJJhvK21CGUuas4kTmpQ6j9rH9JFQS8jaPYJnUOZe4OBvOoF/7LxPqXtFIBa3M0O6XOocw9wThut/zLxfqXtBIBvfgJP3LLnyqax0QusvzLxvqXtDIFO3Ika6WOoawt4ZeczWLLv2z8jUlaoYBtOdNBP2rDNezHY5ZJ+bj6l7QCAW9juOWvNtzDMMu/nKx/SW8SsA6H8sXUOZS5ZxjGzZZ/OVn/kpYT0Is9+Bmrpk6irM1hKpdb/mVl/Ut6g4CCL3IIa6ZOoqy1cgEnssDyLyvrX9Ly3s8Y3pk6hDL3J8Yy0/IvL+tf0usEbE4/3ps6hzJ3L8fxQOoQ6grrX9J/BazOwfyfjwJXRU8zyil/ZWf9S1omoCe7sQc9UydR1uZyIheyxPIvN+tfErBsy9+XGcpbUidR1lq4kNN9sG/5Wf+SXrMtR7Nh6hDK3M0M4nnLv/ysf0lAwPocx2e8nauK7mYoT6UOoWpwg48kAtbgUHa0/FXRi4zjT4Rvk0bg6l9qegEFP+RQ+qROoqzNZRqXWf6NwvqXmlxAwZc4mNVSJ1HWWrmcCcyx/BuF9S/pXQzjfalDKGvBdYxgluXfOKx/qakFbMQAPpo6hzL3BMO4N3UIVZP1LzWxgFXoy/fpnjqJsjaDYdzqlL/GYv1LTSugJz/ix/RKnURZW8hp/IrFln9jsf6lJhUA23OMg35U0RIuYroP9m08/kalJhXwHqbwpdQ5lLm/8SP+bVU0Hsf+tFNAwWq0MN+PgRpBwFqMYIfUOZS5hxjAw6lDqBa8+N9+72AEB9EnUueQuixgDQ7iK17/U0WzGMl1DvppTK7+2yEAtmMAX+MFnuG8aPXDoDILgP+jL6unTqKszeVkfovHuwbl6r9NAQVfYAo70Z2NOI4dlh0+pVJa9o4+lHVTJ1Hm/sBYXrH8G5W/2TYE9OArjOID//2/7uYgbvZymMopALbgTD6bOoky91cO5C6Pc43L1X9FAX34Pie+rvzhg4xh69TJpE7bgH58KnUIZe5pBnO35d/IrP8KAtZmfybx9uX+wXYM5u3eAFD5BPTkIPZwyp8qep5R3OBdzsZm/a9UwNoczrGs/6Z/1I2dGcDGfjZULgE9+AF70zt1EmWthV9yFotc+zc2638lAjZhMIewzgr/8Sr8kF+wVnh6rNJY9g2Wo3lr6iTKWgsXM9kH+zY+638FgoCtOZH9WHOl/9KqHMzezkpXWQTAVvR334racBfDeMLyb3zW/5sEFGzLRL7BKhX/xT7047v0cP2vkliTo/lq6hDK3KMM477UIVQP1v9yAnqwIyewQzu+FPkWRrGrUwCUv4DVOJAf+IlXRXOZwJV+rbk5eDB4g4Ce7MoUPtvOn8xmDOJzngAobwGwC4fSJ3USZW0+J3IOSyz/5mD9v07AqvyYMWzZgf/oPRzH1p4AKF8B8CmOYIPUSZS5PzCFWZZ/s7D+/ytgTX7BSN7Wwf/wixzPu1Knl1YsAN5Bf7ZNnUSZ+wcjeTJ1CNWPj/wBlh0iN6Y/P2GNDv/HBTszh8NihmfNytLaHMmOqUMoc88xgts8hjUTV/+v2ZhR7NuJ8gfoxnc4nLW8AaDcBPRgT37qlD9VNIfjuTx1CNWX9U8QBVsxhd3p2ek/pDf7sT99PAFQTgK68V0OY9XUSZS1Fk7nbJakjqH6avr6D+jOZzmT73bxRsiaHM2e9PIEQLkIgI/Rv8O7WdRcgsuZxCwfANtsmrz+A7rxFU7gk1X4w9ZmADtReAKgHCx7sG8/3p86iTJ3L2N5rLD8m05T139Ab77HaD5YpT9wI4b4FHXlIADWpC/fbO7PuNr0NIO4LXUIpdDEh4aA3hzEeD5QxT/0A4xkOx8EpAz0Yh9+1MyfcLXDPKZwOS2u/JtRk/7WA2BtDuOwTu71r+Q6DuZfTfujVQYC4GucwUapkyhrS5jOQF71WNWcmndtsBED6VuD8ofPL52v5hUApREAn2CI5a823MAJvJo6hFJpyrE/Ae+nH9/rwhf9KunO7sxnMC+mfp1qWptyDB9LHUKZu53jeMTrlM2r6Vb/QcCHGccPalT+AL3ZmyNZzfW/6i0IWJcj+XLqJMrcC0zhFsu/mTVZ/QcUfJKJfKXGU9B6szd70NMTANVdd3bhZw76UUXzGMUFln9za6r6D+jJd5jOZ+rwrl+PY/ieJwCqs4JvMtAH+6qiFn7H6Syw/JtbE/3+A1ZhDwbWcQbav+nL72ltoh+ykgp4P+f6bD+14QoO4+GmOvxrBZpk9R8ErMbPGFrXAajvYnhVpwpIFQS8k2G+49SGBxln+atJ6j8ANuI4hrJxnf/qbRjHFt4AUO0F9OHnfNNn+6mipxnITZa/mqT+gc0YSl/WrfvfW/BFxvMOTwBUWwE92ZOfN80nWp2zgLO42Cl/gqao/4D3MZI9a/hFv0q6sRPHsqEnAKqpgs/SL8EJrsqklV8yyfLXUg1e/0HAdkziewkHHPVkdw6gj08CUK0EfJhhbJI6hzJ3E2MdR6bXNHT9B3RjR07hS4mnG67KQexH79Q/DzWmgA04hu29nauK7mUQD3nXX69p4PoP6MHXmMI2Gbzf16U/P6aH639VW8BaHMlOqXMoc68ylT9b/vqfhq3/gDX5MdN5V+oky6xHP3bwQUCqroDufId9vLakiuYxjnMtf71egz7yJ2BdDuZg1kud5HXewXBmcUv4EVSVBBTsyJGsmTqJshb8nunM88ij12vA90MArMORHJjhQfE2fs49DfljVwIBm3MhH02dQ5m7lkO53+OO3qgxL/6/kzEckmH5w8cZ6f5sVUfApoziQ6lzKHNPMNLy15s1WP0HAR9gKnuyWuosK1TwFYY4BUBdF7Aq+/Itp/ypoucYyI2Wv96soeo/oOATTOGrGR8Se/IDDmc9TwDUFcseYLW3W/5U0ULO5SIH/WhFGqj+A3qwA1P5bOokbViN/diHVT0BUGcFwEc4su7PsFC5tPBrJjHX8teKNEz9B/TmR5zGR0pwlWsNDmVXunsCoE7bmjFsmTqEshbcwzieyf+AqDQapP4DVudnjOLtqZO00wYMZecSnKgoQwHrcSSfSJ1DmXuIvtyfOoTy1QDf+1/2Rb8DOZgNUmfpgM0Zw7y41i056piANTiE72a8v0U5eJkp3OzxRSvXAPUPbMoAfsBaqWN00FYM4QXucgyQ2i+g4Bvsx+qpkyhr8ziZc1nksUUrV/KL/0HAZoxnr9KVP8B2DGALBwGrvQIKvsSgUl3nUv21ch1TmGX5q5JS139Adz7IJL5Dz9RZOqUbuzCKt6WOoRLZgv5slTqEMncTR/Gs5a/KSlz/Ad35ItPZpcS3MLrzbQ5nTdf/alvAWziWz6TOocw9xhgeTB1C+Stx/dONnRhX+qec92AvDqS3JwCqLKAX+/A9t/ypopcZw7VEuQ+LqoeS1n8QPdiD8WyTOkkVrMHh/JxVPAHQygUU/IBfZDrMWrlYzC/5lVv+1B4lfJcEwJrsz2FsmDpL1TzL4ZxPawl/HaqDAPgMJ/G+1EmUteBSDuQ5jyNqj9LdNV/2Lf9jOJA+qbNU0cYczTPcGF6y04ptxUDLX224g9GWv9qrjBf/N2RIg5U/wDaMYrvUIZSjgLU4jC+kzqHMPcpA/p46hMqjVPUfBGzNFPZvuPKHgu0YxvvCKQB6g4BVOJQfueVPFc1mGte55U/tV6L6D4DtmMp3y3fLol0KdmAwb00dQzkJKNiFfZzyp4oWM52TWZg6hsqkNPUf0I3PMZbPlydzhxV8myNZxysAWioAPs0ATwpVUStXcTJzijLu5VYyJanSgO7szpSGH3nSg304vAFvbagTAmAzDuf9qZMoc3czmP9Y/eqYUtR/QG/2YwwfSJ2kDvpwEPvTzfW/gHUYytdTh1DmnmUUd1n+6qjs6z+WPuD0IAazceosdbIWh7KrJwDNLqAXe7BrSZ9noXqZzWAu9X6hOq4Mm+g24SAOaqqtT5sylHn8PhwD1LQCCr5HP6f8qaJF/IpLWOyRQh2X+bsm4F0MZLcm/NLT3ezPLdn/glQTAfAxTuLDqZMoc1dwAE96lFBnZHzxPwh4HyP5fhOWP3yQIbwndQilEABvZzgfSp1EmbuX8Za/Oivb+g8o+Cwn8a2mvfe5A8N5m7f0mtIaHMKXvPSjil7iCG5MHULllem9/1j6ON9RvLeJD4Hd2IX5HBHPN++PoBkF9OQQ9sn31FxZmMNErvcxYeq8LA8xAb34P07gfU1c/gDd+R6Hs7pXAJpHQMFX2L+ptrqq41o5lxNZlDqGyizD+g9Ym30YzztSJ8lAL/Zmb1bxBKCJfJyhbJI6hDJ3HSfwilP+1BWZXfwPgHU5jINYO3WWTKzL0czm3PCrPQ0vADblCPf7qw33M4AHU4dQ2WVW/8BGHM3P/bbz62zMEGZySfgsr8a3JkfzrdQhlLnnOJ6/+6VgdVVWF/8D3skYDrD8l7Mp/dkOB3s1tICe7M7eTftNF7XPIiZwoQ/2VddlU/9BwMeZzm70Sp0lQx9mFB/xBKDB7UJ/Vk0dQllbzAWcwSLLX12XybsooGA7JrFd6iQZu5YD+Xc2vzJVUQC8n1PYPnUSZe73HMSjHgVUDVms/gN6sROn8fHUSbL2BY5m3dQhVCNvZ5gnv2rDA0yy/FUtGdR/wOr8mJPZ2nd1RT3YjSNY1xsAjSUIWI2fs0sOn0Zl7EUG80fLX9WS/IATsCYHcDxvTZ2kBPpwMAc7Bqjh9GA/DkodQpmby2lc7pY/VU/S+g8C1ucIjuItqX8QJbE6+/NdunsC0CgC4HMcylqpkyhzv2Ys8yx/VU/q7/2/g6F8izVS/xhKZEOG8BJXOgWgYWzH8WyaOoQydwMn8HLqEGosyeo/ALZiDDs35eN8u+LtjGcB1/ktwLILgA05iI+lTqLM3cux3Oddf1VXoov/Ad3YjkmWf6dsxfF8xPZvAGtxNN/zqK6KZjCVWyx/VVuS+g/ozk5M42uWfyd9hIFs6QlAmQV057v81DFXqmgRJ3K2D/ZV9SWo/4AefJdxfCT1iy+xbnyVQWwa3gEos69wLOukDqGstXAJJ7PA8lf11b3+A1blJ4xhq9QvveR68n2OYh0HAZdREPBu+rNF6iTK3A0M5rnUIdSY6lr/QSx9gO0Y3p76hTeAnuzD/qySOoY65W0cz6dSh1DmHmEMD3rXX7VR753/6zOQPVk99ctuEKtwOC9wdvgAkFIJWI2f8VWP6qroJUbyB8tftVK31X8QsClj2Nfyr6J1GcpuFN4AKI+AHvwfB9AndRJlbQGncr5T/lQ7dXpvBRR8mOP4uk8zr7qHOYBrXSOURcCnOYt3ps6hrAUXcDAv+KlW7dTl3RVQ8BnG+ESzGvkbB/F3TwDKIOB9nOmzLdWGW9mb+/1Mq5bqc/G/G19lrOVfMx9jBO9PHUJtC9iIY/zKq9rwHwZa/qq1mtd/ED3ZixMcbFpDBTswjM3dAZC3gNU4gO847EoVvcg4brD8VWs1rv+APvyCkbzL93JNdePrHMG6ngDkK6A732Bvt/ypooWcztn4bR7VXA3rPwhYm0M4lvVTv8wm0Iuf8gtW9wQgTwHwGUbx1tRJlLVWfs80H+yreqjt9/434wh+xqqpX2STWI3DmMOUcEBont7DsWyWOoQydyf9eTJ1CDWHmq3+A97HaPaz/OtoDY7i/7zNkp+AjRjAF/zdqKKHGM6/veuv+qhJ/QcB2zCOXf2Wf52tT3++Eo4BykpAb/bkm275U0UzmczltFj+qo8a1H9Ad77IZHas+0hhwXsYww4+CCgfAd34PkewRuokytpCzuTXlr/qp+r1H9CDXTmZz6Z4mLCAbTiO93sCkIeAgk9xMOumTqKsBX9iBK9Y/qqfKld0QG92ZzRbevsqoU/T3x3m2diC4Q76URtuZTAvetBUPVXx8nwArMXP6cvGqV9Wk+vGriyiXzzn4SStgPU4gu1T51DmnmM4f0sdQs2munfnN+Bo9vGJfhnoyW68ysCY5QlAOgHdOJifugFWFb3CGP7kfn/VW9Uu/ge8jSEcaPlnohd7sBerugMglWUP9t2T3qmTKGstnMN0nNahuqtK/QcB72c0e7JK6hek/1qXI/khvTwBSCEAPsYQB/2oolZ+z1TLXylU4V0XULA9x/MZ9/pn5wkO4zJaPbjUW8DmTOYbqXMoc/fzQ+7y86kUuvy+C+jGpzmBD3rrKksPsAe3+6upr4DVOYXve0Ksip7kMC719FxpdPHwFNCHnTmdbS3/TL2Hibw/nAJQRwG92Y+dLH9VNJex/NbyVypdOkAFrMU+TGXL1C9DFXyK0bzLMUD1EgDfoi9rpk6irC3kTM5jieWvVDr93guANTiEvs4zy14LF3AYz/vVotoLgO2YykdTJ1HmrmNPnvQTqXS6svpfl4EcbvmXQHe+Q19nztfJphxv+asNdzHI8ldanRr7EwBbMJpv+EW/kliF/ZnNpJjjAaeWAtbhaD6bOocy9yID+GvqEGp2nVj9B8D7mMp3Lf8SWYPD2ZOe7gConYCCfdjLJ12qoleYyPWEp+JKq8P1H1DwCU7gq95ILpm16cs36O4JQG0EdOOb7Eef1EmUteAipjPPw6dS6+B7MKAHX+V4PpA6uDrlPg5x3VELy7b8nc7WqZMoa8HVHMaDbsNVeh1a/Qeswg+ZYvmX1tZMclta9QXAZhxu+asNDzGYBwvLXxnoQP0H9GFvjmfz1KHVBR9gPFt6A6Dq+tCPb6cOocw9ywhuTx1CWqqd9R8EbMgAjuOtqSOri7ZnEJt6AlA9AavwE3Zzy58qWsiJXOCUP+Wi/QesDRnB7qyaOrC6rAe78irDYob3H6shAHbmWNZOnURZW8RZnMzC1DGk17Rj9R8EvJMx7GH5N4je7M1hrOEg4K4LgA/Rl01SJ1HmbmYCL3jKrXy0Wf8B3fg4U/ghvVKHVdWsyr78gJ6pY5RdAGzCQD6ZOokydy/DecjyV07aqP+AbnyByXyN7qmjqqrWYSDfdwxQl63NwXw9dQhl7mWO53r3+ysvFes/oODrjGe71DFVA5syjG94A6DzArqxBwd4XUwVLWASl/pBU24q1H/AKuzDZLZJHVI1sjlH8xFPADonAL7KL3yUktrwG6azIHUIaXkruRq17HG+B3E466WOqJq6kqO433uSHRUAH+EkhyipDddxiJ8w5WjlX/xbh74cwpqpA6rGvk4rh/Kf1DHKJQA25gjLX214hDGWv/K0wvoP2JJD+ZlP9GsCBV/jafrHKx6gOqQPfdk1dQhl7kWG8WfLX3l6073/IGAbJrCv5d8kevBjDqOPOwDaK6AHP2Jvp/ypokWcyvkssvyVp+XqP6Dgw4xhZw9tTaQPh3AQq3oC0B4BsAP9WSd1EmWthV9zglv+lK9ub/rf32A6X/FqVZNZiyPYjR6eALQlAD7AQN6eOoky91fG8rwX/pWv19V/EL34ISfwcd+xTegt9OfL/ubbYSP6O+VPbfgXw/mX5a+cLav/WPo4370Y5eN8m9Y7GcHnwikAKxUErMHBfDN1EmVuJtP4A2H5K2fdYNkFzbU5hBE+zrepfYhhbOsYoAq6830OpE/qGMraAk7gHFf+yl0BELAJh7M/vVPHUXK/5RCe8ND1ZgHwJabwntRJlLXgUvblRT9Byl03lj7OdwQHWf4CdqY/G6QOkan3MNTyVxtuZDAvpg4hta1HwPsZxDd9+KsA6M5PaeGYmOXq5X8CYFP68ZHUSZS5JxjLPV49Uxl0Y0dO4Vs+s0z/tQo/5RAfBbycVdmb3fycqKIXGca1lr/KoRt78wlX/nqDPhzMT50C8JpYuuVvP8tfFS3mfM51yp/KohujuCV1CGVnA/rxbU8A/uvTDGWj1CGUuUsZyULLX2XRjTsYxEOpYyg7WzCUz1N4AhDwQY5jk9Q5lLl/MJKnU4eQ2q8bcD3DfdvqTd7DULZOHSK1gLU5lC+++eFY0us8whDu9q6/yqRbAS38hgE8nzqKsrMdo3hXM6//A1bnEL7rUV0VzWYqVzjlT+XSDQpYzK8Zx6zUYZSZbnyNEbytWQcBx9JHYB3OGqmTKGuLmM6Zlr/KphtAAYs4mdNYnDqOMtONb3MUa6eOkUjBZziGNVPHUNaCPzOJmZa/ymbZHc0CZjOWcz0B0HJ6sAf7smrzrf8DNmMIH0idQ5m7hQE8mzqE1HH/3dBUwHMM4BJaU0dSZtbiKA6gd3OdAARswHE+2FdtmMFY/u6WP5XR6/YzF/Asx3Btk97o1cqty5F8p5m+BBiwCvvwQwdiqaKXGMrvLX+V0xu+zlTAYwzj7tShlJ0NOZrPNsujgAN6sCv7+hAsVbSECzjLKX8qq+W/zRzcQj9PAPQm2zCGTzbDCUAAbM1ANk2dRFlr5beMY67lr7Jarv4LaOUPDOGx1MGUnY8zukked/suRvGu1CGUuYcZw39Sh5A6702zzAoILmMkL6SOpuxsz7G8tbHX/wFrcCxf8XauKnqUI7jdu/4qsxWMMi0gOJsJzE4dTpnpzv8xgI0a9wQgYDX255uO+FVFc5jONbRa/iqzFR7mCljINCaxMHU8ZWYVfsIvWKsxTwAC4KscwTqpkyhrCzmbM93yp7Jb+SpnNhM52TFAWk4fDmC3RnwUcAB8kgG8JXUSZe5WxvOi5a+yW0n9FwCvMJErHAOk5azJYHahe+OdALAJQ/hg6hDK3B305VHLX+W30tV/AfAYx/EHTwC0nA0Zw9cb60uAARvQj8+6l0sVPctYvxitxlBhi1NBAfdxLDc11HFe1fAOhvO51CGqJ6A7P+Gn9EqdRFmbzWR+S4vniGoEbe9wvoMBPJg6prKzDQN4b2M8CjigO9/lIFZPnURZa+USTmO+5a/G0Eb9FwA3cxxPpg6q7HyRYWxR/lsAAbANR7FZ6iTKWvBHBrvlT42jzdV/sXS45VAfaanldGMXhjTEPvl3MJAPpw6hzD3AEB6z/NU42jHepIDFnMNwXk4dVpnpzvf4BWuWef0fsBqHs7Nb/lTRswzl1tQhpGpq13SzAhZxNqc5BUDL6cXB7EPvsp4ABPRgH/agR+okytp8TuNyp/ypsbR/uOlcJnCmJwBazpr048flnAIQAF/nUNZMnURZa+FcJjE3dQyputpZ/wXA8wzjfE8AtJz1OIavUZTtBCAAPsqxbvlTRcENnMDLhfeH1GDavfovKOAphnCVY4C0nM0ZzqdKeHTcmP58PHUIZe4hBnF/+d7cUls69GSzAh5mKLenDq3sbMPxfKRMUwACVucYvpE6hzL3EuO5JXUIqRY6+GDTAu6gv2OAtJyCTzOC95ZlCkBAd37Ij93yp4oWMIZzaUkdQ6qFjj/XPPgTv/AEQMsp2IHD2aAMJwABBd+kH2ulTqKsLeESfsUC7/qrMXW4/oul06+G8Uzq6MpMd3bnKNbI/QQgAN7PkWyeOokydyNDeDp1CKlWOr76p4AWLmEys1KHV2ZW5QAOp0/qGJUEwKYMdsuf2vAIY3jIlb8aVyfqHwqYz0lMYV7q+MrMqhzEbnTLev2/KgfzTbqnjqGszaY/16UOIdVSp+ofCpjJOE5hfuoXoMysxzF8K9cxQAE9+Bn7uOVPFc1jOlewxJW/Glkn6x+AVzmeC5wCoOW8k5HsmOMVgAD4PIeyduokytz5jPXaphpdp+u/AHiBMfwp9UtQdt7NAN6f2xbAZVP+hrBF6iTK3C1M4UXv+qvRdWH1XwDcz9HcmNlxXul9gtG8PXWI1wuADTiET6ZOosw9xgDuTB1Cqr2uXPxfOgj4Do7in6lfhjJT8GXGsVlW54WrcTS7pg6hzL3KWG7Alb+aQJfqf5m/czRPpH4hykx3vkV/1s/jBCCgO9/kZ6yaOomytoipnEWL5a9m0OX6L6CV6xnmeAwtpye7sx+r5XECwNcY6oN9VVErv2Ma8yx/NYcqrP4LWMSvGMMLqV+MMrMGh7A3q6Q9AQgC3s1RbJn6x6HM3cxgnksdQqqXalz8XzoG6DROYE7ql6PMvIVj+E7KKQDLpvwNdcuf2vAEJ3Cfd/3VPKpS/1AsHZRxHktSvyBlZiNG8IWkXwLszU/4rlP+VNEshvBby1/NpEr1DwW8zAAu9ARAy3kHw/loshOAbvyIQy1/VbSAc/m1U/7UXKpW/wDM4FguT/2SlJ3tmMA2KU4AAj7N0ayf+gegzP2WESxIHUKqryrWfwHwKAP5S+oXpex8hmFsVO+/NOADDHHLn9rwDybwrBf+1WyquvovAO7lWO5J/bKUna/Rn3Xrt/4PAtbiID6f+oUrc/9hAH+z/NV8qnvxf+lH6CaO49+pX5gy05O9OJx16ngDYDWO5EepX7Yy9yonc53lr2ZU5fqHAoIrGMTjqV+aMrMaB7JXfaYABHTj6xxAn9QvWllr4UxOZLHlr2ZU9fqHAlq4hBOYlfrFKTNrcWjdpgB8kUGsk/oFK2vB1UxhjuWv5lSD+ocCFnIyU5if+uUpM5sylB0pankCEARsxrFsnfrFKnN/5zgeTR1CSqUm9b9sDNA4prEw9QtUZrZkAp+p8d+xEcNq/neo7J5kHHd611/Nq0b1DwW8ykh+TWvql6jMvJuRbF2r9X/AKuzhlD+1YSZjuNTyVzOrWf0D8DIj+H3ql6jsbMcgNo8ajAEK6MFu/ILVUr9EZW0xv+ZXTvlTc6th/RcAjzDIMUBaTnd24Tg2rvYcwICCD3AUm6R+gcrcHxnJK5a/mltNV/8FwB0cya2pX6Yy05M9OIo1q/7nvpvxvCf1i1Pm/slgnkwdQkqtthf/KSjgNobxWOoXqsz0ZC9+Ws0pAAHrcDCf8nauKnqGoU75k2pe/8v8gcG8kPqlKjNr0p89q3UCENCH/fgRvVK/LGVtFlO4yvKX6lL/BSzhPIbwYuoXq8xsyAC+XY0pAAEFX+LgGtxOUCNZwnlMZ57lL9Vp9V/AIk5jlHMAtZxNOIpPVmELYMFnGM3GqV+OshbcwHhmWv4S1Ovi/2tzAE9jUeoXrMx8iFF8tGt/RMDbOZp3p34pytw9HOXDyKTX1Kn+oYA5TOQiWlK/ZGXmU4zgPZ1f/wesy1F8ydu5quhJRvJP7/pLr6lb/UMBTzGQS5wDqDco+BIDWL9zJwCx9EuEP3TLnyqax8lc4qAf6X/qWP8APMJArk/9opWZbuzK0azZ8TmAAd34Fv3c8qeKlnA+p7HI8pf+p86fhwD4NCfzvtQvXJmZyzjGdGxPdgB8jFP5YOrwylrwJ37MM5a/9Hp1Xv0XADdxDA+nfuHKzGoczM/p0cH1/zsYzDapoytz/2Qkz6YOIeWm3hf/l54AXMmRPJP6pSsz63Ik32j/FICANTiQHdzLpYpeYTR/InybSG9U9/qHAlq4nH7OAdRyNmE4O7bvBCCgJwewD6ukDq2szWEyl1v+0pslqH8AWriEacxN/fKVmfdxPNu3PQYooBtfZ1/WSB1YWQsuZjxzLH/pzZLUf0EBczmRUzwB0HI+xADeUfkEIAC2ZRDvSB1WWQuuZRyzLX9pRVKt/ingBUZxHotT/wiUma8ylLe28e9szNFsmzqoMvcYA7nX8pdWLFn9QwEzGMzVXR/4roZS8AOGs87K3hYBazCYb7vlTxXNYBj/SB1CylfC+gfgaY7httQ/BGWmBz/gcPqs6AQgoBc/5Lv0TB1SWVvEVM5zyp+0cknrvwC4j8P4W+ofgzKzKvuxF6ssfwIQADvRn/VSB1TWlnA+p7PA8pdWLvHqvwC4lX7ck/oHocysx5F8/41jgAJgG/ryttThlLk7GO6UP6my1Bf/l54A/Jnjncql5WzGEL5MtzdcAVif0XwydTBl7t8M5CHLX6osef1DAcGlDOXF1EmUmc0Zzodf+xJgwBocyhdzeM8qY7MZxLWpQ0j5y+JQWsBCzmIMr6ZOosx8iFFsDcsG/fyMg32wryqaw4n8nlbX/lJbsqh/KGABJ3MqC1InUVYKdmAk7wyAHdjPB/uqDZcznpmWv9S2TOofCpjFRM5nSeokyszXOYo12ZrhbJU6ijJ3E2N5wfKX2qNH6gD/UxDPMoS1+UY+JyXKQHd2Zw5v5WOpgyhzTzKQOy1/qX0y+6wEbMFkvp5bLiXWAnRPHUJZm8EQTnHQj9Re+a2z/8Mgbk8dQpnpbvmrohZO4yzLX2q/zOq/ALiTITyQOomk0mjhAk5iXuoYUplkVv9QQCtXM5BHUyeRVBJ3MIYns7uXKWUto61/rymIFi5hVcayQeoskrL3H4Zzt+UvdUx2q3+AAlo4j6nMTp1EUubmMIYrirD8pY7Jsv4BWMwJjgGSVNFiTubXtKaOIZVPpvVfAMxiFKexMHUWSdm6nIleJZQ6I9P6h4ICXuB4LqYldRZJWbqNkTztXX+pM7Ktf4ACnmU4NxJd/7MkNZinGMntlr/UOVnXPxTwAP25LXUOSZmZzWiutPylzsq8/oHgNvpzV+oYkjLSwrlO+ZO6Ivv6LyC4nsE8ljqJpEwEv2Usc1LHkMos+/pfdnHvSsbxUuokkrJwF6N4zAv/UleUoP6hgCWcxWheTZ1EUnKPM4I7LH+pa0pR/1DAXKYx0Yd6SE1uHqdwGS2Wv9Q1Jal/AOYxhdOd7yU1scWcykmWv9R1pan/AuAVJnKJY4CkpnU943k5dQipEZSm/pfNAXyUQfzBKwBSU/obg32wr1QdJap/gALu5xj+4hxAqek8x3husfyl6ihZ/QPwT4bwcOoQkupqNmO5wvKXqqV09V9AcCMDeDx1Ekl108rvOIV5lr9ULaWrfyighUs4jmdTJ5FUJ1cykDmWv1Q9Jaz/ZWOALmQks1InkVQH/2IE/0kdQmospax/KGABZzKZhamTSKqxpxnug32laitp/UMBc5jEmZ4ASA1tPqdxgYN+pGorbf0D8BLDOZ9FqWNIqpElnMtUH+wrVV/JP1UB72IqX0mdQ1JN3MCePFryw5SUpXKv/gH+TX/+kTqEpBq4i4E8ljqE1JhKXv8FBfyDQ7kndRJJVTaTSdxIuPaXaqHk9b/MX+nnHECpocxmDBeW/v6klK0GqP8CWvkDw3kudRJJVdLKFZzolD+pdhqg/peNAbqACbyaOomkKgj+yHBetfyl2mmI+ocC5nMyY5mdOomkLnuKMdyfOoTU2Bqk/qGAWUzhTBanTiKpS57lGP7sXX+pthqm/gGYzXh+R6SOIanTFnAGlzrlT6q1Bqr/AuAJjuEqTwCkklrChUx3y59Uew32KQuA9zKdz6VOIqkT7mAP7m+ww5KUpQb8nAV8mHPYOnUOSR30APvyFwf9SPXQQBf/X+cujnVUqFQyLzORWyx/qT4asP4LaOUqBnsCIJXIHE7kNyy2/KX6aMD6hwIWcR5jeDF1EkntElzDNGZZ/lK9NGT9LzsBOIPTWJg6iaR2uI3jeM7yl+qnQesfCljIaM5xDJCUvccYxAOWv1RPDVv/UMCrDORcWlMnkVTBS4zkeqd1SPXVwPUPwHMM5rLUISSt1GLO5Dy3/En11tD1XwA8yXBuSZ1E0goFlzCe2Za/VG8NXf/LTgDuZCB3pU4iaQVuZ5xb/qQUmuJzF/AVprBV6hyS3uA/HMjVTXEQkrLT4Kv//7qOgTyTOoSk15nFZK5LHUJqVk1R/wW0cCnjmJM6iaRlFjOVM/xirpRKU9T/sjFApzKW2amTSGLplL8zmF00x/1HKUNNUv9QwBwmchILUieRxN84jkdSh5CaWdPUPxQwmzFc4BggKbGnGcddrvyllJqo/gF4kRFc4XwxKaGFDOW3qUNIza6p6r8AeIhj3W0sJbOIs7jAKX9Sak1V/8tOAO5lEHekTiI1qcsZzqupQ0hqsvqHggL+ymC3HUkJ/JMTeMq7/lJ6TfopjG7sxjg2Sp1DairPsifX0tqkhx0pK023+l+mlQs4jpdTx5CayFwmc53lL+WhSeu/gMX8klGOAZLqpIXTmc4Sy1/KQ5PWPxSwgLM42zFAUl1cxyRmWv5SLpq2/qGAFxjFr5w6LtXcnQzg0dQhJP1PE9c/FPA0Q7jUOYBSTc1gMn9v2p3GUpaauv4BeJLB/DV1CKmBzWcU51n+Ul6avP4LgH9xDHelTiI1qMVcwmkstPylvDR5/S87AbiZftyXOonUkK7kWL9hI+Wn6esfCgiu5RieTJ1EajgPcAKPe+Ffyo/1DxTQytWMdxK5VFXPMJAbLX8pR9b/axZzOuOZmTqG1DDmcRaXO+VPypP1Dyx7ENAcpjGdOamzSA2hlbMZywLLX8qT9f9fBbzCeH7tGCCpCv7CCd5Ok/Jl/b9OAS9yPNcSqZNIJXcvA3nQu/5Svqz/NyjgcY7mBk8ApC6YwQncZPlLObP+3+xeDncOoNRp85jMuW75k/Jm/S+nALiDwTyYOolUSi1c6pQ/KX/W/5sUANcznGdSJ5FK6K8M5XnLX8qd9b8CBbRwPkOYkTqJVDIPM4SHUoeQ1Dbrf4UKWMzZjObF1EmkEnmBYfzJLX9SGVj/K1HAQk7ldBakTiKVxHxO4WLC8pfKwPpfqQJmM5mLWJI6iVQCrVzGCcy1/KVysP4rKOAZjuEiWlInkbL3d0bzguUvlYWf1jYEbMkUdvQnJVXwMD/jBg8oUnm4+m/bwxzHnalDSBmbwVhusfylMrH+27BsDNAA7k+dRMrUQs7mlyyy/KUysf7bVEAr1zCQR1InkTLUypVMZZ7lL5WLn9l2CejGjxnL+qmTSJn5G7vziAcSqWxc/bdLAa2czyTmpk4iZeUhjufR1CEkdZz1304FzGcSkz0BkP7rFcZyhc/2k8rI+u+IuYznLBanjiFlYQFncREtlr9URn5yOyAANmEi3/W0SeIy9uZlDyFSOVljHVBQwNMM5vqlZwJS0wpuYaTlL5WXn94Oi4KPMobPp84hJfQsP+GPPt5HKi9X/x0X/J0B3J06hpTMq4zhRstfKjPrv8MKgFsYxdOpk0hJtHAGp7HQ8pfKzPrvhAJauZBhvJA6iVR3rVzBNOZY/lK5+RnupIBV2JvjWSt1Eqmu7uKn3O2BQyo7V/+dVMBCzuAEpwCoqTzJMP5p+UvlZ/13xQKmcgZLUseQ6mQ+x/M7v/YqNQLrv9MKgBcYzUVeAVBTWMDZXMQS1/5SI/CT3EUBWzKenT2RUsO7kv14ykOG1BgsrS4q4GGnAKgJ3MlIy19qHNZ/NdzLETycOoRUQy8yhL+mDiGpeqz/Lisg+DN9PQFQw3qVCVzjlD+pkVj/VVBAK1dyHM+kTiLVxK84kQWWv9RIrP+qKKCVi5nA7NRJpCpr5UomMzN1DEnVZf1XSQGLOZWTmJ86iVRVDzCSh/ySkNRorP+qKWAWoziJBamTSFXzDMdzq+UvNR7rv7peZgwX0pI6hlQVC5jMBbRY/lLjsf6rqKCA5xjO9amTSFWwiLM5zZmWUmOy/qusgIc4hltT55C67HrG8pIX/qXGZP1XXQG3cwj3pM4hdcl9jOIRy19qVNZ/bdzO4Y4BUom9yCj+bPlLjcv6r4ECghsYy/Opk0idMp8TuNDylxqZ9V8TBSziV4zkxdRJpA4Lfs00Flr+UiOz/mukgLmcyjTmpk4iddAfGcsrqUNIqi3rv2YKmMc4zmVh6iRSBzzI8TzohX+p0Vn/tTWHYVziGCCVxgxGc7PlLzU+67+GCoBnOI4rUyeR2mURJ/ErFlv+UuOz/muqAHiEY/hz6iRSm1r5NdNYZPlLzcD6r7EC4H6Gcl/qJFIbbmU0M1KHkFQf1n/NFQA3cAwPpU4iVXA/g93yJzUP678OCmjlKobwVOok0kq8wkSuJSx/qVlY/3VRwBIuYhyvpk4ircB8JnOBK3+pmVj/dVLAIk5nGvNSJ5GWE/yRycyy/KVmYv3XTQFzmMCpzE+dRHqDP9Ofl1OHkFRf1n8dFfAywzmHJamTSP/1OMdzrxf+pWZj/dfbi4zl2tQhpGWeYyg3Wv5S87H+62rZGKCB/CV1EglYxHn80kE/UjOy/uusALid/vw9dRI1vVYuYZzlLzUnP/lJBHyJk9kidQ41tX/wY+73ECA1J1f/qVzPUJ5LHUJN7CEG8kDqEJJSsf6TKKCF8xnNK6mTqEnNYzpX0eraX2pW1n8iBSzgZEYyM3USNaH5TOEMR/xKzcz6T6aA+ZzCqSxMnURNJvgTE5zyJzU36z+hAmYygYtoTZ1ETeWvDGGG5S81N48BSQXAlozlm56IqU5m8FOu8qMvNTtLJ6kC4GGO5Y+pk6hJvMQQrrP8JVn/iRUA9zOYO1MnURNYwm+c8icJrP8MFAC3MIRHUydRg2vhUia65U8SeA0wEwE9+DbjeVvqJGpgD7A7d/qRlwSu/jNRwBIuZTAvpE6ihvUYR3JX6hCScmH9Z6KAJfyaCcxNnUQNaTbTuNZBP5JeY/1no4AFnM5pzE+dRA1nAWdxJgstf0mvsf4zUsALjOZXLEqdRA3mL0zgJctf0v94RMhMwCZMYFdPzFQ19/JT/uFHXdLrWTL5eZoR3Jo6hBrGc06VkPRm1n9mCoB/cgy3p06ihjCLCVzpg30lLc/6z04BcCP9+FfqJCq9Vs7nDBZY/pKW53EhSwHd+QbT2Sh1EpXa1ezPY37IJb2Zq/8sFdDClQzmpdRJVGL3M9Lyl7Ri1n++FvNLJvJq6hgqqWcYzE2pQ0jKlfWfqYIC5jKNE5mTOotKaD4ncblb/iStjPWfsQJeZTKX0ZI6iUqmhTM4kQWpY0jKl/WftQKepz9X05o6iUrleqbwUuHOXkkrZf1nroAn6csfUudQidzHYB5MHUJS3qz/MniIfs4BVDu9xAT+6spfUmXWf/YKgLsZ5HpO7TCPkZxHpI4hKXfWfwkUAH9kKE+kTqLMtXAp5/rIaElt8wphSQT0YDdGs3HqJMrYtRzIv/1YS2qbq/+SKGAJ5zOZuamTKFuPMJF/e9dfUntY/2WyiJM4hUWpYyhLr3AM16YOIaksrP/SKJaOARrN2Z4A6E0Wcgq/ZYkrf0ntY/2XSgHPM4ALnQOoNwjOY7ynhZLaz8VC6QRszul8wd+d/uuv7MN9fpwltZ+r/zJ6nAHckTqEsvEQAyx/SR1j/ZdOAcFtHM2dqZMoCy8zkRssf0kdY/2XUAGtXMcQHkudRMktZgpn+2BfSR1l/ZdSAfBbxvFq6iRKqoWrmcZ8y19SR1n/JVUAnMpYZqVOooRu4GheSB1CUhlZ/6VVwCImM4EFqZMokceZyL+86y+pM6z/EitgDpM40e97N6WXGcbVlr+kzrH+S62AmUzhSlpTJ1GdLeQ3nO+UP0mdZf2XXAGPMZhrPAFoMhczlDmWv6TOsv5Lr4B/cgy3EqmTqG7+zjieTx1CUplZ/43hbo7hgdQhVCcPMoC7vOsvqSus/wZQAPyFwTydOonq4FVO5TrC8pfUFdZ/QygguJQBXhBueIs4hZNosfwldY313yAKWMyvGMorqZOohoJrmMZcy19SV1n/DaOAxZzNKSxMnUQ1cysDeSJ1CEmNwPpvLHOZwOmeADSopxnjlj9J1WH9N5ACYAbHcyFLUmdR1c1kNFdY/pKqw/pvKAUFPM0wrnMKQINZxDmc65Q/SdXi0aQBBXyE6XwsdQ5VTXAl+/OUH1dJ1eLxpAEFFHyOqWydOomq5B5+yh1+XCVVjxf/G1ABwQ0cySOpk6gqnqK/5S+puqz/hlQs/Yb4UMcANYBXmcx1lr+k6rL+G1QBrVzCBGamTqIuWcS5nMp8y19SdVn/DauAOUxnEnNTJ1GnBTcwhVctf0nVZv03sAJmM5FTWJQ6iTrpfg7n35a/pOqz/htaATMZx2W0pE6iTniC0fwrdQhJjcn6b3zPMMgxQCU0h8mc76AfSbVh/Te4AuABjuQGTwBKZQkXcC6LLH9JteHRpSkEfIxT+WDqHGq36/kRz/jxlFQrrv6bxT8YyKOpQ6id/skwy19SLVn/TaGAVq5mKE+lTqJ2eIkh/Dl1CEmNzfpvEgUs4jeM4sXUSdSGOUzhGsK1v6Rasv6bRgELOJ2pjgHK3K8Yz1zLX1JtWf9NpIAFTObXLE6dRCsR/IkpzLH8JdWax5mmEgCbMoLd6Jk6i1bg3/yUv/qhlFR7rv6bSgHwFAO53CkAGZrBCG5LHUJSc7D+m0wB8DjDuDV1Ei1nCRP5jeOZJdWH9d90CoC7GMA/UyfR6yzmfH7JQu/HSaoPjzVNKgp2YizvSZ1Dy/yFvX22n6T6cfXfrIKrnAOYjQc53vKXVE/Wf5MqoIXfMYWZqZOIWRzHH1KHkNRcrP+mVcBCTmeaY4ASm8t0fk+ra39J9WT9N7ECZjGG6SxMnaSpXcJ4T8Ek1Zv139QKmMlYznUKQCLBDUzgBffgSqo3jzpNLgC2YALfSp2kKf2HvfmzH0NJ9efqv8kVAP9hMDekTtKEXmYcN1n+klKw/pvesjFA/bnNWwB1tYSTOYsllr+kFKx/UVDAXxnM46mTNJElXMg05qeOIalZWf96zR84lhmpQzSNv3E8T3vhX1Iq1r8AKKCVixjIC6mTNIVHGMW9lr+kdKx/LVPAIs5lArNSJ2l4MxnJlZa/pJSsf/1XAfM4idMdA1RTizmN3zjlT1Ja1r9ep4BXGcuFPnW+hi5jnFP+JKVm/Wt5zzKACzwBqJFbGMVzXviXlJr1rzcoAB5nCH9OnaQhPcFI7rD8JaVn/Ws5BcCDDOee1EkazqtM4FrLX1IOrH+9SQHwZ/rxUOokDaWFszmVBZa/pBz0SB1AOSoIuJpunMxbU2dpEMGlTGCe5S8pD67+tUIFtHI1Q3gldZIGcTsjeCJ1CEl6jfWvlShgCb9iIrNTJ2kAjzKKe7zrLykf1r9WqoC5TGc6c1InKbk5TOMyWix/Sfmw/lVBAS8yll+zJHWSElvEaZzllD9JefGYpDYEbMyZfMX3Siddw5486w9PUl5c/attz3I4N6cOUVJ/ZxDPpg4hScuz/tWGAuA++nJL6iQl9ByjuM2LbJLyY/2rTQXA3zmaB1MnKZlXGMPVlr+kHFn/aocC4CYG81zqJCXSwmWc4qAfSXmy/tUuBQSXMILnUycpieAahjPX8peUJ+tf7VQs/QrbWOcAtssDDOE/qUNI0spY/2q3AhZwKiczP3WS7D3BEP7hXX9J+bL+1QEFzGIil9CSOknW5nMylzjlT1LOrH91SAEzOJbLaE2dJFuLOZtTWGz5S8qZxyh1WMAWTGNH3z0r9Bd+xBP+aCTlzdW/OuM/HMvfU4fI0l0M5MnUISSpLda/OqwAuIvh/Dt1kuzMZDQ3EK79JeXO+lcnFNDK7+nHo6mTZGU2o/md5S+pDKx/dUoBLfyWEbyQOkk2Wp3yJ6k8rH91UgEtnMtEZqZOkoVW/sBoXrL8JZWD9a9OK2AR0xwDBMCTHM99lr+ksrD+1TWzGM1ZLE4dI7Fn6M9fU4eQpPaz/tUFBQW8zDAubuo5gAs4ySl/ksrF+lcXFfAsI7mBSJ0kkcWcz+kssPwllYn1r2q4h35Ne/H7H4zmGctfUrlY/+qyAoK/0587UydJ4H6O5l+Wv6Sysf5VBQXAjRzPE6mT1NnLjOPm1CEkqeOsf1VFAXAZI3kxdZI6ms+JXOiWP0llZP2rSgpYwtkM5+XUSeokuJzpzLH8JZWR9a+qKWA+pzCxScYA3cxgt/xJKivrX9U1n1M5jyWpY9Tcowx2y5+k8rL+VUUFwPMM5+IGPwF4iRH8OXUISeo8619VVVDAowziKlpTZ6mZRZzF+W75k1Rm1r+qroAHOZZbU+eokeACJjAndQxJ6grrX7VxL8fxYOoQNXEbE3imwLW/pDKz/lUDBQQ3cCz/SZ2k6h5lUFNON5TUYKx/1UQBLVzGcTydOklVzWYy17nyl1R+1r9qpIAWLmYcc1MnqZqFnMAZTf1oY0kNw/pXzRSwkNOZxoLUSarkD5zKrNQhJEnKXBDEejEl5kf5/TW2CSL1j1SSqsLVv2qooICXGMl5LEqdpYue5gT+6V1/SZLaKYgt4+poTb1874K5sXf0cuUvqXG4+lfNFfAwA7kjdY5OW8w5/IZFrvwlSeqAIIrYPu5IvYjvpF/HJt71lySpw4Io4qvxQOom74S7YjvLX5KkTgmie+wZz6du8w56Ir4ZheUvqdF47191UkALFzCWV1In6YA5TOX3hHf9JTUa6191U8BcpjOJ2amTtNMSTuMkllj+kiR1SRBrxMRYlPqafju0xtVu+ZMkqQqCIDaN86Ildbu36bb4qOUvSVKVBLFl/C7zE4BnY3fLX5KkqgmC+EDcmLrhK5gVh0Zvy1+SpCoKoohPxD2pW34lFsU50cfylySpyoLoFt+Ih1M3/Qr9Lt5u+UuSVANB9IwfxxOpu/5N7ovPeNdfkqQaCaJXHBAvpO77N3g8do3ulr+kRufYHyVTwCLO4TQWpE7yX3M5m9/R4qAfSZJqKIg148RYkHrRHxERi+OkWMeVvyRJNRYEsUGcHEtSd39EXB/vtvwlSaqDIIi3x+9Sd3/cFZ92y58kSXUSBPGhuClp+c+In0Q3y1+SpLoJgvhC/D1aE5X/rDgqVrH8JUmqsyhih7g/SfkvibNjA8tfkqS6C6JH/CRm1L38W+PP8S7LX5KkJILoFYfFzDrX/8PxObf8SZKUTBCrRf+YVcfynxG7u+VPkqSkglgtjo+FdSr/OTE81rT8JUlKLIj149xoqUP5L46z3PInSVIGgiC2iivq8CXAW2Mby1+SpCwEQbwvrqnxCcBDsb1b/iRJykYQxCfirhqW/3Pxs+hp+UuSlJUgvhlP1Kj858fQ6GP5S5KUmSC6xw/j6RqUf0tcFJtZ/pIkZSiIHrFnvFD1+v9LbGH5S5KUqSBWiSOqPAfwofhGFKlfmSRJWqkg1o+pVRwDNDP2jO6u/SVJyloQm8Qpsbgq5T8/JsTalr8kSdkLYtO4uCpzAH8T6/ldf0mSSiAI4j1xQ5fL/7b4mNUvSVJJBEF8rotjgJ6Mr1j+kiSVSBBF7BAPdrr8X45DnPInSVLJBFHEzp2cA9gSI2M17/pLklQ6QfSKg+LFTpT/xbG55S9JUikFsVocEy93sP7v8MG+kiSVWBBrx+iY14Hyfzz+z/KXJKnUgnhLnN3uMUDz4mfRw/qXJKnkgtgsfhet7Sj/BXFirONdf0mSSi8IYuu4ph0nABfHJpa/JEkNIQhi2zbnAN4e21v9kiQ1jCCIr8XDFcr/2djZlb8kSQ0liB6xWzy5kvJ/NfpFL8tfkqQGE0TP2DueWUH5t8T4WN3ylySpAQWxShwes95U/lfEll74lySpQQWxTkyI+W+o/7tiO8tfkqQGFsRGcWYs+m/5Px0/jG6WvyRJDS2IjeOXsSQiIuZGX6f8SZLUBILYMq6JiJY4Ldax/CVJagJBEJ+If8Q1PthXkqSmEUT3+HR8zPKXpPb4f9SOuTGzAEzTAAAAAElFTkSuQmCC";
		["6425281788"] = "iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAQAAADYv8WvAAAAEklEQVQI12P4/5+BgYGB4f9/ABP2A/2YpxkeAAAAAElFTkSuQmCC";
		["6511490623"] = "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";
		["6578871732"] = "iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAQAAAAAYLlVAAADGElEQVRo3u1ZTU8TURQ9pTXWDRKDrtSEr9BCSMUOP4CVSTfQHwGLdiEhamJciLgoS5ZEfgIbd5iIG43RRKqBphGDxtiwQfnoooQ2bTkuyNR2hjfzXjudgcTbTfPuveeeeZ13P15BKH6SPKRIDplUxfMRSnIZeQQt9EV0oaQC2KEWH72W4YEgetUAVQn0O2Dxn8DFJtDngEWDqB3DAI4RsLGp4AoqreyAhojQetA2PBDAoFAXgWZaM2SmOZLkBhPsNGj8THKfMrLPJP0G704muEGSnGvUNJqFWa7BFLhMraYZ56ZUcF02OV7z1bjMQk1TZlhMYNUElOYUh7iiFFyXFQ5ximnT+qqIQKypMM1I7KxidAkZi9fHWfmGEZSNpyDpWnhgEEn9q74D3dhGl2sEgDwGsFe/A/Ouhge6MF+/AyP4Ar+rBIAqRpHRd2DR9fCAH4sAAIKTLRyoXe624D15egy3mnj/1/EKaaxjB8AtRKEhhlFllC2EwSAriryPOMMOU3/r50MeKyJVGQTBlJLTO/YLm+wQPyhhLeipeJpFSZe3Zzx74z58lEQqcrq+FowxJ+FUYK/tqBGS+iFyHDMWo26u2bolpKadWVucNXafVQ39TPHEwu09fVIEOvjJAuWEqfp2xegcr2sdjPJEeuJ7bvEjxq06IhDMCJ3vSROYEGJkjLbmpvSaMG18lk4waaHGhC5PIIc/0gR28Lt5Ai6LmcCBwPI2rkuj3sQNgcaELk8AuCtNICrU2BKIo0forEFWxJY9iBtWzk8i8jgVe1yMPC7HC5Iup+JkQ5IiwCCrSk7kEe871JJVGPQR+IqQ9AHTxcGm1Mu2fEJ/Cd+0ANK8vCbo6WgWQVZPxRm8cDk8sIQs4N14foCB08KkF6M9PHP1+Z/qddGbK5os7uiXmf/KcRmzrj3/TN1dakM2c+ea7qW4LXfjorLEPqu5oP1XtY/tBhONEWG1G5YiMCz0jzBqXDuH1/XW4L9sbX6qhFcfTH7YWmyrAaoS+O6ARZsJeL4DF42A039eH+Eqqu3cgRIeIC/U5vFILTzwF/nT5M4aeeFlAAAAAElFTkSuQmCC";
		["6578933307"] = "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAAwUlEQVQoz4WRvQ4BURSEJzdbeBBRyEal9BAqL6DyCl5ANqJQiIharVKJbUW1xVY6CSI6GxGFn0/DdTdY083MyTmTM9ITFGgTkZAQ06UoF3gEXHBxo0fubY/5hulzhJaVjlTwWVs+kETeWb6QJEbOoZKnujwbpkxTB1UtN2qIuXP1wpYtZ0dZin2KSmLiKCejPzBaZfobozBzIDQa6vrTvmsgicBG2lGjRpR6VMarZ24b7Y+y+ta2dXeISDgS08V/6Q9lQAfvDL5HbQAAAABJRU5ErkJggg==";
		["6579106223"] = "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0NQkuOgFv7ks6+gXhak334rkAQPhbvDDkNY4qVUchPH6c6g4+PmhOq9//m3r12+NxbmfK7EKAG/ha/hPRlooJfo6aHq87X3TMHcB0t6VPerCDwBbisSXV6om29LxiAjuLq/QtOB5/63HAUsBT9b4ML8sVxrbvijqyFZ1++Cb8eWre/RCiK4h8J7oAJJaTwXHLWBmyWw5Y5JTF/oApKCgoFgplQ+gwbKsH61YsaLT4dVohAaBvccspNkqcfn4TDy3C9j+seDLOg2jmws/wtxK3A1TVq2a/+zcuW/0X718Tf8pP3Qmj70EtR4DUlcDbecLqNqzq/ZkvadXt/M7EpMAEO3XgIfqrfMAmi38g7UJNkw1/OqnAjwOwaozU8lOzSPTIt1mqOX54gUwL//36jFdxzwAEwEMl8CdjIcV8KZl4LGS2+XD9raxZYuY2IJfLFinfm8J7hHBJAgGA6iHwidQeNZ7Gk88Oi82/68gPz//SaXUnSJyGsCUFStWdGkKcGeag4DXAA6caET9R5uQrH0Hw/qPxP/t1zA6S8PE5sIfZp5Ad32/rGzrH+bO3N2wcc2zWReXj9f7ZqLurb/gRPWpMo/ovb6d35Fe0QTorfMAglwFIEFEVtj92ki/3QoOAEeUqP9IydT+UF7Z/c9b6Y/lIwD3dGcbj9wmHwC4O+p9R9kHoGnaasuyLhKRn0U94SdKgsDVX5lexA+ZjPerhmOoDky7REdWmrSkCTdZKBZuLdt0aM3cuRO9/3hnGQRDXUZ97q1re34iT3f1igAQonfNAwAgSvYqUdkAnD6bOVkgnwAYA+DfYWilvr4wiiaKEc02vw6Ki4vfBdBpR2es7D2mMCK7D4b1S8PorDNvFwbaCQIx0tQv8LX6B6S9YiowevE8AACwYP5OoF0PQCCwAapSM/XvewTHl/9Y6s9eDp47nX03YE9/dyAA3DROR0pCZPMEgoMAte/r23EXY4s2GLcAcr3f0h6AAU9Xv/G3t+npgt18kXj0Ff8yJSg8O3uRQ/NutA3ryfMkIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIi6g3+Hz+rrZcBX/MWAAAAAElFTkSuQmCC";
		["sunglaso"] = "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";
		["hydroxide"] = "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"
	}
	
	Main.DisplayOrders = {
		SideWindow = 8,
		Window = 10,
		Menu = 100000,
		Core = 101000
	}
	
	Main.GetInitDeps = function()
		return {
			Main = Main,
			Lib = Lib,
			Apps = Apps,
			Settings = Settings,
			
			API = API,
			RMD = RMD,
			env = env,
			service = service,
			plr = plr,
			create = create,
			createSimple = createSimple
		}
	end
	
	Main.Error = function(str)
		if rconsoleprint then
			rconsoleprint("AWESOME EXPLORER ERROR: "..tostring(str).."\n")
			wait(9e9)
		else
			error(str)
		end
	end
	
	Main.LoadModule = function(name)
		if Main.Elevated then -- If you don't have filesystem api then ur outta luck tbh
			local control
			
			if EmbeddedModules then -- Offline Modules
				control = EmbeddedModules[name]()
				
				if not control then Main.Error("Missing Embedded Module: "..name) end
			end
			
			Main.AppControls[name] = control
			control.InitDeps(Main.GetInitDeps())

			local moduleData = control.Main()
			Apps[name] = moduleData
			return moduleData
		else
			local module = script:WaitForChild("Modules"):WaitForChild(name,2)
			if not module then Main.Error("CANNOT FIND MODULE "..name) end
			
			local control = require(module)
			Main.AppControls[name] = control
			control.InitDeps(Main.GetInitDeps())
			
			local moduleData = control.Main()
			Apps[name] = moduleData
			return moduleData
		end
	end
	
	Main.LoadModules = function()
		for i,v in pairs(Main.ModuleList) do
			local s,e = pcall(Main.LoadModule,v)
			if not s then
				Main.Error("FAILED LOADING " .. v .. " CAUSE " .. e)
			end
		end
		
		-- Init Major Apps and define them in modules
		Explorer = Apps.Explorer
		Properties = Apps.Properties
		ScriptViewer = Apps.ScriptViewer
		Notebook = Apps.Notebook
		local appTable = {
			Explorer = Explorer,
			Properties = Properties,
			ScriptViewer = ScriptViewer,
			Notebook = Notebook
		}
		
		Main.AppControls.Lib.InitAfterMain(appTable)
		for i,v in pairs(Main.ModuleList) do
			local control = Main.AppControls[v]
			if control then
				control.InitAfterMain(appTable)
			end
		end
	end
	
	Main.InitEnv = function()
		setmetatable(env,{__newindex = function(self,name,func)
			if not func then Main.MissingEnv[#Main.MissingEnv+1] = name return end
			rawset(self,name,func)
		end})
		
		-- file
		env.readfile = readfile
		env.isfile = isfile
		env.writefile = writefile
		env.appendfile = appendfile
		env.makefolder = makefolder
		env.listfiles = listfiles
		env.loadfile = loadfile
		env.saveinstance = saveinstance
		
		-- debug
		env.getupvalues = debug.getupvalues or getupvals
		env.getconstants = debug.getconstants or getconsts
		env.islclosure = islclosure or is_l_closure
		env.checkcaller = checkcaller
		env.getreg = getreg
		env.getgc = getgc
		
		-- other
		env.setfflag = setfflag
		env.decompile = decompile
		env.protectgui = protect_gui or (syn and syn.protect_gui)
		env.gethui = gethui
		env.setclipboard = setclipboard
		env.getnilinstances = getnilinstances or get_nil_instances
		env.getloadedmodules = getloadedmodules
		env.getcustomasset = getcustomasset or getsynasset

		env.b64encode = (type(syn) == 'table' and syn.crypt.base64.encode) or (type(crypt) == 'table' and crypt.base64encode)
		env.b64decode = (type(syn) == 'table' and syn.crypt.base64.decode) or (type(crypt) == 'table' and crypt.base64decode)

		if identifyexecutor then
			Main.Executor = identifyexecutor()
		end
		
		Main.GuiHolder = Main.Elevated and service.CoreGui or plr:FindFirstChildOfClass("PlayerGui")
		
		setmetatable(env,nil)
	end

	Main.IncompatibleTest = function()
	end
	
	Main.LoadSettings = function()
		local s,data = pcall(env.readfile or error,"AwesomeExplorerSettings.json")
		if s and data and data ~= "" then
			local s,decoded = service.HttpService:JSONDecode(data)
			if s and decoded then
				for i,v in next,decoded do
					
				end
			else
				-- TODO: Notification
			end
		else
			Main.ResetSettings()
		end
	end
	
	Main.ResetSettings = function()
		local function recur(t,res)
			for set,val in pairs(t) do
				if type(val) == "table" and val._Recurse then
					if type(res[set]) ~= "table" then
						res[set] = {}
					end
					recur(val,res[set])
				else
					res[set] = val
				end
			end
			return res
		end
		recur(DefaultSettings,Settings)
	end
	
	Main.FetchAPI = function()
		local api,rawAPI
		if Main.Elevated then
			if Main.LocalDepsUpToDate() then
				local localAPI = Lib.ReadFile("awesome explorer/rbx_api.dat")
				if localAPI then 
					rawAPI = localAPI
				else
					Main.DepsVersionData[1] = ""
				end
			end
			rawAPI = rawAPI or game:HttpGet("http://setup.roblox.com/"..Main.RobloxVersion.."-API-Dump.json")
		else
			if script:FindFirstChild("API") then
				rawAPI = require(script.API)
			else
				error("NO API EXISTS")
			end
		end
		Main.RawAPI = rawAPI
		api = service.HttpService:JSONDecode(rawAPI)
		
		local classes,enums = {},{}
		local categoryOrder,seenCategories = {},{}
		
		local function insertAbove(t,item,aboveItem)
			local findPos = table.find(t,item)
			if not findPos then return end
			table.remove(t,findPos)

			local pos = table.find(t,aboveItem)
			if not pos then return end
			table.insert(t,pos,item)
		end
		
		for _,class in pairs(api.Classes) do
			local newClass = {}
			newClass.Name = class.Name
			newClass.Superclass = class.Superclass
			newClass.Properties = {}
			newClass.Functions = {}
			newClass.Events = {}
			newClass.Callbacks = {}
			newClass.Tags = {}
			
			if class.Tags then for c,tag in pairs(class.Tags) do newClass.Tags[tag] = true end end
			for __,member in pairs(class.Members) do
				local newMember = {}
				newMember.Name = member.Name
				newMember.Class = class.Name
				newMember.Security = member.Security
				newMember.Tags ={}
				if member.Tags then for c,tag in pairs(member.Tags) do newMember.Tags[tag] = true end end
				
				local mType = member.MemberType
				if mType == "Property" then
					local propCategory = member.Category or "Other"
					propCategory = propCategory:match("^%s*(.-)%s*$")
					if not seenCategories[propCategory] then
						categoryOrder[#categoryOrder+1] = propCategory
						seenCategories[propCategory] = true
					end
					newMember.ValueType = member.ValueType
					newMember.Category = propCategory
					newMember.Serialization = member.Serialization
					table.insert(newClass.Properties,newMember)
				elseif mType == "Function" then
					newMember.Parameters = {}
					newMember.ReturnType = member.ReturnType.Name
					for c,param in pairs(member.Parameters) do
						table.insert(newMember.Parameters,{Name = param.Name, Type = param.Type.Name})
					end
					table.insert(newClass.Functions,newMember)
				elseif mType == "Event" then
					newMember.Parameters = {}
					for c,param in pairs(member.Parameters) do
						table.insert(newMember.Parameters,{Name = param.Name, Type = param.Type.Name})
					end
					table.insert(newClass.Events,newMember)
				end
			end
			
			classes[class.Name] = newClass
		end
		
		for _,class in pairs(classes) do
			class.Superclass = classes[class.Superclass]
		end
		
		for _,enum in pairs(api.Enums) do
			local newEnum = {}
			newEnum.Name = enum.Name
			newEnum.Items = {}
			newEnum.Tags = {}
			
			if enum.Tags then for c,tag in pairs(enum.Tags) do newEnum.Tags[tag] = true end end
			for __,item in pairs(enum.Items) do
				local newItem = {}
				newItem.Name = item.Name
				newItem.Value = item.Value
				table.insert(newEnum.Items,newItem)
			end
			
			enums[enum.Name] = newEnum
		end
		
		local function getMember(class,member)
			if not classes[class] or not classes[class][member] then return end
	        local result = {}
	
	        local currentClass = classes[class]
	        while currentClass do
	            for _,entry in pairs(currentClass[member]) do
	                result[#result+1] = entry
	            end
	            currentClass = currentClass.Superclass
	        end
	
	        table.sort(result,function(a,b) return a.Name < b.Name end)
	        return result
		end
		
		insertAbove(categoryOrder,"Behavior","Tuning")
		insertAbove(categoryOrder,"Appearance","Data")
		insertAbove(categoryOrder,"Attachments","Axes")
		insertAbove(categoryOrder,"Cylinder","Slider")
		insertAbove(categoryOrder,"Localization","Jump Settings")
		insertAbove(categoryOrder,"Surface","Motion")
		insertAbove(categoryOrder,"Surface Inputs","Surface")
		insertAbove(categoryOrder,"Part","Surface Inputs")
		insertAbove(categoryOrder,"Assembly","Surface Inputs")
		insertAbove(categoryOrder,"Character","Controls")
		categoryOrder[#categoryOrder+1] = "Unscriptable"
		categoryOrder[#categoryOrder+1] = "Attributes"
		
		local categoryOrderMap = {}
		for i = 1,#categoryOrder do
			categoryOrderMap[categoryOrder[i]] = i
		end
		
		return {
			Classes = classes,
			Enums = enums,
			CategoryOrder = categoryOrderMap,
			GetMember = getMember
		}
	end
	
	Main.FetchRMD = function()
		local rawXML
		if Main.Elevated then
			if Main.LocalDepsUpToDate() then
				local localRMD = Lib.ReadFile("awesome explorer/rbx_rmd.dat")
				if localRMD then 
					rawXML = localRMD
				else
					Main.DepsVersionData[1] = ""
				end
			end
			rawXML = rawXML or game:HttpGet("https://raw.githubusercontent.com/CloneTrooper1019/Roblox-Client-Tracker/roblox/ReflectionMetadata.xml")
		else
			if script:FindFirstChild("RMD") then
				rawXML = require(script.RMD)
			else
				error("NO RMD EXISTS")
			end
		end
		Main.RawRMD = rawXML
		local parsed = Lib.ParseXML(rawXML)
		local classList = parsed.children[1].children[1].children
		local enumList = parsed.children[1].children[2].children
		local propertyOrders = {}
		
		local classes,enums = {},{}
		for _,class in pairs(classList) do
			local className = ""
			for _,child in pairs(class.children) do
				if child.tag == "Properties" then
					local data = {Properties = {}, Functions = {}}
					local props = child.children
					for _,prop in pairs(props) do
						local name = prop.attrs.name
						name = name:sub(1,1):upper()..name:sub(2)
						data[name] = prop.children[1].text
					end
					className = data.Name
					classes[className] = data
				elseif child.attrs.class == "ReflectionMetadataProperties" then
					local members = child.children
					for _,member in pairs(members) do
						if member.attrs.class == "ReflectionMetadataMember" then
							local data = {}
							if member.children[1].tag == "Properties" then
								local props = member.children[1].children
								for _,prop in pairs(props) do
									if prop.attrs then
										local name = prop.attrs.name
										name = name:sub(1,1):upper()..name:sub(2)
										data[name] = prop.children[1].text
									end
								end
								if data.PropertyOrder then
									local orders = propertyOrders[className]
									if not orders then orders = {} propertyOrders[className] = orders end
									orders[data.Name] = tonumber(data.PropertyOrder)
								end
								classes[className].Properties[data.Name] = data
							end
						end
					end
				elseif child.attrs.class == "ReflectionMetadataFunctions" then
					local members = child.children
					for _,member in pairs(members) do
						if member.attrs.class == "ReflectionMetadataMember" then
							local data = {}
							if member.children[1].tag == "Properties" then
								local props = member.children[1].children
								for _,prop in pairs(props) do
									if prop.attrs then
										local name = prop.attrs.name
										name = name:sub(1,1):upper()..name:sub(2)
										data[name] = prop.children[1].text
									end
								end
								classes[className].Functions[data.Name] = data
							end
						end
					end
				end
			end
		end
		
		for _,enum in pairs(enumList) do
			local enumName = ""
			for _,child in pairs(enum.children) do
				if child.tag == "Properties" then
					local data = {Items = {}}
					local props = child.children
					for _,prop in pairs(props) do
						local name = prop.attrs.name
						name = name:sub(1,1):upper()..name:sub(2)
						data[name] = prop.children[1].text
					end
					enumName = data.Name
					enums[enumName] = data
				elseif child.attrs.class == "ReflectionMetadataEnumItem" then
					local data = {}
					if child.children[1].tag == "Properties" then
						local props = child.children[1].children
						for _,prop in pairs(props) do
							local name = prop.attrs.name
							name = name:sub(1,1):upper()..name:sub(2)
							data[name] = prop.children[1].text
						end
						enums[enumName].Items[data.Name] = data
					end
				end
			end
		end
		
		return {Classes = classes, Enums = enums, PropertyOrders = propertyOrders}
	end
	
	Main.ShowGui = function(gui)
		if env.protectgui then
		--	env.protectgui(gui)
		end
		gui.Parent = Main.GuiHolder
	end
	
	Main.CreateIntro = function(initStatus) -- TODO: Must theme and show errors
		local gui = create({
			{1,"ScreenGui",{Name="Intro",}},
			{2,"Frame",{Active=true,BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderSizePixel=0,Name="Main",Parent={1},Position=UDim2.new(0.5,-175,0.5,-100),Size=UDim2.new(0,350,0,200),}},
			{3,"Frame",{BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderSizePixel=0,ClipsDescendants=true,Name="Holder",Parent={2},Size=UDim2.new(1,0,1,0),}},
			{4,"UIGradient",{Parent={3},Rotation=30,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(1,1,0),}),}},
			{5,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=4,Name="Title",Parent={3},Position=UDim2.new(0,-190,0,25),Size=UDim2.new(0,100,0,50),Text="Awesome Explorer",TextColor3=Color3.new(1,1,1),TextSize=25,TextTransparency=1,}},
			{6,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Desc",Parent={3},Position=UDim2.new(0,-230,0,60),Size=UDim2.new(0,180,0,25),Text="Most awesome explorer ev4r!",TextColor3=Color3.new(1,1,1),TextSize=18,TextTransparency=1,}},
			{7,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="StatusText",Parent={3},Position=UDim2.new(0,20,0,110),Size=UDim2.new(0,180,0,25),Text="Fetching API",TextColor3=Color3.new(1,1,1),TextSize=14,TextTransparency=1,}},
			{8,"Frame",{BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderSizePixel=0,Name="ProgressBar",Parent={3},Position=UDim2.new(0,110,0,145),Size=UDim2.new(0,0,0,4),}},
			{9,"Frame",{BackgroundColor3=Color3.new(0.2392156869173,0.56078433990479,0.86274510622025),BorderSizePixel=0,Name="Bar",Parent={8},Size=UDim2.new(0,0,1,0),}},
			{10,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("2764171053"),ImageColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),Parent={8},ScaleType=1,Size=UDim2.new(1,0,1,0),SliceCenter=Rect.new(2,2,254,254),}},
			{11,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Creator",Parent={2},Position=UDim2.new(1,-110,1,-20),Size=UDim2.new(0,105,0,20),Text="Developed by Light Devs",TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=1,}},
			{12,"UIGradient",{Parent={11},Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(1,1,0),}),}},
			{13,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Version",Parent={2},Position=UDim2.new(1,-110,1,-35),Size=UDim2.new(0,105,0,20),Text="Beta 6.3.0",TextColor3=Color3.new(1,1,1),TextSize=14,TextXAlignment=1,}},
			{14,"UIGradient",{Parent={13},Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(1,1,0),}),}},
			{15,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Image=Main.GetLocalAsset("1427967925"),Name="Outlines",Parent={2},Position=UDim2.new(0,-5,0,-5),ScaleType=1,Size=UDim2.new(1,10,1,10),SliceCenter=Rect.new(6,6,25,25),TileSize=UDim2.new(0,20,0,20),}},
			{16,"UIGradient",{Parent={15},Rotation=-30,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(1,1,0),}),}},
			{17,"UIGradient",{Parent={2},Rotation=-30,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(1,1,0),}),}},
			{18,"ImageLabel",{Parent={2},BackgroundTransparency=1,ImageTransparency=1,BackgroundColor3=Color3.new(1,1,1),Image=Main.GetLocalAsset("sunglaso"),Name='Logo',Position=UDim2.fromOffset(281,8),Size=UDim2.fromOffset(64,64)}}
		})
		Main.ShowGui(gui)
		local backGradient = gui.Main.UIGradient
		local outlinesGradient = gui.Main.Outlines.UIGradient
		local holderGradient = gui.Main.Holder.UIGradient
		local titleText = gui.Main.Holder.Title
		local descText = gui.Main.Holder.Desc
		local versionText = gui.Main.Version
		local versionGradient = versionText.UIGradient
		local creatorText = gui.Main.Creator
		local creatorGradient = creatorText.UIGradient
		local statusText = gui.Main.Holder.StatusText
		local progressBar = gui.Main.Holder.ProgressBar
		local tweenS = service.TweenService
		local logo = gui.Main.Logo
		
		local renderStepped = service.RunService.RenderStepped
		local signalWait = renderStepped.wait
		local fastwait = function(s)
			if not s then return signalWait(renderStepped) end
			local start = tick()
			while tick() - start < s do signalWait(renderStepped) end
		end
		
		statusText.Text = initStatus
		
		local function tweenNumber(n,ti,func)
			local tweenVal = Instance.new("IntValue")
			tweenVal.Value = 0
			tweenVal.Changed:Connect(func)
			local tween = tweenS:Create(tweenVal,ti,{Value = n})
			tween:Play()
			tween.Completed:Connect(function()
				tweenVal:Destroy()
			end)
		end
		
		local ti = TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
		tweenNumber(100,ti,function(val)
			    val = val/200
				local start = NumberSequenceKeypoint.new(0,0)
				local a1 = NumberSequenceKeypoint.new(val,0)
				local a2 = NumberSequenceKeypoint.new(math.min(0.5,val+math.min(0.05,val)),1)
				if a1.Time == a2.Time then a2 = a1 end
				local b1 = NumberSequenceKeypoint.new(1-val,0)
				local b2 = NumberSequenceKeypoint.new(math.max(0.5,1-val-math.min(0.05,val)),1)
				if b1.Time == b2.Time then b2 = b1 end
				local goal = NumberSequenceKeypoint.new(1,0)
				backGradient.Transparency = NumberSequence.new({start,a1,a2,b2,b1,goal})
				outlinesGradient.Transparency = NumberSequence.new({start,a1,a2,b2,b1,goal})
		end)
		
		fastwait(0.4)
		
		tweenNumber(100,ti,function(val)
			val = val/166.66
			local start = NumberSequenceKeypoint.new(0,0)
			local a1 = NumberSequenceKeypoint.new(val,0)
			local a2 = NumberSequenceKeypoint.new(val+0.01,1)
			local goal = NumberSequenceKeypoint.new(1,1)
			holderGradient.Transparency = NumberSequence.new({start,a1,a2,goal})
		end)
		
		tweenS:Create(titleText,ti,{Position = UDim2.new(0,60,0,25), TextTransparency = 0}):Play()
		tweenS:Create(descText,ti,{Position = UDim2.new(0,20,0,60), TextTransparency = 0}):Play()
		tweenS:Create(logo,ti,{ImageTransparency=0}):Play()

		local function rightTextTransparency(obj)
			tweenNumber(100,ti,function(val)
				val = val/100
				local a1 = NumberSequenceKeypoint.new(1-val,0)
				local a2 = NumberSequenceKeypoint.new(math.max(0,1-val-0.01),1)
				if a1.Time == a2.Time then a2 = a1 end
				local start = NumberSequenceKeypoint.new(0,a1 == a2 and 0 or 1)
				local goal = NumberSequenceKeypoint.new(1,0)
				obj.Transparency = NumberSequence.new({start,a2,a1,goal})
			end)
		end
		rightTextTransparency(versionGradient)
		rightTextTransparency(creatorGradient)
		
		fastwait(0.9)
		
		local progressTI = TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
		
		tweenS:Create(statusText,progressTI,{Position = UDim2.new(0,20,0,120), TextTransparency = 0}):Play()
		tweenS:Create(progressBar,progressTI,{Position = UDim2.new(0,60,0,145), Size = UDim2.new(0,100,0,4)}):Play()
		
		fastwait(0.25)
		
		local function setProgress(text,n)
			statusText.Text = text
			tweenS:Create(progressBar.Bar,progressTI,{Size = UDim2.new(n,0,1,0)}):Play()
		end
		
		local function close()
			tweenS:Create(titleText,progressTI,{TextTransparency = 1}):Play()
			tweenS:Create(descText,progressTI,{TextTransparency = 1}):Play()
			tweenS:Create(logo,ti,{ImageTransparency=1}):Play()
			tweenS:Create(versionText,progressTI,{TextTransparency = 1}):Play()
			tweenS:Create(creatorText,progressTI,{TextTransparency = 1}):Play()
			tweenS:Create(statusText,progressTI,{TextTransparency = 1}):Play()
			tweenS:Create(progressBar,progressTI,{BackgroundTransparency = 1}):Play()
			tweenS:Create(progressBar.Bar,progressTI,{BackgroundTransparency = 1}):Play()
			tweenS:Create(progressBar.ImageLabel,progressTI,{ImageTransparency = 1}):Play()
			
			tweenNumber(100,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.In),function(val)
				val = val/250
				local start = NumberSequenceKeypoint.new(0,0)
				local a1 = NumberSequenceKeypoint.new(0.6+val,0)
				local a2 = NumberSequenceKeypoint.new(math.min(1,0.601+val),1)
				if a1.Time == a2.Time then a2 = a1 end
				local goal = NumberSequenceKeypoint.new(1,a1 == a2 and 0 or 1)
				holderGradient.Transparency = NumberSequence.new({start,a1,a2,goal})
			end)
			
			fastwait(0.5)
			gui.Main.BackgroundTransparency = 1
			outlinesGradient.Rotation = 30
			
			tweenNumber(100,ti,function(val)
				val = val/100
				local start = NumberSequenceKeypoint.new(0,1)
				local a1 = NumberSequenceKeypoint.new(val,1)
				local a2 = NumberSequenceKeypoint.new(math.min(1,val+math.min(0.05,val)),0)
				if a1.Time == a2.Time then a2 = a1 end
				local goal = NumberSequenceKeypoint.new(1,a1 == a2 and 1 or 0)
				outlinesGradient.Transparency = NumberSequence.new({start,a1,a2,goal})
				holderGradient.Transparency = NumberSequence.new({start,a1,a2,goal})
			end)
			
			fastwait(0.45)
			gui:Destroy()
		end
		
		return {SetProgress = setProgress, Close = close}
	end
	
	Main.CreateApp = function(data)
		if Main.MenuApps[data.Name] then return end -- TODO: Handle conflict
		local control = {}
		
		local app = Main.AppTemplate:Clone()
		
		local iconIndex = data.Icon
		if data.IconMap and iconIndex then
			if type(iconIndex) == "number" then
				data.IconMap:Display(app.Main.Icon,iconIndex)
			elseif type(iconIndex) == "string" then
				data.IconMap:DisplayByKey(app.Main.Icon,iconIndex)
			end
		elseif type(iconIndex) == "string" then
			app.Main.Icon.ImageRectSize = Vector2.zero
			app.Main.Icon.Image = iconIndex
		else
			app.Main.Icon.Image = ""
		end
		
		local function updateState()
			app.Main.BackgroundTransparency = data.Open and 0 or (Lib.CheckMouseInGui(app.Main) and 0 or 1)
			app.Main.Highlight.Visible = data.Open
		end
		
		local function enable(silent)
			if data.Open then return end
			data.Open = true
			updateState()
			if not silent then
				if data.Window then data.Window:Show() end
				if data.OnClick then data.OnClick(data.Open) end
			end
		end
		
		local function disable(silent)
			if not data.Open then return end
			data.Open = false
			updateState()
			if not silent then
				if data.Window then data.Window:Hide() end
				if data.OnClick then data.OnClick(data.Open) end
			end
		end
		
		updateState()
		
		local ySize = service.TextService:GetTextSize(data.Name,14,Enum.Font.SourceSans,Vector2.new(62,999999)).Y
		app.Main.Size = UDim2.new(1,0,0,math.clamp(46+ySize,60,74))
		app.Main.AppName.Text = data.Name
		
		app.Main.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				app.Main.BackgroundTransparency = 0
				app.Main.BackgroundColor3 = Settings.Theme.ButtonHover
			end
		end)
		
		app.Main.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				app.Main.BackgroundTransparency = data.Open and 0 or 1
				app.Main.BackgroundColor3 = Settings.Theme.Button
			end
		end)
		
		app.Main.MouseButton1Click:Connect(function()
			if data.Open then disable() else enable() end
		end)
		
		local window = data.Window
		if window then
			window.OnActivate:Connect(function() enable(true) end)
			window.OnDeactivate:Connect(function() disable(true) end)
		end
		
		app.Visible = true
		app.Parent = Main.AppsContainer
		Main.AppsFrame.CanvasSize = UDim2.new(0,0,0,Main.AppsContainerGrid.AbsoluteCellCount.Y*82 + 8)
		
		control.Enable = enable
		control.Disable = disable
		control.Data = data
		Main.MenuApps[data.Name] = control
		return control
	end
	
	Main.SetMainGuiOpen = function(val)
		Main.MainGuiOpen = val
		
		Main.MainGui.OpenButton.Text = val and "X" or "AE"
		if val then Main.MainGui.OpenButton.MainFrame.Visible = true end
		Main.MainGui.OpenButton.MainFrame:TweenSize(val and UDim2.new(0,224,0,200) or UDim2.new(0,0,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.2,true)
		--Main.MainGui.OpenButton.BackgroundTransparency = val and 0 or (Lib.CheckMouseInGui(Main.MainGui.OpenButton) and 0 or 0.2)
		service.TweenService:Create(Main.MainGui.OpenButton,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = val and 0 or (Lib.CheckMouseInGui(Main.MainGui.OpenButton) and 0 or 0.2)}):Play()
		
		if Main.MainGuiMouseEvent then Main.MainGuiMouseEvent:Disconnect() end
		
		if not val then
			local startTime = tick()
			Main.MainGuiCloseTime = startTime
			coroutine.wrap(function()
				Lib.FastWait(0.2)
				if not Main.MainGuiOpen and startTime == Main.MainGuiCloseTime then Main.MainGui.OpenButton.MainFrame.Visible = false end
			end)()
		else
			Main.MainGuiMouseEvent = service.UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and not Lib.CheckMouseInGui(Main.MainGui.OpenButton) and not Lib.CheckMouseInGui(Main.MainGui.OpenButton.MainFrame) then
					Main.SetMainGuiOpen(false)
				end
			end)
		end
	end
	
	Main.CreateMainGui = function()
		local gui = create({
			{1,"ScreenGui",{IgnoreGuiInset=true,Name="MainMenu",}},
			{2,"TextButton",{AnchorPoint=Vector2.new(0.5,0),AutoButtonColor=false,BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),BorderSizePixel=0,Font=4,Name="OpenButton",Parent={1},Position=UDim2.new(0.5,0,0,2),Size=UDim2.new(0,32,0,32),Text="AE",TextColor3=Color3.new(1,1,1),TextSize=16,TextTransparency=0.20000000298023,}},
			{3,"UICorner",{CornerRadius=UDim.new(0,4),Parent={2},}},
			{4,"Frame",{AnchorPoint=Vector2.new(0.5,0),BackgroundColor3=Color3.new(0.17647059261799,0.17647059261799,0.17647059261799),ClipsDescendants=true,Name="MainFrame",Parent={2},Position=UDim2.new(0.5,0,1,-4),Size=UDim2.new(0,224,0,200),}},
			{5,"UICorner",{CornerRadius=UDim.new(0,4),Parent={4},}},
			{6,"Frame",{BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),Name="BottomFrame",Parent={4},Position=UDim2.new(0,0,1,-24),Size=UDim2.new(1,0,0,24),}},
			{7,"UICorner",{CornerRadius=UDim.new(0,4),Parent={6},}},
			{8,"Frame",{BackgroundColor3=Color3.new(0.20392157137394,0.20392157137394,0.20392157137394),BorderSizePixel=0,Name="CoverFrame",Parent={6},Size=UDim2.new(1,0,0,4),}},
			{9,"Frame",{BackgroundColor3=Color3.new(0.1294117718935,0.1294117718935,0.1294117718935),BorderSizePixel=0,Name="Line",Parent={8},Position=UDim2.new(0,0,0,-1),Size=UDim2.new(1,0,0,1),}},
			{10,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Settings",Parent={6},Position=UDim2.new(1,-48,0,0),Size=UDim2.new(0,24,1,0),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,}},
			{11,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("6578871732"),ImageTransparency=0.20000000298023,Name="Icon",Parent={10},Position=UDim2.new(0,4,0,4),Size=UDim2.new(0,16,0,16),}},
			{12,"TextButton",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Font=3,Name="Information",Parent={6},Position=UDim2.new(1,-24,0,0),Size=UDim2.new(0,24,1,0),Text="",TextColor3=Color3.new(1,1,1),TextSize=14,}},
			{13,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("6578933307"),ImageTransparency=0.20000000298023,Name="Icon",Parent={12},Position=UDim2.new(0,4,0,4),Size=UDim2.new(0,16,0,16),}},
			{14,"ScrollingFrame",{Active=true,AnchorPoint=Vector2.new(0.5,0),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderColor3=Color3.new(0.1294117718935,0.1294117718935,0.1294117718935),BorderSizePixel=0,Name="AppsFrame",Parent={4},Position=UDim2.new(0.5,0,0,0),ScrollBarImageColor3=Color3.new(0,0,0),ScrollBarThickness=4,Size=UDim2.new(0,222,1,-25),}},
			{15,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name="Container",Parent={14},Position=UDim2.new(0,7,0,8),Size=UDim2.new(1,-14,0,2),}},
			{16,"UIGridLayout",{CellSize=UDim2.new(0,66,0,74),Parent={15},SortOrder=2,}},
			{17,"Frame",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Name="App",Parent={1},Size=UDim2.new(0,100,0,100),Visible=false,}},
			{18,"TextButton",{AutoButtonColor=false,BackgroundColor3=Color3.new(0.2352941185236,0.2352941185236,0.2352941185236),BorderSizePixel=0,Font=3,Name="Main",Parent={17},Size=UDim2.new(1,0,0,60),Text="",TextColor3=Color3.new(0,0,0),TextSize=14,}},
			{19,"ImageLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,Image=Main.GetLocalAsset("6579106223"),ImageRectSize=Vector2.new(32,32),Name="Icon",Parent={18},Position=UDim2.new(0.5,-16,0,4),ScaleType=4,Size=UDim2.new(0,32,0,32),}},
			{20,"TextLabel",{BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=1,BorderSizePixel=0,Font=3,Name="AppName",Parent={18},Position=UDim2.new(0,2,0,38),Size=UDim2.new(1,-4,1,-40),Text="Explorer",TextColor3=Color3.new(1,1,1),TextSize=14,TextTransparency=0.10000000149012,TextTruncate=1,TextWrapped=true,TextYAlignment=0,}},
			{21,"Frame",{BackgroundColor3=Color3.new(0,0.66666668653488,1),BorderSizePixel=0,Name="Highlight",Parent={18},Position=UDim2.new(0,0,1,-2),Size=UDim2.new(1,0,0,2),}},
		})
		Main.MainGui = gui
		Main.AppsFrame = gui.OpenButton.MainFrame.AppsFrame
		Main.AppsContainer = Main.AppsFrame.Container
		Main.AppsContainerGrid = Main.AppsContainer.UIGridLayout
		Main.AppTemplate = gui.App
		Main.MainGuiOpen = false
		
		local openButton = gui.OpenButton
		openButton.BackgroundTransparency = 0.2
		openButton.MainFrame.Size = UDim2.new(0,0,0,0)
		openButton.MainFrame.Visible = false
		openButton.MouseButton1Click:Connect(function()
			Main.SetMainGuiOpen(not Main.MainGuiOpen)
		end)
		
		openButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				service.TweenService:Create(Main.MainGui.OpenButton,TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
			end
		end)

		openButton.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				service.TweenService:Create(Main.MainGui.OpenButton,TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundTransparency = Main.MainGuiOpen and 0 or 0.2}):Play()
			end
		end)
		
		-- Create Main Apps
		Main.CreateApp({Name = "Explorer", IconMap = Main.LargeIcons, Icon = "Explorer", Open = true, Window = Explorer.Window})
		Main.CreateApp({Name = "Properties", IconMap = Main.LargeIcons, Icon = "Properties", Open = true, Window = Properties.Window})
		Main.CreateApp({Name = "Script Viewer", IconMap = Main.LargeIcons, Icon = "Script_Viewer", Window = ScriptViewer.Window})
		
		local app;
		app = Main.CreateApp({Name = 'Remote Spy', Icon = Main.GetLocalAsset("hydroxide"), OnClick = function(state)
			if (not Main.RemoteSpyLoaded) then
				task.spawn(Main.LoadRemoteSpy)
				Main.RemoteSpyLoaded = true
			end
			app.Enable(true)
		end })
		app.Enable(true)

		Lib.ShowGui(gui)
	end

	Main.LoadRemoteSpy = function()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/init.lua'))()
		loadstring(game:HttpGet('https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/ui/main.lua'))()
	end
	
	Main.SetupFilesystem = function()
		if not env.writefile or not env.makefolder then return end
		
		local writefile,makefolder = env.writefile,env.makefolder
		
		makefolder("awesome explorer")
		makefolder("awesome explorer/assets")
		makefolder("awesome explorer/saved")
		makefolder("awesome explorer/plugins")
		makefolder("awesome explorer/ModuleCache")
	end
	
	Main.SetupAssets = function()
		if env.getcustomasset == nil or env.b64decode == nil then
			Main.Error("Unable to initialize assets.")
		end

		for id, data in next, Main.LocalAssetData do
			writefile('awesome explorer/assets/' .. id .. '.png', env.b64decode(data))
		end
	end

	Main.GetLocalAsset = function(id)
		local path = 'awesome explorer/assets/' .. id .. '.png'
		if not env.isfile(path) then 
			Main.Error("Invalid local asset id: " .. id) 
		end
		return env.getcustomasset(path)
	end

	Main.LocalDepsUpToDate = function()
		return Main.DepsVersionData and Main.ClientVersion == Main.DepsVersionData[1]
	end
	
	Main.Init = function()
		Main.Elevated = pcall(function() local a = game:GetService("CoreGui"):GetFullName() end)
		Main.InitEnv()
		Main.LoadSettings()
		Main.SetupFilesystem()
		Main.SetupAssets()
		
		-- Load Lib
		local intro = Main.CreateIntro("Initializing Library")
		Lib = Main.LoadModule("Lib")
		Lib.FastWait()
		
		-- Init other stuff
		Main.IncompatibleTest()
		
		-- Init icons
		Main.MiscIcons = Lib.IconMap.new(Main.GetLocalAsset("6511490623"),256,256,16,16)
		Main.MiscIcons:SetDict({
			Reference = 0,             Cut = 1,                         Cut_Disabled = 2,      Copy = 3,               Copy_Disabled = 4,    Paste = 5,                Paste_Disabled = 6,
			Delete = 7,                Delete_Disabled = 8,             Group = 9,             Group_Disabled = 10,    Ungroup = 11,         Ungroup_Disabled = 12,    TeleportTo = 13,
			Rename = 14,               JumpToParent = 15,               ExploreData = 16,      Save = 17,              CallFunction = 18,    CallRemote = 19,          Undo = 20,
			Undo_Disabled = 21,        Redo = 22,                       Redo_Disabled = 23,    Expand_Over = 24,       Expand = 25,          Collapse_Over = 26,       Collapse = 27,
			SelectChildren = 28,       SelectChildren_Disabled = 29,    InsertObject = 30,     ViewScript = 31,        AddStar = 32,         RemoveStar = 33,          Script_Disabled = 34,
			LocalScript_Disabled = 35, Play = 36,                       Pause = 37,            Rename_Disabled = 38
		})
		Main.LargeIcons = Lib.IconMap.new(Main.GetLocalAsset("6579106223"),256,256,32,32)
		Main.LargeIcons:SetDict({
			Explorer = 0, Properties = 1, Script_Viewer = 2,
		})
		
		-- Fetch version if needed
		intro.SetProgress("Fetching Roblox Version",0.2)
		if Main.Elevated then
			local fileVer = Lib.ReadFile("awesome explorer/deps_version.dat")
			Main.ClientVersion = Version()
			if fileVer then
				Main.DepsVersionData = string.split(fileVer,"\n")
				if Main.LocalDepsUpToDate() then
					Main.RobloxVersion = Main.DepsVersionData[2]
				end
			end
			Main.RobloxVersion = Main.RobloxVersion or game:HttpGet("http://setup.roblox.com/versionQTStudio")
		end
		
		-- Fetch external deps
		intro.SetProgress("Fetching API",0.35)
		API = Main.FetchAPI()
		Lib.FastWait()
		intro.SetProgress("Fetching RMD",0.5)
		RMD = Main.FetchRMD()
		Lib.FastWait()
		
		-- Save external deps locally if needed
		if Main.Elevated and env.writefile and not Main.LocalDepsUpToDate() then
			env.writefile("awesome explorer/deps_version.dat",Main.ClientVersion.."\n"..Main.RobloxVersion)
			env.writefile("awesome explorer/rbx_api.dat",Main.RawAPI)
			env.writefile("awesome explorer/rbx_rmd.dat",Main.RawRMD)
		end
		
		-- Load other modules
		intro.SetProgress("Loading Modules",0.75)
		Main.AppControls.Lib.InitDeps(Main.GetInitDeps()) -- Missing deps now available
		Main.LoadModules()
		Lib.FastWait()
		
		-- Init other modules
		intro.SetProgress("Initializing Modules",0.9)
		Explorer.Init()
		Properties.Init()
		ScriptViewer.Init()
		Lib.FastWait()
		
		-- Done
		intro.SetProgress("Complete",1)
		coroutine.wrap(function()
			Lib.FastWait(1.25)
			intro.Close()
		end)()
		
		-- Init window system, create main menu, show explorer and properties
		Lib.Window.Init()
		Main.CreateMainGui()
		Explorer.Window:Show({Align = "right", Pos = 1, Size = 0.5, Silent = true})
		Properties.Window:Show({Align = "right", Pos = 2, Size = 0.5, Silent = true})
		Lib.DeferFunc(function() Lib.Window.ToggleSide("right") end)
	end
	
	return Main
end)()

-- Start
Main.Init()

--for i,v in pairs(Main.MissingEnv) do print(i,v) end