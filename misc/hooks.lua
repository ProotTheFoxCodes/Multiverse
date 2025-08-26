local is_face_hook = Card.is_face
function Card:is_face(from_boss)
    if self.config.center.key == "m_mul_calling_card" then
        if self.debuff and not from_boss then return end
        if next(SMODS.find_card("j_pareidolia")) then return true end
    end
    if self.config.center.key == "m_mul_normal" then
        if self.debuff and not from_boss then return end
        return true
    end
    return is_face_hook(self, from_boss)
end
local draw_hook = love.draw
function love.draw()
    draw_hook()
    local width, height = love.graphics.getDimensions()
    local x_factor = width / 1980
    local y_factor = height / 1080
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
            --print(Multiverse.clamp(math.floor(anim.progress) + 1, 1, #anim.frames))
            love.graphics.setColor(1,1,1,1)
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
            love.graphics.setColor(1,1,1,1)
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
    if Multiverse.in_limbo then
        if Multiverse.in_limbo == "end" then
            for _, key in ipairs(Multiverse.limbo_keys) do
                love.graphics.setColor(key.end_color)
                love.graphics.draw(
                    Multiverse.LIMBO_KEY_SPRITE,
                    love.graphics.getWidth() / 2 + (key.x - 2.5) * 150,
                    love.graphics.getHeight() / 2 + (key.y - 1.5) * 150,
                    0,
                    1,
                    1,
                    30.5,
                    21.5,
                    0,
                    0
                )
            end
        else
            for _, key in ipairs(Multiverse.limbo_keys) do
                love.graphics.setColor(key.current_color)
                love.graphics.draw(
                    Multiverse.LIMBO_KEY_SPRITE,
                    love.graphics.getWidth() / 2 + (key.x - 2.5) * 150,
                    love.graphics.getHeight() / 2 + (key.y - 1.5) * 150,
                    0,
                    1,
                    1,
                    30.5,
                    21.5,
                    0,
                    0
                )
            end
        end
    end
end

local tooltip_hook = create_popup_UIBox_tooltip
function create_popup_UIBox_tooltip(tooltip)
    local ret = tooltip_hook(tooltip)
    if ret and tooltip.colour then
        ret.config.colour = tooltip.colour
    end
    return ret
end

local copy_card_hook = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
    local card = copy_card_hook(other, new_card, card_scale, playing_card, strip_edition)
    if card and SMODS.has_enhancement(card, "m_mul_waldo") then
        if not Multiverse.all_animations["explosion"].is_active then
            Multiverse.start_animation("explosion")
            play_sound("mul_deltarune_explosion", 1, 0.8)
        end
        card:set_ability("c_base", nil, true)
    end
    return card
end

local mousepressed_hook = love.mousepressed
function love.mousepressed(x, y, button, istouch, presses)
    mousepressed_hook(x, y, button, istouch, presses)
    if Multiverse.in_limbo == "end" and not Multiverse.has_guessed then
        local clicked = Multiverse.detect_key_click(x, y)
        if clicked then
            Multiverse.has_guessed = true
            Multiverse.in_limbo = nil
            Multiverse.limbo_safe = clicked.is_correct
            if not clicked.is_correct then
                G.GAME.blind.chips = G.GAME.blind.chips * 10
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                Multiverse.start_animation("explosion")
                play_sound("mul_deltarune_explosion", 1, 0.8)
            end
        end
    end
end

local options_hook = G.FUNCS.options
function G.FUNCS.options()
    if Multiverse.in_limbo then return end
    options_hook()
end

local info_hook = G.FUNCS.run_info
function G.FUNCS.run_info()
    if Multiverse.in_limbo then return end
    info_hook()
end

local deck_info_hook = G.FUNCS.deck_info
function G.FUNCS.deck_info()
    if Multiverse.in_limbo then return end
    deck_info_hook()
end