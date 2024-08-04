require("constants")
require("events")
require("ui")

---Closes the Datapad HUD of the given player.
---@param player LuaPlayer Player
function Datapadreader.GuiClose(player)
    local gui = Datapadreader.GetGui(player)
  
    if gui then
      --local playerdata = get_make_playerdata(player)
      --playerdata.lifesupport_hud_location = gui.location
      gui.destroy()
    end
end

---Opens or closes the GUI.
---@param player LuaPlayer
function Datapadreader.GuiToggle(player)
    if Datapadreader.GetGui(player) then
        Datapadreader.GuiClose(player)
    else
        Datapadreader.GuiOpen(player)
    end
end