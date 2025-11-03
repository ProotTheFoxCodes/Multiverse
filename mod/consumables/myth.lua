SMODS.ConsumableType({
	key = "mul_Myth",
	primary_colour = HEX("C5CC41"),
	secondary_colour = HEX("89C41B"),
	collection_rows = { 3, 4 },
	shop_rate = 2,
	default = "c_mul_holy_grail",
})
---@type table<string, {key: string, other: table<string, table | function>}>
Multiverse.transmutations = {
	["j_joker"] = {
		key = "j_mul_ren_amamiya",
		other = {
			grail = function()
				for i = 1, 3 do
					G.E_MANAGER:add_event(Event({
						func = function()
							SMODS.add_card({
								key = "c_emperor",
								edition = "e_negative",
								key_append = "mul_holy_grail",
							})
							return true
						end,
					}))
				end
			end,
			tree_of_eden = { "j_cartomancer", "j_hallucination", "j_vagabond" },
		},
	},
	["j_mul_villager"] = {
		key = "j_mul_steve",
		other = {
			grail = function()
				for i = 1, 3 do
					G.E_MANAGER:add_event(Event({
						func = function()
							local card_pool = { "c_tower", "c_chariot", "c_devil" }
							SMODS.add_card({
								key = pseudorandom_element(card_pool, "mul_holy_grail"),
								edition = "e_negative",
								key_append = "mul_holy_grail",
							})
							return true
						end,
					}))
				end
			end,
			tree_of_eden = { "j_midas_mask", "j_marble" },
		},
	},
	["j_mul_hammer_bro"] = {
		key = "j_mul_gerson",
		other = {
			grail = function()
				for i = 1, 3 do
					G.E_MANAGER:add_event(Event({
						func = function()
							local card_pool = { "c_deja_vu", "c_mul_chair" }
							SMODS.add_card({
								key = pseudorandom_element(card_pool, "mul_holy_grail"),
								edition = "e_negative",
								key_append = "mul_holy_grail",
							})
							return true
						end,
					}))
				end
			end,
			tree_of_eden = { "j_hanging_chad", "j_hack", "j_sock_and_buskin" },
		},
	},
	["j_pareidolia"] = {
		key = "j_mul_waldo",
		other = {
			grail = function()
				for i = 1, 3 do
					G.E_MANAGER:add_event(Event({
						func = function()
							local card_pool = { "c_lovers", "c_strength", "c_death", "c_hanged_man" }
							SMODS.add_card({
								key = pseudorandom_element(card_pool, "mul_holy_grail"),
								edition = "e_negative",
								key_append = "mul_holy_grail",
							})
							return true
						end,
					}))
				end
			end,
			voodoo_doll = { "j_mul_jack_frost", "j_smeared", "j_shortcut" },
		},
	},
}
SMODS.Consumable({
	key = "philosophers_stone",
	set = "mul_Myth",
	atlas = "p_stone",
	anim_info = { anim_time = 0.9, frames = 18, anim_progress = 0 },
	update = function(self, card, dt)
		Multiverse.update_card_anim(card, G.real_dt)
	end,
	pos = { x = 0, y = 0 },
	config = { extra = { energy_per_joker = 15 } },
	discovered = true,
	cost = 6,
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, {
			set = "Other",
			key = "mul_transmutable",
			vars = { G.GAME.mul_thaumaturgy_energy_per_joker or 10 },
		})
		local count = 0
		if G.jokers then
			for _, j in ipairs(G.jokers.cards) do
				if j.config.center.rarity == "mul_transmuted" then
					count = count + 1
				end
			end
		end
		return { vars = { card.ability.extra.energy_per_joker, count * card.ability.extra.energy_per_joker } }
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
		return #G.jokers.highlighted == 1 and G.jokers.highlighted[1].ability.mul_transmutable
	end,
	use = function(self, card, area, copier)
		local joker_to_transmute = G.jokers.highlighted[1]
		G.jokers:unhighlight_all()
		local transmute_key = Multiverse.transmutations[joker_to_transmute.config.center.key].key
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("tarot1")
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				joker_to_transmute:flip()
				play_sound("card1", 1.15)
				joker_to_transmute:juice_up(0.3, 0.5)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 1.65,
			func = function()
				joker_to_transmute:mul_safe_dissolve(nil, false, 1.6)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 1.5,
			func = function()
				joker_to_transmute:remove_sticker("mul_transmutable")
				joker_to_transmute:set_ability(transmute_key)
				play_sound("tarot2", 0.85, 0.6)
				joker_to_transmute:start_materialize(nil, false, 1.6)
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 1.85,
			func = function()
				joker_to_transmute:flip()
				play_sound("card1", 1.15)
				joker_to_transmute:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.5)
	end,
})
SMODS.Consumable({
	key = "holy_grail",
	set = "mul_Myth",
	atlas = "holy_grail",
	anim_info = { anim_time = 0.9, frames = 18, anim_progress = 0 },
	update = function(self, card, dt)
		Multiverse.update_card_anim(card, G.real_dt)
	end,
	pos = { x = 0, y = 0 },
	config = { extra = { num_consumables = 3 } },
	discovered = true,
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.num_consumables } }
	end,
	can_use = function(self, card)
		return #G.jokers.highlighted == 1
			and (Multiverse.transmutations[G.jokers.highlighted[1].config.center.key] ~= nil)
		-- in order for this card to be usable,
		-- the joker's key must be in Multiverse.transmutations
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local j_key = G.jokers.highlighted[1].config.center.key
			if Multiverse.transmutations[j_key].other.grail then
				Multiverse.transmutations[j_key].other.grail()
			end
		end)
	end,
})
SMODS.Consumable({
	key = "perpetual_motion",
	set = "mul_Myth",
	atlas = "temp_myth",
	pos = { x = 0, y = 0 },
	discovered = true,
	config = { extra = { max_thaum_energy = 50 } },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_thaum_energy } }
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			Multiverse.ease_thaumaturgy_energy(
				Multiverse.clamp(G.GAME.mul_thaumaturgy_energy, 0, card.ability.extra.max_thaum_energy)
			)
		end)
	end,
})
SMODS.Consumable({
	key = "tree_of_eden",
	set = "mul_Myth",
	atlas = "temp_myth",
	pos = { x = 0, y = 0 },
	discovered = true,
	cost = 6,
	can_use = function(self, card)
		return (
			G.jokers
			and #G.jokers.highlighted == 1
			and #G.jokers.cards < G.jokers.config.card_limit
			and Multiverse.transmutations[G.jokers.highlighted[1].config.center.key] ~= nil
		)
		-- in order for this card to be usable,
		-- the joker's key must be in Multiverse.transmutations
		-- and you must have space for a Joker
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local j_key = G.jokers.highlighted[1].config.center.key
			if Multiverse.transmutations[j_key].other.tree_of_eden then
				SMODS.add_card({
					key = pseudorandom_element(Multiverse.transmutations[j_key].other.tree_of_eden, "mul_tree_of_eden"),
				})
			end
		end)
	end,
})

