SMODS.ConsumableType {
    key = "Myth",
    primary_colour = HEX("C5CC41"),
    secondary_colour = HEX("89C41B"),
    collection_rows = {3,4},
    shop_rate = 1.5,
    default = "c_mul_holy_grail"
}
SMODS.Consumable {
    key = "philosophers_stone",
    set = "Myth",
    atlas = "p_stone",
    anim_info = {anim_time = .9, frames = 18, anim_progress = 0},
    update = function(self, card, dt)
        Multiverse.update_anim(card, G.real_dt)
    end,
    pos = {x = 0, y = 0},
    config = {max_highlighted = 1},
    discovered = true,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.mul_transmutable)
        return {vars = {card.ability.max_highlighted}}
    end,
    in_pool = function(self, args)
        for _, c in ipairs(G.jokers.cards) do
            if c.ability.mul_transmutable then
                return true
            end
        end
        return false
    end,
    can_use = function(self, card)
        return (
            G.jokers and
            G.jokers.highlighted and
            G.jokers.highlighted[1] and
            G.jokers.highlighted[1].ability.mul_transmutable and
            #G.jokers.cards <= G.jokers.config.card_limit - ((G.jokers.highlighted[1].edition and G.jokers.highlighted[1].edition.negative) and 1 or 0))
    end,
    use = function(self, card, area, copier)
        local joker_to_transmute = G.jokers.highlighted[1]
        local transmute_key = joker_to_transmute.config.center.key
        SMODS.destroy_cards(joker_to_transmute, true)
        local new_card = SMODS.add_card({
            set = "Joker",
            key = Multiverse.transmutations[transmute_key].key,
            no_edition = true,
            key_append = "mul_philosophers_stone"
        })
    end
}
SMODS.Consumable {
    key = "holy_grail",
    set = "Myth",
    atlas = "holy_grail",
    anim_info = {anim_time = .9, frames = 18, anim_progress = 0},
    update = function(self, card, dt)
        Multiverse.update_anim(card, G.real_dt)
    end,
    pos = {x = 0, y = 0},
    config = {max_highlighted = 1, extra = {num_consumables = 3}},
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.num_consumables}}
    end,
    can_use = function(self, card)
        return (
            G.jokers and
            G.jokers.highlighted and
            G.jokers.highlighted[1] and
            G.jokers.highlighted[1].ability and
            G.jokers.highlighted[1].ability.extra and -- butt ton of checks to make sure nothing is nil
            G.jokers.highlighted[1].ability.extra.transmute_req)
            -- in order to register a joker as transmutable,
            -- the joker must have transmute_req as a field in ability.extra
    end,
    use = function(self, card, area, copier)
        local j_key = G.jokers.highlighted[1].config.center.key
        if j_key == "j_joker" then
            for i = 1, card.ability.extra.num_consumables do
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        SMODS.add_card({
                            set = "Tarot",
                            key = "c_emperor",
                            edition = "e_negative",
                            key_append = "mul_holy_grail"
                        })
                        return true
                    end
                }))
            end
        elseif j_key == "j_mul_villager" then
            for i = 1, card.ability.extra.num_consumables do
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        local card_pool = {"c_tower", "c_chariot", "c_devil"}
                        SMODS.add_card({
                            set = "Tarot",
                            key = Multiverse.get_random_item(card_pool, "mul_holy_grail"),
                            edition = "e_negative",
                            key_append = "mul_holy_grail"
                        })
                        return true
                    end
                }))
            end
        end
    end
}