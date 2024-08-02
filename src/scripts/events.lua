---Handles GUI clicks.
---@param event EventData.on_gui_click
function DataPad.on_gui_click(event)
    if event.element.name == DataPad.name_close_button then
        DataPad.close(game.get_player(event.player_index))
    end
end

---@param event EventData.on_gui_text_changed
function DataPad.on_gui_text_changed(event)
    if event.element.name == DataPad.name_textfield then
        
    elseif event.element.name == DataPad.name_text_box then

    end
end

local function main()
    script.on_event(defines.events.on_gui_click, DataPad.on_gui_click)
    script.on_event(defines.events.on_gui_text_changed, DataPad.on_gui_text_changed)
end

main()