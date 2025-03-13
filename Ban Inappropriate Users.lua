local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local banListUrl = "https://raw.githubusercontent.com/tomanyy/Roblox-Ban-List-Repo/refs/heads/main/PlayersBanList.txt"
local bannedUsers = {}

-- Function to fetch and store banned UserIds
local function fetchBanList()
	local success, response = pcall(function()
		return HttpService:GetAsync(banListUrl)
	end)

	if success then

		bannedUsers = {} -- Reset the list

		for userId in response:gmatch("%d+") do
			local numId = tonumber(userId)
			if numId then
				bannedUsers[numId] = true
			end
		end

	else
		warn("Failed to fetch ban list:", response)
	end
end

-- Fetch ban list when the game starts
fetchBanList()

-- Check and kick banned players
Players.PlayerAdded:Connect(function(player)
	print("Player joined:", player.Name, "UserID:", player.UserId)

	if bannedUsers[player.UserId] then
		print("Banned player detected: " .. player.Name .. " (UserID: " .. player.UserId .. ")")
		player:Kick("You are banned from this game for safety reasons.                                                                Please appeal in the S.O.R. community server.")
	else
		print("Player is not banned: " .. player.Name)
	end
end)
