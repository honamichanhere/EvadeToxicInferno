local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Rigs = workspace:WaitForChild("Rigs")

local SourceAttachment = ReplicatedStorage
	:WaitForChild("Items")
	:WaitForChild("ItemPacks")
	:WaitForChild("Events")
	:WaitForChild("2022")
	:WaitForChild("Halloween2022")
	:WaitForChild("Cosmetics")
	:WaitForChild("Tier3")
	:WaitForChild("ToxicInferno")
	:WaitForChild("CharacterClassic")
	:WaitForChild("Torso")
	:WaitForChild("Attachment")

local ATTACHMENT_NAME = "ToxicInferno"

local function ApplyAttachment(rig)
	if not rig or not rig:IsA("Model") then
		return
	end

	local torso = rig:FindFirstChild("UpperTorso")
		or rig:FindFirstChild("Torso")

	if not torso then
		torso = rig:WaitForChild("UpperTorso", 3)
			or rig:WaitForChild("Torso", 3)
	end

	if not torso then
		return
	end

	local oldAttachment = torso:FindFirstChild(ATTACHMENT_NAME)

	if oldAttachment then
		oldAttachment:Destroy()
	end

	local newAttachment = SourceAttachment:Clone()
	newAttachment.Name = ATTACHMENT_NAME
	newAttachment.Parent = torso

	print("Applied ToxicInferno to:", rig.Name)
end


local function FindPlayerRig()
	local rig = Rigs:FindFirstChild(Player.Name)

	if rig then
		return rig
	end

	return Player.Character
end

local function Refresh()
	task.defer(function()
		task.wait(0.25)

		local rig = FindPlayerRig()

		if rig then
			ApplyAttachment(rig)
		end
	end)
end

Refresh()

Player.CharacterAdded:Connect(function()
	Refresh()
end)

Rigs.ChildAdded:Connect(function(child)
	if child.Name == Player.Name then
		task.wait(0.25)
		ApplyAttachment(child)
	end
end)
