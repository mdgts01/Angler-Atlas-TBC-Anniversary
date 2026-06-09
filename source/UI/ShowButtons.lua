local LibDBIcon = AnglerAtlas.MM:GetModule("LibDBIcon")
local LDB = AnglerAtlas.MM:GetModule("LDB")

local UI = AnglerAtlas.MM:GetModule("UI")

local ShowButtons = {}
function ShowButtons:Create(parent)
    local showButtons

    if SpellBookSideTabsFrame then
        showButtons = CreateFrame("FRAME", "angler-show-button-tab", SpellBookSideTabsFrame)
        showButtons:SetSize(62, 62)
        showButtons:SetPoint("BOTTOMRIGHT", SpellBookSideTabsFrame, "BOTTOMRIGHT", 27, 150)
        showButtons.texture = showButtons:CreateTexture(nil,'ARTWORK')
        showButtons.texture:SetTexture("Interface\\SPELLBOOK\\SpellBook-SkillLineTab")
        showButtons.texture:SetAllPoints()

        showButtons.showButton = CreateFrame("BUTTON", "angler-show-button", showButtons, "ItemButtonTemplate")
        showButtons.showButton:SetSize(32, 32)
        showButtons.showButton:SetPoint("TOPLEFT", showButtons, "TOPLEFT", 3, -10)

        local normalTexture = _G[showButtons.showButton:GetName().."NormalTexture"]
        if normalTexture then
            normalTexture:SetSize(50, 50)
        end

        showButtons.showButton:SetScript("OnClick", function()
            UI:ToggleUI()
        end)
        showButtons.showButton:SetScript("OnEnter", function()
            GameTooltip:SetOwner(showButtons.showButton, "ANCHOR_RIGHT")
            GameTooltip:AddLine("Calpico's 'A Master's Guide to Fishing'")
            GameTooltip:Show()
        end)

        showButtons.showButton:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        SetItemButtonTexture(showButtons.showButton, GetItemIcon('19970'))

        if not AnglerAtlasSettings.showSpellbookButton then
            showButtons:Hide()
        end
    end

    -- Minimap icon
    if LibDBIcon and LDB then
        LibDBIcon:Register("AnglerAtlas", LDB, AnglerAtlasSettings.miniMapIcon)
    end

    return showButtons
end

AnglerAtlas.MM:RegisterModule("ShowButtons", ShowButtons)
