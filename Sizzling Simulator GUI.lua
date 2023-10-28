--[[
Game : https://www.roblox.com/games/4572547530
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Sizzling Simulator GUI"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')

---- destroy old gui if exists ----
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
    wait(2)
end

---- antiAFK ----
kVars.connectAntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.vu:CaptureController()
    kVars.vu:ClickButton2(Vector2.new())
 end)

---- gui build ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local Window = library:CreateMain({
    projName = kVars.WindowName,
    Resizable = true,
    MinSize = UDim2.new(0,400,0,400),
    MaxSize = UDim2.new(0,750,0,500),
})

local pageMain = Window:CreateCategory("Main")
local sectionAutoAttack = pageMain:CreateSection("AutoAttack")
local sectionCollect = pageMain:CreateSection("Collect")

local pageBuy = Window:CreateCategory("Buy")
local sectionUpgrades = pageBuy:CreateSection("Auto Upgrades")
local sectionWeapons = pageBuy:CreateSection("Weapon")
local sectionForks = pageBuy:CreateSection("Fork")

local pageRebirth = Window:CreateCategory("Rebirth")
local sectionRebirth = pageRebirth:CreateSection("Rebirth")
local sectionRebirthShop = pageRebirth:CreateSection("Rebirth Shop")
local sectionRebirthMenus = pageRebirth:CreateSection("Rebirth Menus")

local pageEggs = Window:CreateCategory("Eggs/Crates")
local sectionEggs = pageEggs:CreateSection("Eggs/Pets")
local sectionDelPets = pageEggs:CreateSection("Delete Pets")
local sectionCrates = pageEggs:CreateSection("Crate/Hats")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")
local sectionLocations = pageTeleport:CreateSection("Locations")

local pageMenus = Window:CreateCategory("Menus")
local sectionMenus = pageMenus:CreateSection("Menus *Area may have to be loaded once")
local sectionCrafting = pageMenus:CreateSection("Crafting")

local pageCharacter = Window:CreateCategory("Character")
local sectionCharacter = pageCharacter:CreateSection("Options")

local pageMisc = Window:CreateCategory("Misc")
local sectionKeybinds = pageMisc:CreateSection("KeyBinds")
local sectionWorld = pageMisc:CreateSection("World Options")
local sectionMisc = pageMisc:CreateSection("Options")

local pageCredits = Window:CreateCategory("Credits")
local sectionCreditsKeath = pageCredits:CreateSection("Coded by : Keathunsar")
local sectionCreditsAlex = pageCredits:CreateSection("UI-Lib by : xTheAlex14")

--========== page main ==========----
---- section Auto Attack ----
kVars.animalData = require(game:GetService("ReplicatedStorage").ScriptData.AnimalData)
kVars.animalList = {}
for i,v in pairs(kVars.animalData) do
	table.insert(kVars.animalList,v.Title)
end
table.sort(kVars.animalList)
table.insert(kVars.animalList,1,"Closest Without Bosses")
table.insert(kVars.animalList,1,"Closest")

kVars.selectedAnimal = "Closest"
sectionAutoAttack:Create("DropDown", "Select closest or an animal name",function(value)
    kVars.selectedAnimal = value
end,{options = kVars.animalList, default = kVars.animalList[1], search = true})

kVars.boolWalkToTarget = false
sectionAutoAttack:Create("Toggle", "Walk to target", function(bool)
    kVars.boolWalkToTarget = bool
    
end,
{default = kVars.boolWalkToTarget}
)

kVars.boolAttack = false
sectionAutoAttack:Create("Toggle", "Attack", function(bool)
    kVars.boolAttack = bool
    if bool then fAttack() end    
end,
{default = kVars.boolAttack}
)

kVars.autoAttack = {}
kVars.autoAttack.last = math.huge
kVars.autoAttack.nearest = "nil"
kVars.autoAttack.id = 0
function fAttack()
    
    spawn(function()
        while kVars.boolAttack do
            wait()
            local a,b = pcall(function()
                for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                    if v:FindFirstChild('CharId') and v.HealthGui.Health.Amount.Text:sub(1,1) ~= "0" then
                        if kVars.selectedAnimal == "Closest" and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then 
                            local distance = (kVars.hrp.Position - v:FindFirstChildWhichIsA('Part').Position).magnitude
                            if distance < kVars.autoAttack.last then
                                kVars.autoAttack.last = distance
                                kVars.autoAttack.nearest = v
                                kVars.autoAttack.id = v.CharId.Value
                            end
                        elseif kVars.selectedAnimal == "Closest Without Bosses" then
                            if v.name ~= "Yeti" and v.name ~= "Big Bad Wolf" and v.name ~= "Fiery Dinosaur" then
                                local distance = (kVars.hrp.Position - v:FindFirstChildWhichIsA('Part').Position).magnitude
                                if distance < kVars.autoAttack.last then
                                    kVars.autoAttack.last = distance
                                    kVars.autoAttack.nearest = v
                                    kVars.autoAttack.id = v.CharId.Value
                                end
                            end
                        elseif v.Name == kVars.selectedAnimal then
                            kVars.autoAttack.nearest = v
                            kVars.autoAttack.id = v.CharId.Value					
                        end
                    end
                end
                kVars.autoAttack.last = math.huge
            end)
            if not a then
                print(a,b)
            end
        end
    end)
    spawn(function()
		while kVars.boolAttack do
			wait()
            pcall(function()
                local targetToAttackId = kVars.autoAttack.id
                local targetToAttack = kVars.autoAttack.nearest
                if targetToAttackId and targetToAttack and targetToAttack:FindFirstChild('HealthGui') then
                    if targetToAttack.HealthGui.Health.Amount.Text:sub(1,1) ~= "0" then
                        kVars.rs.RemoteEvent:FireServer("Animal Selected", targetToAttackId)
                        if kVars.boolWalkToTarget then
                            kVars.humanoid.WalkToPart = targetToAttack:FindFirstChildWhichIsA('Part')
                            kVars.humanoid.WalkToPoint = Vector3.new(0,0,0)
                        end
                        repeat
                            wait()
                            kVars.rs.RemoteEvent:FireServer("Animal Hit", targetToAttackId)
                        until not targetToAttack:FindFirstChild('HealthGui') or targetToAttack.HealthGui.Health.Amount.Text:sub(1,1) == "0" or not targetToAttack:FindFirstChild('Main') or kVars.boolAttack == false
                    end
                end
            end)
		end
	end)
end



---- section collect ----
kVars.boolMagnet = false
sectionCollect:Create("Toggle", "Magnet",function(bool)
    kVars.boolMagnet = bool
    if bool then
        fMagnet()
    end
end,{default = kVars.boolMagnet})

function fMagnet()
    spawn(function()
        while kVars.boolMagnet do
            wait()
            pcall(function()
                local amount = kVars.lp.PlayerGui.MainGui.SideMenu.Fork.Amount.Text
                local cAmount, mAmount = unpack(string.split(amount, "/"))
                if cAmount ~= mAmount then
                    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                        if string.find(v.Name:lower(), "meat") or string.find(v.Name:lower(), "item") and v.Name ~= "DropOffMeat" and v.Name ~= "ItemCapsules" then
                            for x,z in pairs(v:GetChildren()) do
                                if z.Name == "Part" and z:FindFirstChild("TouchInterest") then
                                    firetouchinterest(kVars.hrp, z, 0)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

kVars.boolDropOffMeat = false
sectionCollect:Create("Toggle", "Drop Off Meat",function(bool)
    kVars.boolDropOffMeat = bool
    if bool then
        fDropOffMeat()
    end
end,{default = kVars.boolDropOffMeat})

function fDropOffMeat()
    spawn(function()
        while kVars.boolDropOffMeat do
            wait()
            kVars.rs.RemoteEvent:FireServer('Drop Off Meat')
        end
    end)
end

kVars.boolGrillCoins = false
sectionCollect:Create("Toggle", "Grill Coins",function(bool)
    kVars.boolGrillCoins = bool
    if bool then
        fGrillCoins()
    end
end,{default = kVars.boolGrillCoins})

function fGrillCoins()
    spawn(function()
        while kVars.boolGrillCoins do
            wait()
            kVars.rs.RemoteEvent:FireServer('Collect Grill Coins')
        end
    end)
end

kVars.boolCoins = false
sectionCollect:Create("Toggle", "Coins",function(bool)
    kVars.boolCoins = bool
    if bool then
        fCoins()
    end
end,{default = kVars.boolCoins})

function fCoins()
    spawn(function()
        while kVars.boolCoins do
            pcall(function()
                for i,v in pairs(game:GetService("Workspace").Currency:GetChildren()) do
                    if v then
                        firetouchinterest(kVars.hrp, v.Part, 0)
                    end
                end
            end)
            wait(2)
        end
    end)
end

kVars.boolChests = false
sectionCollect:Create("Toggle", "Chests",function(bool)
    kVars.boolChests = bool
    if bool then
        fChests()
    end
end,{default = kVars.boolChests})

function fChests()
    spawn(function()
        while kVars.boolChests do
            pcall(function()
                for i,v in pairs(game:GetService("Workspace").Chests:getChildren()) do
                    if v.Bottom:FindFirstChild('Emitter') then
                        firetouchinterest(kVars.hrp, v.Bottom.Emitter, 0)
                        firetouchinterest(kVars.hrp, v.Bottom.Emitter, 1)
                    end
                end
            end)
            wait(3)
        end
    end)
end

--========== page buy ==========----
---- section upgrades ----
kVars.boolUnlockAreas = false
sectionUpgrades:Create("Toggle", "Unlock Areas",function(bool)
    kVars.boolUnlockAreas = bool
    if bool then
        fUnlockAreas()
    end
end,{default = kVars.boolUnlockAreas})

function fUnlockAreas()
    spawn(function()
        while kVars.boolUnlockAreas do
            wait(1)
            pcall(function()
                local v1, v2 = kVars.rs.RemoteFunction:InvokeServer("Get Area Data")
                local areaUnlock = {}
                table.foreach(v1,function(i,v) table.insert(areaUnlock, tostring(i)) end)
                local areaToUnlock = #areaUnlock
                if #areaUnlock ~= nil and #areaUnlock ~= 13 then
                    kVars.rs.RemoteEvent:FireServer("Purchase Area", #areaUnlock)
                end
            end)
        end
    end)
end

kVars.boolUpgradeGrills = false
sectionUpgrades:Create("Toggle", "Upgrade Grills",function(bool)
    kVars.boolUpgradeGrills = bool
    if bool then
        fUpgradeGrills()
    end
end,{default = kVars.boolUpgradeGrills})

function fUpgradeGrills()
    spawn(function()
        while kVars.boolUpgradeGrills do
            wait(1)
            pcall(function()
                local grillNum = 0
                for i,v in pairs(game:GetService("Workspace").DropOffMeat:getChildren()) do
                    local grillFrame = kVars.lp.PlayerGui.MainGui.GrillMenuFrame.GrillsContents.Contents.ScrollingFrame
                    if grillFrame:FindFirstChild('5') then
                        break
                    elseif grillFrame:FindFirstChild('4') then
                        grillNum = 1
                        break
                    elseif grillFrame:FindFirstChild('3') then
                        grillNum = 2
                        break
                    elseif grillFrame:FindFirstChild('2') then
                        grillNum = 3
                        break
                    elseif grillFrame:FindFirstChild('1') then
                        grillNum = 4
                        break
                    end
                end
                if grillNum ~= 0 then
                    for i=1,grillNum do
                        kVars.rs.RemoteEvent:FireServer("Buy +1 Grill")
                    end
                end
                for i=1,5 do
                    kVars.rs.RemoteEvent:FireServer("Upgrade Grill", i)
                end
            end)
        end
    end)
end

kVars.weaponData = {
[1] = {name = "$50 - Big Stick", id = 2, price = 50}, 
[2] = {name = "$100 - Boulder Club", id = 3, price = 100},
[3] = {name = "$300 - Wooden Sword", id = 4, price = 300},
[4] = {name = "$700 - Axe", id = 6, price = 700},
[5] = {name = "$1000 - Khopesh", id = 7, price = 1000},
[6] = {name = "$2000 - Machete", id = 8, price = 2000},
[7] = {name = "$5000 - Pirate Cutlass", id = 9, price = 5000},
[8] = {name = "$10000 - Lumber Axe", id = 10, price = 10000},
[9] = {name = "$13000 - Ice Axe", id = 11, price = 13000},
[10] = {name = "$25000 - Stop Sign Axe", id = 12, price = 25000},
[11] = {name = "$40000 - Saw Sword", id = 13, price = 40000},
[12] = {name = "$55000 - Swordbreaker", id = 14, price = 55000},
[13] = {name = "$75000 - Redcliff Axe", id = 15, price = 75000},
[14] = {name = "$100000 - Judge Hammer", id = 16, price = 100000},
[15] = {name = "$250000 - Inflatable Sword", id = 17, price = 250000},
[16] = {name = "$375000 - Skull Basher", id = 18, price = 375000},
[17] = {name = "$500000 - Skeleton Axe", id = 19, price = 500000},
[18] = {name = "$1000000 - Grim Axe", id = 20, price = 1000000},
[19] = {name = "$1500000 - Overseer Axe", id = 21, price = 1500000},
[20] = {name = "$4000000 - Overseer Sword", id = 22, price = 4000000},
[21] = {name = "$7500000 - Overseer Mace", id = 23, price = 7500000},
[22] = {name = "$10000000 - Ice Spiky Club", id = 24, price = 10000000},
[23] = {name = "$15000000 - Murder Knife", id = 25, price = 15000000},
[24] = {name = "$20000000 - Earth Sword", id = 26, price = 20000000},
[25] = {name = "$25000000 - Tides Sword", id = 27, price = 25000000},
[26] = {name = "$35000000 - Flames Sword", id = 28, price = 35000000},
[27] = {name = "$50000000 - Mega Mallet", id = 29, price = 50000000},
[28] = {name = "$80000000 - Glorious Sword", id = 30, price = 80000000},
[29] = {name = "$120000000 - Fang Dagger", id = 31, price = 120000000},
[30] = {name = "$150000000 - Luck Sword", id = 32, price = 150000000},
[31] = {name = "$200000000 - Pot O' Gold Sword", id = 33, price = 200000000},
[32] = {name = "$400000000 - Bombastic Sword", id = 34, price = 400000000},
[33] = {name = "$750000000 - 8-Bit Sword", id = 35, price = 750000000},
[34] = {name = "$1500000000 - Chartreuse Periastron", id = 36, price = 1500000000},
[35] = {name = "$5000000000 - Rainbow Periastron", id = 37, price = 5000000000},
[36] = {name = "$7500000000 - Ghostfire Dagger", id = 38, price = 7500000000},
[37] = {name = "$10000000000 - Golem's Hammer", id = 39, price = 10000000000},
[38] = {name = "$1e+14 - Dark Sword", id = 41, price = 1e+14},
[39] = {name = "$1e+17 - Ice Breaker", id = 42, price = 1e+17}
}

kVars.boolUpgradeWeapon = false
sectionUpgrades:Create("Toggle", "Upgrade Weapon",function(bool)
    kVars.boolUpgradeWeapon = bool
    if bool then
        fUpgradeWeapon()
    end
end,{default = kVars.boolUpgradeWeapon})

function fUpgradeWeapon()
    spawn(function()
        while kVars.boolUpgradeWeapon do
            wait(1)
            pcall(function()
                local pCoins, Gems = kVars.rs.RemoteFunction:InvokeServer("Get Currency");
				local WeaponInv, curWeaponId = kVars.rs.RemoteFunction:InvokeServer("Get Weapon Data")
				local wantToBuy = nil
				---- stops if you have the best weapon in game equiped
				if curWeaponId ~= 42 then
					---- set robux weapons ID equal to equivlent 
					if curWeaponId == 40 then curWeaponId = 3 end
					if curWeaponId == 5 then curWeaponId = 22 end
					---- get want to buyitems
					for i,v in pairs(kVars.weaponData) do
						if v.price then
							if v.price > pCoins and v.id > curWeaponId then
								if curWeaponId == 1 then
									wantToBuy = kVars.weaponData[1].id
									break
								end
								wantToBuy = kVars.weaponData[i-1].id
								if wantToBuy == 40 then wantToBuy = 39 end
								if wantToBuy == 5 then wantToBuy = 4 end
								break
							elseif i == #kVars.weaponData then
								wantToBuy = 42
							end
						end
					end
					if wantToBuy ~= nil and wantToBuy ~= curWeaponId then
						kVars.rs.RemoteEvent:FireServer("Buy Weapon", wantToBuy)
					end
				end
            end)
        end
    end)
end

kVars.forkData = {
[1] = {name = "$50 - Green Fork", id = 2, price = 50},
[2] = {name = "$150 - Blue Fork", id = 3, price = 150},
[3] = {name = "$250 - White Fork", id = 4, price = 250},
[4] = {name = "$500 - Yellow Fork", id = 5, price = 500},
[5] = {name = "$800 - Orange Fork", id = 6, price = 800},
[6] = {name = "$2000 - Red Fork", id = 7, price = 2000},
[7] = {name = "$5000 - Purple Fork", id = 8, price = 5000},
[8] = {name = "$10000 - Pink Fork", id = 9, price = 10000},
[9] = {name = "$20000 - Neon Blue Fork", id = 10, price = 20000},
[10] = {name = "$35000 - Neon Green Fork", id = 11, price = 35000},
[11] = {name = "$75000 - Neon Yellow Fork", id = 12, price = 75000},
[12] = {name = "$150000 - Neon Orange Fork", id = 13, price = 150000},
[13] = {name = "$250000 - Neon Red Fork", id = 14, price = 250000},
[14] = {name = "$400000 - Really Blue Fork", id = 15, price = 400000},
[15] = {name = "$750000 - Dark Fork", id = 16, price = 750000},
[16] = {name = "$1000000 - Forcefield Fork", id = 17, price = 1000000},
[17] = {name = "$1200000 - Love Fork", id = 18, price = 1200000},
[18] = {name = "$3000000 - Lucky Fork", id = 19, price = 3000000},
[19] = {name = "$6000000 - Bubbling Fork", id = 20, price = 6000000},
[20] = {name = "$12000000 - Forest Fork", id = 21, price = 12000000},
[21] = {name = "$18000000 - Ghost Fork", id = 22, price = 18000000},
[22] = {name = "$30000000 - Toxic Fork", id = 23, price = 30000000},
[23] = {name = "$45000000 - Flaming Fork", id = 24, price = 45000000},
[24] = {name = "$80000000 - Galaxy Fork", id = 25, price = 80000000},
[25] = {name = "$120000000 - Plasma Fork", id = 26, price = 120000000},
[26] = {name = "$200000000 - Electric Fork", id = 27, price = 200000000},
[27] = {name = "$300000000 - Shiny Fork", id = 28, price = 300000000},
[28] = {name = "$500000000 - Hot Fork", id = 29, price = 500000000} 
}

kVars.boolBestFork = false
sectionUpgrades:Create("Toggle", "Upgrade Fork",function(bool)
    kVars.boolBestFork = bool
    if bool then
        fBestFork()
    end
end,{default = kVars.boolBestFork})

function fBestFork()
    spawn(function()
        while kVars.boolBestFork do
            wait(1)
            pcall(function()
                local pCoins, Gems = kVars.rs.RemoteFunction:InvokeServer("Get Currency")
                local forkInv, curForkId = kVars.rs.RemoteFunction:InvokeServer("Get Fork Data")
                if curForkId ~= 30 then
                    local forkWantToBuy = nil
                    if curForkId ~= 29 then
                        for i,v in pairs(kVars.forkData) do
                            if v.price then
                                if v.price > pCoins and v.id > curForkId and v.id ~= 30  then
                                    forkWantToBuy = i-1
                                    break
                                elseif i == #kVars.forkData or i == 29 then
                                    forkWantToBuy = 29
                                end
                            end
                        end
                        if forkWantToBuy ~= nil and forkWantToBuy ~= curForkId then
                            kVars.rs.RemoteEvent:FireServer("Buy Fork", forkWantToBuy)
                        end
                    end
                end
            end)
        end
    end)
end

---- section weapons ----
kVars.weaponDropDown = {}
for i,v in pairs(kVars.weaponData) do
    table.insert(kVars.weaponDropDown,v.name)
end
kVars.selectedWeapon = kVars.weaponDropDown[1]
sectionWeapons:Create("DropDown", "Weapon Selection", function(value)
    kVars.selectedWeapon = value

end,{options = kVars.weaponDropDown, default = kVars.weaponDropDown[1], search = true}
)

sectionWeapons:Create("Button","Buy",function()
    for i,v in pairs(kVars.weaponData) do
		if kVars.selectedWeapon ~= nil then
			if v.name == kVars.selectedWeapon then
				kVars.rs.RemoteEvent:FireServer("Buy Weapon", v.id)
				break
			end
		end
	end	
end,{animated = true}
)

sectionWeapons:Create("Button","Buy Best",function()
    local pCoins, Gems = kVars.rs.RemoteFunction:InvokeServer("Get Currency");
    local WeaponInv, curWeaponId = kVars.rs.RemoteFunction:InvokeServer("Get Weapon Data")
    local wantToBuy = nil
    ---- stops if you have the best weapon in game equiped
    if curWeaponId ~= 42 then
        ---- set robux weapons ID equal to equivlent 
        if curWeaponId == 40 then curWeaponId = 3 end
        if curWeaponId == 5 then curWeaponId = 22 end
        ---- get want to buyitems
        for i,v in pairs(kVars.weaponData) do
            if v.price then
                if v.price > pCoins and v.id > curWeaponId then
                    if curWeaponId == 1 then
                        wantToBuy = kVars.weaponData[1].id
                        break
                    end
                    wantToBuy = kVars.weaponData[i-1].id
                    if wantToBuy == 40 then wantToBuy = 39 end
                    if wantToBuy == 5 then wantToBuy = 4 end
                    break
                elseif i == #kVars.weaponData then
                    wantToBuy = 42
                end
            end
        end
        if wantToBuy ~= nil and wantToBuy ~= curWeaponId then
            kVars.rs.RemoteEvent:FireServer("Buy Weapon", wantToBuy)
        end
    end
end,{animated = true,}
)

---- section fork ----
kVars.forkDropDown = {}
for i,v in ipairs(kVars.forkData) do
    table.insert(kVars.forkDropDown, v.name)
end
kVars.selectedFork = kVars.forkDropDown[1]
sectionForks:Create("DropDown","Select a fork", function(value)
    kVars.selectedFork = value
end,{options = kVars.forkDropDown, default = kVars.forkDropDown[1], search = true}
)

sectionForks:Create("Button", "Buy", function()
    for i,v in pairs(kVars.forkData) do
		if kVars.selectedFork ~= nil then
			if v.name == kVars.selectedFork then
				kVars.rs.RemoteEvent:FireServer("Buy Fork", v.id)
				break
			end
		end
	end
end,{animated = true}
)

sectionForks:Create("Button", "Buy Best", function()
    local pCoins, Gems = kVars.rs.RemoteFunction:InvokeServer("Get Currency")
	local forkInv, curForkId = kVars.rs.RemoteFunction:InvokeServer("Get Fork Data")
	local forkWantToBuy = nil
	if curForkId ~= 29 then
		for i,v in pairs(kVars.forkData) do
			if v.price then
				if v.price > pCoins and v.id > curForkId and v.id ~= 30  then
					forkWantToBuy = i-1
					break
				elseif i == #kVars.forkData or i == 29 then
					forkWantToBuy = 29
				end
			end
		end
		if forkWantToBuy ~= nil and forkWantToBuy ~= curForkId then
			kVars.rs.RemoteEvent:FireServer("Buy Fork", forkWantToBuy)
		end
	end
end,{animated = true}
)

--========== page rebirth ==========----
---- section rebirth ----
kVars.rebirthDropDown = {"x1","x3","x5"}
kVars.selectedRebirthMulti =  kVars.rebirthDropDown[1]
sectionRebirth:Create("DropDown", "Select rebirth multiplayer", function(value)
    kVars.selectedRebirthMulti = value
end,{options = kVars.rebirthDropDown, default = kVars.selectedRebirthMulti, search = true})

kVars.boolRebirth = false
sectionRebirth:Create("Toggle", "Rebirth", function(bool)
    kVars.boolRebirth = bool
    if bool then
        fRebirth()
    end
end,{default = kVars.boolRebirth})

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            pcall(function()
                local pCoins, Gems = kVars.rs.RemoteFunction:InvokeServer("Get Currency")
                local getRebirths = kVars.rs.RemoteFunction:InvokeServer("Get Rebirths")
                local cost = nil
                if kVars.selectedRebirthMulti == "x5" then
                    cost = math.floor(getRebirths ^ 0.9) * 1000000000000000 + 1E+17
                elseif kVars.selectedRebirthMulti == "x3" then
                    cost = math.floor(getRebirths ^ 0.9) * 5000000000000 + 500000000000000
                elseif kVars.selectedRebirthMulti == "x1" then
                    cost = math.floor(getRebirths ^ 0.9) * 1000000000 + 1000000000
                end
                if pCoins >= cost then
                    local num = string.match(kVars.selectedRebirthMulti, "%d")
                    kVars.rs.RemoteEvent:FireServer('Rebirth',tonumber(num))
                end
            end)
        end
    end)
end

kVars.boolTpAreaRebirth = false
sectionRebirth:Create("Toggle", "Teleport to area",function(bool)
    kVars.boolTpAreaRebirth = bool
    if bool then
        fTpAreaRebirth()
    end
end,{default = kVars.boolTpAreaRebirth})

function fTpAreaRebirth()
    spawn(function()
        while kVars.boolTpAreaRebirth do
            wait(1)
            if kVars.boolTpAreaRebirth == false then break end
            local list = {
                [1] = (kVars.hrp.Position - Vector3.new(-11, 6, 58)).magnitude,
                [2] = (kVars.hrp.Position - Vector3.new(299, 6, 58)).magnitude,
                [3] = (kVars.hrp.Position - Vector3.new(576, 6, 58)).magnitude,
                [4] = (kVars.hrp.Position - Vector3.new(854, 6, 58)).magnitude,
                [5] = (kVars.hrp.Position - Vector3.new(1133, 6, 58)).magnitude,
                [6] = (kVars.hrp.Position - Vector3.new(1411, 6, 58)).magnitude,
                [7] = (kVars.hrp.Position - Vector3.new(1689, 6, 58)).magnitude,
                [8] = (kVars.hrp.Position - Vector3.new(1966, 6, 58)).magnitude,
                [9] = (kVars.hrp.Position - Vector3.new(2246, 6, 58)).magnitude,
                [10] = (kVars.hrp.Position - Vector3.new(2629, 6, 44)).magnitude,
                [11] = (kVars.hrp.Position - Vector3.new(-1421, 6, 11)).magnitude,
                [12] = (kVars.hrp.Position - Vector3.new(-426, 6, 751)).magnitude
                }
			local WeaponInv, curWeaponId = game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Get Weapon Data")
            if curWeaponId == 40 then curWeaponId = 3 end
            if curWeaponId == 5 then curWeaponId = 22 end
            local v1, v2 = kVars.rs.RemoteFunction:InvokeServer("Get Area Data")
            local tmptable = {}
            table.foreach(v1,function(i,v) table.insert(tmptable,v) end)
            local unlockedArea = #tmptable - 1
            if curWeaponId < 7 then
                if unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId <= 11 and curWeaponId >= 8 then
                if unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId <= 16 and curWeaponId  >= 12 then
                if unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId <= 19 and curWeaponId >= 17 then
                if unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId <= 21 and curWeaponId >= 20 then
                if unlockedArea == 5 and list[5] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1133, 6, 58)
                    wait()
                elseif unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId <= 24 and curWeaponId >= 22 then
                if unlockedArea == 6 and list[6] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1411, 6, 58)
                    wait()
                elseif unlockedArea == 5 and list[5] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1133, 6, 58)
                    wait()
                elseif unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId <= 26 and curWeaponId >= 25 then
                if unlockedArea == 7 and list[7] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1689, 6, 58)
                    wait()
                elseif unlockedArea == 6 and list[6] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1411, 6, 58)
                    wait()
                elseif unlockedArea == 5 and list[5] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1133, 6, 58)
                    wait()
                elseif unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif  curWeaponId <= 29 and curWeaponId >= 27 then
                if unlockedArea == 8 and list[8] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1966, 6, 58)
                    wait()
                elseif unlockedArea == 7 and list[7] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1689, 6, 58)
                    wait()
                elseif unlockedArea == 6 and list[6] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1411, 6, 58)
                    wait()
                elseif unlockedArea == 5 and list[5] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1133, 6, 58)
                    wait()
                elseif unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId <= 34 and curWeaponId >= 30 then
                if unlockedArea == 9 and list[9] > 5 then
                    kVars.hrp.CFrame = CFrame.new(2246, 6, 58)
                    wait()
                elseif unlockedArea == 8 and list[8] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1966, 6, 58)
                    wait()
                elseif unlockedArea == 7 and list[7] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1689, 6, 58)
                    wait()
                elseif unlockedArea == 6 and list[6] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1411, 6, 58)
                    wait()
                elseif unlockedArea == 5 and list[5] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1133, 6, 58)
                    wait()
                elseif unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId <= 39 and curWeaponId >= 35 then
                if unlockedArea == 10 and list[10] > 5 then
                    kVars.hrp.CFrame = CFrame.new(2629, 6, 44)
                    wait()
                elseif unlockedArea == 9 and list[9] > 5 then
                    kVars.hrp.CFrame = CFrame.new(2246, 6, 58)
                    wait()
                elseif unlockedArea == 8 and list[8] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1966, 6, 58)
                    wait()
                elseif unlockedArea == 7 and list[7] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1689, 6, 58)
                    wait()
                elseif unlockedArea == 6 and list[6] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1411, 6, 58)
                    wait()
                elseif unlockedArea == 5 and list[5] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1133, 6, 58)
                    wait()
                elseif unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId == 41 then
                if unlockedArea == 11 and list[11] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-1421, 6, 11)
                    wait()
                elseif unlockedArea == 10 and list[10] > 5 then
                    kVars.hrp.CFrame = CFrame.new(2629, 6, 44)
                    wait()
                elseif unlockedArea == 9 and list[9] > 5 then
                    kVars.hrp.CFrame = CFrame.new(2246, 6, 58)
                    wait()
                elseif unlockedArea == 8 and list[8] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1966, 6, 58)
                    wait()
                elseif unlockedArea == 7 and list[7] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1689, 6, 58)
                    wait()
                elseif unlockedArea == 6 and list[6] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1411, 6, 58)
                    wait()
                elseif unlockedArea == 5 and list[5] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1133, 6, 58)
                    wait()
                elseif unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            elseif curWeaponId == 42 then
                if unlockedArea == 12 and list[12] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-426, 6, 751)
                    wait()
                elseif unlockedArea == 11 and list[11] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-1421, 6, 11)
                    wait()
                elseif unlockedArea == 10 and list[10] > 5 then
                    kVars.hrp.CFrame = CFrame.new(2629, 6, 44)
                    wait()
                elseif unlockedArea == 9 and list[9] > 5 then
                    kVars.hrp.CFrame = CFrame.new(2246, 6, 58)
                    wait()
                elseif unlockedArea == 8 and list[8] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1966, 6, 58)
                    wait()
                elseif unlockedArea == 7 and list[7] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1689, 6, 58)
                    wait()
                elseif unlockedArea == 6 and list[6] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1411, 6, 58)
                    wait()
                elseif unlockedArea == 5 and list[5] > 5 then
                    kVars.hrp.CFrame = CFrame.new(1133, 6, 58)
                    wait()
                elseif unlockedArea == 4 and list[4] > 5 then
                    kVars.hrp.CFrame = CFrame.new(854, 6, 58)
                    wait()
                elseif unlockedArea == 3 and list[3] > 5 then
                    kVars.hrp.CFrame = CFrame.new(576, 6, 58)
                    wait()
                elseif unlockedArea == 2 and list[2] > 5 then
                    kVars.hrp.CFrame = CFrame.new(299, 6, 58)
                    wait()
                elseif unlockedArea == 1 and list[1] > 5 then
                    kVars.hrp.CFrame = CFrame.new(-11, 6, 58)
                    wait()
                end
            end
        end
    end)
