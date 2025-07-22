SMODS.ConsumableType {
    key = "Myth",
    default = "philosophers_stone",
    primary_colour = HEX("89C41B"),
    secondary_colour = HEX("C5CC41"),
    collection_rows = {3,4}
}
SMODS.Consumable {
    key = "philosophers_stone",
    set = "Myth",
    atlas = "philosophers_stone",
    pos = {x = 0, y = 0},
    discovered = true,
    config = {max_highlighted = 1},
    in_pool = function(self, args)
        for i, c in ipairs(G.jokers.cards) do
            if c.ability.mul_transmutable then
                return true, {allow_duplicates = false}
            end
        end
        return false, {allow_duplicates = false}
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.highlighted > 0 and G.jokers.highlighted[1].ability.mul_transmutable
    end
}