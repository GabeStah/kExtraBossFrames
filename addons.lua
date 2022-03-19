function EBF:Addons_AreAddOnsLoaded()
  for key, addon in pairs(self.db.profile.addons) do
    if addon.enabled and not addon.loaded then
      return false
    end
  end
  return true
end

function EBF:Addons_BuildAddOns()
  local numAddons = GetNumAddOns()
  for key, addon in pairs(self.db.profile.addons) do
    for i = 1, numAddons do
      local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
      if name == addon.name then
        addon.enabled = enabled
        addon.loaded = false
      end
    end
  end
end

function EBF:Addons_HasEnabledAddOns()
  for key, addon in pairs(self.db.profile.addons) do
    if addon.enabled then
      return true
    end
  end
  return false
end

function EBF:Addons_OnAddOnLoaded(addon)
  self:Addons_SetAddOnLoaded(addon)

  if self:Addons_AreAddOnsLoaded() and not self.addons.loaded then
    self:Print("All addons loaded.")
    self.addons.loaded = true
    MAX_BOSS_FRAMES = 5
  end
end

function EBF:Addons_Enable(addon)
  self.db.profile.addons[addon].enabled = true
end

function EBF:Addons_SetAddOnLoaded(name)
  for key, addon in pairs(self.db.profile.addons) do
    if addon.name == name then
      addon.loaded = true
      if (name == "ElvUI" and self.db.profile.addons.elvui.enabled) then
        local E = unpack(ElvUI)
        self.addons.elvui.UF = E:GetModule("UnitFrames")
        self:Print("ElvUI registered.")
      end
      if (name == "ShadowedUnitFrames" and self.db.profile.addons.suf.enabled) then
        self:Print("ShadowedUnitFrames registered.")
      end
    end
  end
end
