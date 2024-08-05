---@param spriteButton LuaGuiElement
---@return boolean
local function IsSpriteButtonEmpty(spriteButton)
    return spriteButton.sprite == nil or spriteButton.sprite == ""
end

---@param spriteButton LuaGuiElement
---@return boolean
local function HasSpriteButtonDatapadEmpty(spriteButton)
    return spriteButton.sprite == "datapad-icon-empty"
end

---@param spriteButton LuaGuiElement
---@return boolean
local function HasSpriteButtonDatapadWithData(spriteButton)
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
    return player.cursor_stack.name == Datapadreader.item_datapad_empty or player.cursor_stack.name == Datapadreader.item_datapad_wdata
end

---@param player LuaPlayer
function Datapadreader.OnWriteButtonClick(player)
    local spriteButton = Datapadreader.GetSpriteButton(player)
    local txtBox = Datapadreader.GetTextbox(player)
    local player_index = player.index

    global.datapad_data[player_index] = {content=txtBox.text}
    spriteButton.sprite = "datapad-icon"
end

---@param player LuaPlayer
function Datapadreader.OnSpriteButtonClick(player)
    local spriteButton = Datapadreader.GetSpriteButton(player)
    local txtBox = Datapadreader.GetTextbox(player)

    if IsCursorEmpty(player) then
        if HasSpriteButtonDatapadEmpty(spriteButton) then
            spriteButton.sprite = nil
            local dpad = {name=Datapadreader.item_datapad_empty, count=1}
            player.cursor_stack.set_stack(dpad)
            txtBox.text = ""
            --return
        end

        if HasSpriteButtonDatapadWithData(spriteButton) then
            spriteButton.sprite = nil
            local dpad = {name=Datapadreader.item_datapad_wdata, count=1}
            local player_index = player.index

            if global.datapad_data[player_index].content ~= nil and global.datapad_data[player_index].content ~= {} then
                player.cursor_stack.set_stack(dpad)
                player.cursor_stack.tags = {content=global.datapad_data[player_index].content}
                player.cursor_stack.custom_description = global.datapad_data[player_index].content
                global.datapad_data[player_index].content = nil
            else
                player.cursor_stack.set_stack(dpad)
            end

            txtBox.text = ""
            --return
        end

        Datapadreader.DisableAllControls(player)
        return
    end

    if not HasCursorValidItem(player) or not IsSpriteButtonEmpty(spriteButton) then
        return
    end

    if player.cursor_stack.name == Datapadreader.item_datapad_empty then
        spriteButton.sprite = "datapad-icon-empty"

        Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_write_button).enabled = true
        Datapadreader.GetTextbox(player).enabled = true

        player.cursor_stack.clear()

        return
    end

    if player.cursor_stack.name == Datapadreader.item_datapad_wdata then
        local player_index = player.index

        txtBox.text = player.cursor_stack.tags.content --[[@as string]]
        global.datapad_data[player_index] = {content=player.cursor_stack.tags.content}

        Datapadreader.EnableAllControls(player)
        spriteButton.sprite = "datapad-icon"
        player.cursor_stack.clear()

        return
    end
end

---@param player LuaPlayer
function Datapadreader.OnPlayerCursorStackChanged(player)
    if IsCursorEmpty(player) then
        return
    end
    if HasCursorValidItem(player) then
        Datapadreader.GuiOpen(player)
    end 
end