end

---- section rebirth shop ----
kVars.boolRebirthCoinMultiplier = false
sectionRebirthShop:Create("Toggle", "Buy Coin Multiplier",function(bool)
    kVars.boolRebirthCoinMultiplier = bool
    if bool then
        fRebirthCoinMultiplier()
    end
end,{default = kVars.boolRebirthCoinMultiplier})

function fRebirthCoinMultiplier()
    spawn(function()
        while kVars.boolRebirthCoinMultiplier do
            wait(1)
            kVars.rs.RemoteEvent:FireServer("Purchase Rebirth Shop", "Coins")
        end
    end)
end

kVars.boolRebirthXPMultiplier = false
sectionRebirthShop:Create("Toggle", "Buy XP Multiplier",function(bool)
    kVars.boolRebirthXPMultiplier = bool
    if bool then
        fRebirthXPMultiplier()
    end
end,{default = kVars.boolRebirthXPMultiplier})

function fRebirthXPMultiplier()
    spawn(function()
        while kVars.boolRebirthXPMultiplier do
            wait(1)
            kVars.rs.RemoteEvent:FireServer("Purchase Rebirth Shop", "XP")
        end
    end)
end

kVars.boolRebirthPetLevel = false
sectionRebirthShop:Create("Toggle", "Buy Pet Start Level",function(bool)
    kVars.boolRebirthPetLevel = bool
    if bool then
        fRebirthPetLevel()
    end
end,{default = kVars.boolRebirthPetLevel})

