local Equipment = {}

local UI = AnglerAtlas.MM:GetModule("UI")
local DATA = AnglerAtlas.MM:GetModule("DATA")

function Equipment:Create(uiParent, anchor)
    local equipmentUID = 1
    local itemSize = 37
    local itemGap = 5
    local maxItemsPerLine = 7
    local rowWidth = 310

    local function buildEquipmentRow(parent, equipmentHeader, equipmentData)
        local equipmentRow = CreateFrame("FRAME", "angler-equipment-row-"..equipmentUID, parent)
        equipmentUID = equipmentUID + 1
        local lineCount = math.max(1, math.ceil(#equipmentData / maxItemsPerLine))
        local rowHeight = 25 + lineCount * (itemSize + itemGap)
        equipmentRow:SetSize(rowWidth, rowHeight)

        equipmentRow.name = equipmentRow:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        equipmentRow.name:SetPoint("TOPLEFT", equipmentRow, "TOPLEFT", 0, 0)
        equipmentRow.name:SetFont("Fonts\\FRIZQT__.ttf", 15)
        equipmentRow.name:SetText(equipmentHeader)

        equipmentRow.items = {}
        for i = 1, #equipmentData do
            local data = equipmentData[i]
            local equipmentItem = CreateFrame("BUTTON", "angler-equipment-item-"..tostring(data.id), equipmentRow, "ItemButtonTemplate")
            equipmentItem:SetSize(itemSize, itemSize)
            local line = math.floor((i - 1) / maxItemsPerLine)
            local column = (i - 1) % maxItemsPerLine
            equipmentItem:SetPoint("TOPLEFT", equipmentRow, "TOPLEFT", 1 + column * (itemSize + itemGap), -24 - line * (itemSize + itemGap))
            SetItemButtonTexture(equipmentItem, GetItemIcon(tostring(data.id)))
            _G[equipmentItem:GetName().."NormalTexture"]:SetSize(itemSize*1.662, itemSize*1.662)
            -- Tooltip
            equipmentItem:SetScript("OnEnter", function()
                GameTooltip:SetOwner(equipmentItem, "ANCHOR_LEFT", 0, 0)
                GameTooltip:SetItemByID(tostring(data.id))
                GameTooltip:Show()
            end)
            equipmentItem:SetScript("OnLeave", function()
                GameTooltip:Hide()
            end)
            GameTooltip:HookScript("OnTooltipSetItem", function(self)
                if GameTooltip:GetOwner() == equipmentItem then
                    GameTooltip:AddLine(" ")
                    GameTooltip:AddLine(data.desc)
                end
            end)
            equipmentRow.items[i] = equipmentItem
        end

        return equipmentRow
    end

    local equipment = CreateFrame("FRAME", "angler-equipment-info", uiParent, "BackdropTemplate")
    equipment:Raise()
    -- equipment:SetBackdrop(BACKDROP_GOLD_DIALOG_32_32)
    equipment:SetBackdrop(BACKDROP_DIALOG_32_32)
    equipment:SetBackdropColor(1.0, 1.0, 1.0, 1.0);
    equipment:SetSize(355, 408)
    equipment:SetPoint("TOPLEFT", anchor, "TOPLEFT", 0, 0)
    equipment:Hide()
    -- On show hide
    equipment:SetScript("OnShow", function()
        PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN, "Master");
    end)
    equipment:SetScript("OnHide", function()
        PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE, "Master");
    end)

    equipment.scrollFrame = CreateFrame("ScrollFrame", nil, equipment, "UIPanelScrollFrameTemplate")
    equipment.scrollFrame:SetPoint("TOPLEFT", equipment, "TOPLEFT", 25, -25)
    equipment.scrollFrame:SetPoint("BOTTOMRIGHT", equipment, "BOTTOMRIGHT", -28, 18)

    equipment.scrollChild = CreateFrame("Frame")
    equipment.scrollChild:SetSize(310, 1)
    equipment.scrollFrame:SetScrollChild(equipment.scrollChild)

    local contentHeight = 0
    local function addRow(key, header)
        local row = buildEquipmentRow(equipment.scrollChild, header, DATA.equipment[key])
        if contentHeight == 0 then
            row:SetPoint("TOPLEFT", equipment.scrollChild, "TOPLEFT", 0, 0)
        else
            row:SetPoint("TOPLEFT", equipment.scrollChild, "TOPLEFT", 0, -contentHeight)
        end
        equipment[key] = row
        contentHeight = contentHeight + row:GetHeight() + 18
    end

    addRow("gear", "Gear")
    addRow("rods", "Rods")
    addRow("lures", "Lures")
    addRow("other", "Other")
    addRow("pets", "Pets")

    equipment.scrollChild:SetHeight(contentHeight)
    
    return equipment
end

AnglerAtlas.MM:RegisterModule("Equipment", Equipment)
