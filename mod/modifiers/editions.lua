SMODS.Shader({
	key = "hyperdimensional",
	path = "hyperdimensional.fs",
})

SMODS.Edition({
	key = "hyperdimensional",
	shader = "hyperdimensional",
	config = {
		card_limit = 1,
		extra = {
			thaum_energy = 8,
			tp = 6,
		},
	},
	extra_cost = 6,
	weight = 3,
	in_shop = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.edition.card_limit, card.edition.extra.tp, card.edition.extra.thaum_energy } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.blueprint and not context.game_over and context.main_eval then
			SMODS.calculate_effect({
				message = localize({
					type = "variable",
					key = "a_mul_TP",
					vars = { card.edition.extra.tp },
				}),
				colour = G.C.IMPORTANT,
			}, card)
			Multiverse.ease_TP(card.edition.extra.tp)
			SMODS.calculate_effect({
				message = localize({
					type = "variable",
					key = "a_mul_thaumaturgy_energy",
					vars = { card.edition.extra.thaum_energy },
				}),
				colour = Multiverse.TRANSMUTED_GRADIENT,
			}, card)
			Multiverse.ease_thaumaturgy_energy(card.edition.extra.thaum_energy, { from_charge = true })
		end
	end,
})
