Multiverse = Multiverse or {}
---Talisman compatibility?
to_big = to_big or function(x)
    return x
end
---Checks if value is mapped to a key within a table t.
---@param table table
---@param value any
---@return boolean
function Multiverse.contains_value(table, value)
    for _, v in ipairs(table) do
        if v == value then return true end
    end
    return false
end
---Counts the number of items in a table t.
---@param table table
---@return integer
function Multiverse.len(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end
---@type table<string, {key: string}>
Multiverse.transmutations = {
    ["j_joker"] = {
        key = "j_mul_ren_amamiya",
    },
    ["j_mul_villager"] = {
        key = "j_mul_steve",
    },
    ["j_mul_hammer_bro"] = {
        key = "j_mul_gerson",
    }
}
---Forces a number to be within a given range
---@param n number
---@param min? number
---@param max? number
---@return number
function Multiverse.clamp(n, min, max)
    local lower = min or 0
    local higher = max or 1
    if lower > higher then error("min cannot be higher than max") end
    if n < lower then return lower
    elseif n > higher then return higher
    else return n end
end
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
function Multiverse.update_card_anim(card, dt, vertical)
    local dir = (vertical and "y") or "x"
    if card.config.center.anim_info then
        local data = card.config.center.anim_info
        card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress or 0
        card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress + (dt * data.frames / data.anim_time)
        if card.config.center.anim_info.anim_progress >= data.frames then
            card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress - data.frames
        end
        card.config.center.pos[dir] = Multiverse.clamp(math.floor(card.config.center.anim_info.anim_progress), 0, data.frames)
    end
end

---@class Anchor
---@field x_alignment "l" | "c" | "r"
---@field y_alignment "b" | "c" | "t"
---@field x_offset number?
---@field y_offset number?

---@class Animation
---@field path string The path to the file where the animation is stored
---@field frames integer The number of frames the animation has
---@field columns integer? The number of columns the spritesheet has. Do not include if the spritesheet is all in one row.
---@field px integer The width of an individual frame of the animation
---@field py integer The height of an individual frame of the animation
---@field key string The key of the animation.
---@field is_continuous boolean? Whether or not this animation is supposed to run continuously.
---@field anchor Anchor
---@field duration number The amount of time that one animation loop will take
---@field x_scale number?
---@field y_scale number?
---@field rotation number?

---@class AnimationData
---@field frames love.Quad[]
---@field image love.Image
---@field is_active boolean
---@field progress number
---@field is_continuous boolean
---@field anchor Anchor
---@field x_scale number
---@field y_scale number
---@field rotation number
---@field px integer
---@field py integer
---@field duration number

---@type AnimationData[]
Multiverse.all_animations = {}

---Registers an animation to a global table.
---@param t Animation
---@return AnimationData
function Multiverse.Animation(t)
    local file_data = assert(NFS.newFileData(Multiverse.path .. "assets/animations/" .. t.path), "Failed to get file data")
    local image_data = assert(love.image.newImageData(file_data), "Failed to convert to image data")
    local love_image = assert(love.graphics.newImage(image_data), "Failed to create an image")
    ---@type AnimationData
    local anim_data = {
        frames = {},
        image = love_image,
        is_active = false,
        progress = 0,
        is_continuous = t.is_continuous or false,
        anchor = t.anchor,
        x_scale = t.x_scale or 1,
        y_scale = t.y_scale or 1,
        rotation = t.rotation or 0,
        px = t.px,
        py = t.py,
        duration = t.duration
    }
    for i = 1, t.frames do
        local x, y = (i - 1) % (t.columns or i), (t.columns and math.floor((i-1)/t.columns) or 0)
        anim_data.frames[#anim_data.frames+1] = love.graphics.newQuad(x * t.px, y * t.py, t.px, t.py, love_image)
    end
    Multiverse.all_animations = Multiverse.all_animations or {}
    Multiverse.all_animations[t.key] = anim_data
    return anim_data
end
---@type table<string,table<string, number>>>
Multiverse.anchors = {
    x = {
        l = 0,
        c = love.graphics.getWidth() / 2,
        r = love.graphics.getWidth()
    },
    y = {
        t = 0,
        c = love.graphics.getHeight() / 2,
        b = love.graphics.getHeight()
    }
}
---Gets the correct offset for love.draw based on the animation's dimensions
---using a function that takes in an Animation and returns a number.
---The functions are grouped by axis and then by alignment type.
---@type table<string, table<string, fun(a: AnimationData): number>>
Multiverse.base_offsets = {
    x = {
        l = function(a)
            return 0
        end,
        c = function(a)
            return a.px / 2
        end,
        r = function(a)
            return a.px
        end
    },
    y = {
        t = function(a)
            return 0
        end,
        c = function(a)
            return a.py/2
        end,
        b = function(a)
            return a.py
        end
    }
}

---Starts the animation with the given key.
---@param key string The key of the animation to start
---@param callback? fun(): nil
function Multiverse.start_animation(key, callback)
    if Multiverse.all_animations[key] then
        Multiverse.all_animations[key].progress = 0
        Multiverse.all_animations[key].is_active = true
    else
        error("No animation for " .. key .. " exists")
    end
end

function Multiverse.end_animation(key)
    if Multiverse.all_animations[key] then
        Multiverse.all_animations[key].progress = 0
        Multiverse.all_animations[key].is_active = false
    else
        error("No animation for " .. key .. " exists")
    end
end