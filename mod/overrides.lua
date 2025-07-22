SMODS.Joker:take_ownership("joker", {
    transmutable_compat = true,
    config = {extra = {mult = 4, tarots_used = {n = 0}}},
    loc_vars = function(self, info, card)
        return {vars = {card.ability.extra.mult, card.ability.extra.tarots_used.n}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {mult = card.ability.extra.mult}
        end
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Tarot" then
            if not card.ability.extra.tarots_used[context.consumeable.ability.name] then
                card.ability.extra.tarots_used[context.consumeable.ability.name] = true
                card.ability.extra.tarots_used.n = card.ability.extra.tarots_used.n + 1
            end
            if card.ability.extra.tarots_used.n >= 20 then
                -- note to self: when adding modded stickers, must add mod prefix before sticker key
                card.ability.mul_transmutable = true
            end
        end
    end
}, true)