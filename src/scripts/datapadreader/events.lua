require("eventhandler")
require("datapaddata")

---Handles gui clicks
---@param event EventData.on_gui_click
function Datapadreader.on_gui_click(event)
    local tags = event.element.tags
    local action = tags.action
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]

    if action == {} or action == nil or player == nil then
        return
    end

    if action == Datapadreader.ui_action_close_button then
        Datapadreader.GuiClose(player)
    end

    if action == Datapadreader.ui_action_write_button then
        Datapadreader.OnWriteButtonClick(player)
        return
    end

    if action == Datapadreader.ui_sprite_button then
        Datapadreader.OnSpriteButtonClick(player)
    end
end
script.on_event(defines.events.on_gui_click, Datapadreader.on_gui_click)

--Function to handle cursor stack changes
---@param event EventData.on_player_cursor_stack_changed
function Datapadreader.on_cursor_stack_changed(event)
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]
    Datapadreader.OnPlayerCursorStackChanged(player)
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
function Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player)
    local player_index = player.index

    if global.datapad_data == nil then
        global.datapad_data = DatapadData
    end
    global.datapad_data[player_index] = global.datapad_data[player_index] or {}
    return global.datapad_data[player_index]
end

---Initializes DataPad
function Datapadreader.on_init()
    global.datapad_data = DatapadData
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