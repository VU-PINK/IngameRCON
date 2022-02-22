---@class Client
local Client = class('Client')

local m_Logger = Logger('Client', true)

function Client:__init()
    self:RegisterVars()
    self:RegisterEvents()
end

function Client:RegisterVars()
    self.m_AvailableMaps = {
        ['MP_001'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_003'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_007'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_011'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_012'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_013'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_017'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_018'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['MP_Subway'] = {'Vanilla'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP1_001'] = {'Back to Karkand'}, {'ConquestAssaultLarge0', 'ConquestAssaultSmall0', 'ConquestAssaultSmall1', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP1_002'] = {'Back to Karkand'}, {'ConquestAssaultSmall0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP1_003'] = {'Back to Karkand'}, {'ConquestAssaultLarge0', 'ConquestAssaultSmall0', 'ConquestAssaultSmall1', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP1_004'] = {'Back to Karkand'}, {'ConquestAssaultLarge0', 'ConquestAssaultSmall0', 'ConquestAssaultSmall1', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP2_Palace'] = {'Close Quarters'}, {'Domination0', 'GunMaster0', 'SquadDeathMatch0', 'TeamDeathMatchC0'},
        ['XP2_Office'] = {'Close Quarters'}, {'Domination0', 'GunMaster0', 'SquadDeathMatch0', 'TeamDeathMatchC0'},
        ['XP2_Factory'] = {'Close Quarters'}, {'Domination0', 'GunMaster0', 'SquadDeathMatch0', 'TeamDeathMatchC0'},
        ['XP2_Skybar'] = {'Close Quarters'}, {'Domination0', 'GunMaster0', 'SquadDeathMatch0', 'TeamDeathMatchC0'},
        ['XP3_Alborz'] = {'Armored Shield'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TankSuperiority0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP3_Shield'] = {'Armored Shield'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TankSuperiority0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP3_Desert'] = {'Armored Shield'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TankSuperiority0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP3_Valley'] = {'Armored Shield'}, {'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TankSuperiority0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP4_Parl'] = {'Aftermath'}, {'ConquestLarge0', 'ConquestSmall0', 'GunMaster0', 'RushLarge0', 'Scavenger0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP4_Quake'] = {'Aftermath'}, {'ConquestLarge0', 'ConquestSmall0', 'GunMaster0', 'RushLarge0', 'Scavenger0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP4_FD'] = {'Aftermath'}, {'ConquestLarge0', 'ConquestSmall0', 'GunMaster0', 'RushLarge0', 'Scavenger0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP4_Rubble'] = {'Aftermath'}, {'ConquestAssaultLarge0', 'ConquestAssaultSmall0', 'GunMaster0', 'RushLarge0', 'Scavenger0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP5_001'] = {'End Game'}, {'AirSuperiority0', 'CaptureTheFlag0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP5_002'] = {'End Game'}, {'AirSuperiority0', 'CaptureTheFlag0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP5_003'] = {'End Game'}, {'AirSuperiority0', 'CaptureTheFlag0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
        ['XP5_004'] = {'End Game'}, {'AirSuperiority0', 'CaptureTheFlag0', 'ConquestLarge0', 'ConquestSmall0', 'RushLarge0', 'SquadDeathMatch0', 'SquadRush0', 'TeamDeathMatch0', 'TeamDeathMatchC0'},
    }

    self.IsAdmin = false
end

function Client:RegisterEvents()
	-- Net
	NetEvents:Subscribe('IngameRCON:PullAnswer', self, self.OnPullAnswer)
    NetEvents:Subscribe('IngameRCON:IsAdmin', self, self.OnServerAdminCheck)
	-- Events
	Events:Subscribe('Extension:Loaded', self, self.OnExtensionLoaded)
    Events:Subscribe('Client:UpdateInput', self, self.OnClientUpdateInput)
    Events:Subscribe('WebUI:UpdateValues', self, self.OnWebUIUpdateValues)
	Events:Subscribe('WebUI:PullRequest', self, self.OnPullRequest)
    Events:Subscribe('InGameRCON:RegisterCustomMap', self, self.OnMapRegister)
end

function Client:OnExtensionLoaded()
	WebUI:Init()
    WebUI:Hide()
end

function Client:OnClientUpdateInput()
    -- TODO: Check if admin
	if self.IsAdmin and InputManager:WentKeyDown(InputDeviceKeys.IDK_F10) then
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
    --Table has to look like: {'NameOfMap', {'CustomGroup'}, {'Mode1, Mode2, Mode3'}}
    if p_MapTable ~= nil and type(p_MapTable[1] == 'string' and type(p_MapTable[2]) == 'table') then
        m_Logger:Write('Received Custom Map: ' .. p_MapTable[1] .. ' with Modes: ' .. p_MapTable[2])
        self.m_AvailableMaps[p_MapTable[1]] = p_MapTable[2]
    end
end

function Client:OnServerAdminCheck(p_Boolean)
    self.IsAdmin = p_Boolean

    if p_Boolean then
        WebUI:Show()
    else
        WebUI:Hide()
    end
end

return Client()
