function EBF:Addons_ElvUI_UpdateBossFrames(frame)
  local UF = self.addons.elvui.UF
  local db = UF.db.units["boss"]

  frame.db = db
  frame.colors = ElvUF.colors

  do
    frame.ORIENTATION = db.orientation --allow this value to change when unitframes position changes on screen?
    frame.UNIT_WIDTH = db.width
    frame.UNIT_HEIGHT = db.infoPanel.enable and (db.height + db.infoPanel.height) or db.height
    frame.USE_POWERBAR = db.power.enable
    frame.POWERBAR_DETACHED = db.power.detachFromFrame
    frame.USE_INSET_POWERBAR = not frame.POWERBAR_DETACHED and db.power.width == "inset" and frame.USE_POWERBAR
    frame.USE_MINI_POWERBAR = (not frame.POWERBAR_DETACHED and db.power.width == "spaced" and frame.USE_POWERBAR)
    frame.USE_POWERBAR_OFFSET =
      (db.power.width == "offset" and db.power.offset ~= 0) and frame.USE_POWERBAR and not frame.POWERBAR_DETACHED
    frame.POWERBAR_OFFSET = frame.USE_POWERBAR_OFFSET and db.power.offset or 0
    frame.POWERBAR_HEIGHT = not frame.USE_POWERBAR and 0 or db.power.height
    frame.POWERBAR_WIDTH =
      frame.USE_MINI_POWERBAR and (frame.UNIT_WIDTH - (UF.BORDER * 2)) / 2 or
      (frame.POWERBAR_DETACHED and db.power.detachedWidth or (frame.UNIT_WIDTH - ((UF.BORDER + UF.SPACING) * 2)))
    frame.USE_PORTRAIT = db.portrait and db.portrait.enable
    frame.USE_PORTRAIT_OVERLAY = frame.USE_PORTRAIT and (db.portrait.overlay or frame.ORIENTATION == "MIDDLE")
    frame.PORTRAIT_WIDTH = (frame.USE_PORTRAIT_OVERLAY or not frame.USE_PORTRAIT) and 0 or db.portrait.width
    frame.USE_INFO_PANEL = not frame.USE_MINI_POWERBAR and not frame.USE_POWERBAR_OFFSET and db.infoPanel.enable
    frame.INFO_PANEL_HEIGHT = frame.USE_INFO_PANEL and db.infoPanel.height or 0
    frame.BOTTOM_OFFSET = UF:GetHealthBottomOffset(frame)
  end

  UF:Configure_InfoPanel(frame)
  UF:Configure_HealthBar(frame)
  UF:UpdateNameSettings(frame)
  UF:Configure_Power(frame)
  UF:Configure_PowerPrediction(frame)
  UF:Configure_Portrait(frame)
  UF:EnableDisable_Auras(frame)
  UF:Configure_AllAuras(frame)
  UF:Configure_Castbar(frame)
  UF:Configure_RaidIcon(frame)
  UF:Configure_AuraHighlight(frame)
  UF:Configure_CustomTexts(frame)
  UF:Configure_Fader(frame)
  UF:Configure_Cutaway(frame)
  UF:Configure_HealComm(frame)
  UF:Configure_AuraWatch(frame)

  if db.growthDirection == "UP" or db.growthDirection == "DOWN" then
    BossHeader:Width(frame.UNIT_WIDTH)
    BossHeader:Height(frame.UNIT_HEIGHT + ((frame.UNIT_HEIGHT + db.spacing) * (MAX_BOSS_FRAMES - 1)))
  elseif db.growthDirection == "LEFT" or db.growthDirection == "RIGHT" then
    BossHeader:Width(frame.UNIT_WIDTH + ((frame.UNIT_WIDTH + db.spacing) * (MAX_BOSS_FRAMES - 1)))
    BossHeader:Height(frame.UNIT_HEIGHT)
  end

  UF:HandleRegisterClicks(frame)

  frame:UpdateAllElements("ElvUI_UpdateAllElements")
end

function EBF:Addons_ElvUI_Update()
  if (not self.db.profile.enabled or not self.db.profile.addons.elvui.enabled) then
    return
  end

  for i = 1, 8 do
    EBF:Addons_ElvUI_UpdateBossFrames(_G["ElvUF_Boss" .. i])
  end
end
