function EBF:Addons_ShadowedUnitFrames_RegisterEvents()
  if (not self.db.profile.enabled or not self.db.profile.addons.suf.enabled) then
    return
  end
  for frame in pairs(ShadowUF.modules["units"].frameList) do
    if (frame.unitType == "boss") then
      if (not frame.healthBar) then
        frame.healthBar = ShadowUF.Units:CreateBar(frame)
      end

      frame:RegisterUnitEvent("UNIT_HEALTH", ShadowUF.modules["healthBar"], "Update")
      frame:RegisterUnitEvent("UNIT_MAXHEALTH", ShadowUF.modules["healthBar"], "Update")
      frame:RegisterUnitEvent("UNIT_CONNECTION", ShadowUF.modules["healthBar"], "Update")
      frame:RegisterUnitEvent("UNIT_FACTION", ShadowUF.modules["healthBar"], "UpdateColor")
      frame:RegisterUnitEvent("UNIT_THREAT_SITUATION_UPDATE", ShadowUF.modules["healthBar"], "UpdateColor")
      frame:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", ShadowUF.modules["healthBar"], "UpdateColor")

      if (frame.unit == "pet") then
        frame:RegisterUnitEvent("UNIT_POWER_UPDATE", ShadowUF.modules["healthBar"], "UpdateColor")
      end

      if (ShadowUF.db.profile.units[frame.unitType].healthBar.colorDispel) then
        frame:RegisterUnitEvent("UNIT_AURA", ShadowUF.modules["healthBar"], "UpdateAura")
        frame:RegisterUpdateFunc(ShadowUF.modules["healthBar"], "UpdateAura")
      end

      frame:RegisterUpdateFunc(ShadowUF.modules["healthBar"], "UpdateColor")
      frame:RegisterUpdateFunc(ShadowUF.modules["healthBar"], "Update")
    end
  end
end

function EBF:Addons_ShadowedUnitFrames_Update()
  if (not self.db.profile.enabled or not self.db.profile.addons.suf.enabled) then
    return
  end
  for frame in pairs(ShadowUF.modules["units"].frameList) do
    if (frame.unitType == "boss") then
      frame:FullUpdate()
    end
  end
end
