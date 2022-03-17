local unitEvents = {
  ["UNIT_ABSORB_AMOUNT_CHANGED"] = true,
  ["UNIT_AURA"] = true,
  ["UNIT_HEAL_PREDICTION"] = true,
  ["UNIT_HEALTH"] = true,
  ["UNIT_MANA"] = true,
  ["UNIT_MAXHEALTH"] = true,
  ["UNIT_MAXPOWER"] = true,
  ["UNIT_NAME_UPDATE"] = true,
  ["UNIT_POWER_UPDATE"] = true,
  ["UNIT_TARGETABLE_CHANGED"] = true
}

function EBF:ADDON_LOADED(event, ...)
  self:Addons_OnAddOnLoaded(...)
end

function EBF:OnUnitEvent(unit)
  if
    (unit == "boss1" or unit == "boss2" or unit == "boss3" or unit == "boss4" or unit == "boss5" or unit == "boss6" or
      unit == "boss7" or
      unit == "boss8")
   then
    if (self.db.profile.addons.elvui.enabled) then
      self:Addons_ElvUI_Update()
    end
    if (self.db.profile.addons.suf.enabled) then
      self:Addons_ShadowedUnitFrames_Update()
    end
  end
end

function EBF:RegisterEvents()
  EBF:RegisterEvent("ADDON_LOADED")

  for i, v in pairs(unitEvents) do
    EBF.updateFrame:RegisterUnitEvent(i)
  end

  EBF.updateFrame:SetScript(
    "OnEvent",
    function(self, event, ...)
      for key, value in pairs(unitEvents) do
        if (event == key) then
          EBF:OnUnitEvent(...)
        end
      end
    end
  )
end
