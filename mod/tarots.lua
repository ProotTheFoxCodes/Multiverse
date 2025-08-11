SMODS.Consumable {
    key = "lobotomized",
    set = "Tarot",
    atlas = "placeholder",
    pos = {x = 0, y = 1},
    config = {max_highlighted = 2, mod_conv = "m_mul_normal"},
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS[card.ability.mod_conv])
        return {vars = {card.ability.max_highlighted}}
    end
}
SMODS.Consumable {
    key = "chair",
    set = "Tarot",
    atlas = "placeholder",
    pos = {x = 0, y = 1},
    config = {max_highlighted = 1, mod_conv = "m_mul_motivated"},
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS[card.ability.mod_conv])
        return {vars = {card.ability.max_highlighted}}
    end
}
SMODS.Consumable {
    key = "apple",
    set = "Tarot",
    atlas = "placeholder",
    pos = {x = 0, y = 1},
    use = function(self, card, area, copier)
        Multiverse.play_video("bad_apple")
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 219 * G.SPEEDFACTOR
        }))
    end,
    can_use = function(self, card)
        return true
    end
}