function fRebirthPetLevel()
    spawn(function()
        while kVars.boolRebirthPetLevel do
            wait(1)
            kVars.rs.RemoteEvent:FireServer("Purchase Rebirth Shop", "PetLevel")
        end
    end)
end

---- section rebirth menus ----
sectionRebirthMenus:Create("Button", "x1", function()
    if game:GetService("Workspace"):FindFirstChild('RebirthButton') then
		firetouchinterest(kVars.hrp, game:GetService("Workspace").RebirthButton.TouchPart, 0)
	end
end,{animated = true})

sectionRebirthMenus:Create("Button", "x3", function()
    firetouchinterest(kVars.hrp, game:GetService("Workspace").Rebirth3Button.TouchPart, 0)
end,{animated = true})

sectionRebirthMenus:Create("Button", "x5", function()
    firetouchinterest(kVars.hrp, game:GetService("Workspace").Rebirth5Button.TouchPart, 0)
end,{animated = true})

--========== page eggs/crates ==========----
---- section eggs/pets ----
kVars.eggData = {
    [1] = {name = "$100 - Basic Egg", id = 1 },
    [2] = {name = "$1500 - Snack Egg", id = 2 },
    [3] = {name = "$10000 - Toy Egg", id = 3 },
    [4] = {name = "$50000 - Jungle Egg", id = 4},
    [5] = {name = "$150000 - Rare Egg", id = 5},
    [6] = {name = "$750000 - Cactus Egg", id = 6},
    [7] = {name = "$2000000 - Watermelon Egg", id = 7},
    [8] = {name = "$5000000 - Vampire Egg", id = 8},
    [9] = {name = "$20000000 - Shark Egg", id = 9},
    [10] = {name = "$75000000 - Magma Egg", id = 10},
    [11] = {name = "$1e+14 - Black Forest Egg", id = 19},
    [12] = {name = "$1e+16 - Snowman Egg", id = 21 }
}
kVars.eggNames = {}
table.foreach(kVars.eggData,function(i,v) table.insert(kVars.eggNames,v.name) end)
kVars.selectedEgg = 1
sectionEggs:Create("DropDown", "Select and egg to open", function(value)
    table.foreach(kVars.eggData,function(i,v) if v.name==value then kVars.selectedEgg = v.id end end)
end,{options = kVars.eggNames, default = kVars.eggNames[1][name], search = true})

