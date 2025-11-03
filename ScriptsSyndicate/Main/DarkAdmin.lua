--    ____  ___    ____  __ __ ___    ____  __  ________   __
--   / __ \/   |  / __ \/ //_//   |  / __ \/  |/  /  _/ | / /
--  / / / / /| | / /_/ / ,<  / /| | / / / / /|_/ // //  |/ / 
-- / /_/ / ___ |/ _, _/ /| |/ ___ |/ /_/ / /  / // // /|  /  
--/_____/_/  |_/_/ |_/_/ |_/_/  |_/_____/_/  /_/___/_/ |_/                        
-- 𝘾𝙧𝙚𝙖𝙩𝙤𝙧 𝙗𝙮
-- __   __   _         _ _       __  __
-- \ \ / /__| |___  __(_) |_ _  _\ \/ /
--  \ V / -_) / _ \/ _| |  _| || |>  < 
--   \_/\___|_\___/\__|_|\__|\_, /_/\_\
--                           |__/      

local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/IceMinisterq/Notification-Library/Main/Library.lua"))()
local InsertService = game:GetService("InsertService")
local StarterGui = game:GetService("StarterGui")
local CommandSystem = {
	commands = {}
}

function CommandSystem:AddCmd(data)
	local command = {
		Title = data.Title,
		Alias = data.Alias or {},
		Callback = data.Callback or function() end
	}
	table.insert(self.commands, command)
end

