---@class DatapadData
---@field Name string
---@field Content string
---@field Location GuiLocation
---@field IsStackEventEnabled boolean

DatapadData = {}
DatapadData.__index = DatapadData

---@return DatapadData
function DatapadData.new()
    local self = setmetatable({}, DatapadData)

    self.IsStackEventEnabled = true

    return self
end