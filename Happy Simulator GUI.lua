-- Example made by twink marie
local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local kVars = {}
local mainFrame = Material.Load({
    Title = "Happy Simulator 2",
    Style = 3,
    SizeX = 500,
    SizeY = 350,
    Theme = "Dark",
    ColorOverrides = {
        MainFrame = Color3.fromRGB(0,0,0)
    }
})

---------------- Vars ----------------
kVars.plrName = game.Players.LocalPlayer.Name
local myToolTable = {}
local eggsList = {}
local TeleTable = {}
TeleTable[1] = {name = "Spawn", cf = game:GetService("Workspace").Map.Spawns.SpawnLocation.CFrame}
TeleTable[2] = {name = "Egypt", cf = CFrame.new(711, 893, -1163)}
TeleTable[3] = {name = "Atlantis", cf = CFrame.new(720, 1837, -1182)}
TeleTable[4] = {name = "Nature", cf = CFrame.new(760, 2683, -1173)}
TeleTable[5] = {name = "Ninja", cf = CFrame.new(720, 3510, -1182)}
TeleTable[6] = {name = "Candy", cf = CFrame.new(760, 4112, -1173)}
TeleTable[7] = {name = "Tropical", cf = CFrame.new(760, 4561, -1173)}
TeleTable[8] = {name = "Premium Island", cf = CFrame.new(-2419, 459, -1648)}
TeleTable[9] = {name = "VIP Island", cf = CFrame.new(-2370, 459, -964)}


---------------- Main Page ----------------
mainPage = mainFrame.New({
    Title = "Main"
})

---- Auto Swing ----
mainPage.Toggle({
    Text = "Swing",
    Callback = function(Value)
        kVars.swingBool = Value
        if Value then swingFunc() end
    end,
    Enabled = false
})
function swingFunc()
    spawn(function()
        while kVars.swingBool do
            wait()
            while #myToolTable ~= 0 do rawset(myToolTable, #myToolTable, nil) end
            for i,v in pairs(game:GetService("Players").LocalPlayer.Swords:getChildren()) do
                myToolTable[i] = v
            end
            kVars.myTool = myToolTable[#myToolTable].Name
            if kVars.myTool ~= nil then
                game:GetService("ReplicatedStorage").Modules.Events.Sword:FireServer(kVars.myTool)
            end		
        end
    end)
end

---- Auto Sell ----
mainPage.Toggle({
    Text = "Sell",
    Callback = function(Value)
        kVars.sellBool = Value
        if Value then sellFunc() end
    end,
    Enabled = false
})
function sellFunc()
    spawn(function()
        while kVars.sellBool do
            wait()
            local sellPart = game:GetService("Workspace").Sells["Sell-Island_4"].Touch
            firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, sellPart, 0)
			wait(.2)
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, sellPart, 1)
        end
    end)
end

---- Auto Buy Tool ----
mainPage.Toggle({
    Text = "Buy Tool",
    Callback = function(Value)
        kVars.buySwordBool = Value
        if Value then buySwordFunc() end
    end,
    Enabled = false
})
function buySwordFunc()
    spawn(function()
        while kVars.buySwordBool do
            wait()
            game:GetService("ReplicatedStorage").Modules.Events.BuyItem:InvokeServer("Sword", "Sword", "BuyAll")
        end
    end)
end

---- Auto Buy Backback ----
mainPage.Toggle({
    Text = "Buy Backback",
    Callback = function(Value)
        kVars.buyBackpackBool = Value
        if Value then buyBackpackFunc() end
    end,
    Enabled = false
})
function buyBackpackFunc()
    spawn(function()
        while kVars.buyBackpackBool do
            wait()
            game:GetService("ReplicatedStorage").Modules.Events.BuyItem:InvokeServer("Backpack", "Backpack", "BuyAll")
        end
    end)
end

