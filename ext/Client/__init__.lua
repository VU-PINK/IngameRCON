---@class Client
local Client = class('Client')

function Client:__init()
    self:RegisterVars()
    self:RegisterEvents()
end

function Client:RegisterVars()
	self.m_ValidCommands = {
        admin = {
            password = {
                description = "<password>"
            },
            say = {
                description = "<message, players>"
            },
            yell = {
                description = "<message, duration, players>"
			},
            kick = {
                description = "<soldier name, reason>"
			},
            move = {
                description = "<name, teamID, squadID, forceKill>"
			},
            kill = {
                description = "<name>"
			},
            ban = {
                description = "<id-type, id, timeout, reason>"
			},
            banRemove = {
                description = "<id-type, id>"
			},
            banClear = {
                description = "clears the banlist"
			},
            banList = {
                description = "lists all banned players"
			}
        },
        maps = {
            add = {
                description = "<map, gamemode, rounds, offset>"
			},
            remove = {
                description = "<index>"
			},
            clear = {
                description = "- Clears the maplist"
			},
            list = {
                description = "<startIndex>"
			},
            nextMap = {
                description = "<index>"
			},
            getMapIndices = {
                description = " - Get indices for current & next map"
			},
            getRounds = {
                description = " - Get current round and number of rounds"
			},
            endRound = {
                description = "<teamID> - End Current round, declaring the specified team as winners"
			},
            runNext = {
                description = " - Run the next round"
			},
            restartRound = {
                description = " - Restart the current round"
			},
		},
        vars = {
            serverName = {
                description = "<name>"
			},
            password = {
                description = "<password>"
			},
            roundStartPlayerCount = {
                description = "<numPlayers>"
			},
            roundRestartPlayerCount = {
                description = "<numPlayers>"
			},
            preRound = {
                description = "<time> - Set duration of pre-round"
			},
            serverMessage = {
                description = "<message>"
			},
            friendlyfire = {
                description = "<true/false>"
			},
            maxPlayers = {
                description = "<numPlayers>"
			},
            serverDesc = {
                description = "<description>"
			},
            killCam = {
                description = "<true/false>"
			},
            miniMap = {
                description = "<true/false>"
			},
            hud = {
                description = "<true/false>"
			},
            crossHair = {
                description = "<true/false>"
			},
            Spotting = {
                description = "<true/false>"
			},
            miniMapSpotting = {
                description = "<true/false>"
			},
            nameTag = {
                description = "<true/false>"
			},
            thirdPersonCam = {
                description = "<true/false>"
			},
            regenerateHealth = {
                description = "<true/false>"
			},
            teamKillCountForKick = {
                description = "<count>"
			},
            teamKillValueForKick = {
                description = "<count>"
			},
            teamKillKillValueIncrease = {
                description = "<count>"
			},
            teamKillKillValueDecreasePerSecond = {
                description = "<count>"
			},
            teamKillKickForBan = {
                description = "<count>"
			},
            idleTimeout = {
                description = "<time>"
			},
            idleBanRounds = {
                description = "<true/false>"
			},
            vehicleSpawnAllowed = {
                description = "<true/false>"
			},
            vehicleSpawnDelay = {
                description = "<percentage modifier>"
			},
            soldierHealth = {
                description = "<percentage modifier>"
			},
            playerRespawnTime = {
                description = "<percentage modifier>"
			},
            playerManDownTime = {
                description = "<percentage modifier>"
			},
            bulletDamage = {
                description = "<percentage modifier>"
			},
            gameModeCounter = {
                description = "<integer> - Set Ticket Scale"
			},
            onlySquadLeaderSpawn = {
                description = "<true/false>"
			},
            unlockMode = {
                description = "<mode>"
			}
        },
        vu = {
            ColorCorrectionEnabled = {
                description = "<true/false>"
			},
            DesertingAllowed = {
                description = "true/false"
			},
            DestructionEnabled = {
                description = "true/false"
			},
            FadeInAll = {
                description = "- Fade in all Players"
			},
            FadeOutAll = {
                description = "- Fade out all Players"
			},
            FrequencyMode = {
                description = " - return frequency of server"
			},
            HighPerformanceReplication = {
                description = "<true/false>"
			},
            ServerBanner = {
                description = "<.jpg link>"
			},
            SetTeamTicketCount = {
                description = "<team, amount>"
			},
            SpectatorCount = {
                description = " - return spec count"
			},
            SquadSize = {
                description = "<size>"
			},
            SunFlareEnabled = {
                description = "<true/false>"
			},
            SuppressionMultiplier = {
                description = "<float>"
			},
            TimeScale = {
                description = "<float>"
			},
            VehicleDisablingEnabled = {
                description = "<true/false>"
			},
            Fps = {
                description = " - return server fps"
			},
            FpsMa = {
                description = " - return 30-second moving average of the server FPS"
			},
        }
	}
end

function Client:RegisterEvents()
	-- Net
	NetEvents:Subscribe('IngameRCON:PullAnswer', self, self.OnPullAnswer)
	-- Events
    Events:Subscribe('WebUI:UpdateValues', self, self.OnWebUIUpdateValues)
	Events:Subscribe('WebUI:PullRequest', self, self.OnPullRequest)
end

function Client:OnWebUIUpdateValues(p_JSONData)
	NetEvents:Send('IngameRCON:UpdateValues', p_JSONData)
end

function Client:OnPullRequest()
	NetEvents:Send('IngameRCON:PullRequest')
end

function Client:OnPullAnswer(p_CurrentSettingsJSON)
	local s_ReceivedSettings = json.decode(p_CurrentSettingsJSON)

	for l_CommandGroup, l_Command in pairs(self.m_ValidCommands) do
        if s_ReceivedSettings[l_CommandGroup][l_Command]['canGet'] == true then
            l_Command['currentData'] = s_ReceivedSettings[l_CommandGroup][l_Command]["currentData"]
        end
	end

	WebUI:ExecuteJS(string.format("OnSyncValues(%s);", json.encode(self.m_ValidCommands)))
end

return Client()
