SMODS.Joker {
    key = "cataclysm",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { mult = 19 } },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}
SMODS.Joker {
    key = "magic_school_bus",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { mult = 0, mult_gain = 1 } },
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_gain,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and context.main_eval then
            local has_face_card = false
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_card:is_face() then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.scale_card(card, {
                                ref_table = card.ability.extra,
                                ref_value = "mult",
                                scalar_value = "mult_gain",
                            })
                            SMODS.calculate_effect({
                                message = localize("k_upgrade_ex"),
                            }, card)
                            return true
                        end
                    }))
                    has_face_card = true
                end
            end
            if not has_face_card then
                card.ability.extra.mult = 0
                return {
                    message = localize("k_mul_missed_bus")
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = "v2",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { seal = "Gold" } },
    rarity = 2,
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_SEALS[card.ability.extra.seal])
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            for _, c in ipairs(context.scoring_hand) do
                if c:is_suit("Hearts") then
                    c:set_seal(card.ability.extra.seal)
                    break
                end
            end
        end
    end
}
SMODS.Joker {
    key = "summoned_skull",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { xmult = 2.5 } },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card == card and G.jokers and not context.blueprint then
            local pool = {}
            for _, c in ipairs(G.jokers.cards) do
                if c ~= card then
                    pool[#pool + 1] = c
                end
            end
            local joker_to_destroy = pseudorandom_element(pool, "mul_summoned_skull")
            SMODS.destroy_cards(joker_to_destroy)
        end
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end
}
SMODS.Joker {
    key = "fifty_fifty",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { xmult = 3, mult = 3, odds = 2 } },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mul_fifty_fifty")
        return { vars = { num, denom, card.ability.extra.xmult, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, "mul_fifty_fifty", 1, card.ability.extra.odds) then
                return {
                    xmult = card.ability.extra.xmult,
                    message = localize("k_mul_won_fifty_fifty")
                }
            else
                return {
                    mult = card.ability.extra.mult,
                    message = localize("k_mul_lost_fifty_fifty")
                }
            end
        end
    end
}
SMODS.Joker {
    key = "victory_royale",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { odds = 100, decrement = 2 } },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mul_victory_royale")
        return { vars = { num, denom, card.ability.extra.decrement } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, "mul_victory_royale", 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = (G.GAME.consumeable_buffer or 0) + 1
                card.ability.extra.odds = 100
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({
                            set = "Spectral",
                            edition = "e_negative",
                            key_append = "mul_victory_royale",
                            skip_materialize = true
                        })
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_spectral"),
                    colour = G.C.SECONDARY_SET.Spectral,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            elseif card.ability.extra.odds > 2 and not context.blueprint then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "odds",
                    scalar_value = "decrement",
                    operation = "-",
                })
            end
        end
    end
}
SMODS.Joker {
    key = "hammer_bro",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { mult = 5, xmult = 1.25, transmute_progress = 0, transmute_req = Multiverse.set_transmute_requirements(120) } },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    transmutable_compat = true,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, {
            set = "Other",
            key = "mul_hammer_bro_hint",
            vars = {
                card.ability.extra.transmute_progress,
                card.ability.extra.transmute_req
            }
        })
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.blueprint then
                card.ability.extra.transmute_progress = card.ability.extra.transmute_progress + 1
            end
            if pseudorandom("hammer_bro", 1, 2) == 1 then
                return { xmult = card.ability.extra.xmult }
            else
                return { mult = card.ability.extra.mult }
            end
        end
        if context.joker_main and card.ability.extra.transmute_progress >= card.ability.extra.transmute_req then
            card:add_sticker("mul_transmutable", true)
        end
    end,
    pools = {["mul_can_transmute"] = true}
}