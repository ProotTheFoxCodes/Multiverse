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
    for _, v in pairs(table) do
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


---Forces a number to be within a given range.
---@param n number
---@param min? number
---@param max? number
---@return number
function Multiverse.clamp(n, min, max)
    local lower = min or 0
    local higher = max or 1
    if lower > higher then error("min cannot be higher than max") end
    if n < lower then
        return lower
    elseif n > higher then
        return higher
    else
        return n
    end
end

---Returns all cards in t such that func(t) is truthy.
---@param t Card[]
---@param func fun(card: Card): boolean
---@return Card[]
function Multiverse.filter(t, func)
    local ret = {}
    for _, c in ipairs(t) do
        if func(c) then
            table.insert(ret, c)
        end
    end
    return ret
end

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
        card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress +
        (dt * data.frames / data.anim_time)
        if card.config.center.anim_info.anim_progress >= data.frames then
            card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress - data.frames
        end
        card.config.center.pos[dir] = Multiverse.clamp(math.floor(card.config.center.anim_info.anim_progress), 0,
            data.frames)
    end
end

---@class Anchor
---@field x_alignment "l" | "c" | "r"
---@field y_alignment "b" | "c" | "t"
---@field x_offset number?
---@field y_offset number?

---@class Multiverse.Animation
---@field path string The name of the file where the animation is stored
---@field frames integer The number of frames the animation has
---@field columns integer? The number of columns the spritesheet has. Do not include if the spritesheet is all in one row.
---@field px integer The width of an individual frame of the animation
---@field py integer The height of an individual frame of the animation
---@field key string The key of the animation
---@field is_continuous boolean? Whether or not this animation is supposed to run continuously
---@field anchor Anchor The place on the screen where the animation is
---@field duration number The amount of time that one animation loop will take
---@field x_scale number? The factor that the animation will be scaled horizontally
---@field y_scale number? The factor that the animation will be scaled vertically
---@field rotation number? The rotation of the animation in radians

---@class Multiverse.AnimationData
---@field frames love.Quad[] The quadrants of the file that each represent a single frame
---@field image love.Image The image where all the quadrants are derived from
---@field is_active boolean Whether or not the animation is displayed on screen
---@field progress number Represents the completion progress of the animation
---@field px integer The width of an individual frame of the animation
---@field py integer The height of an individual frame of the animation
---@field is_continuous boolean? Whether or not this animation is supposed to run continuously
---@field anchor Anchor The place on the screen where the animation is
---@field duration number The amount of time that one animation loop will take
---@field x_scale number? The factor that the animation will be scaled horizontally
---@field y_scale number? The factor that the animation will be scaled vertically
---@field rotation number? The rotation of the animation in radians

---@type table<string, Multiverse.AnimationData>
Multiverse.all_animations = {}

---Registers an animation to a global table.
---Access this animation with Multiverse.all_animations[key].
---@param t Multiverse.Animation
---@return Multiverse.AnimationData
function Multiverse.Animation(t)
    local file_data = assert(NFS.newFileData(Multiverse.path .. "assets/animations/" .. t.path),
        "Failed to get file data")
    local image_data = assert(love.image.newImageData(file_data), "Failed to convert to image data")
    local love_image = assert(love.graphics.newImage(image_data), "Failed to create an image")
    ---@type Multiverse.AnimationData
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
        local x, y = (i - 1) % (t.columns or i), (t.columns and math.floor((i - 1) / t.columns) or 0)
        anim_data.frames[#anim_data.frames + 1] = love.graphics.newQuad(x * t.px, y * t.py, t.px, t.py, love_image)
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
---using a function that takes in AnimationData or VideoData and returns a number.
---The functions are grouped by axis and then by alignment type.
---@type table<string, table<string, fun(a: Multiverse.AnimationData | Multiverse.VideoData): number>>
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
            return a.py / 2
        end,
        b = function(a)
            return a.py
        end
    }
}

---Starts the animation with the given key.
---@param key string The key of the animation to start
function Multiverse.start_animation(key)
    if Multiverse.all_animations[key] then
        Multiverse.all_animations[key].progress = 0
        Multiverse.all_animations[key].is_active = true
    else
        error("No animation for " .. key .. " exists")
    end
end

---Ends the animation with the given key.
---@param key string
function Multiverse.end_animation(key)
    if Multiverse.all_animations[key] then
        Multiverse.all_animations[key].progress = 0
        Multiverse.all_animations[key].is_active = false
    else
        error("No animation for " .. key .. " exists")
    end
end

---@class Multiverse.Video
---@field path string The name of the file where the video is stored
---@field key string The key of the video.
---@field anchor Anchor The place on the screen where the video is
---@field x_scale number? The factor that the video will be scaled horizontally
---@field y_scale number? The factor that the video will be scaled vertically
---@field rotation number? The rotation of the video in radians
---@field volume number? The volume of the video

---@class Multiverse.VideoData
---@field video love.Video The video to be displayed
---@field anchor Anchor The place on the screen where the video is
---@field x_scale number? The factor that the video will be scaled horizontally
---@field y_scale number? The factor that the video will be scaled vertically
---@field rotation number? The rotation of the video in radians
---@field px integer The width of an individual frame of the video
---@field py integer The height of an individual frame of the video
---@field is_visible boolean Whether or not the video is visible on screen

---@type table<string, Multiverse.VideoData>
Multiverse.all_videos = {}

