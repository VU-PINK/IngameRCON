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
				canGet = false
            },
            ['say'] = {
				description = "<message, players>",
				currentData = nil,
				canGet = false
            },
            ['yell'] = {
				description = "<message, duration, players>",
				currentData = nil,
				canGet = false
			},
            ['kick'] = {
				description = "<soldier name, reason>",
				currentData = nil,
				canGet = false
			},
            ['move'] = {
				description = "<name, teamID, squadID, forceKill>",
				currentData = nil,
				canGet = false
			},
            ['kill'] = {
				description = "<name>",
				currentData = nil,
				canGet = false
			},
		},
		['banList'] = {
			['add'] = {
				description = "<id-type, id, timeout, reason>",
				currentData = nil,
				canGet = false
			},
            ['remove'] = {
				description = "<id-type, id>",
				currentData = nil,
				canGet = false
			},
            ['clear'] = {
				description = "clears the banlist",
				currentData = nil,
				canGet = false
			},
            ['list'] = {
				description = "lists all banned players",
				currentData = nil,
				canGet = true
			}
        },
        ['mapList'] = {
            ['add'] = {
				description = "<map, gamemode, rounds, offset>",
				currentData = nil,
				canGet = false
			},
            ['remove'] = {
				description = "<index>",
				currentData = nil,
				canGet = false
			},
            ['clear'] = {
				description = "- Clears the maplist",
				currentData = nil,
				canGet = false
			},
            ['list'] = {
				description = "<startIndex>",
				currentData = nil,
				canGet = false
			},
            ['nextMap'] = {
				description = "<index>",
				currentData = nil,
				canGet = false
			},
            ['getMapIndices'] = {
				description = " - Get indices for current & next map",
				currentData = nil,
				canGet = true
			},
            ['getRounds'] = {
				description = " - Get current round and number of rounds",
				currentData = nil,
				canGet = true
			},
            ['endRound'] = {
				description = "<teamID> - End Current round, declaring the specified team as winners",
				currentData = nil,
				canGet = false
			},
            ['runNext'] = {
				description = " - Run the next round",
				currentData = nil,
				canGet = false
			},
            ['restartRound'] = {
				description = " - Restart the current round",
				currentData = nil,
				canGet = false
			},
		},
        ['vars'] = {
            ['serverName'] = {
				description = "<name>",
				currentData = nil,
				canGet = true
			},
            ['password'] = {
				description = "<password>",
				currentData = nil,
				canGet = false
			},
            ['roundStartPlayerCount'] = {
				description = "<numPlayers>",
				currentData = nil,
				canGet = true
			},
            ['roundRestartPlayerCount'] = {
				description = "<numPlayers>",
				currentData = nil,
				canGet = true
			},
            ['preRound'] = {
				description = "<time> - Set duration of pre-round",
				currentData = nil,
				canGet = false
			},
            ['serverMessage'] = {
				description = "<message>",
				currentData = nil,
				canGet = true
			},
            ['friendlyfire'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['maxPlayers'] = {
				description = "<numPlayers>",
				currentData = nil,
				canGet = true
			},
            ['serverDesc'] = {
				description = "<description>",
				currentData = nil,
				canGet = true
			},
            ['killCam'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['miniMap'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['hud'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['crossHair'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['3dSpotting'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['miniMapSpotting'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['nameTag'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['3pCam'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['regenerateHealth'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['teamKillCountForKick'] = {
				description = "<count>",
				currentData = nil,
				canGet = true
			},
            ['teamKillValueForKick'] = {
				description = "<count>",
				currentData = nil,
				canGet = true
			},
            ['teamKillValueIncrease'] = {
				description = "<count>",
				currentData = nil,
				canGet = true
			},
            ['teamKillValueDecreasePerSecond'] = {
				description = "<count>",
				currentData = nil,
				canGet = true
			},
            ['teamKillKickForBan'] = {
				description = "<count>",
				currentData = nil,
				canGet = true
			},
            ['idleTimeout'] = {
				description = "<time>",
				currentData = nil,
				canGet = true
			},
            ['idleBanRounds'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['vehicleSpawnAllowed'] = {
				description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['vehicleSpawnDelay'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true
			},
            ['soldierHealth'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true
			},
            ['playerRespawnTime'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true
			},
            ['playerManDownTime'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true
			},
            ['bulletDamage'] = {
				description = "<percentage modifier>",
				currentData = nil,
				canGet = true
			},
            ['gameModeCounter'] = {
                description = "<integer> - Set Ticket Scale",
				currentData = nil,
				canGet = true
			},
            ['onlySquadLeaderSpawn'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['unlockMode'] = {
                description = "<mode>",
				currentData = nil,
				canGet = true
			}
        },
        ['vu'] = {
            ['ColorCorrectionEnabled'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['DesertingAllowed'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['DestructionEnabled'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['FadeInAll'] = {
                description = "- Fade in all Players",
				currentData = nil,
				canGet = false
			},
            ['FadeOutAll'] = {
                description = "- Fade out all Players",
				currentData = nil,
				canGet = false
			},
            ['FrequencyMode'] = {
                description = " - return frequency of server",
				currentData = nil,
				canGet = true
			},
            ['HighPerformanceReplication'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['ServerBanner'] = {
                description = "<.jpg link>",
				currentData = nil,
				canGet = true
			},
            ['SetTeamTicketCount'] = {
                description = "<team, amount>",
				currentData = nil,
				canGet = false
			},
            ['SpectatorCount'] = {
                description = " - return spec count",
				currentData = nil,
				canGet = true
			},
            ['SquadSize'] = {
                description = "<size>",
				currentData = nil,
				canGet = true
			},
            ['SunFlareEnabled'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['SuppressionMultiplier'] = {
                description = "<float>",
				currentData = nil,
				canGet = true
			},
            ['TimeScale'] = {
                description = "<float>",
				currentData = nil,
				canGet = true
			},
            ['VehicleDisablingEnabled'] = {
                description = "<true/false>",
				currentData = nil,
				canGet = true
			},
            ['Fps'] = {
                description = " - return server fps",
				currentData = nil,
				canGet = true
			},
            ['FpsMa'] = {
                description = " - return 30-second moving average of the server FPS",
				currentData = nil,
				canGet = true
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
