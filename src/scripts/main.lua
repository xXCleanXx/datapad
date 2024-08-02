---Gets the GUI for a player.
---@param player LuaPlayer
---@return LuaGuiElement?
function DataPad.get(player)
    return player.gui.screen[DataPad.name_root]
end

---Opens the GUI for a player
---@param player LuaPlayer
function DataPad.open(player)
    if DataPad.get(player) then DataPad.close(player) end

    local root = DataPad.create(player)

    if root then return end

    root.force_auto_center()
end

---Closes the GUI of a player if open.
---@param player LuaPlayer
function DataPad.close(player)
    local root = DataPad.get(player)

    if root then root.destroy() end
end

---Opens or closes the GUI.
---@param player LuaPlayer
function DataPad.toggle(player)
    if DataPad.get(player) then
        DataPad.close(player)
    else
        DataPad.open(player)
    end
end