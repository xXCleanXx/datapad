---Returns the Datapad HUD for a given player, if it is open.
---@param player LuaPlayer Player
---@return LuaGuiElement? root
function Datapadreader.GetGui(player)
    return player.gui.screen[Datapadreader.ui_root]
end

---@param player LuaPlayer
function Datapadreader.GuiOpen(player)
    if Datapadreader.GetGui(player) then return end

    local root = player.gui.screen.add{
        type = "frame",
        style = "datapadreader-ui-frame",
        name = Datapadreader.ui_root,
        direction = "horizontal",
    }

    -- todo Move UI to players position

    -- local left_flow = root.add{type="flow", direction="vertical"}
    -- left_flow.add {
    --     name = Datapadreader.ui_root_leftflow,
    --     type = "sprite-button",
    --     sprite = "utility/expand_dots_white",
    --     hovered_sprite = "utility/expand_dots",
    --     clicked_sprite = "utility/expand_dots",
    --     style = "datapadreader-ui-left-minimize-button"
    -- }
    -- local drag_handle = left_flow.add{
    --     type="empty-widget",
    --     style="draggable_space"
    -- }
    -- drag_handle.drag_target = root

    local flow = root.add{
        type = "flow",
        name = Datapadreader.ui_root_panel
    }

    local leftPanel = flow.add{
        type = "frame",
        name = "datapadreader-ui-panel",
        style = "datapadreader-ui-panel"
    }

    Datapadreader.RenderSpriteButton(leftPanel)

    local heading = flow.add{
        type = "label",
        caption = "[color=orange]Datapad Reader[/color]",
    }

    heading.style.font = "default-bold"
    

    -- local button = dividerPanel.add{
    --     type = "button",
    --     caption = "Write",
    --     name = Datapadreader.ui_write_button,
    --     tags = {action="write-button"}
    -- }

    -- button.style.height = 8

    -- local txtBox = dividerPanel.add{
    --     type = "text-box",
    --     name = Datapadreader.ui_text_box
    -- }
    -- txtBox.style.height = 64

    -- txtBox.style.width = 120

    Datapadreader.SetGuiLocation(root, player)
end

---@param element LuaGuiElement
function Datapadreader.RenderSpriteButton(element)
    local spritebutton = element.add{
        type = "sprite-button",
        name = Datapadreader.ui_sprite_button,
        tags = {root=Datapadreader.name, action=Datapadreader.ui_sprite_button}
    }

    spritebutton.style.top_margin = 24

    spritebutton.style.width = 36
    spritebutton.style.height = 36
end

---@param element LuaGuiElement
---@param player LuaPlayer
function Datapadreader.SetGuiLocation(element, player)
    local resolution = player.display_resolution
    local scaling = player.display_scale
    
    gui_location = {
        (resolution.width / 2) + (475 * scaling),
        (resolution.height) - (96 * scaling)
      }

    element.location = gui_location
end