kVars.bool3Egg = false
sectionEggs:Create("Toggle", "x3 *Requires Gamepass",function(bool)
    kVars.bool3Egg = bool
end,{default = kVars.bool3Egg})

kVars.boolOpenEgg = false
sectionEggs:Create("Toggle", "Open Egg",function(bool)
    kVars.boolOpenEgg = bool
    if bool then
        fOpenEgg()
    end
end,{default = kVars.boolOpenEgg})

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            if kVars.bool3Egg then
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase Three Eggs",kVars.selectedEgg)
            else
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase One Egg",kVars.selectedEgg)
            end
        end
    end)
end

---- section delete pets ----
kVars.petNames = {}
table.foreach(game:GetService("ReplicatedStorage").InstanceData.Pets:getChildren(),function(i,v) table.insert(kVars.petNames,v.name) end)
table.sort(kVars.petNames)
table.insert(kVars.petNames,1,"None")


for i=1,5 do
    kVars["selectionPetDel"..tostring(i)] = kVars.petNames[1]
    sectionDelPets:Create("DropDown", "Select Pet to delete", function(value)
        kVars["selectionPetDel"..tostring(i)] = value
    end,{options = kVars.petNames, default = kVars.petNames[1], search = true})
end

kVars.boolPetDel = false
sectionDelPets:Create("Toggle", "Delete By Name !*Carful*!",function(bool)
    kVars.boolPetDel = bool
    if bool then
        fPetDel()
    end
end,{default = kVars.boolPetDel})

