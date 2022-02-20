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
                description = "<password>",
				currentData = nil
            },
            say = {
                description = "<message, players>",
				currentData = nil
            },
            yell = {
                description = "<message, duration, players>",
				currentData = nil
			},
            kick = {
                description = "<soldier name, reason>",
				currentData = nil
			},
            move = {
                description = "<name, teamID, squadID, forceKill>",
				currentData = nil
			},
            kill = {
                description = "<name>",
				currentData = nil
			},
            ban = {
                description = "<id-type, id, timeout, reason>",
				currentData = nil
			},
            banRemove = {
                description = "<id-type, id>",
				currentData = nil
			},
            banClear = {
                description = "clears the banlist",
				currentData = nil
			},
            banList = {
                description = "lists all banned players",
				currentData = nil
			}
        },
        maps = {
            add = {
                description = "<map, gamemode, rounds, offset>",
				currentData = nil
			},
            remove = {
                description = "<index>",
				currentData = nil
			},
            clear = {
                description = "- Clears the maplist",
				currentData = nil
			},
            list = {
                description = "<startIndex>",
				currentData = nil
			},
            nextMap = {
                description = "<index>",
				currentData = nil
			},
            getMaps = {
                description = " - Get indices for current & next map",
				currentData = nil
			},
            getRounds = {
                description = " - Get current round and number of rounds",
				currentData = nil
			},
            endRound = {
                description = "<teamID> - End Current round, declaring the specified team as winners",
				currentData = nil
			},
            runNext = {
                description = " - Run the next round",
				currentData = nil
			},
            restartRound = {
                description = " - Restart the current round",
				currentData = nil
			},
		},
        vars = {
            serverName = {
                description = "<name>",
				currentData = nil
			},
            password = {
                description = "<password>",
				currentData = nil
			},
            roundStartPlayerCount = {
                description = "<numPlayers>",
				currentData = nil
			},
            roundRestartPlayerCount = {
                description = "<numPlayers>",
				currentData = nil
			},
            preRound = {
                description = "<time> - Set duration of pre-round",
				currentData = nil
			},
            serverMessage = {
                description = "<message>",
				currentData = nil
			},
            friendlyfire = {
                description = "<true/false>",
				currentData = nil
			},
            maxPlayers = {
                description = "<numPlayers>",
				currentData = nil
			},
            serverDesc = {
                description = "<description>",
				currentData = nil
			},
            killCam = {
                description = "<true/false>",
				currentData = nil
			},
            miniMap = {
                description = "<true/false>",
				currentData = nil
			},
            hud = {
                description = "<true/false>",
				currentData = nil
			},
            crossHair = {
                description = "<true/false>",
				currentData = nil
			},
            Spotting = {
                description = "<true/false>",
				currentData = nil
			},
            miniMapSpotting = {
                description = "<true/false>",
				currentData = nil
			},
            nameTag = {
                description = "<true/false>",
				currentData = nil
			},
            thirdPersonCam = {
                description = "<true/false>",
				currentData = nil
			},
            regenerateHealth = {
                description = "<true/false>",
				currentData = nil
			},
            teamKillCountForKick = {
                description = "<count>",
				currentData = nil
			},
            teamKillValueForKick = {
                description = "<count>",
				currentData = nil
			},
            teamKillKillValueIncrease = {
                description = "<count>",
				currentData = nil
			},
            teamKillKillValueDecreasePerSecond = {
                description = "<count>",
				currentData = nil
			},
            teamKillKickForBan = {
                description = "<count>",
				currentData = nil
			},
            idleTimeout = {
                description = "<time>",
				currentData = nil
			},
            idleBanRounds = {
                description = "<true/false>",
				currentData = nil
			},
            vehicleSpawnAllowed = {
                description = "<true/false>",
				currentData = nil
			},
            vehicleSpawnDelay = {
                description = "<percentage modifier>",
				currentData = nil
			},
            soldierHealth = {
                description = "<percentage modifier>",
				currentData = nil
			},
            playerRespawnTime = {
                description = "<percentage modifier>",
				currentData = nil
			},
            playerManDownTime = {
                description = "<percentage modifier>",
				currentData = nil
			},
            bulletDamage = {
                description = "<percentage modifier>",
				currentData = nil
			},
            gameModeCounter = {
                description = "<integer> - Set Ticket Scale",
				currentData = nil
			},
            onlySquadLeaderSpawn = {
                description = "<true/false>",
				currentData = nil
			},
            unlockMode = {
                description = "<mode>",
				currentData = nil
			}
        },
        vu = {
            ColorCorrectionEnabled = {
                description = "<true/false>",
				currentData = nil
			},
            DesertingAllowed = {
                description = "true/false",
				currentData = nil
			},
            DestructionEnabled = {
                description = "true/false",
				currentData = nil
			},
            FadeInAll = {
                description = "- Fade in all Players",
				currentData = nil
			},
            FadeOutAll = {
                description = "- Fade out all Players",
				currentData = nil
			},
            FrequencyMode = {
                description = " - return frequency of server",
				currentData = nil
			},
            HighPerformanceReplication = {
                description = "<true/false>",
				currentData = nil
			},
            ServerBanner = {
                description = "<.jpg link>",
				currentData = nil
			},
            SetTeamTicketCount = {
                description = "<team, amount>",
				currentData = nil
			},
            SpectatorCount = {
                description = " - return spec count",
				currentData = nil
			},
            SquadSize = {
                description = "<size>",
				currentData = nil
			},
            SunFlareEnabled = {
                description = "<true/false>",
				currentData = nil
			},
            SuppressionMultiplier = {
                description = "<float>",
				currentData = nil
			},
            TimeScale = {
                description = "<float>",
				currentData = nil
			},
            VehicleDisablingEnabled = {
                description = "<true/false>",
				currentData = nil
			},
            Fps = {
                description = " - return server fps",
				currentData = nil
			},
            FpsMa = {
                description = " - return 30-second moving average of the server FPS",
				currentData = nil
			},
        }
	}
end

function Client:RegisterEvents()
	-- Net
	NetEvents:Subscribe('IngameRCON:PullAnswer', self, self.OnPullAnswer)
	-- Events
	Events:Subscribe('Extension:Loaded', self, self.OnExtensionLoaded)
    Events:Subscribe('WebUI:UpdateValues', self, self.OnWebUIUpdateValues)
	Events:Subscribe('WebUI:PullRequest', self, self.OnPullRequest)
end

function Client:OnExtensionLoaded()
	WebUI:Init()
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
        l_Command['currentData'] = s_ReceivedSettings[l_CommandGroup][l_Command]["currentData"]
	end

	WebUI:ExecuteJS(string.format("OnSyncValues(%s);", json.encode(self.m_ValidCommands)))
end

return Client()
