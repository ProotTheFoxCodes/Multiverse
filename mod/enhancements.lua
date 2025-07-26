SMODS.Enhancement {
    key = "calling_card",
    atlas = "placeholder_modifiers",
    pos = {x = 0, y = 0},
    config = {extra = {xmult = 2, boss_xmult = 3}},
    loc_vars = function(self, info, card)
        return {vars = {card.ability.extra.xmult, card.ability.extra.boss_xmult}}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and (context.cardarea == G.play or context.cardarea == G.hand) then
            if G.GAME.blind and G.GAME.blind.boss then
                return {xmult = card.ability.extra.boss_xmult}
            else
                return {xmult = card.ability.extra.xmult}
            end
        end
    end
}