function fPetDel()
    spawn(function()
        while kVars.boolPetDel do
            wait()
            for i,v in pairs(kVars.lp.PlayerGui.MainGui.InventoryFrame.Contents.ScrollingFrame:GetChildren()) do
				if v:FindFirstChild('Title') then
					local name = v.Title.Text
					if (name == kVars.selectionPetDel1 and kVars.selectionPetDel1 ~= "None") or (name == kVars.selectionPetDel2 and kVars.selectionPetDel2 ~= "None") or (name == kVars.selectionPetDel3 and kVars.selectionPetDel3 ~= "None") or (name == kVars.selectionPetDel4 and kVars.selectionPetDel4 ~= "None") or (name == kVars.selectionPetDel5 and kVars.selectionPetDel5 ~= "None") then
						kVars.rs.RemoteEvent:FireServer("Delete Pet", v.Name:sub(4))
					end
				end
			end
        end
    end)
end

---- section crate/hats ----
kVars.crateData = {
    [1] = {name = "$250 - Basic Crate", id = 11 },
    [2] = {name = "$2000 - Snack Crate", id = 12 },
    [3] = {name = "$15000 - Toy Crate", id = 13 },
    [4] = {name = "$200000 - Rare Crate", id = 14 },
    [5] = {name = "$1000000 - Desert Crate", id = 15 },
    [6] = {name = "$5000000 - Graveyard Crate", id = 16 },
    [7] = {name = "$15000000 - Beach Crate", id = 17 },
    [8] = {name = "$50000000 - Magma Crate", id = 18 },
    [9] = {name = "$1.5e+14 - Black Forest Crate", id = 20 },
    [10] = {name = "Gem750 - Winter Crate", id = 22 }
}
kVars.crateNames = {}
table.foreach(kVars.crateData,function(i,v) table.insert(kVars.crateNames,v.name) end)

