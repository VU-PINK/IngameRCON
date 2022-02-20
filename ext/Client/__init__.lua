---@class Client
local Client = class('Client')

local m_Logger = Logger('Client', true)

function Client:__init()
    self:RegisterVars()
    self:RegisterEvents()
end

function Client:RegisterVars()

end

function Client:RegisterEvents()
	-- Net
	NetEvents:Subscribe('IngameRCON:PullAnswer', self, self.OnPullAnswer)
	-- Events
	Events:Subscribe('Extension:Loaded', self, self.OnExtensionLoaded)
    Events:Subscribe('Client:UpdateInput', self, self.OnClientUpdateInput)
    Events:Subscribe('WebUI:UpdateValues', self, self.OnWebUIUpdateValues)
	Events:Subscribe('WebUI:PullRequest', self, self.OnPullRequest)
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

return Client()
