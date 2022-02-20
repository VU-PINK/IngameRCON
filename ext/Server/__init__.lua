---@class Server
local Server = class('Server')

local m_Logger = Logger('Server', true)

function Server:__init()
    self:RegisterVars()
    self:RegisterEvents()
end

function Server:RegisterVars()
    self.m_ValidCommands = {
        admin = {
            password = {
				currentData = nil
            },
            say = {
				currentData = nil
            },
            yell = {
				currentData = nil
			},
            kick = {
				currentData = nil
			},
            move = {
				currentData = nil
			},
            kill = {
				currentData = nil
			},
            ban = {
				currentData = nil
			},
            banRemove = {
				currentData = nil
			},
            banClear = {
				currentData = nil
			},
            banList = {
				currentData = nil
			}
        },
        maps = {
            add = {
				currentData = nil
			},
            remove = {
				currentData = nil
			},
            clear = {
				currentData = nil
			},
            list = {
				currentData = nil
			},
            nextMap = {
				currentData = nil
			},
            getMaps = {
				currentData = nil
			},
            getRounds = {
				currentData = nil
			},
            endRound = {
				currentData = nil
			},
            runNext = {
				currentData = nil
			},
            restartRound = {
				currentData = nil
			},
		},
        vars = {
            serverName = {
				currentData = nil
			},
            password = {
				currentData = nil
			},
            roundStartPlayerCount = {
				currentData = nil
			},
            roundRestartPlayerCount = {
				currentData = nil
			},
            preRound = {
				currentData = nil
			},
            serverMessage = {
				currentData = nil
			},
            friendlyfire = {
				currentData = nil
			},
            maxPlayers = {
				currentData = nil
			},
            serverDesc = {
				currentData = nil
			},
            killCam = {
				currentData = nil
			},
            miniMap = {
				currentData = nil
			},
            hud = {
				currentData = nil
			},
            crossHair = {
				currentData = nil
			},
            Spotting = {
				currentData = nil
			},
            miniMapSpotting = {
				currentData = nil
			},
            nameTag = {
				currentData = nil
			},
            thirdPersonCam = {
				currentData = nil
			},
            regenerateHealth = {
				currentData = nil
			},
            teamKillCountForKick = {
				currentData = nil
			},
            teamKillValueForKick = {
				currentData = nil
			},
            teamKillKillValueIncrease = {
				currentData = nil
			},
            teamKillKillValueDecreasePerSecond = {
				currentData = nil
			},
            teamKillKickForBan = {
				currentData = nil
			},
            idleTimeout = {
				currentData = nil
			},
            idleBanRounds = {
				currentData = nil
			},
            vehicleSpawnAllowed = {
				currentData = nil
			},
            vehicleSpawnDelay = {
				currentData = nil
			},
            soldierHealth = {
				currentData = nil
			},
            playerRespawnTime = {
				currentData = nil
			},
            playerManDownTime = {
				currentData = nil
			},
            bulletDamage = {
				currentData = nil
			},
            gameModeCounter = {
				currentData = nil
			},
            onlySquadLeaderSpawn = {
				currentData = nil
			},
            unlockMode = {
				currentData = nil
			}
        },
        vu = {
            ColorCorrectionEnabled = {
				currentData = nil
			},
            DesertingAllowed = {
				currentData = nil
			},
            DestructionEnabled = {
				currentData = nil
			},
            FadeInAll = {
				currentData = nil
			},
            FadeOutAll = {
				currentData = nil
			},
            FrequencyMode = {
				currentData = nil
			},
            HighPerformanceReplication = {
				currentData = nil
			},
            ServerBanner = {
				currentData = nil
			},
            SetTeamTicketCount = {
				currentData = nil
			},
            SpectatorCount = {
				currentData = nil
			},
            SquadSize = {
				currentData = nil
			},
            SunFlareEnabled = {
				currentData = nil
			},
            SuppressionMultiplier = {
				currentData = nil
			},
            TimeScale = {
				currentData = nil
			},
            VehicleDisablingEnabled = {
				currentData = nil
			},
            Fps = {
				currentData = nil
			},
            FpsMa = {
				currentData = nil
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
    for l_CommandGroup, l_Command in pairs(self.m_ValidCommands) do
		local s_ConstructedString = self:ConstructCommandString(l_CommandGroup, l_Command)
		local s_ReceivedData = RCON:SendCommand(s_ConstructedString)
        l_Command['currentData'] = s_ReceivedData
        m_Logger:Write('Get Command (' .. s_ConstructedString .. ') Value: ' .. s_ReceivedData)
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
    local s_ConstructedString = p_CommandGroup .. "." .. p_Command
    return s_ConstructedString
end

return Server()