kVars.selectedCrate = kVars.crateNames[1].name
sectionCrates:Create("DropDown", "Select a crate to open", function(value)
    table.foreach(kVars.crateData,function(i,v) if v.name == value then kVars.selectedCrate = v.id end end)
end,{options = kVars.crateNames, default = kVars.crateNames[1], search = true})

kVars.bool3Crate = false
sectionCrates:Create("Toggle", "x3 *Requires Gamepass",function(bool)
    kVars.bool3Crate = bool
end,{default = kVars.bool3Crate})

kVars.boolOpenCrate = false
sectionCrates:Create("Toggle", "Open Crate",function(bool)
    kVars.boolOpenCrate = bool
    if bool then
        fOpenCrate()
    end
end,{default = kVars.boolOpenCrate})

function fOpenCrate()
    spawn(function()
        while kVars.boolOpenCrate do
            wait()
            if kVars.bool3Crate then
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase Three Eggs",kVars.selectedCrate)
            else
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase One Egg",kVars.selectedCrate)
            end
        end
    end)
end

--========== page teleport ==========----
---- section teleport to player ----
kVars.SelectedTPToPlayer = kVars.lp.name
sectionTPToPlayer:Create("TextBox", "Username :", function(value)
    kVars.SelectedTPToPlayer = value
end,{text = "Enter Users Name"})

