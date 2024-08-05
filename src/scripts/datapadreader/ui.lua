---@param root LuaGuiElement
---@param element LuaGuiElement
local function RenderTitlebar(element, root)
    local hFlow = element.add{
        type = "flow",
        direction = "horizontal"
    }
    hFlow.drag_target = root

    local heading = hFlow.add{
        type = "label",
        caption = "[color=orange]Datapad Reader[/color]",
        ignored_by_interaction = true
    }
    heading.style.font = "heading-font"
    heading.style.left_margin = 4

    hFlow.add{
        type = "empty-widget",
        ignored_by_interaction = true,
        style = "datapadreader-ui-draghandle"
    }

    local closeButton = hFlow.add{ -- Close button
        type = "sprite-button",
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
        clicked_sprite = "utility/close_black",
        tags = {action=Datapadreader.ui_action_close_button},
        style = "close_button"
    }

    closeButton.style.width = 16
    closeButton.style.height = 16
    closeButton.style.horizontal_align = "right"
end

---@param element LuaGuiElement
local function RenderSpriteButton(element)
    local buttonFrame = element.add{
        type = "frame",
        name = Datapadreader.ui_root_panel,
        style = "datapadreader-ui-sprite-button-frame"
    }

    local spritebutton = buttonFrame.add{
        type = "sprite-button",
        name = Datapadreader.ui_sprite_button,
        tags = {root=Datapadreader.name, action=Datapadreader.ui_sprite_button}
    }

    spritebutton.style.width = 36
    spritebutton.style.height = 36
end

---@param element LuaGuiElement
local function RenderButtons(element)
    local flow = element.add{
        type = "flow",
        name = Datapadreader.ui_rightflow,
        direction = "vertical"
    }

    local buttonFlow = flow.add{
        type = "flow",
        direction = "vertical",
        name = Datapadreader.ui_buttonflow
    }

    buttonFlow.add{
        type = "button",
        caption = "Write",
        enabled = false,
        name = Datapadreader.ui_write_button,
        tags = {action=Datapadreader.ui_action_write_button}
    }

    buttonFlow.add{
        type = "button",
        caption = "Clear",
        name = Datapadreader.ui_clear_button,
        enabled = false,
        tags = {action=Datapadreader.ui_action_clear_button}
    }
end

---@param element LuaGuiElement
local function RenderTextbox(element)
    local textbox = element.add{
        type = "text-box",
        name = Datapadreader.ui_text_box,
        enabled = false
    }
    textbox.style.margin = 4
    textbox.style.height = 240
    textbox.style.width = 240 - 16
end

---@param element LuaGuiElement
---@param player LuaPlayer
local function SetGuiLocation(element, player)
    local dpadData = Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player)
    local resolution = player.display_resolution
    local scaling = player.display_scale

    if dpadData.Location ~= nil and next(dpadData.Location) then
        element.location = dpadData.Location
        return
    end

    gui_location = {
        (resolution.width - 12) - (240 * scaling),
        (resolution.height / 2) - ((520 / 2 - 80) * scaling)
      }

    element.location = gui_location
end

---@param player LuaPlayer
function Datapadreader.RenderGui(player)
    local root = player.gui.screen.add{
        type = "frame",
        style = "datapadreader-ui-frame",
        name = Datapadreader.ui_root,
        direction = "horizontal",
    }

    local mainflow = root.add{
        type = "flow",
        name = Datapadreader.ui_main_flow,
        direction = "vertical"
    }

    RenderTitlebar(mainflow, root)

    local upperFlow = mainflow.add{
        type = "flow",
        direction = "horizontal",
        name = Datapadreader.ui_upper_flow
    }

    RenderSpriteButton(upperFlow)
    RenderButtons(upperFlow)
    RenderTextbox(mainflow)
    SetGuiLocation(root, player)
end

---@param player LuaPlayer
---@return LuaGuiElement
function Datapadreader.GetSpriteButton(player)
    return player.gui.screen[Datapadreader.ui_root][Datapadreader.ui_main_flow][Datapadreader.ui_upper_flow][Datapadreader.ui_root_panel][Datapadreader.ui_sprite_button] --[[@as LuaGuiElement]]
end

---@param player LuaPlayer
---@return LuaGuiElement
function Datapadreader.GetTextbox(player)
    return player.gui.screen[Datapadreader.ui_root][Datapadreader.ui_main_flow][Datapadreader.ui_text_box] --[[@as LuaGuiElement]]
end

---@param player LuaPlayer
---@param name string
---@return LuaGuiElement
function Datapadreader.GetDatapadControlButton(player, name)
    return player.gui.screen[Datapadreader.ui_root][Datapadreader.ui_main_flow][Datapadreader.ui_upper_flow][Datapadreader.ui_rightflow][Datapadreader.ui_buttonflow][name] --[[@as LuaGuiElement]]
end

---@param player LuaPlayer
function Datapadreader.DisableAllControls(player)
    Datapadreader.GetTextbox(player).enabled = false
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_clear_button).enabled = false
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_write_button).enabled = false
end

---@param player LuaPlayer
function Datapadreader.EnableAllControls(player)
    Datapadreader.GetTextbox(player).enabled = true
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_clear_button).enabled = true
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_write_button).enabled = true
end