SMODS.Consumable({
	key = "sphere",
	set = "mul_Myth",
	atlas = "temp_myth",
	pos = { x = 0, y = 0 },
	discovered = true,
	cost = 6,
	config = { extra = { energy_loss = 5 } },
	loc_vars = function(self, info_queue, card)
		local count = 0
		if G.hand then
			count = #G.hand.cards
		end
		return { vars = { card.ability.extra.energy_loss, count * card.ability.extra.energy_loss } }
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.cards > 0 and G.GAME.mul_thaumaturgy_energy > 0
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local count = #G.hand.cards
			SMODS.destroy_cards(G.hand.cards)
			Multiverse.ease_thaumaturgy_energy(-count * card.ability.extra.energy_loss)
		end)
	end,
})

SMODS.Consumable({
	key = "one_ring",
	set = "mul_Myth",
	atlas = "temp_myth",
	pos = { x = 0, y = 0 },
	discovered = true,
	cost = 6,
	can_use = function(self, card)
		return G.jokers and G.jokers.config.card_limit > #G.jokers.cards
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			SMODS.add_card({ rarity = "Rare", set = "Joker", key_append = "mul_one_ring" })
			Multiverse.ease_thaumaturgy_energy(-G.GAME.mul_thaumaturgy_energy)
		end)
	end,
})

