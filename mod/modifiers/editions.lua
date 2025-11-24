SMODS.Shader({
	key = "hyperdimensional",
	path = "hyperdimensional.fs",
})

SMODS.Edition({
	key = "hyperdimensional",
	shader = "hyperdimensional",
	config = {

	},
	extra_cost = 4,
	weight = 4,
	loc_vars = function(self, info_queue, card)
		return {
		}
	end,
	calculate = function(self, card, context) end,
})
