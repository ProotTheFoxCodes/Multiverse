SMODS.Rarity {
    key = "transmuted",
    default_weight = 0,
    badge_colour = Multiverse.TRANSMUTED_GRADIENT
}
SMODS.Joker {
    key = "ren_amamiya",
    atlas = "placeholder",
    pos = {x = 4, y = 0},
    rarity = "mul_transmuted",
    blueprint_compat = false,
    cost = 40,
    loc_vars = function(self, info, card)
        Multiverse.append(info, G.P_CENTERS.m_mul_calling_card)
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
                context.scoring_hand[1]:set_ability("m_mul_calling_card")
            end
            if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_mul_calling_card") then
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
        end
    end
}