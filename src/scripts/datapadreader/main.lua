require("constants")
require("ui")
require("events")
require("datapaddata")

---Returns the Datapad HUD for a given player, if it is open.
---@param player LuaPlayer
---@return LuaGuiElement
function Datapadreader.GetWindow(player)
    return player.gui.screen[Datapadreader.ui_root] --[[@as LuaGuiElement]]
end

---@param player LuaPlayer
function Datapadreader.GuiOpen(player)
    if Datapadreader.GetWindow(player) then return end
    Datapadreader.RenderGui(player)
end

---Closes the Datapad HUD of the given player.
---@param player LuaPlayer Player
function Datapadreader.GuiClose(player)
    local dpadData = Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player)
    local gui = Datapadreader.GetWindow(player)

    if gui then
        dpadData.Location = Datapadreader.GetWindow(player).location
        gui.destroy()
    end
end

---Opens or closes the GUI.
---@param player LuaPlayer
function Datapadreader.GuiToggle(player)
    if Datapadreader.GetWindow(player) then
        Datapadreader.GuiClose(player)
    else
        Datapadreader.GuiOpen(player)
    end
end

---@param player LuaPlayer
---@return DatapadData
function Datapadreader.GetGlobalDatapadModDataForSpecificPlayer(player)
    local player_index = player.index

    if global.datapad_data == nil then
        global.datapad_data = {}
    end
    global.datapad_data[player_index] = global.datapad_data[player_index] or {}
    return global.datapad_data[player_index]
end