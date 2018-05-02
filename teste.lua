require "kunitokotachi/class"

teste = {}

function teste.new()
  local self = Class.new()

  self.a = {}
  self.a.b = 10

  return self
end

original = teste.new()

copia = original.copy()

copia.a.b = 20

print(copia.a.b)
print(original.a.b)

