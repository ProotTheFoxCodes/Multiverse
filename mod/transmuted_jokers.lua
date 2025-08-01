SMODS.Rarity {
    key = "transmuted",
    default_weight = 0,
    badge_colour = Multiverse.TRANSMUTED_GRADIENT
}
SMODS.Joker {
    key = "ren_amamiya",
    atlas = "ren_amamiya",
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    rarity = "mul_transmuted",
    blueprint_compat = false,
    cost = 40,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_mul_calling_card)
        ---@type table<string, integer | boolean>
        local unique_tarots = {n = 0}
        if G.consumeables then
            for _, c in ipairs(G.consumeables.cards) do
                if not unique_tarots[c.config.center.key] then
                    unique_tarots[c.config.center.key] = true
                    unique_tarots.n = unique_tarots.n + 1
                end
            end
        end
        return {vars = {unique_tarots.n}}
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before and context.main_eval and context.scoring_hand then
                ---@diagnostic disable-next-line: param-type-mismatch
                context.scoring_hand[1]:set_ability("m_mul_calling_card")
                G.E_MANAGER:add_event(Event({
                    trigger = "ease",
                    ref_table = Multiverse,
                    ref_value = "calling_card_anim_state",
                    ease = "quad",
                    ease_to = 5,
                    delay = 1
                }))
            end
            if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_mul_calling_card") then
                ---@type table<string, integer | boolean>
                local unique_tarots = {n = 0}
                if G.consumeables then
                    for _, c in ipairs(G.consumeables.cards) do
                        if not unique_tarots[c.config.center.key] then
                            unique_tarots[c.config.center.key] = true
                            unique_tarots.n = unique_tarots.n + 1
                        end
                    end
                end
                if unique_tarots.n > 0 then
                    return {repetitions = unique_tarots.n}
                end
            end
            if context.end_of_round and not context.game_over and context.main_eval then
                Multiverse.calling_card_anim_state = 0
            end
        end
    end
}
SMODS.Joker {
    key = "steve",
    atlas = "placeholder",
    pos = {x = 4, y = 0},
    rarity = "mul_transmuted",
    blueprint_compat = false,
    cost = 40,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_mul_netherite)
        return {vars = {localize(card.ability.extra.suit, "suits_singular"), card.ability.extra.size_inc}}
    end,
    config = {extra = {suit = "Diamonds", size_inc = 5}},
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.size_inc)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.size_inc)
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before and context.main_eval and context.full_hand then
                for _, c in ipairs(context.full_hand) do
                    if c:is_suit(card.ability.extra.suit) then
                        c:set_ability("m_mul_netherite")
                    end
                end
            end
        end
    end
}