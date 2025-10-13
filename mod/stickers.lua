SMODS.Sticker {
    key = "transmutable",
    atlas = "temp_sticker",
    pos = { x = 0, y = 0 },
    badge_colour = Multiverse.TRANSMUTED_GRADIENT,
    rate = 0,
    default_compat = false,
    loc_vars = function(self, info_queue, card)
        return {vars = {G.GAME.mul_thaumaturgy_energy_per_joker or 10}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.game_over and context.main_eval then
            Multiverse.ease_thaumaturgy_energy(G.GAME.mul_thaumaturgy_energy_per_joker, {from_charge = true})
            return {
                message = localize({type = "variable", key = "a_mul_thaumaturgy_energy", vars = {G.GAME.mul_thaumaturgy_energy_per_joker or 10}}),
                colour = Multiverse.TRANSMUTED_GRADIENT
            }
        end
    end
}
