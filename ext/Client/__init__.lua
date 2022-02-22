---@class Client
local Client = class('Client')

local m_Logger = Logger('Client', true)

function Client:__init()
    self:RegisterVars()
    self:RegisterEvents()
end

function Client:RegisterVars()
    self.m_AvailableMaps = {
        ['MP_001'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_003'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_007'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_011'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_012'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_013'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_017'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_018'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_Subway'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP1_001'] = {'ConquestAssaultLarge0', 'ConquestAssaultSmall0', 'ConquestAssaultSmall1', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP1_002'] = {'ConquestAssaultSmall0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP1_003'] = {'ConquestAssaultLarge0', 'ConquestAssaultSmall0', 'ConquestAssaultSmall1', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP1_004'] = {'ConquestAssaultLarge0', 'ConquestAssaultSmall0', 'ConquestAssaultSmall1', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP2_Palace'] = {'Domination0', 'GunMaster0', 'SquadDeathMatch0', 'TeamDeathMatchC0'},
        ['XP2_Office'] = {'Domination0', 'GunMaster0', 'SquadDeathMatch0', 'TeamDeathMatchC0'},
        ['XP2_Factory'] = {'Domination0', 'GunMaster0', 'SquadDeathMatch0', 'TeamDeathMatchC0'},
        ['XP2_Skybar'] = {'Domination0', 'GunMaster0', 'SquadDeathMatch0', 'TeamDeathMatchC0'},
        ['XP3_Alborz'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TankSuperiority0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP3_Shield'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TankSuperiority0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP3_Desert'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TankSuperiority0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP3_Valley'] = {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TankSuperiority0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP4_Parl'] = {'ConquestLarge0', 'ConquestSmall0', 'GunMaster0', 'RushLarge0', 'Scavenger0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP4_Quake'] = {'ConquestLarge0', 'ConquestSmall0', 'GunMaster0', 'RushLarge0', 'Scavenger0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP4_FD'] = {'ConquestLarge0', 'ConquestSmall0', 'GunMaster0', 'RushLarge0', 'Scavenger0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP4_Rubble'] = {'ConquestAssaultLarge0', 'ConquestAssaultSmall0', 'GunMaster0', 'RushLarge0', 'Scavenger0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP5_001'] = {'AirSuperiority0', 'CaptureTheFlag0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP5_002'] = {'AirSuperiority0', 'CaptureTheFlag0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP5_003'] = {'AirSuperiority0', 'CaptureTheFlag0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP5_004'] = {'AirSuperiority0', 'CaptureTheFlag0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
    }
end

function Client:RegisterEvents()
	-- Net
	NetEvents:Subscribe('IngameRCON:PullAnswer', self, self.OnPullAnswer)
	-- Events
	Events:Subscribe('Extension:Loaded', self, self.OnExtensionLoaded)
    Events:Subscribe('Client:UpdateInput', self, self.OnClientUpdateInput)
    Events:Subscribe('WebUI:UpdateValues', self, self.OnWebUIUpdateValues)
	Events:Subscribe('WebUI:PullRequest', self, self.OnPullRequest)
    Events:Subscribe('InGameRCON:RegisterCustomMap', self, self.OnMapRegister)
end

function Client:OnExtensionLoaded()
	WebUI:Init()
end

function Client:OnClientUpdateInput()
    -- TODO: Check if admin
	if InputManager:WentKeyDown(InputDeviceKeys.IDK_F10) then
        WebUI:ExecuteJS("OnToggleMenu();")
	end
end

function Client:OnWebUIUpdateValues(p_JSONData)
	NetEvents:Send('IngameRCON:UpdateValues', p_JSONData)
end

function Client:OnPullRequest()
    m_Logger:Write("OnPullRequest")
	NetEvents:Send('IngameRCON:PullRequest')
end

function Client:OnPullAnswer(p_CurrentSettingsJSON)
    local s_ReceivedSettings = json.decode(p_CurrentSettingsJSON)
    m_Logger:Write('*Full Table:' .. json.encode(s_ReceivedSettings))
    WebUI:ExecuteJS(string.format("OnSyncValues(%s);", json.encode(s_ReceivedSettings)))
end

function Client:OnMapRegister(p_MapTable)
    --Table has to look like: {'NameOfMap', {'Mode1, Mode2, Mode3'}}
    if p_MapTable ~= nil and type(p_MapTable[1] == 'string' and type(p_MapTable[2]) == 'table') then
        m_Logger:Write('Received Custom Map: ' .. p_MapTable[1] .. ' with Modes: ' .. p_MapTable[2])
        self.m_AvailableMaps[p_MapTable[1]] = p_MapTable[2]
    end
end

return Client()
