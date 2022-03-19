EBF = LibStub("AceAddon-3.0"):NewAddon("kEBF", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

function EBF:OnInitialize()
  -- Load Database
  self.db = LibStub("AceDB-3.0"):New("kExtraBossFramesDB", self.defaults)
  -- Create options
  self.options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
  self.config = LibStub("AceConfig-3.0"):RegisterOptionsTable("kEBF", self.options, {"kebf", "ebf"})
  self.dialog = LibStub("AceConfigDialog-3.0")
  self.AceGUI = LibStub("AceGUI-3.0")
  self.dialog:AddToBlizOptions("kEBF", "kExtraBossFrames")
  -- Local
  self.addons = {
    elvui = {
      UF = nil,
      updateCalls = 0
    },
    loaded = false,
    suf = {
      updateCalls = 0
    }
  }

  self.timers = {}

  if (not self.db.profile.enabled) then
    return
  end

  self:Addons_BuildAddOns()

  if (not self:Addons_HasEnabledAddOns()) then
    self:Print("No supported addons enabled.")
    return
  end

  MAX_BOSS_FRAMES = 8
  
  self:RegisterEvents()
end

function EBF:OnEnable()
  self:CreateBossFramesTimer()
end

function EBF:OnDisable()
  self:CancelAllTimers()
end

function EBF:CreateBossFramesTimer()
  self:CancelTimer(self.timers.boss)
  self.timers.boss = self:ScheduleRepeatingTimer("UpdateBossFrames", self.db.profile.frequency)
end

function EBF:UpdateBossFrames()
  if (self.db.profile.addons.elvui.enabled) then
    self:Addons_ElvUI_Update()
  end
  if (self.db.profile.addons.suf.enabled) then
    self:Addons_ShadowedUnitFrames_Update()
  end
end