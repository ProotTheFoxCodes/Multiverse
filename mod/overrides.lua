SMODS.Joker:take_ownership("joker", {
    transmutable_compat = true,
    config = {extra = {mult = 4, tarots_used = {n = 0}, transmute_req = 1}}, -- Original value is 15
    loc_vars = function(self, info, card)
        table.insert(info, {
            set = "Other", key = "mul_joker_hint"
        })
        return {vars = {card.ability.extra.mult, card.ability.extra.tarots_used.n, card.ability.extra.transmute_req}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {mult = card.ability.extra.mult}
        end
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Tarot" then
            if not card.ability.extra.tarots_used[context.consumeable.config.center.key] then
                card.ability.extra.tarots_used[context.consumeable.config.center.key] = true
                card.ability.extra.tarots_used.n = card.ability.extra.tarots_used.n + 1
            end
            if card.ability.extra.tarots_used.n >= card.ability.extra.transmute_req then
                -- note to self: when adding modded stickers, must add mod prefix before sticker key
                print("entered")
                card:add_sticker("mul_transmutable", true) -- another note to self: pass in true as 2nd argument
            end
        end
    end
}, true)