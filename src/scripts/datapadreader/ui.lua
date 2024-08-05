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
        caption = {"datapad-reader.title"},
        ignored_by_interaction = true
    }
    heading.style.font = "heading-font"
    heading.style.left_margin = 4

    hFlow.add{
        type = "empty-widget",
        ignored_by_interaction = true,
        style = "datapadreader-ui-draghandle"
    }

    local closeButton = hFlow.add{
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
local function RenderSlot(element)
    local buttonFrame = element.add{
        type = "frame",
        name = Datapadreader.ui_root_panel,
        style = "datapadreader-ui-sprite-button-frame"
    }

    local spritebutton = buttonFrame.add{
        type = "sprite-button",
        name = Datapadreader.ui_slot,
        tags = {root=Datapadreader.name, action=Datapadreader.ui_slot}
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
        direction = "horizontal",
        name = Datapadreader.ui_buttonflow
    }
    buttonFlow.style.top_margin = 6

    local buttonClear = buttonFlow.add{
        type = "button",
        caption = {"datapad-reader.clear-button"},
        name = Datapadreader.ui_clear_button,
        enabled = false,
        tags = {action=Datapadreader.ui_action_clear_button},
        style = "red_button"
    }
    buttonClear.style.font = "button-font"
    buttonClear.style.width = 60
    buttonClear.style.height = 28
    buttonClear.style.left_margin = 8

    local buttonWrite = buttonFlow.add{
        type = "button",
        caption = {"datapad-reader.write-button"},
        enabled = false,
        name = Datapadreader.ui_write_button,
        tags = {action=Datapadreader.ui_action_write_button},
        style = "confirm_button"
    }
    buttonWrite.style.font = "button-font"
    buttonWrite.style.width = 64
    buttonWrite.style.height = 28
    buttonWrite.style.left_margin = 44
end

---@param element LuaGuiElement
local function RenderNameTextbox(element)
    local root = element.add{
        type = "flow",
        direction = "vertical",
        name = Datapadreader.ui_content_root_flow_name_flow
    }
    root.style.margin = 4

    root.add{
        type = "label",
        caption = {"datapad-reader.name"},
        style = "heading_3_label_yellow"
    }

    local textbox = root.add{
        type = "textfield",
        name = Datapadreader.ui_content_root_flow_name_flow_txt,
        enabled = false
    }
    textbox.style.width = 240 - 24
end

---@param element LuaGuiElement
local function RenderContentTextbox(element)
    local root = element.add{
        type = "flow",
        direction = "vertical",
        name = Datapadreader.ui_content_root_flow_content_flow
    }
    root.style.margin = 4

    local label = root.add{
        type = "label",
        caption = {"datapad-reader.content"},
        style = "heading_3_label_yellow"
    }

    local textbox = root.add{
        type = "text-box",
        name = Datapadreader.ui_content_root_flow_content_flow_txt,
        enabled = false
    }
    textbox.style.height = 340
    textbox.style.width = 240 - 24
end

---@param element LuaGuiElement
local function RenderContentFrame(element)
        local root = element.add{
        type = "frame",
        name = Datapadreader.ui_content_root,
        style = "datapadreader-ui-content-root"
    }
    root.style.left_margin = 4
    root.style.width = 240 - 16
    root.style.height = 520 - 80

    local rootFlow = root.add{
        type = "flow",
        direction = "vertical",
        name = Datapadreader.ui_content_root_flow
    }

    RenderNameTextbox(rootFlow)
    RenderContentTextbox(rootFlow)
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

    RenderButtons(upperFlow)
    RenderSlot(upperFlow)
    RenderContentFrame(mainflow)

    SetGuiLocation(root, player)
end

---@param player LuaPlayer
---@return LuaGuiElement
function Datapadreader.GetSlot(player)
    return player.gui.screen[Datapadreader.ui_root][Datapadreader.ui_main_flow][Datapadreader.ui_upper_flow][Datapadreader.ui_root_panel][Datapadreader.ui_slot] --[[@as LuaGuiElement]]
end

---@param player LuaPlayer
---@return LuaGuiElement
function Datapadreader.GetNameTextbox(player)
    return player.gui.screen[Datapadreader.ui_root][Datapadreader.ui_main_flow][Datapadreader.ui_content_root][Datapadreader.ui_content_root_flow][Datapadreader.ui_content_root_flow_name_flow][Datapadreader.ui_content_root_flow_name_flow_txt] --[[@as LuaGuiElement]]
end

---@param player LuaPlayer
---@return LuaGuiElement
function Datapadreader.GetContentTextbox(player)
    return player.gui.screen[Datapadreader.ui_root][Datapadreader.ui_main_flow][Datapadreader.ui_content_root][Datapadreader.ui_content_root_flow][Datapadreader.ui_content_root_flow_content_flow][Datapadreader.ui_content_root_flow_content_flow_txt] --[[@as LuaGuiElement]]
end

---@param player LuaPlayer
---@param name string
---@return LuaGuiElement
function Datapadreader.GetDatapadControlButton(player, name)
    return player.gui.screen[Datapadreader.ui_root][Datapadreader.ui_main_flow][Datapadreader.ui_upper_flow][Datapadreader.ui_rightflow][Datapadreader.ui_buttonflow][name] --[[@as LuaGuiElement]]
end

---@param player LuaPlayer
function Datapadreader.DisableAllControls(player)
    Datapadreader.GetNameTextbox(player).enabled = false
    Datapadreader.GetContentTextbox(player).enabled = false
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_clear_button).enabled = false
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_write_button).enabled = false
end

---@param player LuaPlayer
function Datapadreader.EnableAllControls(player)
    Datapadreader.GetNameTextbox(player).enabled = true
    Datapadreader.GetContentTextbox(player).enabled = true
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_clear_button).enabled = true
    Datapadreader.GetDatapadControlButton(player, Datapadreader.ui_write_button).enabled = true
end