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
				title = '',
				description = '<password>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
            },
            ['say'] = {
				title = '',
				description = '<message, players>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
            },
            ['yell'] = {
				title = '',
				description = '<message, duration, players>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['kick'] = {
				title = '',
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
		},
		['banList'] = {
			['add'] = {
				title = '',
				description = '<id-type, id, timeout, reason>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['remove'] = {
				title = '',
				description = '<id-type, id>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['clear'] = {
				title = '',
				description = 'clears the banlist',
				currentData = nil,
				canGet = false,
				inputType = 'button'
			},
            ['list'] = {
				title = '',
				description = 'lists all banned players',
				currentData = nil,
				canGet = true,
				inputType = 'button'
			}
        },
        ['mapList'] = {
            ['add'] = {
				title = '',
				description = '<map, gamemode, rounds, offset>',
				currentData = nil,
				canGet = false,
				inputType = 'alphanumeric'
			},
            ['remove'] = {
				title = '',
				description = '<index>',
				currentData = nil,
				canGet = false,
				inputType = 'integer'
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
				description = '<startIndex>',
				currentData = nil,
				canGet = false,
				inputType = 'integer'
			},
            ['nextMap'] = {
				title = '',
				description = '<index>',
				currentData = nil,
				canGet = false,
				inputType = 'integer'
			},
            ['getMapIndices'] = {
				title = '',
				description = ' - Get indices for current & next map',
				currentData = nil,
				canGet = true,
				inputType = 'button'
			},
            ['getRounds'] = {
				title = '',
				description = ' - Get current round and number of rounds',
				currentData = nil,
				canGet = true,
				inputType = 'button'
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
            ['serverDesc'] = {
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
            ['crossHair'] = {
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
end

function Server:RegisterEvents()
    -- Net
    NetEvents:Subscribe('IngameRCON:UpdateValues', self, self.OnValuesUpdated)
    NetEvents:Subscribe('IngameRCON:PullRequest', self, self.OnValuePullRequest)
    -- Events
    Events:Subscribe('Level:Loaded', self, self.OnLevelLoaded)
end

function Server:OnLevelLoaded(p_LevelName, p_GameMode, p_Round, p_RoundsPerMap)
    self:GetCurrentSettings()
end

function Server:GetCurrentSettings()
    for l_CommandGroup, l_CommandTable in pairs(self.m_ValidCommands) do
		local s_ReceivedData
		for l_Command, l_CommandInfo in pairs(l_CommandTable) do
			local s_ConstructedString = self:ConstructCommandString(l_CommandGroup, l_Command)

			if l_CommandInfo.canGet then
				s_ReceivedData = RCON:SendCommand(s_ConstructedString, {})
				l_CommandInfo['currentData'] = s_ReceivedData
				m_Logger:Write('Get Command (' .. s_ConstructedString .. ')')

				for _, l_Value in pairs(s_ReceivedData) do
					m_Logger:Write('Values: ' .. l_Value)
				end
			end
		end
	end
end

function Server:OnValuesUpdated(p_Player, p_JSONData)
	local s_DecodedData = json.decode(p_JSONData)
	for _, l_Arguments in ipairs(s_DecodedData) do
		local l_Cmd = l_Arguments[1]
		local l_Args = l_Arguments[2]
		for l_CommandGroup, l_CommandTable in pairs(self.m_ValidCommands) do
			for l_Command, l_CommandInfo in pairs(l_CommandTable) do
				local s_ConstructedString = self:ConstructCommandString(l_CommandGroup, l_Command)

				if l_Cmd == s_ConstructedString and l_CommandInfo['currentData'] ~= l_Args then
					--- [1] Command (e.g. admin.say) [2] Arguments (e.g. 'true, 1')
					RCON:SendCommand(l_Cmd, { tostring(l_Args) })
				end
			end
		end
	end
	self:GetCurrentSettings()
end

function Server:OnValuePullRequest(p_Player)
	local s_CurrentSettings = json.encode(self.m_ValidCommands)
    NetEvents:SendTo('IngameRCON:PullAnswer', p_Player, s_CurrentSettings)
end

function Server:ConstructCommandString(p_CommandGroup, p_Command)
    local s_ConstructedString = tostring(tostring(p_CommandGroup) .. '.' .. tostring(p_Command))
    return s_ConstructedString
end

return Server()
