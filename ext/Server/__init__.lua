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
				description = "<password>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
            },
            ['say'] = {
				description = "<message, players>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
            },
            ['yell'] = {
				description = "<message, duration, players>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
            ['kick'] = {
				description = "<soldier name, reason>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
            ['move'] = {
				description = "<name, teamID, squadID, forceKill>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
            ['kill'] = {
				description = "<name>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
		},
		['banList'] = {
			['add'] = {
				description = "<id-type, id, timeout, reason>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
            ['remove'] = {
				description = "<id-type, id>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
            ['clear'] = {
				description = "clears the banlist",
				currentData = nil,
				canGet = false,
				inputType = "button"
			},
            ['list'] = {
				description = "lists all banned players",
				currentData = nil,
				canGet = true,
				inputType = "button"
			}
        },
        ['mapList'] = {
            ['add'] = {
				description = "<map, gamemode, rounds, offset>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
            ['remove'] = {
				description = "<index>",
				currentData = nil,
				canGet = false,
				inputType = "integer"
			},
            ['clear'] = {
				description = "- Clears the maplist",
				currentData = nil,
				canGet = false,
				inputType = "button"
			},
            ['list'] = {
				description = "<startIndex>",
				currentData = nil,
				canGet = false,
				inputType = "integer"
			},
            ['nextMap'] = {
				description = "<index>",
				currentData = nil,
				canGet = false,
				inputType = "integer"
			},
            ['getMapIndices'] = {
				description = " - Get indices for current & next map",
				currentData = nil,
				canGet = true,
				inputType = "button"
			},
            ['getRounds'] = {
				description = " - Get current round and number of rounds",
				currentData = nil,
				canGet = true,
				inputType = "button"
			},
            ['endRound'] = {
				description = "<teamID> - End Current round, declaring the specified team as winners",
				currentData = nil,
				canGet = false,
				inputType = "button"
			},
            ['runNext'] = {
				description = " - Run the next round",
				currentData = nil,
				canGet = false,
				inputType = "button"
			},
            ['restartRound'] = {
				description = " - Restart the current round",
				currentData = nil,
				canGet = false,
				inputType = "button"
			},
		},
        ['vars'] = {
            ['serverName'] = {
				description = "<name>",
				currentData = nil,
				canGet = true,
				inputType = "alphanumeric"
			},
            ['password'] = {
				description = "<password>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
            ['roundStartPlayerCount'] = {
				description = "<numPlayers>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['roundRestartPlayerCount'] = {
				description = "<numPlayers>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['preRound'] = {
				description = "<time> - Set duration of pre-round",
				currentData = nil,
				canGet = false,
				inputType = "integer"
			},
            ['serverMessage'] = {
				description = "<message>",
				currentData = nil,
				canGet = true,
				inputType = "alphanumeric"
			},
            ['friendlyfire'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['maxPlayers'] = {
				description = "<numPlayers>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['serverDesc'] = {
				description = "<description>",
				currentData = nil,
				canGet = true,
				inputType = "alphanumeric"
			},
            ['killCam'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['miniMap'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['hud'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['crossHair'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['3dSpotting'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['miniMapSpotting'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['nameTag'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['3pCam'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['regenerateHealth'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['teamKillCountForKick'] = {
				description = "<count>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['teamKillValueForKick'] = {
				description = "<count>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['teamKillValueIncrease'] = {
				description = "<count>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['teamKillValueDecreasePerSecond'] = {
				description = "<count>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['teamKillKickForBan'] = {
				description = "<count>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['idleTimeout'] = {
				description = "<time>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['idleBanRounds'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['vehicleSpawnAllowed'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['vehicleSpawnDelay'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true,
				inputType = "percentageModifier"
			},
            ['soldierHealth'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true,
				inputType = "percentageModifier"
			},
            ['playerRespawnTime'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true,
				inputType = "percentageModifier"
			},
            ['playerManDownTime'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true,
				inputType = "percentageModifier"
			},
            ['bulletDamage'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true,
				inputType = "percentageModifier"
			},
            ['gameModeCounter'] = {
                description = "<integer> - Set Ticket Scale",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['onlySquadLeaderSpawn'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['unlockMode'] = {
                description = "<mode>",
				currentData = nil,
				canGet = true,
				inputType = "alphanumeric"
			}
        },
        ['vu'] = {
            ['ColorCorrectionEnabled'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['DesertingAllowed'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['DestructionEnabled'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['FadeInAll'] = {
                description = "- Fade in all Players",
				currentData = nil,
				canGet = false,
				inputType = "button"
			},
            ['FadeOutAll'] = {
                description = "- Fade out all Players",
				currentData = nil,
				canGet = false,
				inputType = "button"
			},
            ['FrequencyMode'] = {
                description = " - return frequency of server",
				currentData = nil,
				canGet = true,
				inputType = "button"
			},
            ['HighPerformanceReplication'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['ServerBanner'] = {
                description = "<.jpg link>",
				currentData = nil,
				canGet = true,
				inputType = "alphanumeric"
			},
            ['SetTeamTicketCount'] = {
                description = "<team, amount>",
				currentData = nil,
				canGet = false,
				inputType = "alphanumeric"
			},
            ['SpectatorCount'] = {
                description = " - return spec count",
				currentData = nil,
				canGet = true,
				inputType = "button"
			},
            ['SquadSize'] = {
                description = "<size>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['SunFlareEnabled'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['SuppressionMultiplier'] = {
                description = "<float>",
				currentData = nil,
				canGet = true,
				inputType = "integer"
			},
            ['TimeScale'] = {
                description = "<float>",
				currentData = nil,
				canGet = true,
				inputType = "float"
			},
            ['VehicleDisablingEnabled'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true,
				inputType = "switch"
			},
            ['Fps'] = {
                description = " - return server fps",
				currentData = nil,
				canGet = true,
				inputType = "button"
			},
            ['FpsMa'] = {
                description = " - return 30-second moving average of the server FPS",
				currentData = nil,
				canGet = true,
				inputType = "button"
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

function Server:OnValuesUpdated(p_JSONData)
	local s_DecodedData = json.decode(p_JSONData)
    --- [1] Command (e.g. admin.say) [2] Arguments (e.g. "true, 1")
    RCON:SendCommand(s_DecodedData[1], {s_DecodedData[2]})
end

function Server:OnValuePullRequest(p_Player)
	local s_CurrentSettings = json.encode(self.m_ValidCommands)
    NetEvents:SendTo('IngameRCON:PullAnswer', p_Player, s_CurrentSettings)
end

function Server:ConstructCommandString(p_CommandGroup, p_Command)
    local s_ConstructedString = tostring(tostring(p_CommandGroup) .. "." .. tostring(p_Command))
    return s_ConstructedString
end

return Server()
