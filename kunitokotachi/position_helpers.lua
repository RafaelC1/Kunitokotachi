function inside_screen(args)
    -- if args.x == nil or args.y == nil then return false end
    -- args.xv = args.xv or 0
    -- args.yv = args.yv or 0
    -- local inside = false
    -- if inside_screen_height(args.y + args.yv) and inside_screen_height(args.y + args.yv) then inside = true end
    -- return inside
end
function inside_screen_width(x)
    if 0 < x and x < WIDTH then
        return true
    else
        return false
    end
end
function inside_screen_height(y)
    if 0 < y and y < HEIGHT then
        return true
    else
        return false
    end
end