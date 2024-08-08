---@param spriteButton LuaGuiElement
---@return boolean
local function IsSpriteButtonEmpty(spriteButton)
    return spriteButton.sprite == nil or spriteButton.sprite == ""
end

---@param spriteButton LuaGuiElement
---@return boolean
local function HasSlotDatapadEmpty(spriteButton)
    return spriteButton.sprite == "datapad-icon-empty"
end

---@param spriteButton LuaGuiElement
---@return boolean
local function HasSlotDatapadWithData(spriteButton)
    return spriteButton.sprite == "datapad-icon"
end

---@param player LuaPlayer
---@return boolean
local function IsCursorEmpty(player)
    return not player.cursor_stack.valid_for_read
end

---@param player LuaPlayer
---@return boolean
local function HasCursorValidItem(player)
    if not IsCursorEmpty(player) then
        return player.cursor_stack.name == Datapadreader.item_datapad_empty or player.cursor_stack.name == Datapadreader.item_datapad_wdata
    end

    return false
end

---@param player LuaPlayer
function Datapadreader.OnWriteButtonClick(player)
    local slot = Datapadreader.GetSlot(player)
    local nameBox = Datapadreader.GetNameTextbox(player)
    local txtBox = Datapadreader.GetContentTextbox(player)

    if nameBox.text == nil or nameBox.text == "" then
        nameBox.text = "Unnamed"
    end

    local dpadData = Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player)
    dpadData.Name = nameBox.text
    dpadData.Content = txtBox.text
    slot.sprite = "datapad-icon"
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_clear_button).enabled = true
end

---@param player LuaPlayer
function Datapadreader.OnCloseButtonClick(player)
    local slot = Datapadreader.GetSlot(player)

    if player.cursor_stack.valid_for_read then
        if not player.get_main_inventory().can_insert(player.cursor_stack) then
            player.print({"datapad-reader.cannot-close-message"})
            return
        end

        player.get_main_inventory().insert(player.cursor_stack)
        player.cursor_stack.clear()
    end

    if HasSlotDatapadEmpty(slot) or HasSlotDatapadWithData(slot) then
        Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player).IsStackEventEnabled = false
        Datapadreader.OnSlotClick(player)
    end

    Datapadreader.GuiClose(player)
end

---@param player LuaPlayer
function Datapadreader.OnClearButtonClick(player)
    local slot = Datapadreader.GetSlot(player)

    if not HasSlotDatapadEmpty(slot) and HasSlotDatapadWithData(slot) then
        slot.sprite = "datapad-icon-empty"
        Datapadreader.GetContentTextbox(player).text = ""
        Datapadreader.GetNameTextbox(player).text = ""
        Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_clear_button).enabled = false
        Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_write_button).enabled = false
    end
end

---@param player LuaPlayer
function Datapadreader.OnSlotClick(player)
    local slot = Datapadreader.GetSlot(player)
    local nameBox = Datapadreader.GetNameTextbox(player)
    local txtBox = Datapadreader.GetContentTextbox(player)

    if IsCursorEmpty(player) then
        if HasSlotDatapadEmpty(slot) then
            slot.sprite = nil
            local dpad = {name=Datapadreader.item_datapad_empty, count=1}
            player.cursor_stack.set_stack(dpad)
            nameBox.text = ""
            txtBox.text = ""
        end

        if HasSlotDatapadWithData(slot) then
            slot.sprite = nil
            local dpad = {name=Datapadreader.item_datapad_wdata, count=1}
            local dpadData = Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player)

            if dpadData.Content ~= nil and dpadData.Content ~= {} then
                player.cursor_stack.set_stack(dpad)
                player.cursor_stack.tags = {name=dpadData.Name, content=dpadData.Content}
                player.cursor_stack.custom_description = dpadData.Name

                dpadData.Name = nil --replace with clear method
                dpadData.Content = nil --replace with clear method
            else
                player.cursor_stack.set_stack(dpad)
            end

            nameBox.text = ""
            txtBox.text = ""
        end

        Datapadreader.DisableAllControls(player)
        return
    end

    if not HasCursorValidItem(player) or not IsSpriteButtonEmpty(slot) then
        return
    end

    if player.cursor_stack.name == Datapadreader.item_datapad_empty then
        slot.sprite = "datapad-icon-empty"

        nameBox.enabled = true
        txtBox.enabled = true

        player.cursor_stack.clear()

        return
    end

    if player.cursor_stack.name == Datapadreader.item_datapad_wdata then
        local dpadData = Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player)

        nameBox.text = player.cursor_stack.tags.name --[[@as string]]
        txtBox.text = player.cursor_stack.tags.content --[[@as string]]
        dpadData.Name = player.cursor_stack.tags.name --[[@as string]]
        dpadData.Content = player.cursor_stack.tags.content --[[@as string]]

        Datapadreader.EnableAllControls(player)
        slot.sprite = "datapad-icon"
        player.cursor_stack.clear()

        return
    end
end

---@param player LuaPlayer
function Datapadreader.OnPlayerCursorStackChanged(player)
    if IsCursorEmpty(player) or not settings.get_player_settings(player.index)["datapad-auto-show-gui-on-user-pick-up"].value then
        return
    end

    local dpaddata = Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player)

    if HasCursorValidItem(player) and dpaddata.IsStackEventEnabled then
        Datapadreader.GuiOpen(player)
    end

    if not dpaddata.IsStackEventEnabled then
        dpaddata.IsStackEventEnabled = true
    end
end

---@param player LuaPlayer
function Datapadreader.OnKeyboardShortcutClose(player)
    Datapadreader.OnCloseButtonClick(player)
end