local Informatron = {} -- informatron pages implementation.

function Informatron.menu(player_index)
  local menu = {

  }
  return menu
end

function Informatron.page_content(page_name, player_index, element)
  if page_name == "datapad" then
    element.add{type="label", name="datapad-text", caption={"datapad.page_datapad_text_1"}}
  end
end

return Informatron