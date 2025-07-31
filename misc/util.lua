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
---@return integer
Multiverse.len = function(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end
---Gets a random value from a numerically-indexed table.
---@generic T
---@param table table<integer, T>
---@param seed string
---@return T
Multiverse.get_random_item = function(table, seed)
    local source = seed or "get_random_item"
    return table[pseudorandom(source, 1, #table)]
end
---@type table<string, {key: string}>
Multiverse.transmutations = {
    ["j_joker"] = {
        key = "j_mul_ren_amamiya",
    },
    ["j_mul_villager"] = {
        key = "j_mul_steve",
    }
}
--- Code taken from https://easings.net/
--- 
--- I have generalized the poly easings to allow for any degree of polynomial
Multiverse.easings = {
    exp = {
        ["in"] = function (num)
            if num == 0 then return 0
            else return 2 ^ (10 * num - 10) end
        end,
        ["out"] = function (num)
            if num == 1 then return 0
            else return 1 - (2 ^ (-10 * num)) end
        end,
        ["in_out"] = function (num)
            if num == 0 or num == 1 then return num end
            if num < 0.5 then
                return 2 ^ (20 * num - 11)
            else
                return 1 - (2 ^ (-20 * num + 9))
            end
        end
    },
    poly = {
        ["in"] = function (num, deg)
            return num ^ deg
        end,
        ["out"] = function (num, deg)
            return 1 - (1 - num) ^ deg
        end,
        ["in_out"] = function (num, deg)
            if num < 0.5 then
                return (2 ^ (deg - 1)) * (num ^ deg)
            else
                return 1 - ((2 ^ (deg - 1)) * (num ^ deg))
            end
        end
    },
    sin = {
        ["in"] = function (num)
            return 1 - math.cos(math.pi * num / 2)
        end,
        ["out"] = function (num)
            return math.sin(math.pi * num / 2)
        end,
        ["in_out"] = function (num)
            return -(math.cos(math.pi * num) - 1) / 2
        end
    },
    back = {
        ["in"] = function (num)
            local c = 1.70158
            if num == 1 then return 1 end
            return (c + 1) * (num ^ 3) - c * (num ^ 2)
        end,
        ["out"] = function (num)
            local c = 1.70158
            if num == 0 then return 0 end
            return 1 - (c + 1) * ((1 - num) ^ 3) + c * ((1 - num) ^ 2)
        end,
        ["in_out"] = function (num)
            local c = 1.70158 * 1.525
            if num == 0 or num == 1 then return num end
            if num < 0.5 then
                return 2 * num ^ 2 * ((2 * num - 1) * c + 2 * num)
            else
                return 1 - (2 * (1 - num) ^ 2 * ((1 -2 * num) * c + 2 - 2 * num))
            end
        end
    },
    lin = function (num)
        return num
    end
}

---Updates the animation state of a given card.
---
---Make sure to pass in <code>G.real_dt</code> for the dt argument.
---@param card Card
---@param dt number
---@param vertical? boolean
Multiverse.update_anim = function(card, dt, vertical)
    local dir = (vertical and "y") or "x"
    if card.config.center.anim_info then
        local data = card.config.center.anim_info
        card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress or 0
        card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress + (dt * data.frames / data.anim_time)
        if card.config.center.anim_info.anim_progress > data.frames then
            card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress - data.frames
        end
        card.config.center.pos[dir] = math.floor(card.config.center.anim_info.anim_progress) % data.frames
    end
end