---Registers a video to a global table.
---Access this video with Multiverse.all_videos[key].
---@param t Multiverse.Video
---@return Multiverse.VideoData
function Multiverse.Video(t)
    local path = Multiverse.path .. "assets/videos/" .. t.path
    local f = NFS.read(path)
    love.filesystem.write("mul_" .. t.key .. ".ogv", f)
    local love_video = love.graphics.newVideo("mul_" .. t.key .. ".ogv")
    if love_video:getSource() then
        love_video:getSource():setVolume(G.SETTINGS.SOUND.volume * G.SETTINGS.SOUND.game_sounds_volume / 1000)
    end
    ---@type Multiverse.VideoData
    local v_data = {
        video = love_video,
        anchor = t.anchor,
        x_scale = t.x_scale or 1,
        y_scale = t.y_scale or 1,
        rotation = t.rotation or 0,
        px = love_video:getWidth(),
        py = love_video:getHeight(),
        is_visible = false
    }
    Multiverse.all_videos = Multiverse.all_videos or {}
    Multiverse.all_videos[t.key] = v_data
    return v_data
end

function Multiverse.play_video(key)
    if Multiverse.all_videos[key] then
        Multiverse.all_videos[key].video:rewind()
        Multiverse.all_videos[key].video:play()
        Multiverse.all_videos[key].is_visible = true
    else
        error("No video for " .. key .. " exists")
    end
end

function Multiverse.pause_video(key)
    if Multiverse.all_videos[key] then
        Multiverse.all_videos[key].video:pause()
    else
        error("No video for " .. key .. " exists")
    end
end

function Multiverse.stop_video(key)
    if Multiverse.all_videos[key] then
        Multiverse.all_videos[key].is_visible = false
        Multiverse.all_videos[key].video:pause()
    else
        error("No video for " .. key .. " exists")
    end
end

function Multiverse.handle_other_drawing(x_factor, y_factor)
    for key, anim in pairs(Multiverse.all_animations) do
        if anim.is_active then
            --print(Multiverse.clamp(math.floor(anim.progress) + 1, 1, #anim.frames))
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(
                anim.image,
                anim.frames[Multiverse.clamp(math.floor(anim.progress) + 1, 1, #anim.frames)],
                Multiverse.anchors.x[anim.anchor.x_alignment] + (anim.anchor.x_offset or 0) * x_factor,
                Multiverse.anchors.y[anim.anchor.y_alignment] + (anim.anchor.y_offset or 0) * y_factor,
                anim.rotation,
                anim.x_scale * x_factor,
                anim.y_scale * y_factor,
                Multiverse.base_offsets.x[anim.anchor.x_alignment](anim),
                Multiverse.base_offsets.y[anim.anchor.y_alignment](anim),
                0,
                0
            )
        end
    end
    for key, video in pairs(Multiverse.all_videos) do
        if video.is_visible then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(
                video.video,
                Multiverse.anchors.x[video.anchor.x_alignment] + (video.anchor.x_offset or 0) * x_factor,
                Multiverse.anchors.y[video.anchor.y_alignment] + (video.anchor.y_offset or 0) * y_factor,
                video.rotation,
                video.x_scale * x_factor,
                video.y_scale * y_factor,
                Multiverse.base_offsets.x[video.anchor.x_alignment](video),
                Multiverse.base_offsets.y[video.anchor.y_alignment](video),
                0,
                0
            )
        end
    end
end

function Multiverse.update_animations()
    for key, anim in pairs(Multiverse.all_animations) do
        if anim.is_active then
            if anim.is_continuous then
                anim.progress = anim.progress + G.real_dt * #anim.frames / anim.duration
                if anim.progress >= #anim.frames then
                    anim.progress = anim.progress - #anim.frames
                end
                -- anim_progress \in [0, #anim_frames)
                -- anim_progress + 1 \in [1, anim_frames + 1)
            else
                if anim.progress < #anim.frames then
                    anim.progress = anim.progress + G.real_dt * #anim.frames / anim.duration
                else
                    anim.is_active = false
                end
            end
        end
    end
end

function Multiverse.set_transmute_requirements(base)
    return Multiverse.config.debug and 1 or base
end

function Multiverse.get_screen_x_scale()
    return love.graphics.getWidth() / 1536
end

function Multiverse.get_screen_y_scale()
    return love.graphics.getHeight() / 864
end

function Multiverse.get_screen_scale()
    return Multiverse.get_screen_x_scale(), Multiverse.get_screen_y_scale()
end

---@param card Card
function Multiverse.get_card_x_pos(card)
    return 155 * Multiverse.get_screen_x_scale() + card.children.center.CT.x * card.children.center.scale.x / 1.0445
end

function Multiverse.get_card_y_pos(card)
    return 127.5 * Multiverse.get_screen_y_scale() + card.children.center.CT.y * card.children.center.scale.y / 1.39
end

--- Basically just Card:start_dissolve but doesnt destroy the card
function Card:mul_safe_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    local dissolve_time = 0.7*(dissolve_time_fac or 1)
    self.dissolve = 0
    self.dissolve_colours = dissolve_colours
        or {G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
    if not no_juice then self:juice_up() end
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.01*dissolve_time,
        scale = 0.1,
        speed = 2,
        lifespan = 0.7*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.7*dissolve_time,
        func = (function() childParts:fade(0.3*dissolve_time) return true end)
    }))
    if not silent then 
        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = (function()
                    play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
                    play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
                return true end)
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  1*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.051*dissolve_time,
    }))
end