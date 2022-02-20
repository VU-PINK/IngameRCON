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
				currentData = nil,
				canGet = false
            },
            ['say'] = {
				currentData = nil,
				canGet = false
            },
            ['yell'] = {
				currentData = nil,
				canGet = false
			},
            ['kick'] = {
				currentData = nil,
				canGet = false
			},
            ['move'] = {
				currentData = nil,
				canGet = false
			},
            ['kill'] = {
				currentData = nil,
				canGet = false
			},
            ['ban'] = {
				currentData = nil,
				canGet = false
			},
            ['banRemove'] = {
				currentData = nil,
				canGet = false
			},
            ['banClear'] = {
				currentData = nil,
				canGet = false
			},
            ['banList'] = {
				currentData = nil,
				canGet = true
			}
        },
        ['mapList'] = {
            ['add'] = {
				currentData = nil,
				canGet = false
			},
            ['remove'] = {
				currentData = nil,
				canGet = false
			},
            ['clear'] = {
				currentData = nil,
				canGet = false
			},
            ['list'] = {
				currentData = nil,
				canGet = false
			},
            ['nextMap'] = {
				currentData = nil,
				canGet = false
			},
            ['getMaps'] = {
				currentData = nil,
				canGet = true
			},
            ['getRounds'] = {
				currentData = nil,
				canGet = true
			},
            ['endRound'] = {
				currentData = nil,
				canGet = false
			},
            ['runNext'] = {
				currentData = nil,
				canGet = false
			},
            ['restartRound'] = {
				currentData = nil,
				canGet = false
			},
		},
        ['vars'] = {
            ['serverName'] = {
				currentData = nil,
				canGet = true
			},
            ['password'] = {
				currentData = nil,
				canGet = false
			},
            ['roundStartPlayerCount'] = {
				currentData = nil,
				canGet = true
			},
            ['roundRestartPlayerCount'] = {
				currentData = nil,
				canGet = true
			},
            ['preRound'] = {
				currentData = nil,
				canGet = false
			},
            ['serverMessage'] = {
				currentData = nil,
				canGet = true
			},
            ['friendlyfire'] = {
				currentData = nil,
				canGet = true
			},
            ['maxPlayers'] = {
				currentData = nil,
				canGet = true
			},
            ['serverDesc'] = {
				currentData = nil,
				canGet = true
			},
            ['killCam'] = {
				currentData = nil,
				canGet = true
			},
            ['miniMap'] = {
				currentData = nil,
				canGet = true
			},
            ['hud'] = {
				currentData = nil,
				canGet = true
			},
            ['crossHair'] = {
				currentData = nil,
				canGet = true
			},
            ['Spotting'] = {
				currentData = nil,
				canGet = true
			},
            ['miniMapSpotting'] = {
				currentData = nil,
				canGet = true
			},
            ['nameTag'] = {
				currentData = nil,
				canGet = true
			},
            ['thirdPersonCam'] = {
				currentData = nil,
				canGet = true
			},
            ['regenerateHealth'] = {
				currentData = nil,
				canGet = true
			},
            ['teamKillCountForKick'] = {
				currentData = nil,
				canGet = true
			},
            ['teamKillValueForKick'] = {
				currentData = nil,
				canGet = true
			},
            ['teamKillKillValueIncrease'] = {
				currentData = nil,
				canGet = true
			},
            ['teamKillKillValueDecreasePerSecond'] = {
				currentData = nil,
				canGet = true
			},
            ['teamKillKickForBan'] = {
				currentData = nil,
				canGet = true
			},
            ['idleTimeout'] = {
				currentData = nil,
				canGet = true
			},
            ['idleBanRounds'] = {
				currentData = nil,
				canGet = true
			},
            ['vehicleSpawnAllowed'] = {
				currentData = nil,
				canGet = true
			},
            ['vehicleSpawnDelay'] = {
				currentData = nil,
				canGet = true
			},
            ['soldierHealth'] = {
				currentData = nil,
				canGet = true
			},
            ['playerRespawnTime'] = {
				currentData = nil,
				canGet = true
			},
            ['playerManDownTime'] = {
				currentData = nil,
				canGet = true
			},
            ['bulletDamage'] = {
				currentData = nil,
				canGet = true
			},
            ['gameModeCounter'] = {
				currentData = nil,
				canGet = true
			},
            ['onlySquadLeaderSpawn'] = {
				currentData = nil,
				canGet = true
			},
            ['unlockMode'] = {
				currentData = nil,
				canGet = true
			}
        },
        ['vu'] = {
            ['ColorCorrectionEnabled'] = {
				currentData = nil,
				canGet = true
			},
            ['DesertingAllowed'] = {
				currentData = nil,
				canGet = true
			},
            ['DestructionEnabled'] = {
				currentData = nil,
				canGet = true
			},
            ['FadeInAll'] = {
				currentData = nil,
				canGet = false
			},
            ['FadeOutAll'] = {
				currentData = nil,
				canGet = false
			},
            ['FrequencyMode'] = {
				currentData = nil,
				canGet = true
			},
            ['HighPerformanceReplication'] = {
				currentData = nil,
				canGet = true
			},
            ['ServerBanner'] = {
				currentData = nil,
				canGet = true
			},
            ['SetTeamTicketCount'] = {
				currentData = nil,
				canGet = false
			},
            ['SpectatorCount'] = {
				currentData = nil,
				canGet = true
			},
            ['SquadSize'] = {
				currentData = nil,
				canGet = true
			},
            ['SunFlareEnabled'] = {
				currentData = nil,
				canGet = true
			},
            ['SuppressionMultiplier'] = {
				currentData = nil,
				canGet = true
			},
            ['TimeScale'] = {
				currentData = nil,
				canGet = true
			},
            ['VehicleDisablingEnabled'] = {
				currentData = nil,
				canGet = true
			},
            ['Fps'] = {
				currentData = nil,
				canGet = true
			},
            ['FpsMa'] = {
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
				l_CommandTable['currentData'] = s_ReceivedData
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
