---Talisman compatibility
to_big = to_big or function(x)
    return x
end
---Checks if value is mapped to a key within t.
---@param t table
---@param value any
---@return boolean
table.contains_value = function(t, value)
    for _, v in ipairs(t) do
        if v == value then return true end
    end
    return false
end
---Counts the number of items in a table t with non-numeric indices.
---@param t table
---@return number
table.len = function(t)
    local count = 0
    for _, _ in pairs(t) do
        count = count + 1
    end
    return count
end
---Gets a random value from a numerically-indexed table.
---@param t table
---@return any
table.get_random_item = function(t)
    return t[math.random(#t)]
end
---Appends an item to a numerically-indexed table.
---@param t table
---@param item any
table.append = function(t, item)
    t[#t+1] = item
end
---Destroys the given joker
Multiverse.destroy_joker = function(joker, sound)
    local sfx_path = sound or "tarot1"
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound(sfx_path)
            joker.T.r = -0.2
            joker:juice_up(0.3,0.4)
            joker.states.drag.is = true
            joker.children.center.pinch.x = true
            joker:start_dissolve(G.C.RED, nil, 1.6)
            joker = nil
            return true
        end
    }))
end
