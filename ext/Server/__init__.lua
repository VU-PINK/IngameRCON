---@class Server
local Server = class('Server')

local m_Logger = Logger('Server', true)

function Server:__init()
    self:RegisterVars()
    self:RegisterEvents()
end

function Server:RegisterVars()
    self.m_ValidCommands = {
        ['admin'] = {
            ['password'] = {
				title = 'Set Admin Password',
				description = '<password>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
            },
            ['say'] = {
				title = 'Chat Message (say)',
				description = '<message, players>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
            },
            ['yell'] = {
				title = 'Announcement (yell)',
				description = '<message, duration, players>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['kick'] = {
				title = 'Kick Player',
				description = '<soldier name, reason>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['move'] = {
				title = '',
				description = '<name, teamID, squadID, forceKill>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['kill'] = {
				title = '',
				description = '<name>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
			['listPlayers'] = {
				title = '',
				description = '<players: player subset>',
				currentData = nil,
				canGet = true,
				inputType = 'hidden',
				defaultValue = { 'all' },
			},
		},
		['banList'] = {
			['add'] = {
				title = '',
				description = '<id-type, id, timeout, reason>',
				currentData = nil,
				canGet = false,
				inputType = 'hidden'
			},
            ['remove'] = {
				title = '',
				description = '<id-type, id>',
				currentData = nil,
				canGet = false,
				inputType = 'hidden'
			},
            ['clear'] = {
				title = '',
				description = 'clears the banlist',
				currentData = nil,
				canGet = false,
				inputType = 'hidden'
			},
            ['list'] = {
				title = '',
				description = 'lists all banned players',
				currentData = nil,
				canGet = true,
				inputType = 'hidden'
			}
        },
        ['mapList'] = {
            ['add'] = {
				title = '',
				description = '<map, gamemode, rounds, offset>',
				currentData = nil,
				canGet = false,
				inputType = 'hidden'
			},
            ['remove'] = {
				title = '',
				description = '<index>',
				currentData = nil,
				canGet = false,
				inputType = 'hidden'
			},
            ['clear'] = {
				title = '',
				description = '- Clears the maplist',
				currentData = nil,
				canGet = false,
				inputType = 'button'
			},
            ['list'] = {
				title = '',
				description = '',
				currentData = nil,
				canGet = true,
				inputType = 'hidden'
			},
            ['nextMap'] = {
				title = '',
				description = '<index>',
				currentData = nil,
				canGet = false,
				inputType = 'hidden'
			},
            ['getMapIndices'] = {
				title = '',
				description = ' - Get indices for current & next map',
				currentData = nil,
				canGet = true,
				inputType = 'hidden'
			},
            ['getRounds'] = {
				title = '',
				description = ' - Get current round and number of rounds',
				currentData = nil,
				canGet = true,
				inputType = 'hidden'
			},
            ['endRound'] = {
				title = '',
				description = '<teamID> - End Current round, declaring the specified team as winners',
				currentData = nil,
				canGet = false,
				inputType = 'button'
			},
            ['runNext'] = {
				title = '',
				description = ' - Run the next round',
				currentData = nil,
				canGet = false,
				inputType = 'button'
			},
            ['restartRound'] = {
				title = '',
				description = ' - Restart the current round',
				currentData = nil,
				canGet = false,
				inputType = 'button'
			},
            ['setNextMapIndex'] = {
				title = '',
				description = '',
				currentData = nil,
				canGet = false,
				inputType = 'hidden'
			},
			['runNextRound'] = {
				title = '',
				description = '',
				currentData = nil,
				canGet = false,
				inputType = 'hidden'
			},
		},
        ['vars'] = {
            ['serverName'] = {
				title = '',
				description = '<name>',
				currentData = nil,
				canGet = true,
				inputType = 'alphanumeric'
			},
            ['password'] = {
				title = '',
				description = '<password>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['roundStartPlayerCount'] = {
				title = '',
				description = '<numPlayers>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['roundRestartPlayerCount'] = {
				title = '',
				description = '<numPlayers>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['preRound'] = {
				title = '',
				description = '<time> - Set duration of pre-round',
				currentData = nil,
				canGet = false,
				inputType = 'integer'
			},
            ['serverMessage'] = {
				title = '',
				description = '<message>',
				currentData = nil,
				canGet = true,
				inputType = 'alphanumeric'
			},
            ['friendlyfire'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['maxPlayers'] = {
				title = '',
				description = '<numPlayers>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['serverDescription'] = {
				title = '',
				description = '<description>',
				currentData = nil,
				canGet = true,
				inputType = 'alphanumeric'
			},
            ['killCam'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['miniMap'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['hud'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['3dSpotting'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['miniMapSpotting'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['nameTag'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['3pCam'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['regenerateHealth'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['teamKillCountForKick'] = {
				title = '',
				description = '<count>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['teamKillValueForKick'] = {
				title = '',
				description = '<count>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['teamKillValueIncrease'] = {
				title = '',
				description = '<count>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['teamKillValueDecreasePerSecond'] = {
				title = '',
				description = '<count>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['teamKillKickForBan'] = {
				title = '',
				description = '<count>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['idleTimeout'] = {
				title = '',
				description = '<time>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['idleBanRounds'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['vehicleSpawnAllowed'] = {
				title = '',
				description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['vehicleSpawnDelay'] = {
				title = '',
				description = '<percentage modifier>',
				currentData = nil,
				canGet = true,
				inputType = 'percentageModifier'
			},
            ['soldierHealth'] = {
				title = '',
				description = '<percentage modifier>',
				currentData = nil,
				canGet = true,
				inputType = 'percentageModifier'
			},
            ['playerRespawnTime'] = {
				title = '',
				description = '<percentage modifier>',
				currentData = nil,
				canGet = true,
				inputType = 'percentageModifier'
			},
            ['playerManDownTime'] = {
				title = '',
				description = '<percentage modifier>',
				currentData = nil,
				canGet = true,
				inputType = 'percentageModifier'
			},
            ['bulletDamage'] = {
				title = '',
				description = '<percentage modifier>',
				currentData = nil,
				canGet = true,
				inputType = 'percentageModifier'
			},
            ['gameModeCounter'] = {
				title = '',
                description = '<integer> - Set Ticket Scale',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['onlySquadLeaderSpawn'] = {
				title = '',
                description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['unlockMode'] = {
				title = '',
                description = '<mode>',
				currentData = nil,
				canGet = true,
				inputType = 'alphanumeric'
			}
        },
        ['vu'] = {
            ['ColorCorrectionEnabled'] = {
				title = '',
                description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['DesertingAllowed'] = {
				title = '',
                description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['DestructionEnabled'] = {
				title = '',
                description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['FadeInAll'] = {
				title = '',
                description = '- Fade in all Players',
				currentData = nil,
				canGet = false,
				inputType = 'button'
			},
            ['FadeOutAll'] = {
				title = '',
                description = '- Fade out all Players',
				currentData = nil,
				canGet = false,
				inputType = 'button'
			},
            ['FrequencyMode'] = {
				title = '',
                description = ' - return frequency of server',
				currentData = nil,
				canGet = true,
				inputType = 'button'
			},
            ['HighPerformanceReplication'] = {
				title = '',
                description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['ServerBanner'] = {
				title = '',
                description = '<.jpg link>',
				currentData = nil,
				canGet = true,
				inputType = 'alphanumeric'
			},
            ['SetTeamTicketCount'] = {
				title = '',
                description = '<team, amount>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['SpectatorCount'] = {
				title = '',
                description = ' - return spec count',
				currentData = nil,
				canGet = true,
				inputType = 'button'
			},
            ['SquadSize'] = {
				title = '',
                description = '<size>',
				currentData = nil,
				canGet = true,
				inputType = 'integer'
			},
            ['SunFlareEnabled'] = {
				title = '',
                description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['SuppressionMultiplier'] = {
				title = '',
                description = '<percentage>',
				currentData = nil,
				canGet = true,
				inputType = 'percentageModifier'
			},
            ['TimeScale'] = {
				title = '',
                description = '<float>',
				currentData = nil,
				canGet = true,
				inputType = 'float'
			},
            ['VehicleDisablingEnabled'] = {
				title = '',
                description = '<true/false>',
				currentData = nil,
				canGet = true,
				inputType = 'switch'
			},
            ['Fps'] = {
				title = '',
                description = ' - return server fps',
				currentData = nil,
				canGet = true,
				inputType = 'button'
			},
            ['FpsMa'] = {
				title = '',
                description = ' - return 30-second moving average of the server FPS',
				currentData = nil,
				canGet = true,
				inputType = 'button'
			},
        }
	}

	self.Admins = {}
end

function Server:RegisterEvents()
    -- Net
    NetEvents:Subscribe('IngameRCON:UpdateValues', self, self.OnValuesUpdated)
    NetEvents:Subscribe('IngameRCON:PullRequest', self, self.OnValuePullRequest)
	NetEvents:Subscribe('IngameRCON:UpdateMaplist', self, self.OnUpdateMaplist)
	NetEvents:Subscribe('IngameRCON:UpdateBanlist', self, self.OnUpdateBanlist)
    -- Events
    Events:Subscribe('Level:Loaded', self, self.OnLevelLoaded)
	Events:Subscribe('GameAdmin:Player', self, self.OnAdminBroadcast)
    Events:Subscribe('GameAdmin:Clear', self, self.OnAdminClear)
	Events:Subscribe('Player:Authenticated', self, self.OnPlayerAuthenticated)
end

function Server:OnLevelLoaded(p_LevelName, p_GameMode, p_Round, p_RoundsPerMap)
    self:GetCurrentSettings()
end

function Server:OnPlayerAuthenticated(p_Player)
	if self.Admins[p_Player.name] or DEBUG then
		NetEvents:SendTo('IngameRCON:IsAdmin', p_Player, true)
	end
end

function Server:GetCurrentSettings(p_CommandGroup, p_Command)
	for l_CommandGroup, l_CommandTable in pairs(self.m_ValidCommands) do
		local s_ReceivedData
		for l_Command, l_CommandInfo in pairs(l_CommandTable) do

			if p_CommandGroup ~= nil and p_Command ~= nil then
				if l_CommandGroup == p_CommandGroup and l_Command == p_Command then
					local s_ConstructedString = self:ConstructCommandString(l_CommandGroup, l_Command)

					if l_CommandInfo.canGet then
						if l_CommandInfo.defaultValue then
							s_ReceivedData = RCON:SendCommand(s_ConstructedString, l_CommandInfo.defaultValue)
						else
							s_ReceivedData = RCON:SendCommand(s_ConstructedString, {})
						end
						l_CommandInfo['currentData'] = s_ReceivedData
						m_Logger:Write('Get Command (' .. s_ConstructedString .. ')')

						print(s_ReceivedData)
						for _, l_Value in pairs(s_ReceivedData) do
							m_Logger:Write('Values: ' .. l_Value)
						end
					end
				end
				return
			else
				local s_ConstructedString = self:ConstructCommandString(l_CommandGroup, l_Command)

				if l_CommandInfo.canGet then
					if l_CommandInfo.defaultValue then
						s_ReceivedData = RCON:SendCommand(s_ConstructedString, l_CommandInfo.defaultValue)
					else
						s_ReceivedData = RCON:SendCommand(s_ConstructedString, {})
					end
					l_CommandInfo['currentData'] = s_ReceivedData
					m_Logger:Write('Get Command (' .. s_ConstructedString .. ')')

					print(s_ReceivedData)
					for _, l_Value in pairs(s_ReceivedData) do
						m_Logger:Write('Values: ' .. l_Value)
					end
				end
			end
		end
	end
end

function Server:OnValuesUpdated(p_Player, p_JSONData)
	if self.Admins[p_Player.name] or DEBUG then
		local s_DecodedData = json.decode(p_JSONData)
		for _, l_Arguments in ipairs(s_DecodedData) do
			local l_Cmd = l_Arguments[1]
			local l_Args = l_Arguments[2]
			for l_CommandGroup, l_CommandTable in pairs(self.m_ValidCommands) do
				for l_Command, l_CommandInfo in pairs(l_CommandTable) do
					local s_ConstructedString = self:ConstructCommandString(l_CommandGroup, l_Command)

					if l_Cmd == s_ConstructedString then
						if (tostring(l_Args) == "") then
							--- [1] Command (e.g. mapList.add)
							RCON:SendCommand(l_Cmd)
						else
							--- [1] Command (e.g. mapList.add) [2] Arguments {"MP_001", "RushLarge0", "1"})
							RCON:SendCommand(l_Cmd, { tostring(l_Args) })
						end
					end
				end
			end
		end
		self:GetCurrentSettings()
	else
		m_Logger:Warning('Player is not Admin')
	end
end

function Server:OnValuePullRequest(p_Player)
	if self.Admins[p_Player.name] or DEBUG then
		local s_CurrentSettings = json.encode(self.m_ValidCommands)
		NetEvents:SendTo('IngameRCON:PullAnswer', p_Player, s_CurrentSettings)
	else
		m_Logger:Warning('Player is not Admin')
	end
end

function Server:ConstructCommandString(p_CommandGroup, p_Command)
    local s_ConstructedString = tostring(tostring(p_CommandGroup) .. '.' .. tostring(p_Command))
    return s_ConstructedString
end

function Server:OnAdminBroadcast(p_PlayerName, p_Abilitities)
	if p_Abilitities ~= nil then
    	self.Admins[p_PlayerName] = true
	end

	local s_Player = PlayerManager:GetPlayerByName(p_PlayerName)
	if s_Player ~= nil and p_Abilitities ~= nil then
		NetEvents:SendTo('IngameRCON:IsAdmin', s_Player, true)
	end
end

function Server:OnAdminClear()
	self.Admins = {}

	local s_Players = PlayerManager:GetPlayers()
	for _, l_Player in ipairs(s_Players) do
		NetEvents:SendTo('IngameRCON:IsAdmin', l_Player, false)
	end
end

function Server:OnUpdateMaplist(p_Player, p_JSONData)
	local s_MapListTable = json.decode(p_JSONData)

	if s_MapListTable == nil then
		return
	end

	-- clear old maplist
	RCON:SendCommand("mapList.clear")

	for l_Index, l_Arguments in ipairs(s_MapListTable) do
		local s_Name = l_Arguments[1]
		local s_Gamemode = l_Arguments[2]
		local s_Rounds = math.floor(l_Arguments[3])
		RCON:SendCommand("mapList.add", {s_Name, s_Gamemode, tostring(s_Rounds)})
		m_Logger:Write("Maplist Index: " .. l_Index .. " | Map: " .. s_Name .. " | Gamemode: " .. s_Gamemode .. " | Rounds: " .. s_Rounds)
	end

	RCON:SendCommand("mapList.save")

	self:GetCurrentSettings()
end

function Server:OnUpdateBanlist(p_Player, p_JSONData)

end

return Server()
