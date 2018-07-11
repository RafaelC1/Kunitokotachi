require "class"

Animation = {}

function Animation.new(sprites, frame_per_sec)

  frame_per_sec = frame_per_sec or 1

  local self = Class.new()
  self.sprites = sprites
  self.sprite = 1
  self.time_for_each_frame = frame_per_sec
  self.current_time = 0
  self.loop = true
  self.ended = false

  function self.start()
    self.current_time = 0
    self.sprite = 1
    self.ended = false
  end

  function self.dont_repeat()
    self.loop = false
  end

  function self.repeat_on_end()
    self.loop = true
  end

  function self.reset_time()
    self.current_time = 0
  end

  function self.reset_sprite()
    self.sprite = 1
  end

  function self.current_sprite()
    return self.sprites[self.sprite]
  end

  function self:update_time(dt)
    self.current_time = self.current_time + dt
  end

  function self:update_frame()
    if self.current_time >= self.time_for_each_frame and not self.ended then
      self.reset_time()
      self.sprite = self.sprite + 1
    end
    if self.sprite > #self.sprites then
      if self.loop then
        self.reset_sprite()
      else
        self.sprite = #self.sprites
        self.ended = true
      end
    end
  end

  function self:update(dt)
    self:update_time(dt)
    self:update_frame()
  end

  function self.draw(args)
    self.current_sprite().draw(args)
  end

  return self
end