SMODS.Consumable({
	key = "chaos_emeralds",
	set = "mul_Myth",
	atlas = "temp_myth",
	pos = { x = 0, y = 0 },
	discovered = true,
	cost = 6,
	can_use = function(self, card)
		return G.jokers
			and #G.jokers.highlighted == 1
			and type(G.jokers.highlighted[1].ability.extra) == "table"
			and G.jokers.highlighted[1].ability.extra.transmute_req >= 4
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local target = G.jokers.highlighted[1]
			if type(target.ability.extra.transmute_progress) == "table" then
				target.ability.extra.transmute_progress.n = target.ability.extra.transmute_progress.n
					+ math.floor(target.ability.extra.transmute_req / 4)
			else
				target.ability.extra.transmute_progress = target.ability.extra.transmute_progress
					+ math.floor(target.ability.extra.transmute_req / 4)
			end
			target:juice_up(0.3, 0.5)
		end)
	end,
})

SMODS.Consumable({
	key = "rosetta_stone",
	set = "mul_Myth",
	atlas = "temp_myth",
	pos = { x = 0, y = 0 },
	discovered = true,
	cost = 6,
	config = { extra = { energy_per_joker = 10 } },
	can_use = function(self, card)
		return G.jokers and #G.jokers.cards >= 1
	end,
	loc_vars = function(self, info_queue, card)
		local count = 0
		if G.jokers then
			count = #G.jokers.cards
		end
		return { vars = { card.ability.extra.energy_per_joker, count * card.ability.extra.energy_per_joker } }
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			for _, j in ipairs(G.jokers.cards) do
				j:flip()
			end
			Multiverse.ease_thaumaturgy_energy(card.ability.extra.energy_per_joker * #G.jokers.cards)
		end)
	end,
})

SMODS.Consumable({
	key = "shadow_crystal",
	set = "mul_Myth",
	atlas = "temp_myth",
	pos = { x = 0, y = 0 },
	discovered = true,
	cost = 6,
	can_use = function(self, card)
		return G.jokers
			and #G.jokers.highlighted == 1
			and G.jokers.highlighted[1].config.center.perishable_compat
			and type(G.jokers.highlighted[1].ability.extra) == "table"
			and G.jokers.highlighted[1].ability.extra.transmute_req
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local target = G.jokers.highlighted[1]
			if type(target.ability.extra.transmute_progress) == "table" then
				target.ability.extra.transmute_progress.n = target.ability.extra.transmute_req - 1
			else
				target.ability.extra.transmute_progress = target.ability.extra.transmute_req - 1
			end
			target:set_perishable(true)
			target:juice_up(0.3, 0.5)
		end)
	end,
})

SMODS.Consumable({
	key = "one_piece",
	set = "mul_Myth",
	atlas = "temp_myth",
	pos = { x = 0, y = 0 },
	discovered = true,
	cost = 6,
	config = { extra = { max_thaum_energy = 100 } },
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		local total = 0
		if G.jokers then
			for _, j in ipairs(G.jokers.cards) do
				total = total + j.sell_cost
			end
		end
		return { vars = { total } }
	end,
	use = function(self, card, area, copier)
		Multiverse.consumable_effect(card, function()
			local total = 0
			if G.jokers then
				for _, j in ipairs(G.jokers.cards) do
					total = total + j.sell_cost
				end
			end
			Multiverse.ease_thaumaturgy_energy(
				math.min(math.floor(to_number(total)), card.ability.extra.max_thaum_energy)
			)
		end)
	end,
})
