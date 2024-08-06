---@diagnostic disable-next-line
window_width = 240
---@diagnostic disable-next-line
window_height = 520

data.raw["gui-style"]["default"]["datapadreader-ui-sprite-button-frame"] = {
    type = "frame_style",
    margin = 4,
    parent = "quick_bar_inner_panel",
    maximal_height = 36,
    maximal_width = 36
}

data.raw["gui-style"]["default"]["datapadreader-ui-frame"] = {
    type = "frame_style",
    parent = "quick_bar_window_frame",
    horizontal_flow_style = {
      type = "horizontal_flow_style",
      horizontal_spacing = 0
    },
    padding = 0,
    width = window_width,
    height = window_height
}

data.raw["gui-style"]["default"]["datapadreader-ui-draghandle"] = {
    type = "empty_widget_style",
    parent = "draggable_space",
    horizontally_stretchable = "on",
    height = 16,
    left_margin = 4,
    right_margin = 4
}

data.raw["gui-style"]["default"]["datapadreader-ui-content-root"] = {
    type = "frame_style",
    parent = "inside_shallow_frame",
    width = window_width - 16,
    horizontally_stretchable = "on",
    vertically_stretchable = "on",
    left_margin = 4,
    height = 520 - 80
}

data.raw["gui-style"]["default"]["datapadreader-ui-heading"] = {
    type = "label_style",
    font = "heading-font",
    left_margin = 4
}

data.raw["gui-style"]["default"]["datapadreader-ui-close-button"] = {
    type = "button_style",
    parent = "close_button",
    width = 16,
    height = 16,
    horizontal_align = "right"
}

data.raw["gui-style"]["default"]["datapadreader-ui-button-flow"] = {
    type = "horizontal_flow_style",
    top_margin = 6
}

data.raw["gui-style"]["default"]["datapadreader-ui-clear-button"] = {
    type = "button_style",
    parent = "red_button",
    font = "button-font",
    width = 60,
    height = 28,
    left_margin = 8
}

data.raw["gui-style"]["default"]["datapadreader-ui-write-button"] = {
    type = "button_style",
    parent = "confirm_button",
    font = "button-font",
    width = 64,
    height = 28,
    left_margin = 44
}

data.raw["gui-style"]["default"]["datapadreader-ui-content-textbox"] = {
    type = "textbox_style",
    height = 340,
    width = window_width - 24
}