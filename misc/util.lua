
Multiverse = Multiverse or {}
---Talisman compatibility?
to_big = to_big or function(x)
    return x
end
---Checks if value is mapped to a key within a table t.
---@param table table
---@param value any
---@return boolean
Multiverse.contains_value = function(table, value)
    for _, v in ipairs(table) do
        if v == value then return true end
    end
    return false
end
---Counts the number of items in a table t.
---@param table table
---@return number
Multiverse.len = function(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end
---Gets a random value from a numerically-indexed table.
---@param table table
---@return any
Multiverse.get_random_item = function(table)
    return table[math.random(#table)]
end
---Appends an item to a numerically-indexed table.
---@param table table
---@param item any
Multiverse.append = function(table, item)
    table[#table+1] = item
end
Multiverse.transmutations = {
    ["j_joker"] = "j_mul_ren_amamiya",
    ["j_mul_villager"] = "j_mul_steve"
}
Multiverse.update_anim = function(card, dt)
    if card.config.center.anim_info then
        local data = card.config.center.anim_info
        card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress + (dt * data.num_frames / data.anim_time)
        if card.config.center.anim_info.anim_progress > data.num_frames then
            card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress - data.num_frames
        end
        card.config.center.pos.x = math.floor(card.config.center.anim_info.anim_progress) % data.num_frames
    end
end