function EBF:Addons_ShadowedUnitFrames_Update()
  if (not self.db.profile.enabled or not self.db.profile.addons.suf.enabled) then
    return
  end
  for i = 6, 8 do
    local unit = "boss" .. i
    if (UnitExists(unit)) then
      for frame in pairs(ShadowUF.modules["units"].frameList) do
        if (frame.unit == unit) then
          frame:FullUpdate()
        end
      end
    end
  end
end
