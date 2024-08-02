function DataPad.create(player)
    local root = player.gui.screen.add{
        type = 'frame',
        direction = 'vertical',
        name = DataPad.name_root
    }

    player.opened = root

    if not root.valid then return nil end

    root.add{
        type = 'label',
        text = 'Datapad'
    }

    root.add{
        type = 'textfield',
        name = DataPad.name_textfield
    }

    root.add{
        type = 'text-box',
        name = DataPad.name_text_box
    }

    root.add{
        type = 'button',
        name = DataPad.name_close_button,
        style = 'datapad_close_button'
    }

    return root
end