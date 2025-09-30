SMODS.Joker {
    key = "bloodbath",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { xmult = 1.9 } },
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
SMODS.Joker {
    key = "antimatter",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { mult = 1, dim1 = 1, dim2 = 1, rounds_held = 0 } },
    rarity = 3,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
        if context.end_of_round and context.main_eval and not context.blueprint and not context.game_over then
            card.ability.extra.rounds_held = card.ability.extra.rounds_held + 1
            local msg
            if card.ability.extra.rounds_held == 1 then
                msg = localize("k_mul_antimatter_init")
            elseif card.ability.extra.rounds_held <= 3 then
                msg = localize("k_mul_antimatter_grow1")
            elseif card.ability.extra.rounds_held <= 6 then
                card.ability.extra.dim2 = 2
                msg = localize("k_mul_antimatter_grow2")
            elseif card.ability.extra.rounds_held <= 10 then
                card.ability.extra.dim2 = card.ability.extra.dim2 + 1
                msg = localize("k_mul_antimatter_grow3")
            else
                card.ability.extra.dim2 = card.ability.extra.dim2 + card.ability.extra.rounds_held - 9
                msg = localize("k_mul_antimatter_grow4")
            end
            card.ability.extra.dim1 = card.ability.extra.dim1 + card.ability.extra.dim2
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "dim1",
            })
            return { message = msg }
        end
    end
}
SMODS.Joker {
    key = "stand_user",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { ante_change = 1, in_boss = false } },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { -card.ability.extra.ante_change } }
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind then
            card.ability.extra.in_boss = G.GAME.blind.boss
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.in_boss = context.blind.boss
        end
        if context.end_of_round and context.game_over and context.main_eval and card.ability.extra.in_boss and not context.blueprint then
            ease_ante(-card.ability.extra.ante_change)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.ante_change
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.destroy_cards(card)
                    return true
                end
            }))
            return {
                message = localize("k_saved_ex"),
                saved = "mul_stand_user",
                colour = G.C.RED
            }
        end
    end
}