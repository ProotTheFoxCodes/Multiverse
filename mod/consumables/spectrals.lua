SMODS.Consumable({
	key = "eternity",
	set = "Spectral",
	atlas = "placeholder",
	pos = { x = 1, y = 1 },
	config = { max_highlighted = 1 },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, {
			set = "Other",
			key = "eternal",
		})
		local has_incompat = false
		if G.jokers then
			for _, j in ipairs(G.jokers.cards) do
				if not j.config.center.eternal_compat then
					has_incompat = true
					break
				end
			end
		end
		return { key = (has_incompat and "c_mul_eternity_alt") or nil, vars = { card.ability.max_highlighted } }
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.highlighted == 1 and G.jokers and #G.jokers.cards > 0
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local cards_to_destroy = {}
			for _, playing_card in ipairs(G.hand.cards) do
				if not playing_card.highlighted then
					cards_to_destroy[#cards_to_destroy + 1] = playing_card
				end
			end
			for _, j in ipairs(G.jokers.cards) do
				if not j.config.center.eternal_compat then
					cards_to_destroy[#cards_to_destroy + 1] = j
				else
					j:set_eternal(true)
					j:juice_up(0.3, 0.5)
				end
			end
			Multiverse.start_animation("lightning")
			SMODS.destroy_cards(cards_to_destroy)
		end)
	end,
})

SMODS.Consumable({
	key = "backstab", -- may need to be nerfed, dont got time to test ts
	set = "Spectral",
	atlas = "placeholder",
	pos = { x = 1, y = 1 },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, {
			set = "Other",
			key = "mul_traitorous",
		})
	end,
	can_use = function(self, card)
		return G.jokers and #G.jokers.cards >= 1
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local target = pseudorandom_element(G.jokers.cards, "mul_backstab")
			local copied_joker = copy_card(target, nil, nil, nil, true)
			copied_joker:add_sticker("mul_traitorous", true)
			copied_joker:set_edition("e_negative")
			copied_joker:add_to_deck()
			G.jokers:emplace(copied_joker)
		end)
	end,
})

SMODS.Consumable({
	key = "scheme",
	set = "Spectral",
	atlas = "placeholder",
	pos = { x = 0, y = 1 },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, {
			set = "Other",
			key = "rental",
			vars = { G.GAME.rental_rate },
		})
		local total_value = 0
		if G.jokers then
			for _, j in ipairs(G.jokers.cards) do
				total_value = total_value + j.sell_cost
			end
		end
		return { vars = { total_value * 3 } }
	end,
	can_use = function(self, card)
		return G.jokers and #G.jokers.cards > 0
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local total = 0
			for _, j in ipairs(G.jokers.cards) do
				total = total + j.sell_cost
				j:set_rental(true)
				j:juice_up(0.3, 0.5)
			end
			ease_dollars(total * 3, true)
		end)
	end,
})
