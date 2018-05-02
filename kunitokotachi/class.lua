Class = {}

function Class.new()
  local self = {}

  self.title = 'class'

  -- this method make a class inherit another passed as 'o' parameter
  function self.inherit(o)
    for k, v in pairs(o) do
      self[k] = v
    end
  end
  -- this method give a perfect copy of this table
  function self.copy(table)
    local self_copy = {}
    if table == nil then
      table = self
    end
    for k, v in pairs(table) do
      local temp = v
      if type(v) == table then
        temp = self.copy(v)
      end
      self_copy[k] = temp
    end
    return self_copy
  end
  -- this calss return a list of attributes of this calss
  function self.attributes()
    return self.list_of_characteristics('attributes')
  end
  -- this calss return a list of methods of this calss
  function self.methods()
    return self.list_of_characteristics('function')
  end
  -- this method check if this class has a method passed as parameter
  function self.has_method(method_name)
    for i, class_method_name in ipairs(self.methods()) do
      if class_method_name == method_name then
        return true
      end
    end
    return false
  end

  function self.has_method(method_name)
    for i, class_method_name in ipairs(self.methods()) do
      if class_method_name == method_name then
        return true
      end
    end
    return false
  end
  -- this calss return a list of attributes or methods of this calss
  function self.list_of_characteristics(looking_for)
    local list = {}
    local i = 0
    for k, v in pairs(self) do
      if type(v) == looking_for then
        list[i] = k
        i = i + 1
      end
    end
    return list
  end

  return self
end