---- Collect Coins ----
mainPage.Toggle({
    Text = "Collect Coins",
    Callback = function(Value)
        kVars.collectCoinsBool = Value
        if kVars.claimFlagsBool == false and Value then
            collectCoinsGemsFunc()
        end
    end,
    Enabled = false
})
---- Collect Gems ----
mainPage.Toggle({
    Text = "Collect Gems",
    Callback = function(Value)
        kVars.collectGemsBool = Value
        if kVars.claimFlagsBool == false and Value then
            collectCoinsGemsFunc()
        end
    end,
    Enabled = false
})
kVars.noClipie = false
function collectCoinsGemsFunc()
    spawn(function()
        while kVars.collectCoinsBool or kVars.collectGemsBool do
            wait()
            if kVars.collectCoinsBool or kVars.collectGemsBool or kVars.clamFlagsBool and kVars.noClipie == false then
                kVars.noClipie = true
                for i,v in pairs(game.workspace:getChildren()) do
                    if v.Name == "Part" then
                        v.CanCollide = false
                    end
                end
            elseif kVars.collectCoinsBool == false and kVars.collectGemsBool == false and kVars.clamFlagsBool == false and kVars.noClipie == true then
                kVars.noClipie = false
                for i,v in pairs(game.workspace:getChildren()) do
                    if v.Name == "Part" then
                        v.CanCollide = true
                    end
                end
            end
            if kVars.collectGemsBool then 
                for i,v in pairs(game:GetService("Workspace").Coins.Locations:getChildren()) do
                    if kVars.collectGemsBool == false then break end
                    if v:FindFirstChild('TouchInterest') and string.match(v.Name, "Gem") then
                        repeat
                            wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        until string.match(v.Name, "Spawn") or kVars.collectGemsBool == false
                    end
                end
                for i,v in pairs(game:GetService("Workspace").Coins.Spawned:getChildren()) do
                    if kVars.collectGemsBool == false then break end
                    if v:FindFirstChild('TouchInterest') and string.match(v.Name, "Gem") then
                        repeat
                            wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        until string.match(v.Name, "Spawn") or kVars.collectGemsBool == false
                    end
                end	
            end
            if kVars.collectCoinsBool then
                for i,v in pairs(game:GetService("Workspace").Coins.Locations:getChildren()) do
                    if kVars.collectCoinsBool == false then break end
                    if v:FindFirstChild('TouchInterest') and string.match(v.Name, "Coin") then
                        repeat
                            wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        until string.match(v.Name, "Spawn") or kVars.collectCoinsBool == false
                    end
                end
                for i,v in pairs(game:GetService("Workspace").Coins.Spawned:getChildren()) do
                    if kVars.collectCoinsBool == false then break end
                    if v:FindFirstChild('TouchInterest') and string.match(v.Name, "Coin") then
                        repeat
                            wait()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                        until string.match(v.Name, "Spawn") or kVars.collectCoinsBool == false
                    end
                end
            end
        end
    end)
end

---- claim Flags ----
mainPage.Toggle({
    Text = "Claim Flags",
    Callback = function(Value)
        kVars.claimFlagsBool = Value
        if kVars.collectCoinsBool == false and kVars.collectGemsBool == false and value then
            clamFlagsFunc()
        end
    end,
    Enabled = false
})
function clamFlagsFunc()
    spawn(function()
        while kVars.claimFlagsBool do
            wait()
            for i,v in pairs(game:GetService("Workspace").Flags:getChildren()) do
                if kVars.claimFlagsBool == false then break end
                if v.Name == "Flag" and v:IsA('Model') and v.Config.Owner.Value ~= kVars.plrName then
                    --local nx, ny, nz, r00, r01, r02, r10, r11, r12, r20, r21, r22 = v.Zone.Touch.CFrame:components()
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Zone.Touch.CFrame + CFrame.new(3,-8,0)
                    until v.Config.Owner.Value == kVars.plrName or kVars.claimFlagsBool == false
                    wait(5)
                end
            end
        end
    end)