sectionTPToPlayer:Create("Button", "Teleport To Player", function()
    for i,v in pairs(game.Players:GetPlayers()) do
        if kVars.SelectedTPToPlayer ~= nil and kVars.SelectedTPToPlayer ~= kVars.lp.name then
            if string.find(string.lower(v.DisplayName), string.lower(kVars.SelectedTPToPlayer)) then
                kVars.hrp.CFrame = v.Character.HumanoidRootPart.CFrame                
            end
        end
    end
end,{animated = true})

---- section locations ----
kVars.Locations = {
	[1] = {name = "Area1 - Spawn", cf = CFrame.new(-60, 5, 35)},
	[2] = {name = "Area2 - Duck", cf = CFrame.new(248, 5, 35)},
	[3] = {name = "Area3 - Cow", cf = CFrame.new(516, 5, 35)},
	[4] = {name = "Area4 - Turkey", cf = CFrame.new(794, 5, 35)},
	[5] = {name = "Area5 - Pig", cf = CFrame.new(1069, 5, 35)},
	[6] = {name = "Area6 - WildWest", cf = CFrame.new(1339, 5, 35)},
	[7] = {name = "Area7 - GrassLand", cf = CFrame.new(1620, 5, 35)},
	[8] = {name = "Area8 - DarkForest", cf = CFrame.new(1898, 5, 35)},
	[9] = {name = "Area9 - Moose", cf = CFrame.new(2177, 5, 35)},
	[10] = {name = "Area10 - Prehistoric", cf = CFrame.new(2460, 5, 35)},
	[11] = {name = "Area11 - BlackForest", cf = CFrame.new(-1389, 5, -19)},
	[12] = {name = "Area12 - WinterForest", cf = CFrame.new(-422, 5, 676)},
	[13] = {name = "BossBattle", cf = CFrame.new(366, 5, 882)},
	[14] = {name = "VIP", cf = CFrame.new(-151, 5, -180)}
} 
for i,v in pairs(kVars.Locations) do
    sectionLocations:Create("Button", v.name, function()
        kVars.hrp.CFrame = v.cf
    end,{animated = true})
end




--========== page menus ==========----
---- section menus ----
function fireTouch(part)
	if kVars.lp.Character:FindFirstChild('RightFoot') then
		firetouchinterest(kVars.hrp, part, 0)
		wait(.5)
		firetouchinterest(kVars.hrp, part, 1)
	end
end

sectionMenus:Create("Button", "Grills Upgrade", function()
    kVars.lp.PlayerGui.MainGui.GrillMenuFrame:tsTweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end,{animated = true})

sectionMenus:Create("Button", "Rebirth Shop", function()
    game:GetService("Players").LocalPlayer.PlayerGui.MainGui.RebirthShopFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end,{animated = true})

sectionMenus:Create("Button", "Hats Upgrade", function()
    game:GetService("Players").LocalPlayer.PlayerGui.MainGui.UpgradeFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end,{animated = true})

sectionMenus:Create("Button", "Potions", function()
    if game:GetService("Workspace"):FindFirstChild("Pet Scientist Touch") then
        fireTouch(game:GetService("Workspace")["Pet Scientist Touch"].TouchPart)
    end
end,{animated = true})

sectionCrafting:Create("Button", "Julia [Zone 6]", function()
    if game:GetService("Workspace"):FindFirstChild("Julia Touch") then
		fireTouch(game:GetService("Workspace")["Julia Touch"].TouchPart)
	end
end,{animated = true})

sectionCrafting:Create("Button", "Ancient Dragon [Zone 10]", function()
    if game:GetService("Workspace"):FindFirstChild("Ancient Dragon Touch") then
		fireTouch(game:GetService("Workspace")["Ancient Dragon Touch"].TouchPart)
	end
end,{animated = true})

sectionCrafting:Create("Button", "Henry [Zone 11]", function()
    if game:GetService("Workspace"):FindFirstChild("Henry Touch") then
		fireTouch(game:GetService("Workspace")["Henry Touch"].TouchPart)
	end
end,{animated = true})

sectionCrafting:Create("Button", "Trevor [Zone 12]", function()
    if game:GetService("Workspace"):FindFirstChild("Trevor Touch") then
		fireTouch(game:GetService("Workspace")["Trevor Touch"].TouchPart)
	end
end,{animated = true})

sectionCrafting:Create("Button", "Steven [VIP]", function()
    if game:GetService("Workspace"):FindFirstChild("Steven Touch") then
		fireTouch(game:GetService("Workspace")["Steven Touch"].TouchPart)
	end
end,{animated = true})

--========== page character ==========----
---- section options ----
kVars.walkSpeed = kVars.humanoid.WalkSpeed
sectionCharacter:Create("Slider", "Walk Speed", function(value)
    kVars.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.humanoid.WalkSpeed, precise = false, changablevalue = true})

kVars.jumpPower = kVars.humanoid.JumpPower
sectionCharacter:Create("Slider", "Jump Power", function(value)
    kVars.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 50, max = 500, default = kVars.humanoid.JumpPower, precise = false, changablevalue = true})


kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpPower = kVars.jumpPower
end)

kVars.boolInfJump = false
sectionCharacter:Create("Toggle", "Inf Jump",function(bool)
    kVars.boolInfJump = bool
end,{default = kVars.boolInfJump})

kVars.connectJumpRequest = game:GetService("UserInputService").JumpRequest:Connect(function()
	if kVars.boolInfJump then
		kVars.humanoid:ChangeState("Jumping")
	end
end)


--========== page misc ==========----
---- section keybinds ----
kVars.OpenCloseMenuKey = Enum.KeyCode.F5
sectionKeybinds:Create("KeyBind", "Open Close Menu", function(key)
    kVars.OpenCloseMenuKey = key
end,{default = kVars.OpenCloseMenuKey})


