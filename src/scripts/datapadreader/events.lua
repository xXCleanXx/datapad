require("eventhandler")

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
        Datapadreader.OnCloseButtonClick(player)
        return
    end

    if action == Datapadreader.ui_action_clear_button then
        Datapadreader.OnClearButtonClick(player)
        return
    end

    if action == Datapadreader.ui_action_write_button then
        Datapadreader.OnWriteButtonClick(player)
        return
    end

    if action == Datapadreader.ui_slot then
        Datapadreader.OnSlotClick(player)
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

---Handles the keyboard shortcut for Informatron being used.
---@param event EventData.CustomInputEvent Event data
function Datapadreader.on_keyboard_shortcut(event)
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]

    if event.input_name == Datapadreader.keyboard_shortcut then
        Datapadreader.OnKeyboardShortcutClose(player)
    end
end
script.on_event(Datapadreader.keyboard_shortcut, Datapadreader.on_keyboard_shortcut)

---Initializes DataPad
function Datapadreader.on_init()
    global.datapad_data = DatapadData
end
script.on_init(Datapadreader.on_init)

---@param event EventData.on_gui_text_changed
local function on_gui_text_changed(event)
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]

    if not event.element.type == "text-box" then
        return
    end

    local txtBox = Datapadreader.GetContentTextbox(player)

    if txtBox == nil then
        return
    end

    if txtBox.text == nil then
        return
    end

    if txtBox.text ~= "" then
        Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_write_button).enabled = true
    else
        Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_write_button).enabled = false
    end
end
script.on_event(defines.events.on_gui_text_changed, on_gui_text_changed)

---@param event EventData.on_player_created
function Datapadreader.OnNewPlayer(event)
    local player = game.get_player(event.player_index) --[[@as LuaPlayer]]

    if player.get_main_inventory() == nil then
        return
    end

    if player.get_main_inventory().get_contents()[Datapadreader.name] == nil then
        player.insert({name=Datapadreader.item_datapad_empty, count=1}) -- Give every new player an awesome datapad!
    end
end
script.on_event(defines.events.on_player_created, Datapadreader.OnNewPlayer)
script.on_event(defines.events.on_cutscene_cancelled, Datapadreader.OnNewPlayer)
script.on_event(defines.events.on_cutscene_finished, Datapadreader.OnNewPlayer)