--// Anti Afk
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

--// Get Services
local sPlayer = game:GetService("Players")
local sRep = game:GetService("ReplicatedStorage")

--// Global
_G.AutoCollect = false
_G.AutoBuy = false
_G.AutoWash = false
_G.AutoParkour = false

--// Get Player/Character
local localPlayer = sPlayer.LocalPlayer
local playerGui = localPlayer.PlayerGui
local cashShop = playerGui:WaitForChild("Cash Shop")
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

--// Disable Popups
game:GetService("Lighting"):WaitForChild("Blur").Enabled = false
cashShop:WaitForChild("ImageLabel").Visible = false

--// Get Tycoon
function getTycoon()
    local tycoon
    for i,v in pairs(workspace.Tycoons:GetChildren()) do
        if v.Parts.BuildingBase.Sign.Main.SurfaceGui.TextLabel.Text:find(localPlayer.Name) then
            tycoon = v
        end
    end

    if not tycoon then
        local mag = math.huge
        for i,v in pairs(workspace.Tycoons:GetChildren()) do
            if (character.PrimaryPart.Position - v.Spawn.Position).Magnitude < mag then
                mag = (character.PrimaryPart.Position - v.Spawn.Position).Magnitude
                tycoon = v
            end
        end
    end
    
    return tycoon
end

--// Functions
function collectRats()
    for i,v in pairs(getTycoon().Rats:GetChildren()) do
        sRep.Knit.Services.TycoonService.RE.CollectRat:FireServer(tonumber(v.Name))
    end
end

function washRats()
    sRep.Knit.Services.TycoonService.RE.SellRats:FireServer()
end

function getMoney()
    local moneyLabel
    for i,v in pairs(playerGui.Headers.Frame:GetChildren()) do
        if v.TextLabel.Text ~= "Scrubbing Spree!" then
            moneyLabel = v.TextLabel
            break
        end
    end
    return tonumber(moneyLabel.Text:gsub(",", ""):sub(2, #moneyLabel.Text))
end

function getCost(cost)
    local aCost = cost:sub(2, #cost)
    local fCost
    
    if cost == "FREE!" then
        fCost = 0
    elseif aCost:match("K") or aCost:match("M") or aCost:match("B") then
        local tCost = tonumber(aCost:sub(1, #aCost-1))
        if aCost:match("K") then
            tCost = tCost * 1000
        elseif aCost:match("M") then
            tCost = tCost * 1000000
        elseif aCost:match("B") then
            tCost = tCost * 1000000000
        end
        fCost = tCost
    else
        fCost = tonumber(aCost)
    end
    
    return fCost
end

function checkPurchases()
    for i,v in pairs(getTycoon().Buttons:GetChildren()) do
        if v:FindFirstChild("Hitbox") and v.Hitbox.Transparency ~= 1 then
            local costLabel
            for i,v in pairs(v.Hitbox.BillboardGui.Frame:GetChildren()) do
                if v:IsA("TextLabel") and #v:GetChildren() > 0 then
                    costLabel = v
                end
            end
            
            if costLabel.Text:match("R%$") then
                continue
            end
            
            if getMoney() >= getCost(costLabel.Text) then
                firetouchinterest(character.PrimaryPart, v.Hitbox, 1)
                firetouchinterest(character.PrimaryPart, v.Hitbox, 0)
            end
        end
    end
end

--// Automation
getTycoon().Rats.ChildAdded:Connect(function(c)
    if _G.AutoCollect == true then
        collectRats()
    end
end)
spawn(function()
    while wait(1) do
        if _G.AutoBuy == true then
            checkPurchases()
        end
        if _G.AutoWash == true then
            washRats()
        end
        if _G.AutoParkour == true then
            local obby = workspace.Obby
            if obby.Sign.Forcefield.Ring.Transparency == 1 then
                firetouchinterest(character.PrimaryPart, obby.Button.Hitbox, 1)
                firetouchinterest(character.PrimaryPart, obby.Button.Hitbox, 0)
            end
        end
    end
end)
