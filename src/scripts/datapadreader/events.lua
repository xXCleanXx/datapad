---Handles gui clicks
---@param event EventData.on_gui_click
function Datapadreader.on_gui_click(event)
    local tags = event.element.tags
    local action = tags.action
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]
    
    if action == "write-button" then
        local spriteButton = player.gui.screen[DataPad.name_gui_root]["panel"]["datapad-ui-sprite-button"] --[[@as LuaGuiElement]]
        if spriteButton.sprite == nil or spriteButton.sprite == {} then
            return
        end
        spriteButton.sprite = "datapad-icon"
        local txtBox = player.gui.screen[DataPad.name_gui_root]["panel"]["datapad-ui-textbox"] --[[@as LuaGuiElement]]
        global.datapad_data = {content=txtBox.text}
        return
    end
    
    if action == DataPad.ui_sprite_button then
        local spriteButton = event.element --[[@as LuaGuiElement]]
        local txtBox = player.gui.screen[DataPad.name_gui_root]["panel"]["datapad-ui-textbox"] --[[@as LuaGuiElement]]

        if player.cursor_stack.valid_for_read and player.cursor_stack.name == "datapad-off" and (spriteButton.sprite == nil or spriteButton.sprite == "") then
            spriteButton.sprite = "datapad-icon-off"

            txtBox.text = "Empty datapad"

            player.cursor_stack.clear()
            return
        end

        if player.cursor_stack.valid_for_read and player.cursor_stack.name == "datapad" and (spriteButton.sprite == nil or spriteButton.sprite == "") then
            spriteButton.sprite = "datapad-icon"

            if next(player.cursor_stack.tags) == nil then
                txtBox.text = "Empty datapad"
            else
                txtBox.text = player.cursor_stack.tags.content --[[@as string]]
                global.datapad_data = {content=player.cursor_stack.tags.content}
            end

            player.cursor_stack.clear()

            return
        end

        if not player.cursor_stack.valid_for_read and spriteButton.sprite == "datapad-icon-off" then
            spriteButton.sprite = nil
            local dpad = {name="datapad-off", count=1}
            player.cursor_stack.set_stack(dpad)
            txtBox.text = ""
            return
        end
        
        if not player.cursor_stack.valid_for_read and spriteButton.sprite == "datapad-icon" then
            spriteButton.sprite = nil
            local dpad = {name="datapad", count=1}

            if global.datapad_data.content ~= nil and global.datapad_data.content ~= {} then
                --dpad.tags = {content=global.datapad_data.content}
                player.cursor_stack.set_stack(dpad)
                player.cursor_stack.tags = {content=global.datapad_data.content}
                player.cursor_stack.custom_description = global.datapad_data.content
                global.datapad_data.content = nil
            else
                player.cursor_stack.set_stack(dpad)
            end

            txtBox.text = ""
            return
        end
    end
end
script.on_event(defines.events.on_gui_click, Datapadreader.on_gui_click)

-- Function to handle cursor stack changes
---@param event EventData.on_player_cursor_stack_changed
function Datapadreader.on_cursor_stack_changed(event)
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]
    Datapadreader.GuiToggle(player)
end
script.on_event(defines.events.on_player_cursor_stack_changed, Datapadreader.on_cursor_stack_changed)

-- ---@param event EventData.on_gui_text_changed
-- function DataPad.on_gui_text_changed(event)
--     if event.element.name == DataPad.name_textfield then
        
--     elseif event.element.name == DataPad.name_text_box then

--     end
-- end
-- script.on_event(defines.events.on_gui_text_changed, DataPad.on_gui_text_changed)

---Handles the keyboard shortcut for Informatron being used.
---@param event EventData.CustomInputEvent Event data
function Datapadreader.on_keyboard_shortcut(event)
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]

    if event.input_name == Datapadreader.keyboard_shortcut then
        Datapadreader.GuiToggle(player)
    end
end
script.on_event(Datapadreader.keyboard_shortcut, Datapadreader.on_keyboard_shortcut)

---@param player LuaPlayer
---@return DatapadData
function Datapadreader.GetGlobalDatapadData(player)
    local player_index = player.index
    global.datapad_data[player_index] = global.datapad_data[player_index] or {}
    return global.datapad_data[player_index]
end

---Initializes DataPad
function Datapadreader.on_init()
    global.datapad_data = {}
end
script.on_init(Datapadreader.on_init)

---@param event EventData.on_player_created
function Datapadreader.OnNewPlayer(event)
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]

    if player.get_main_inventory() == nil then
        return
    end

    if player.get_main_inventory().get_contents()[Datapadreader.name] == nil then
        player.insert({name=Datapadreader.item_datapad_wdata, count=1, tags = {content = "Lorem Ipsum my firend"}}) -- Give every new player an awesome datapad!
    end
end
script.on_event(defines.events.on_player_created, Datapadreader.OnNewPlayer)
script.on_event(defines.events.on_cutscene_cancelled, Datapadreader.OnNewPlayer)
script.on_event(defines.events.on_cutscene_finished, Datapadreader.OnNewPlayer)