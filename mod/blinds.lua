SMODS.Blind {
    key = "limbo",
    atlas = "multiverse_blinds",
    pos = {x = 0, y = 0},
    boss_colour = HEX("F2994B"),
    boss = {min = 1},
    mult = 2,
    set_blind = function(self)
        Multiverse.add_limbo_keys()
        G.E_MANAGER:add_event(Event({
            func = function()
                Multiverse.limbo_keys_intro()
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 18.8 * (G.SPEEDFACTOR or 1)
        }))
    end,
    disable = function(self)
        if get_blind_amount(G.GAME.round_resets.ante) * 2 < G.GAME.blind.chips then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips / 10)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end,
    loc_vars = function(self)
        return {vars = {10}}
    end,
    collection_loc_vars = function(self)
        return {vars = {10}}
    end,
    in_pool = function(self)
        return Multiverse.config.joke
    end
}