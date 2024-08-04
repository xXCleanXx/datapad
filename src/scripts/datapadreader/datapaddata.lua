---@class DatapadData
---@field Name string
---@field Content string

DatapadData = {}
DatapadData.__index = DatapadData

function DatapadData:new()
    local obj = {}
    setmetatable(obj, DatapadData)
    obj.Name = nil
    obj.Content = nil

    return obj
end

---@param name string
function DatapadData:set_name(name)
    self.name = name
end

---@return string
function DatapadData:get_name()
    return self.name
end

return DatapadData