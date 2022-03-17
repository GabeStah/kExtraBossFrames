EBF = LibStub("AceAddon-3.0"):NewAddon("kEBF", "AceConsole-3.0", "AceEvent-3.0")

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
      UF = nil
    },
    loaded = false
  }

  if (not self.db.profile.enabled) then
    return
  end

  self:Addons_BuildAddOns()

  if (not self:Addons_HasEnabledAddOns()) then
    self:Print("No supported addons enabled.")
    return
  end

  MAX_BOSS_FRAMES = 8
  self.updateFrame = CreateFrame("Frame", "kExtraBossFramesUpdateFrame", UIParent)
  self:RegisterEvents()
end
