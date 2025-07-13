SMODS.Joker {
    key = "bloodbath",
    atlas = "placeholder",
    pos = {x = 2, y = 0},
    config = {extra = {xmult = 1.9}},
    rarity = 3,
    blueprint_compat = true,
    cost = 7,
    loc_vars = function(self, info, card)
        return {vars = {card.ability.extra.xmult}}
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