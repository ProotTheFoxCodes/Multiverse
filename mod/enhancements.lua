SMODS.Enhancement {
    key = "calling_card",
    atlas = "calling_card",
    pos = {x = 0, y = 0},
    config = {extra = {xmult = 2, boss_xmult = 3}},
    overrides_base_rank = true,
    replace_base_card = true,
    any_suit = true,
    weight = 0,
    update = function (self, card, dt)
        card.config.center.pos.x = math.floor(Multiverse.calling_card_anim_state)
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult, card.ability.extra.boss_xmult}}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if G.GAME.blind and G.GAME.blind.boss then
                return {xmult = card.ability.extra.boss_xmult}
            else
                return {xmult = card.ability.extra.xmult}
            end
        end
    end
}
SMODS.Enhancement {
    key = "netherite",
    atlas = "placeholder_modifiers",
    pos = {x = 0, y = 0},
    config = {h_x_mult = 2, h_dollars = 5, bonus = 75, h_chips = 75},
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.bonus, card.ability.h_x_mult, card.ability.h_dollars}}
    end
}