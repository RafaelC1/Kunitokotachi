function on_screen(x, y)
    if inside_screen_width(x) and inside_screen_height(y) then
      return true
    else
      return false
    end
  end
function inside_screen_width(x)
  if 0 < x and x < WIDTH then
    return true
  else
    return false
  end
end
function inside_screen_height(y)
  if below_top(y) and above_bottom(y) then
    return true
  else
    return false
  end
end
function below_top(y)
  if y > 0 then
    return true
  else
    return false
  end
end
function above_bottom(y)
  if y < HEIGHT then
    return true
  else
    return false
  end
end