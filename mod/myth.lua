SMODS.ConsumableType {
    key = "Myth",
    primary_colour = HEX("C5CC41"),
    secondary_colour = HEX("89C41B"),
    collection_rows = {3,4}
}
SMODS.Consumable {
    key = "philosophers_stone",
    set = "Myth",
    atlas = "p_stone",
    anim_info = {anim_time = .8, num_frames = 18, anim_progress = 0},
    update = function(self, card, dt)
        Multiverse.update_anim(card, G.real_dt)
    end,
    pos = {x = 0, y = 0},
    config = {max_highlighted = 1},
    discovered = true,
    loc_vars = function(self, info, card)
        return {vars = {card.ability.max_highlighted}}
    end,
    in_pool = function(self, args)
        for _, c in ipairs(G.jokers.cards) do
            if c.ability.mul_transmutable then
                return true, {allow_duplicates = false}
            end
        end
        return false, {allow_duplicates = false}
    end,
    can_use = function(self, card)
        return (
            G.jokers and
            #G.jokers.highlighted == 1 and
            G.jokers.highlighted[1] and
            G.jokers.highlighted[1].ability.mul_transmutable and
            #G.jokers.cards <= G.jokers.config.card_limit - (G.jokers.highlighted[1].edition.negative and 1 or 0)
        ) --  Jokers owned           Joker slots            Is the joker negative? If so we need 1 free joker slot
    end,
    use = function(self, card, area, copier)
        local joker_to_transmute = G.jokers.highlighted[1]
        joker_to_transmute.ability.eternal = false
        SMODS.destroy_cards(joker_to_transmute)
        SMODS.add_card({
            set = "Joker",
            key = Multiverse.transmutations[joker_to_transmute.config.center.key]
        })
    end
}