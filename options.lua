function EBF:GetMyMessage(info)
  return myMessageVar
end

function EBF:SetMyMessage(info, input)
  myMessageVar = input

  EBF:Print("My message is now: " .. myMessageVar)
end

EBF.defaults = {
  profile = {
    addons = {
      elvui = {
        enabled = false,
        name = "ElvUI",
        loaded = false
      },
      suf = {
        enabled = false,
        name = "ShadowedUnitFrames",
        loaded = false
      }
    },
    enabled = true
  }
}

EBF.options = {
  type = "group",
  name = "kExtraBossFrames",
  args = {
    enabled = {
      name = "Enabled",
      type = "toggle",
      desc = "Enable kExtraBossFrames.",
      get = function(info)
        return EBF.db.profile.enabled
      end,
      set = function(info, value)
        EBF.db.profile.enabled = value
        ReloadUI()
      end,
      confirm = function(info, value)
        return "Are you sure you want to " ..
          (value and "enable" or "disable") .. " kExtraBossFrames?  This will reload the UI."
      end
    }
    -- addons = {
    --   type = "group",
    --   name = "Addons",
    --   args = {
    --     header = {
    --       type = "header",
    --       name = "Addons",
    --       order = 1
    --     },
    --     desc = {
    --       type = "description",
    --       name = "Enabled addons are adjusted when kExtraBossFrames is enabled.",
    --       order = 2
    --     },
    --     elvui = {
    --       type = "toggle",
    --       name = "ElvUI",
    --       desc = "Enable ElvUI",
    --       get = function(info)
    --         return EBF.db.profile.addons.elvui.enabled
    --       end,
    --       set = function(info, value)
    --         EBF.db.profile.addons.elvui.enabled = value
    --       end,
    --       order = 3
    --     },
    --     suf = {
    --       type = "toggle",
    --       name = "ShadowedUnitFrames",
    --       desc = "Enable ShadowedUnitFrames",
    --       get = function(info)
    --         return EBF.db.profile.addons.suf.enabled
    --       end,
    --       set = function(info, value)
    --         EBF.db.profile.addons.suf.enabled = value
    --       end,
    --       order = 4
    --     }
    --   }
    -- }
  }
}