kVars.connectInputBegan = kVars.uis.InputBegan:Connect(function(key)
    if key.UserInputType == Enum.UserInputType.Keyboard and key.KeyCode == kVars.OpenCloseMenuKey then
        if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled then
            game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled = false
        else
            game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled = true
        end
    end
end)


---- section world ----
sectionWorld:Create("Toggle", "Always Day", function(bool)
    kVars.boolAlwaysDay = bool
end,{default = kVars.boolAlwaysDay})


local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = function(self, ...)
    local method = getnamecallmethod()
    if self == game.Lighting and method == "SetMinutesAfterMidnight" and kVars.boolAlwaysDay then
        game.Lighting.TimeOfDay = "12:00:00"
        return
    end
    return old(self, ...)
end
setreadonly(mt, true)

if game.Lighting.FogStart < 100 then
    kVars.boolFog = true
else
    kVars.boolFog = false
end
sectionWorld:Create("Toggle", "Fog",function(bool)
    kVars.boolFog = bool
    if bool then
        game.Lighting.FogStart = 0
    else
        game.Lighting.FogStart = math.huge
    end
end,{default = kVars.boolFog})

sectionWorld:Create("Toggle", "Sun Rays",function(bool)
    game:GetService("Lighting").SunRays.Enabled = bool
end,{default = game:GetService("Lighting").SunRays.Enabled})

sectionWorld:Create("Toggle", "Blur",function(bool)
    game:GetService("Lighting").Blur.Enabled = bool
end,{default = game:GetService("Lighting").Blur.Enabled})

sectionWorld:Create("Toggle", "Bloom",function(bool)
    game:GetService("Lighting").Bloom.Enabled = bool
end,{default = game:GetService("Lighting").Bloom.Enabled})

---- sections options ----
sectionMisc:Create("Toggle", "Egg Reveal Frame",function(bool)
    game:GetService("Players").LocalPlayer.PlayerGui.MainGui.EggRevealFrame.Visible = bool
end,{default = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.EggRevealFrame.Visible})

kVars.boolServerChatSpam = true
sectionMisc:Create("Toggle", "Server Chat Spam",function(bool)
    kVars.boolServerChatSpam = bool
end,{default = kVars.boolServerChatSpam})

kVars.connectServerChatSpam = kVars.lp.PlayerGui.Chat.Frame.ChatChannelParentFrame.Frame_MessageLogDisplay.Scroller.ChildAdded:Connect(function()
    if kVars.boolServerChatSpam == false then
        wait(.1)
        local filterList = {"Hint:", "Like the game?"}
        for i,v in pairs(game:GetService("Players").keathunsar.PlayerGui.Chat.Frame.ChatChannelParentFrame.Frame_MessageLogDisplay.Scroller:GetChildren()) do
            if v.name == "Frame" and v:FindFirstChild("TextLabel") then
                for b,g in pairs(filterList) do
                    if v:FindFirstChild("TextLabel") and string.find(v.TextLabel.Text, g) then
                        v:Destroy()
                    end
                end
            end
        end
    end
end)

sectionMisc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

kVars.Esp = {}
kVars.boolEsp = false
sectionMisc:Create("Toggle", "Player ESP",function(bool)
    kVars.boolEsp = bool
    if not bool then
        for i,v in pairs(game.Players:GetPlayers()) do
            if kVars.Esp[v] then
                kVars.Esp[v].Drawing:Remove()
            end
        end
        kVars.Esp = {}
    else
        fEsp()
    end
end,{default = kVars.boolEsp})

kVars.plrRemovingConnect = game:GetService("Players").PlayerRemoving:Connect(function(player)
    if kVars.Esp[player] then
        kVars.Esp[player].Drawing:Remove()
    end
end)

function fEsp()
    spawn(function()
        while kVars.boolEsp do
            task.wait()
            pcall(function()
                for i,v in pairs(game.Players:GetPlayers()) do
                    if kVars.boolEsp == false then break end
                    if kVars.lp.name ~= v.name and kVars.boolEsp then
                        if not kVars.Esp[v] then
                            kVars.Esp[v] = {}
                            kVars.Esp[v].Drawing = Drawing.new("Text")
                            kVars.Esp[v].Drawing.Visible = false
                            kVars.Esp[v].Drawing.Size = 16
                            kVars.Esp[v].Drawing.Color = Color3.fromRGB(0, 255, 60)
                            kVars.Esp[v].Drawing.Transparency = 1
                            kVars.Esp[v].Drawing.ZIndex = 1
                            kVars.Esp[v].Drawing.Center = true
                            kVars.Esp[v].Drawing.Font = 3
                            kVars.Esp[v].Drawing.Outline = true
                            kVars.Esp[v].Drawing.OutlineColor = Color3.fromRGB(0,0,0)
                            kVars.Esp[v].Drawing.Text = v.name
                        end
                        if v.Character:FindFirstChild("Head") then
                            local vector, onScreen = game.Workspace.CurrentCamera:WorldToScreenPoint(game.Players[v.name].Character.Head.Position)
                            if onScreen then
                                kVars.Esp[v].Drawing.Visible = true
                                kVars.Esp[v].Drawing.Position = Vector2.new(vector.x, vector.y)
                            else
                                kVars.Esp[v].Drawing.Visible = false
                            end
                        end
                    end
                end
            end)
        end
    end)
end

sectionMisc:Create("Button", "Delete All Pets In World *Only Graphical", function()
    for i,v in pairs(game:GetService('Workspace'):GetChildren()) do
        if v:FindFirstChild("PetId") then
            v:Destroy()
        end
    end
end,{animated = true})

--========== page credits ==========----
---- keaths ----
sectionCreditsKeath:Create("Button", "https://github.com/dady172172/Roblox-Cheats", function()
    setclipboard('https://github.com/dady172172/Roblox-Cheats')
end,{animated = true})

sectionCreditsKeath:Create("Button", "https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
end,{animated = true})

---- alex ----
sectionCreditsAlex:Create("Button", "https://teppyboy.github.io/", function()
    setclipboard('https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/main.html')
end,{animated = true})

----========== set window size after load ==========----
game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Motherframe.Size = UDim2.new(0, 495, 0, 400)

--========== delete script if re-injecting ==========----

kVars.cR = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.name == kVars.WindowName then
        for i,v in pairs(kVars) do
            if type(v) == "boolean" then
                kVars[i] = false
            end
        end
        for i,v in pairs(game.Players:GetPlayers()) do
            if kVars.Esp[v] then
                kVars.Esp[v].Drawing:Remove()
            end
        end
        kVars.Esp = {}
        kVars.connectAntiAfk:Disconnect()
        kVars.connectInputBegan:Disconnect()
        kVars.connectJumpRequest:Disconnect()
        kVars.plrRemovingConnect:Disconnect()
        kVars.connectServerChatSpam:Disconnect()
        kVars.cR:Disconnect()
        wait(1)
        script:Destroy()
    end
end)

