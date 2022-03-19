function EBF:ADDON_LOADED(event, ...)
  self:Addons_OnAddOnLoaded(...)
end

function EBF:RegisterEvents()
  EBF:RegisterEvent("ADDON_LOADED")
end
