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

local is_suit_hook = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if self.config.center.key == "m_mul_calling_card" then
        if flush_calc then
            if SMODS.find_card("j_smeared") then
                return suit == "Hearts" or suit == "Diamonds"
            end
            return suit == "Hearts"
        else
            if self.debuff and not bypass_debuff then return end
            if SMODS.find_card("j_smeared") then
                return suit == "Hearts" or suit == "Diamonds"
            end
            return suit == "Hearts"
        end
    end
    return is_suit_hook(self, suit, bypass_debuff, flush_calc)
end

local get_id_hook = Card.get_id
function Card:get_id()
    if self.config.center.key == "m_mul_calling_card" and not self.vampired then
        return 14
    end
    return get_id_hook(self)
end

local draw_hook = love.draw
function love.draw()
    local ret = draw_hook()
    local width, height = love.graphics.getDimensions()
    local x_factor = width / 1536
    local y_factor = height / 864
    Multiverse.handle_other_drawing(x_factor, y_factor)
    Multiverse.handle_limbo_drawing(x_factor, y_factor)
    Multiverse.handle_undyne_drawing(x_factor, y_factor)
    return ret
end

local update_hook = Game.update
function Game:update(dt)
    local ret = update_hook(self, dt)
    Multiverse.update_animations()
    Multiverse.update_spears()
    Multiverse.update_transmutable_sticker_anim_state()
    return ret
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
    if card and SMODS.has_enhancement(card, "m_mul_waldo") and not G.VIEWING_DECK then
        if not Multiverse.all_animations["explosion"].is_active then
            Multiverse.start_animation("explosion")
            play_sound("mul_deltarune_explosion", 1, 0.7)
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

local keypressed_hook = love.keypressed
function love.keypressed(key, scancode, is_repeat)
    keypressed_hook(key, scancode, is_repeat)
    if Multiverse.in_undyne then
        if key == "left" or key == "right" or key == "up" or key == "down" then
            Multiverse.shield_dir = key
        end
    end
end

local options_hook = G.FUNCS.options
function G.FUNCS.options()
    if Multiverse.in_limbo or Multiverse.in_undyne then return end
    options_hook()
end

local info_hook = G.FUNCS.run_info
function G.FUNCS.run_info()
    if Multiverse.in_limbo or Multiverse.in_undyne then return end
    info_hook()
end

local deck_info_hook = G.FUNCS.deck_info
function G.FUNCS.deck_info()
    if Multiverse.in_limbo or Multiverse.in_undyne then return end
    deck_info_hook()
end

local start_run_hook = Game.start_run
function Game:start_run(args)
    local ret = start_run_hook(self, args)
    if not G.GAME.mul_thaumaturgy_energy then G.GAME.mul_thaumaturgy_energy = 0 end
    if not G.GAME.mul_thaumaturgy_energy_rate then G.GAME.mul_thaumaturgy_energy_rate = 2 end
    if not G.GAME.mul_thaumaturgy_energy_per_joker then G.GAME.mul_thaumaturgy_energy_per_joker = 10 end
    return ret
end