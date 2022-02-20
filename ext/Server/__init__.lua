---@class Server
local Server = class('Server')

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

function Server:GetCurrentSettings()
    for l_CommandGroup, l_Command in pairs(self.m_ValidCommands) do
		local s_ConstructedString = l_CommandGroup .. "." .. l_Command
		local s_ReceivedData = RCON:SendCommand(s_ConstructedString)
        l_Command['currentData'] = s_ReceivedData
        Logger:Write('Get Command (' .. s_ConstructedString .. ') Value: ' .. s_ReceivedData)
	end
end

function Server:OnValuesUpdated(p_JSONData)
	local s_DecodedData = json.decode(p_JSONData)
end

function Server:OnValuePullRequest(p_JSONData)
	local s_CurrentSettings
    -- do smth

    NetEvents:Dispatch('IngameRCON:PullAnswer', s_CurrentSettings)
end

return Server()