end

---- Collect Chests ----
mainPage.Button({
    Text = "Chests",
    Callback = function()
        local startingCFrame = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame
        for i,v in pairs(game:GetService("Workspace").CollectableChests:getChildren()) do
            if v:FindFirstChild('Touch') and game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
                wait(.1)
                game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = v.Touch.CFrame
            end
        end
        game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = startingCFrame
    end,
    Menu = {
        Information = function(self)
            mainFrame.Banner({
                Text = ""
            })
        end
    }
})

---- Unlock Areas ----
mainPage.Button({
    Text = "Unlock Areas",
    Callback = function()
        for i,v in pairs(game:GetService("Players").LocalPlayer.Zones:getChildren()) do
            v.Value = true
        end
    end,
    Menu = {
        Information = function(self)
            mainFrame.Banner({
                Text = ""
            })
        end
    }
})

---- Speed/Jumps Max ----
mainPage.Button({
    Text = "Speed, Jumps Max",
    Callback = function()
        local jumps = { "Jump2", "Jump3", "Jump4", "Jump5", "Jump6", "Jump7", "Jump8", "Jump9", "Jump10" }
        local speed = { "Speed1", "Speed2", "Speed3" }
        for i,v in pairs(jumps) do
            if not game:GetService("Players").LocalPlayer.Skills:FindFirstChild(v) then
                local strValue = Instance.new("StringValue")
                strValue.Parent = game:GetService("Players").LocalPlayer.Skills
                strValue.Name = v
                strValue.Value = v
            end
        end
        for i,v in pairs(speed) do
            if not game:GetService("Players").LocalPlayer.Skills:FindFirstChild(v) then
                local strValue = Instance.new("StringValue")
                strValue.Parent = game:GetService("Players").LocalPlayer.Skills
                strValue.Name = v
                strValue.Value = v
            end
        end
    end,
    Menu = {
        Information = function(self)
            mainFrame.Banner({
                Text = "This will max skills"
            })
        end
    }
})

---------------- Eggs Page ----------------
---- Set Eggs Page ----
local eggsPage = mainFrame.New({
    Title = "Eggs"
})

---- Selection Egg ----
for i,v in pairs(game:GetService("ReplicatedStorage").Extra.Eggs:getChildren()) do
    table.insert(eggsList, tostring(v.Name))
end
table.sort(eggsList)
eggsPage.Dropdown({
    Text = "Open Egg",
    Callback = function(Value)
        kVars.eggSelected = Value
    end,
    Options = eggsList,
    Menu = {
        Information = function(self)
            eggsPage.Banner({
                Text = "Select an egg to auto open."
            })
        end
    }
})

---- Open Eggs ----
eggsPage.Toggle({
    Text = "Open Egg",
    Callback = function(Value)
        kVars.openEggBool = Value
        if Value then openEggFunc() end
    end,
    Enabled = false
})
function openEggFunc()
    spawn(function()
        while kVars.openEggBool do
            wait()
            if kVars.eggSelected ~= nil then
                game:GetService("ReplicatedStorage").Modules.Events.EggBuy:InvokeServer(kVars.eggSelected, "Buy1")
            else
                print("error - line 315 - eggSelected = nil")
            end
        end
    end)
end

---- CombinePets ----
eggsPage.Toggle({
    Text = "Pet Combine",
    Callback = function(Value)
        kVars.petCombineBool = Value
        if Value then petCombineFunc() end
    end,
    Enabled = false
})
function petCombineFunc()
    spawn(function()
        while kVars.petCombineBool do
            wait()
            for i,v in pairs(game:GetService("Players").LocalPlayer.Pets.OwnedPets:GetChildren()) do
                if kVars.petCombineBool == false then break end
                if v:FindFirstChild('PetName') then
                    game:GetService("ReplicatedStorage").Modules.Events.PetHandler:InvokeServer("CombinePet", v.PetName.Value)
               end
           end
        end
    end)
