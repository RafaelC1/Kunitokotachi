pai = {}
mae = {}
filho = {}

function pai.new()
  local self = {}
  self.a = 10

  return self
end

function mae.new()
  local self = {}
  function self:teste()
    print(self.a)
  end
  return self
end

function filho.new()
  local self = {}
  function self.inherit(o)
    for k, v in pairs(o) do
      print(k, v)
      self[k] = v
    end
  end
  self.inherit(pai.new())
  self.inherit(mae.new())
  return self
end

f = filho.new()

print(f.a)
f:teste()