function CommandSystem:GetMatchingCommands(text)
	if text == "" then
		return self.commands
	end
	
	local exactMatches = {}
	local partialMatches = {}
	local lowerText = text:lower()
	
	for _, cmd in ipairs(self.commands) do
		local titleLower = cmd.Title:lower()
		local addedToExact = false
		
		if titleLower:sub(1, #lowerText) == lowerText then
			table.insert(exactMatches, cmd)
			addedToExact = true
		end
		
		if not addedToExact then
			for _, alias in ipairs(cmd.Alias) do
				local aliasLower = alias:lower()
				if aliasLower:sub(1, #lowerText) == lowerText then
					table.insert(exactMatches, cmd)
					addedToExact = true
					break
				end
			end
		end
		
		if not addedToExact then
			if titleLower:find(lowerText, 1, true) then
				table.insert(partialMatches, cmd)
			else
				for _, alias in ipairs(cmd.Alias) do
					local aliasLower = alias:lower()
					if aliasLower:find(lowerText, 1, true) then
						table.insert(partialMatches, cmd)
						break
					end
				end
			end
		end
	end
	
	local combinedMatches = {}
	for _, cmd in ipairs(exactMatches) do
		table.insert(combinedMatches, cmd)
	end
	for _, cmd in ipairs(partialMatches) do
		table.insert(combinedMatches, cmd)
	end
	
	return combinedMatches
end

function CommandSystem:ExecuteCommand(text)
	local lowerText = text:lower()
	
	for _, cmd in ipairs(self.commands) do
		if cmd.Title:lower() == lowerText then
			cmd.Callback()
			return true
		end
	end
	
	for _, cmd in ipairs(self.commands) do
		for _, alias in ipairs(cmd.Alias) do
			if alias:lower() == lowerText then
				cmd.Callback()
				return true
			end
		end
	end
	
	return false
end

local G2L = {}

G2L["DarkAdmin_1"] = Instance.new("ScreenGui", game:GetService("CoreGui"))
G2L["DarkAdmin_1"]["Name"] = "DarkAdmin"
G2L["DarkAdmin_1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
G2L["DarkAdmin_1"]["ResetOnSpawn"] = false

CollectionService:AddTag(G2L["DarkAdmin_1"], "main")

G2L["CommandFrame_2"] = Instance.new("Frame", G2L["DarkAdmin_1"])
G2L["CommandFrame_2"]["BorderSizePixel"] = 0
G2L["CommandFrame_2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["CommandFrame_2"]["Size"] = UDim2.new(0, 0, 0, 40)
G2L["CommandFrame_2"]["Position"] = UDim2.new(0, 230, 0, -46)
G2L["CommandFrame_2"]["Name"] = "CommandFrame"
G2L["CommandFrame_2"]["BackgroundTransparency"] = 0.1
G2L["CommandFrame_2"]["Visible"] = false
G2L["CommandFrame_2"]["ClipsDescendants"] = false

G2L["UICorner_3"] = Instance.new("UICorner", G2L["CommandFrame_2"])
G2L["UICorner_3"]["CornerRadius"] = UDim.new(0, 20)

G2L["UIGradient_4"] = Instance.new("UIGradient", G2L["CommandFrame_2"])
G2L["UIGradient_4"]["Color"] = ColorSequence.new{
	ColorSequenceKeypoint.new(0.000, Color3.fromRGB(5, 5, 5)),
	ColorSequenceKeypoint.new(1.000, Color3.fromRGB(40, 40, 40))
}

G2L["UIStroke_CommandFrame"] = Instance.new("UIStroke", G2L["CommandFrame_2"])
G2L["UIStroke_CommandFrame"]["Thickness"] = 0
G2L["UIStroke_CommandFrame"]["Color"] = Color3.fromRGB(255, 255, 255)
G2L["UIStroke_CommandFrame"]["Transparency"] = 1

G2L["Frame_5"] = Instance.new("Frame", G2L["CommandFrame_2"])
G2L["Frame_5"]["BorderSizePixel"] = 0
G2L["Frame_5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["Frame_5"]["Size"] = UDim2.new(0, 190, 0, 28)
G2L["Frame_5"]["Position"] = UDim2.new(0, 8, 0, 6)
G2L["Frame_5"]["BackgroundTransparency"] = 1

G2L["UICorner_6"] = Instance.new("UICorner", G2L["Frame_5"])
G2L["UICorner_6"]["CornerRadius"] = UDim.new(0, 25)

G2L["TextBox_7"] = Instance.new("TextBox", G2L["Frame_5"])
G2L["TextBox_7"]["CursorPosition"] = -1
G2L["TextBox_7"]["PlaceholderColor3"] = Color3.fromRGB(156, 156, 156)
G2L["TextBox_7"]["BorderSizePixel"] = 0
G2L["TextBox_7"]["TextSize"] = 20
G2L["TextBox_7"]["TextColor3"] = Color3.fromRGB(211, 211, 211)
G2L["TextBox_7"]["BackgroundColor3"] = Color3.fromRGB(142, 142, 142)
G2L["TextBox_7"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
G2L["TextBox_7"]["PlaceholderText"] = "Command Bar :"
G2L["TextBox_7"]["Size"] = UDim2.new(0, 190, 0, 28)
G2L["TextBox_7"]["Text"] = ""
G2L["TextBox_7"]["BackgroundTransparency"] = 1
G2L["TextBox_7"]["TextXAlignment"] = Enum.TextXAlignment.Center

G2L["UICorner_8"] = Instance.new("UICorner", G2L["TextBox_7"])
G2L["UICorner_8"]["CornerRadius"] = UDim.new(0, 20)

G2L["UIStroke_a"] = Instance.new("UIStroke", G2L["TextBox_7"])
G2L["UIStroke_a"]["Thickness"] = 0.5

G2L["UIStroke_b"] = Instance.new("UIStroke", G2L["Frame_5"])
G2L["UIStroke_b"]["Thickness"] = 0.3
G2L["UIStroke_b"]["Color"] = Color3.fromRGB(99, 99, 99)

G2L["AutocompleteFrame"] = Instance.new("Frame", G2L["CommandFrame_2"])
G2L["AutocompleteFrame"]["BorderSizePixel"] = 0
G2L["AutocompleteFrame"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
G2L["AutocompleteFrame"]["Size"] = UDim2.new(0, 202, 0, 0)
G2L["AutocompleteFrame"]["Position"] = UDim2.new(0, 2, 1, 6)
G2L["AutocompleteFrame"]["BackgroundTransparency"] = 0.3
G2L["AutocompleteFrame"]["Visible"] = false
G2L["AutocompleteFrame"]["ClipsDescendants"] = false
G2L["AutocompleteFrame"]["ZIndex"] = 10

G2L["UICorner_Auto"] = Instance.new("UICorner", G2L["AutocompleteFrame"])

G2L["ScrollingFrame_Auto"] = Instance.new("ScrollingFrame", G2L["AutocompleteFrame"])
G2L["ScrollingFrame_Auto"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
G2L["ScrollingFrame_Auto"]["BorderSizePixel"] = 0
G2L["ScrollingFrame_Auto"]["CanvasSize"] = UDim2.new(0, 0, 0, 0)
G2L["ScrollingFrame_Auto"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["ScrollingFrame_Auto"]["ScrollBarImageTransparency"] = 0.3
G2L["ScrollingFrame_Auto"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y
G2L["ScrollingFrame_Auto"]["Size"] = UDim2.new(1, -8, 1, -8)
G2L["ScrollingFrame_Auto"]["ScrollBarImageColor3"] = Color3.fromRGB(21, 21, 21)
G2L["ScrollingFrame_Auto"]["Position"] = UDim2.new(0, 4, 0, 4)
G2L["ScrollingFrame_Auto"]["ScrollBarThickness"] = 2
G2L["ScrollingFrame_Auto"]["BackgroundTransparency"] = 1

G2L["UIListLayout_Auto"] = Instance.new("UIListLayout", G2L["ScrollingFrame_Auto"])
G2L["UIListLayout_Auto"]["Padding"] = UDim.new(0, 2)

G2L["UIPadding_Auto"] = Instance.new("UIPadding", G2L["ScrollingFrame_Auto"])
G2L["UIPadding_Auto"]["PaddingLeft"] = UDim.new(0, 4)
G2L["UIPadding_Auto"]["PaddingTop"] = UDim.new(0, 2)
G2L["UIPadding_Auto"]["PaddingBottom"] = UDim.new(0, 2)

G2L["Frame_c"] = Instance.new("Frame", G2L["DarkAdmin_1"])
G2L["Frame_c"]["BorderSizePixel"] = 0
G2L["Frame_c"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
G2L["Frame_c"]["Size"] = UDim2.new(0, 40, 0, 40)
G2L["Frame_c"]["Position"] = UDim2.new(0, 230, 0, -150)
G2L["Frame_c"]["BackgroundTransparency"] = 0.2
G2L["Frame_c"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
G2L["Frame_c"]["Active"] = true

G2L["UICorner_d"] = Instance.new("UICorner", G2L["Frame_c"])
G2L["UICorner_d"]["CornerRadius"] = UDim.new(0, 50)

G2L["TextButton_e"] = Instance.new("TextButton", G2L["Frame_c"])
G2L["TextButton_e"]["BorderSizePixel"] = 0
G2L["TextButton_e"]["TextSize"] = 20
G2L["TextButton_e"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
G2L["TextButton_e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
G2L["TextButton_e"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
G2L["TextButton_e"]["BackgroundTransparency"] = 1
G2L["TextButton_e"]["Size"] = UDim2.new(1, 0, 1, 0)
G2L["TextButton_e"]["Text"] = "DA"
G2L["TextButton_e"]["Active"] = false

G2L["UICorner_f"] = Instance.new("UICorner", G2L["TextButton_e"])
G2L["UICorner_f"]["CornerRadius"] = UDim.new(0, 50)

G2L["UIStroke_10"] = Instance.new("UIStroke", G2L["TextButton_e"])
G2L["UIStroke_10"]["Thickness"] = 0.5

local Settings = {
	isCommandFrameOpen = false,
	isDragging = false,
	isTyping = false,
	dragStart = nil,
	startPos = nil,
	inputStartPos = nil,
	dragThreshold = 3,
	lastTypingTime = 0,
	hideTimerActive = false,
	selectedCommandIndex = 1,
	currentMatches = {},
	dragConnection = nil
}

local toggleCommandFrame
local startHideTimer
local updateCommandFramePosition

function createCommandLabel(text, index)
	local label = Instance.new("TextLabel")
	label.BorderSizePixel = 0
	label.TextSize = 18
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(0, 184, 0, 32)
	label.Text = text
	label.Name = "CommandLabel_" .. index
	label.ZIndex = 11
	return label
end

function updateSelectionHighlight()
	for i, child in ipairs(G2L["ScrollingFrame_Auto"]:GetChildren()) do
		if child:IsA("TextLabel") then
			if i == Settings.selectedCommandIndex then
				child.TextColor3 = Color3.fromRGB(100, 200, 255)
			else
				child.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
		end
	end
end

function updateAutocomplete(text)
	for _, child in ipairs(G2L["ScrollingFrame_Auto"]:GetChildren()) do
		if child:IsA("TextLabel") then
			child:Destroy()
		end
	end
	
	local matches = CommandSystem:GetMatchingCommands(text)
	Settings.currentMatches = matches
	
	if #matches > 0 then
		Settings.selectedCommandIndex = 1
		
		for i, cmd in ipairs(matches) do
			local label = createCommandLabel(cmd.Title, i)
			label.Parent = G2L["ScrollingFrame_Auto"]
			
			label.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					CommandSystem:ExecuteCommand(cmd.Title)
					G2L["TextBox_7"].Text = ""
				end
			end)
		end
		
		updateSelectionHighlight()
		
		local targetHeight = math.min(#matches * 34, 266)
		G2L["AutocompleteFrame"].Visible = true
		TweenService:Create(
			G2L["AutocompleteFrame"],
			TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 202, 0, targetHeight)}
		):Play()
	else
		if G2L["AutocompleteFrame"].Size.Y.Offset > 0 then
			TweenService:Create(
				G2L["AutocompleteFrame"],
				TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
				{Size = UDim2.new(0, 202, 0, 0)}
			):Play()
			task.wait(0.2)
		end
		G2L["AutocompleteFrame"].Visible = false
	end
end

updateCommandFramePosition = function()
	if Settings.isCommandFrameOpen then
		local circleX = G2L["Frame_c"].Position.X.Offset
		local circleY = G2L["Frame_c"].Position.Y.Offset
		G2L["CommandFrame_2"].Position = UDim2.new(0, circleX + 20, 0, circleY)
	end
end

startHideTimer = function()
	if Settings.hideTimerActive then
		return
	end
	
	Settings.hideTimerActive = true
	task.spawn(function()
		while Settings.hideTimerActive and Settings.isCommandFrameOpen do
			task.wait(0.5)
			
			if not Settings.isTyping and Settings.isCommandFrameOpen and (tick() - Settings.lastTypingTime) >= 1.5 then
				Settings.isCommandFrameOpen = false
				TweenService:Create(
					G2L["AutocompleteFrame"],
					TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
					{Size = UDim2.new(0, 202, 0, 0)}
				):Play()
				local hideCommandTween = TweenService:Create(
					G2L["CommandFrame_2"],
					TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
					{Size = UDim2.new(0, 0, 0, 40)}
				)
				
				hideCommandTween:Play()
				hideCommandTween.Completed:Wait()
				G2L["CommandFrame_2"].Visible = false
				G2L["AutocompleteFrame"].Visible = false
				Settings.hideTimerActive = false
				break
			end
		end
	end)
end

toggleCommandFrame = function()
	if Settings.isTyping then
		return
	end
	
	if Settings.isCommandFrameOpen then
		Settings.isCommandFrameOpen = false
		TweenService:Create(
			G2L["AutocompleteFrame"],
			TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
			{Size = UDim2.new(0, 202, 0, 0)}
		):Play()
		TweenService:Create(
			G2L["CommandFrame_2"],
			TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
			{Size = UDim2.new(0, 0, 0, 40)}
		):Play()
		task.wait(0.3)
		G2L["CommandFrame_2"].Visible = false
		G2L["AutocompleteFrame"].Visible = false
	else
		Settings.isCommandFrameOpen = true
		updateCommandFramePosition()
		G2L["CommandFrame_2"].Visible = true
		TweenService:Create(
			G2L["CommandFrame_2"],
			TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 206, 0, 40)}
		):Play()
		task.wait(0.35)
		G2L["TextBox_7"]:CaptureFocus()
		startHideTimer()
	end
end

G2L["Frame_c"].MouseEnter:Connect(function()
	if not Settings.isDragging then
		TweenService:Create(
			G2L["Frame_c"],
			TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 45, 0, 45)}
		):Play()
	end
end)

G2L["Frame_c"].MouseLeave:Connect(function()
	if not Settings.isDragging then
		TweenService:Create(
			G2L["Frame_c"],
			TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{Size = UDim2.new(0, 40, 0, 40)}
		):Play()
	end
end)

function setupDragging()
	local circleFrame = G2L["Frame_c"]
	local runService = game:GetService("RunService")
	local renderConnection = nil
	local inputConnection = nil
	
	circleFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Settings.inputStartPos = input.Position
			Settings.startPos = circleFrame.Position
			
			if inputConnection then
				inputConnection:Disconnect()
			end
			
			if renderConnection then
				renderConnection:Disconnect()
			end
			
			inputConnection = UserInputService.InputChanged:Connect(function(changedInput)
				if changedInput.UserInputType == Enum.UserInputType.MouseMovement or changedInput.UserInputType == Enum.UserInputType.Touch then
					local totalDelta = (changedInput.Position - Settings.inputStartPos).Magnitude
					
					if totalDelta >= Settings.dragThreshold then
						Settings.isDragging = true
					end
					
					if Settings.isDragging then
						local delta = changedInput.Position - Settings.inputStartPos
						circleFrame.Position = UDim2.new(
							Settings.startPos.X.Scale,
							Settings.startPos.X.Offset + delta.X,
							Settings.startPos.Y.Scale,
							Settings.startPos.Y.Offset + delta.Y
						)
					end
				end
			end)
			
			renderConnection = runService.RenderStepped:Connect(function()
				if Settings.isDragging then
					updateCommandFramePosition()
				end
			end)
		end
	end)
	
	circleFrame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if inputConnection then
				inputConnection:Disconnect()
				inputConnection = nil
			end
			
			if renderConnection then
				renderConnection:Disconnect()
				renderConnection = nil
			end
			
			if not Settings.isDragging and Settings.inputStartPos then
				local totalDelta = (input.Position - Settings.inputStartPos).Magnitude
				if totalDelta < Settings.dragThreshold then
					if not Settings.isCommandFrameOpen then
						toggleCommandFrame()
					else
						G2L["TextBox_7"]:CaptureFocus()
					end
				end
			end
			
			Settings.isDragging = false
			Settings.inputStartPos = nil
			
			TweenService:Create(
				G2L["Frame_c"],
				TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{Size = UDim2.new(0, 40, 0, 40)}
			):Play()
		end
	end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not Settings.isTyping or gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.Up then
		if #Settings.currentMatches > 0 then
			Settings.selectedCommandIndex = math.max(1, Settings.selectedCommandIndex - 1)
			updateSelectionHighlight()
		end
	elseif input.KeyCode == Enum.KeyCode.Down then
		if #Settings.currentMatches > 0 then
			Settings.selectedCommandIndex = math.min(#Settings.currentMatches, Settings.selectedCommandIndex + 1)
			updateSelectionHighlight()
		end
	elseif input.KeyCode == Enum.KeyCode.Tab then
		if #Settings.currentMatches > 0 then
			G2L["TextBox_7"].Text = Settings.currentMatches[Settings.selectedCommandIndex].Title
		end
	end
end)

G2L["TextBox_7"].Focused:Connect(function()
	Settings.isTyping = true
	Settings.lastTypingTime = tick()
	G2L["UIStroke_CommandFrame"].Thickness = 0.5
	G2L["UIStroke_CommandFrame"].Transparency = 0
	updateAutocomplete(G2L["TextBox_7"].Text)
end)

G2L["TextBox_7"].FocusLost:Connect(function(enterPressed)
	Settings.isTyping = false
	Settings.lastTypingTime = tick()
	
	local textToExecute = G2L["TextBox_7"].Text
	
	G2L["TextBox_7"].Text = ""
	
	if textToExecute ~= "" and (enterPressed or UserInputService.TouchEnabled) then
		CommandSystem:ExecuteCommand(textToExecute)
	end
	
	G2L["UIStroke_CommandFrame"].Thickness = 0
	G2L["UIStroke_CommandFrame"].Transparency = 1
	
	TweenService:Create(
		G2L["AutocompleteFrame"],
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Size = UDim2.new(0, 202, 0, 0)}
	):Play()
	task.wait(0.2)
	G2L["AutocompleteFrame"].Visible = false
	
	startHideTimer()
end)

G2L["TextBox_7"]:GetPropertyChangedSignal("Text"):Connect(function()
	Settings.lastTypingTime = tick()
	if G2L["TextBox_7"].Text ~= "" then
		G2L["UIStroke_CommandFrame"].Thickness = 0.5
		G2L["UIStroke_CommandFrame"].Transparency = 0
	else
		if not Settings.isTyping then
			G2L["UIStroke_CommandFrame"].Thickness = 0
			G2L["UIStroke_CommandFrame"].Transparency = 1
		end
	end
	
	updateAutocomplete(G2L["TextBox_7"].Text)
end)

function PlayIntro()
	task.wait(0.5)
	
	local IconAnim = TweenService:Create(
		G2L["Frame_c"],
		TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Position = UDim2.new(0, 250, 0, -26)}
	)
	
	IconAnim:Play()
	IconAnim.Completed:Wait()
	
	G2L["CommandFrame_2"].Position = UDim2.new(0, 270, 0, -26)
	G2L["CommandFrame_2"].Visible = true
	
	local CommandFrameAnim = TweenService:Create(
		G2L["CommandFrame_2"],
		TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		{Size = UDim2.new(0, 206, 0, 40)}
	)
	
	CommandFrameAnim:Play()
	CommandFrameAnim.Completed:Wait()
	
	local S = TweenService:Create(
		G2L["CommandFrame_2"],
		TweenInfo.new(0.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
		{Size = UDim2.new(0, 206, 0, 40)}
	)
	
	S:Play()
	S.Completed:Wait()
	
	Settings.isCommandFrameOpen = true
	Settings.lastTypingTime = tick()
	startHideTimer()
	
	setupDragging()
	task.wait(2)
	NotificationLibrary:SendNotification("Success", "DarkAdmin has Loaded.", 5)
end

CommandSystem:AddCmd({
	Title = "Console",
	Alias = {"Console"},
	Callback = function()
		StarterGui:SetCore("DevConsoleVisible", true)
	end
})
CommandSystem:AddCmd({
	Title = "OldConsole / OConsole",
	Alias = {"OldConsole", "OConsole"},
	Callback = function()
		local _, str = pcall(function()
		return game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/console.lua", true)
	end)

	local s, e = loadstring(str)
	if typeof(s) ~= "function" then
		return
	end

	local success, message = pcall(s)
	if (not success) then
		if printconsole then
			printconsole(message)
		elseif printoutput then
			printoutput(message)
		end
	end
	wait(1)
	NotificationLibrary:SendNotification("Error", "Failed to Load. try f9", 3)
	end
})
CommandSystem:AddCmd({
	Title = "Help / Info",
	Alias = {"Info", "Help"},
	Callback = function()
		
	end
})
CommandSystem:AddCmd({
	Title = "Discord / Support",
	Alias = {"Discord", "Support"},
	Callback = function()
		setclipboard("https://discord.gg/DMB3CDrDa9")
	end
})
CommandSystem:AddCmd({
	Title = "DarkDex / Dex / Explorer",
	Alias = {"Dex", "DarkDex", "Explorer"},
	Callback = function()
	    NotificationLibrary:SendNotification("Info", "Loading Dex by Moon", 3)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end
})
CommandSystem:AddCmd({
	Title = "OldDex / OldExplorer / ODex",
	Alias = {"OldDex", "OldExplorer", "ODex"},
	Callback = function()
	    NotificationLibrary:SendNotification("Info", "Loading OldModel of Dex", 3)
		local getobjects = function(a)
		local Objects = {}
		if a then
			local b = InsertService:LoadLocalAsset(a)
			if b then 
				table.insert(Objects, b) 
			end
		end
		return Objects
	end

	local Dex = getobjects("rbxassetid://10055842438")[1]
	Dex.Parent = PARENT

	function Load(Obj, Url)
		function GiveOwnGlobals(Func, Script)
			local Fenv, RealFenv, FenvMt = {}, {
				script = Script,
				getupvalue = function(a, b)
					return nil 
				end,
				getreg = function()
					return {} 
				end,
				getprops = getprops or function(inst)
					if getproperties then
						local props = getproperties(inst)
						if props[1] and gethiddenproperty then
							local results = {}
							for _,name in pairs(props) do
								local success, res = pcall(gethiddenproperty, inst, name)
								if success then
									results[name] = res
								end
							end

							return results
						end

						return props
					end

					return {}
				end
			}, {}
			FenvMt.__index = function(a,b)
				return RealFenv[b] == nil and getgenv()[b] or RealFenv[b]
			end
			FenvMt.__newindex = function(a, b, c)
				if RealFenv[b] == nil then 
					getgenv()[b] = c 
				else 
					RealFenv[b] = c 
				end
			end
			setmetatable(Fenv, FenvMt)
			pcall(setfenv, Func, Fenv)
			return Func
		end

		function LoadScripts(_, Script)
			if Script:IsA("LocalScript") then
				task.spawn(function()
					GiveOwnGlobals(loadstring(Script.Source,"="..Script:GetFullName()), Script)()
				end)
			end
			table.foreach(Script:GetChildren(), LoadScripts)
		end

		LoadScripts(nil, Obj)
	end

	Load(Dex)
end
})

CommandSystem:AddCmd({
	Title = "RemoteSpy / Rspy",
	Alias = {"RemoteSpy", "Rspy"},
	Callback = function()
	    NotificationLibrary:SendNotification("Info", "Loading Rspy...", 3)
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua"))()
	end
})
CommandSystem:AddCmd({
	Title = "AudioLogger / AudioLog / ALogger",
	Alias = {"AudioLogger", "AudioLog", "ALogger"},
	Callback = function()
	    NotificationLibrary:SendNotification("Info", "Loading AudioLogger by Edge", 3)
		loadstring(game:HttpGet(('https://raw.githubusercontent.com/infyiff/backup/main/audiologger.lua'),true))()
	end
})

PlayIntro()

return {
	GUI = G2L["DarkAdmin_1"],
	AddCmd = function(data) return CommandSystem:AddCmd(data) end
}
