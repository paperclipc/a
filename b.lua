local sTween = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Frame_2 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding_2 = Instance.new("UIPadding")

ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Frame.Position = UDim2.new(0.333820313, 0, 0.541003644, 0)
Frame.Size = UDim2.new(0, 203, 0, 161)

UICorner.Parent = Frame

Frame_2.Parent = Frame
Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame_2.Size = UDim2.new(0.975000024, 0, 0.949999988, 0)

UICorner_2.Parent = Frame_2

UIListLayout.Parent = Frame_2
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0.0500000007, 0)

UIPadding_2.Parent = Frame_2
UIPadding_2.PaddingLeft = UDim.new(0, 5)
UIPadding_2.PaddingRight = UDim.new(0, 5)
UIPadding_2.PaddingTop = UDim.new(0, 5)

function createToggle(parent, text, funcOn, funcOff)
	
	local Toggle = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local Button = Instance.new("TextButton")
	local UIPadding = Instance.new("UIPadding")
	local Decoration = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local UICorner_4 = Instance.new("UICorner")
	
	Toggle.Parent = parent
	Toggle.AnchorPoint = Vector2.new(0, 1)
	Toggle.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	Toggle.Position = UDim2.new(0, 0, 0.200345486, 0)
	Toggle.Size = UDim2.new(0, 60, 0, 30)

	TextLabel.Parent = Toggle
	TextLabel.AnchorPoint = Vector2.new(0, 1)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.Position = UDim2.new(1.18956351, 0, 0.985266387, 0)
	TextLabel.Size = UDim2.new(2, 0, 1, 0)
	TextLabel.Font = Enum.Font.GothamBlack
	TextLabel.Text = text
	TextLabel.TextColor3 = Color3.fromRGB(202, 202, 202)
	TextLabel.TextSize = 14.000
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	Button.Parent = Toggle
	Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Button.BackgroundTransparency = 1.000
	Button.Size = UDim2.new(1, 0, 1, 0)
	Button.ZIndex = 2
	Button.Font = Enum.Font.SourceSans
	Button.Text = ""
	Button.TextColor3 = Color3.fromRGB(0, 0, 0)
	Button.TextSize = 14.000

	UIPadding.Parent = Toggle
	UIPadding.PaddingBottom = UDim.new(0, 2)
	UIPadding.PaddingLeft = UDim.new(0, 2)
	UIPadding.PaddingRight = UDim.new(0, 2)
	UIPadding.PaddingTop = UDim.new(0, 2)

	Decoration.Parent = Toggle
	Decoration.AnchorPoint = Vector2.new(0, 0.5)
	Decoration.BackgroundColor3 = Color3.fromRGB(202, 202, 202)
	Decoration.Position = UDim2.new(0, 0, 0.5, 0)
	Decoration.Size = UDim2.new(1, 0, 1, 0)
	Decoration.SizeConstraint = Enum.SizeConstraint.RelativeYY

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = Decoration

	UICorner_4.CornerRadius = UDim.new(1, 0)
	UICorner_4.Parent = Toggle
	
	local on = false
	Button.MouseButton1Click:Connect(function()
		if on == true then
			on = false
			
			sTween:Create(Decoration, TweenInfo.new(0.5), {AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(202, 202, 202)}):Play()
			sTween:Create(Toggle, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
			
			funcOff()
		else
			on = true
			
			sTween:Create(Decoration, TweenInfo.new(0.5), {AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			sTween:Create(Toggle, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(109, 197, 100)}):Play()
			
			funcOn()
		end
	end)
end

createToggle(Frame_2, "AUTO COLLECT", function() _G.AutoCollect = true end, function() _G.AutoCollect = false end)
createToggle(Frame_2, "AUTO WASH", function() _G.AutoWash = true end, function() _G.AutoWash = false end)
createToggle(Frame_2, "AUTO UPGRADE", function() _G.AutoBuy = true end, function() _G.AutoBuy = false end)
createToggle(Frame_2, "AUTO PARKOUR", function() _G.AutoParkour = true end, function() _G.AutoParkour = false end)

function dragify(Frame)
	dragToggle = nil
	dragSpeed = .9 -- You can edit this.
	dragInput = nil
	dragStart = nil
	dragPos = nil

	function updateInput(input)
		Delta = input.Position - dragStart
		Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
		game:GetService("TweenService"):Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
	end

	Frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if (input.UserInputState == Enum.UserInputState.End) then
					dragToggle = false
				end
			end)
		end
	end)

	Frame.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if (input == dragInput and dragToggle) then
			updateInput(input)
		end
	end)
end

dragify(Frame)