end

---- delete egg dropdown ----
local allPetNamesList = {}

for i,v in pairs(game:GetService("ReplicatedStorage").Pets:GetChildren()) do
	table.insert(allPetNamesList, tostring(v.Name))
end
table.sort(allPetNamesList)
table.insert(allPetNamesList,1,"None")

---- del pet dropdown 1 ----

eggsPage.Dropdown({
    Text = "Delete Pet",
    Callback = function(Value)
        kVars.delPetName1 = Value
    end,
    Options = allPetNamesList,
    Menu = {
        Information = function(self)
            eggsPage.Banner({
                Text = "Select Pet to delete."
            })
        end
    }
})

---- del pet dropdown 2 ----

eggsPage.Dropdown({
    Text = "Delete Pet",
    Callback = function(Value)
        kVars.delPetName2 = Value
    end,
    Options = allPetNamesList,
    Menu = {
        Information = function(self)
            eggsPage.Banner({
                Text = "Select Pet to delete."
            })
        end
    }
})

---- del pet dropdown 3 ----

eggsPage.Dropdown({
    Text = "Delete Pet",
    Callback = function(Value)
        kVars.delPetName3 = Value
    end,
    Options = allPetNamesList,
    Menu = {
        Information = function(self)
            eggsPage.Banner({
                Text = "Select Pet to delete."
            })
        end
    }
})

---- del pet dropdown 4 ----

eggsPage.Dropdown({
    Text = "Delete Pet",
    Callback = function(Value)
        kVars.delPetName4 = Value
    end,
    Options = allPetNamesList,
    Menu = {
        Information = function(self)
            eggsPage.Banner({
                Text = "Select Pet to delete."
            })
        end
    }
})

---- del pet dropdown 5

eggsPage.Dropdown({
    Text = "Delete Pet",
    Callback = function(Value)
        kVars.delPetName5 = Value
    end,
    Options = allPetNamesList,
    Menu = {
        Information = function(self)
            eggsPage.Banner({
                Text = "Select Pet to delete."
            })
        end
    }
})

---- del pet toggle ----
eggsPage.Toggle({
    Text = "Delete Pets",
    Callback = function(Value)
        kVars.delPetBool = Value
        if Value then
            delPetFunc()
        end
    end,
    Enabled = false
})
function delPetFunc()
    spawn(function()
        while kVars.delPetBool do
            wait()
            for i,v in pairs(game:GetService("Players").LocalPlayer.Pets.OwnedPets:GetChildren()) do
                local petNameNew = tostring(v.PetName.Value)
                local isEquip = v.IsEquip.Value
                if petNameNew == kVars.delPetName1 or petNameNew == kVars.delPetName2 or petNameNew == kVars.delPetName3 or petNameNew == kVars.delPetName4 or petNameNew == kVars.delPetName5 then
                    if isEquip == false then
                        local args = {
                            [1] = "Delete",
                            [2] = {
                                ["PetId"] = v.PetID.Value,
                                ["PetName"] = petNameNew
                            }
                        }
                        game:GetService("ReplicatedStorage").Modules.Events.PetHandler:InvokeServer(unpack(args))
                    end
                end
            end
        end
    end)
end


---------------- Teleports ----------------
---- Set Teleport Page ----
teleportPage = mainFrame.New({
    Title = "Teleports"
})

for i,v in pairs(TeleTable) do
    teleportPage.Button({
        Text = v['name'],
        Callback = function()
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v['cf']
        end,
        Menu = {
            Information = function(self)
                mainFrame.Banner({
                    Text = "Teleport to " .. v['name']
                })
            end
        }
    })
end


local antiAFK = game:GetService('Players').LocalPlayer.Idled:connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)


kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == "Happy Simulator 2" then
		table.clear(kVars)
        antiAFK:Disconnect()
		kVars.closeing:Disconnect()
		script:Destroy()
	end
end)