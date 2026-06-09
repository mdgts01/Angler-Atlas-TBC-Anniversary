local SettingsAA = {}
local UI = AnglerAtlas.MM:GetModule("UI")
local LibDBIcon = AnglerAtlas.MM:GetModule("LibDBIcon")

function SettingsAA:Create()
    if self.panel then
        return
    end

    local panel = CreateFrame("Frame")
    panel.name = "AnglerAtlas"
    self.panel = panel

    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local category = Settings.RegisterCanvasLayoutCategory(panel, panel.name, panel.name)
        category.ID = panel.name
        Settings.RegisterAddOnCategory(category)
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    end

    -- add widgets to the panel as desired
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOP")
    title:SetText("AnglerAtlas")

    local subtitle = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    subtitle:SetHeight(40)
    subtitle:SetPoint("TOPLEFT", 16, -32)
    subtitle:SetPoint("RIGHT", panel, -32, 0)
    subtitle:SetNonSpaceWrap(true)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetJustifyV("TOP")
    subtitle:SetText("AnglerAtlas is a fishing addon that shows you where to catch fish, what fish you can catch, and what fish are in season.")

    local info = panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    info:SetHeight(40)
    info:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 0, -8)
    info:SetPoint("RIGHT", panel, -32, 0)
    info:SetNonSpaceWrap(true)
    info:SetJustifyH("LEFT")
    info:SetJustifyV("TOP")
    info:SetText("You can always use /aa /angler or /angleratlas to toggle the Angler Atlas main window.")

    local showSpellbookButton = CreateFrame("CheckButton", "AnglerAtlasShowSpellbookButton", panel, "InterfaceOptionsCheckButtonTemplate")
    showSpellbookButton:SetPoint("TOPLEFT", info, "BOTTOMLEFT", 0, -8)
    showSpellbookButton.text = showSpellbookButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    showSpellbookButton.text:SetPoint("LEFT", showSpellbookButton, "RIGHT", 0, 3)
    showSpellbookButton.text:SetText("Show AnglerAtlas button in spellbook")
    showSpellbookButton.tooltipText = "Show AnglerAtlas button in spellbook"
    showSpellbookButton:SetScript("OnClick", function(self)
        AnglerAtlasSettings.showSpellbookButton = self:GetChecked()
        -- UI:ShowSpellbookButton()
        if not UI.showButtonTab then
            return
        end
        if AnglerAtlasSettings.showSpellbookButton then
            UI.showButtonTab:Show()
        else
            UI.showButtonTab:Hide()
        end
    end)
    showSpellbookButton:SetChecked(AnglerAtlasSettings.showSpellbookButton)

    local showMinimapButton = CreateFrame("CheckButton", "AnglerAtlasShowMinimapButton", panel, "InterfaceOptionsCheckButtonTemplate")
    showMinimapButton:SetPoint("TOPLEFT", showSpellbookButton, "BOTTOMLEFT", 0, -8)
    showMinimapButton.text = showMinimapButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    showMinimapButton.text:SetPoint("LEFT", showMinimapButton, "RIGHT", 0, 3)
    showMinimapButton.text:SetText("Show AnglerAtlas button on minimap")
    showMinimapButton.tooltipText = "Show AnglerAtlas button on minimap"
    showMinimapButton:SetScript("OnClick", function(self)
        AnglerAtlasSettings.miniMapIcon.hide = not self:GetChecked()
        if LibDBIcon and LibDBIcon.Refresh then
            LibDBIcon:Refresh("AnglerAtlas", AnglerAtlasSettings.miniMapIcon)
        end
    end)
    showMinimapButton:SetChecked(not AnglerAtlasSettings.miniMapIcon.hide)

    local showMapZoneFishInfoButton = CreateFrame("CheckButton", "AnglerAtlasShowMapZoneFishInfo", panel, "InterfaceOptionsCheckButtonTemplate")
    showMapZoneFishInfoButton:SetPoint("TOPLEFT", showMinimapButton, "BOTTOMLEFT", 0, -8)
    showMapZoneFishInfoButton.text = showMapZoneFishInfoButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    showMapZoneFishInfoButton.text:SetPoint("LEFT", showMapZoneFishInfoButton, "RIGHT", 0, 3)
    showMapZoneFishInfoButton.text:SetText("Show fish info on map")
    showMapZoneFishInfoButton.tooltipText = "Show fish info on map"
    showMapZoneFishInfoButton:SetScript("OnClick", function(self)
        AnglerAtlasSettings.showMapZoneFishInfo = self:GetChecked()
    end)
    showMapZoneFishInfoButton:SetChecked(AnglerAtlasSettings.showMapZoneFishInfo)

end

AnglerAtlas.MM:RegisterModule("SettingsAA", SettingsAA)
