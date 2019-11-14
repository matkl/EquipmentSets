local inventorySlotNames = {
  "AMMOSLOT",
  "HEADSLOT",
  "NECKSLOT",
  "SHOULDERSLOT",
  "SHIRTSLOT",
  "CHESTSLOT",
  "WAISTSLOT",
  "LEGSSLOT",
  "FEETSLOT",
  "WRISTSLOT",
  "HANDSSLOT",
  "FINGER0SLOT",
  "FINGER1SLOT",
  "TRINKET0SLOT",
  "TRINKET1SLOT",
  "BACKSLOT",
  "MAINHANDSLOT",
  "SECONDARYHANDSLOT",
  "RANGEDSLOT",
  "TABARDSLOT"
}

local function log(...)
  print(YELLOW_FONT_COLOR_CODE .. ...)
end

local function equipSet(name)
  local data = EquipmentSets_Saved[name]

  if not data then
    log("Set ''" .. name .. "' not found")
    return
  end

  for slotName, slotData in pairs(data) do
    local itemId, enchantId = unpack(slotData)
    local slotId = GetInventorySlotInfo(slotName)

    if slotId > INVSLOT_FIRST_EQUIPPED and slotId <= INVSLOT_LAST_EQUIPPED then
      EquipItemByName(itemId, slotId)
    end
  end
end

local function showSet(name)
  local data = EquipmentSets_Saved[name]

  if not data then
    log("Set '" .. name .. "' not found")
    return
  end

  log(name .. ":")

  for slotName, slotData in pairs(data) do
    local itemId, enchantId = unpack(slotData)
    local slotId = GetInventorySlotInfo(slotName)

    if slotId > INVSLOT_FIRST_EQUIPPED and slotId <= INVSLOT_LAST_EQUIPPED then
      local itemLink = select(2, GetItemInfo(itemId))
      log("- " .. itemLink)
    end
  end
end

local function saveSet(name)
  EquipmentSets_Saved[name] = {}
  local data = EquipmentSets_Saved[name]

  for _, slotName in ipairs(inventorySlotNames) do
    local slotId = GetInventorySlotInfo(slotName)
    local itemId = GetInventoryItemID("player", slotId)
    local itemLink = GetInventoryItemLink("player", slotId)
    local enchantId = itemLink and tonumber(select(2, string.match(itemLink, "item:(%d+):(%d*)")))
    data[slotName] = {itemId, enchantId}
  end

  log("Saved set '" .. name .. "'")
end

local function deleteSet(name)
  local data = EquipmentSets_Saved[name]

  if not data then
    log("Set '" .. name .. "' not found")
    return
  end

  EquipmentSets_Saved[name] = nil
  log("Deleted set '" .. name .. "'")
end

local function listSets()
  log("Equipment sets:")

  local empty = true

  for name in pairs(EquipmentSets_Saved) do
    empty = false
    log("- " .. name)
  end

  if (empty) then
    log("(none)")
  end
end

local function handleEvent(self, event, arg1)
  if (event == "ADDON_LOADED") then
    if arg1 == "EquipmentSets" then
      EquipmentSets_Saved = EquipmentSets_Saved or {}
    end
  end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", handleEvent)

SLASH_EQUIPSET1 = "/equipset"
SLASH_EQUIPSET2 = "/equipmentsets"
SLASH_EQUIPSET3 = "/equipmentset"
SLASH_EQUIPSET3 = "/es"
SLASH_SHOWSET1 = "/showset"
SLASH_SAVESET1 = "/saveset"
SLASH_DELETESET1 = "/deleteset"
SLASH_REMOVESET1 = "/removeset"
SLASH_LISTSETS1 = "/listsets"

SlashCmdList["EQUIPSET"] = function(name)
  if name == "" then
    log("Equipment Sets help:")
    log("/equipset <name> - equip previously saved items")
    log("/showset <name> - show all items in a set")
    log("/saveset <name> - save currently equipped items")
    log("/deleteset <name> - delete a specific set")
    log("/listsets - list names of all saved sets")
    return
  end

  equipSet(string.lower(name))
end

SlashCmdList["SHOWSET"] = function(name)
  if name == "" then
    log("Syntax: /showset <name>")
    return
  end

  showSet(string.lower(name))
end

SlashCmdList["SAVESET"] = function(name)
  if name == "" then
    log("Syntax: /saveset <name>")
    return
  end

  saveSet(string.lower(name))
end

SlashCmdList["DELETESET"] = function(name)
  if name == "" then
    log("Syntax: /deleteset <name>")
    return
  end

  deleteSet(string.lower(name))
end

SlashCmdList["LISTSETS"] = listSets

_G["UseEquipmentSet"] = equipSet
