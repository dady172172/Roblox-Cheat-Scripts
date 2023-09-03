kVars = {}
kVars.mps = game:GetService("MarketplaceService")
kVars.pi = mps:GetProductInfo(game.PlaceId)
kVars.updateDate = pi.Updated
kVars.scriptUpdateDate = "2023-08-30T13:02:48.8270924Z"
kVars.players = game:GetService("Players")
kVars.lp = players.LocalPlayer
if kVars.scriptUpdateDate ~= kVars.updateDate then
    kVars.lp:Kick("Game has updated please wait for script to be updated, so we can insure your safety!")
end