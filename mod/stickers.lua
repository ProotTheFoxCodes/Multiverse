SMODS.Sticker({
	key = "transmutable",
	atlas = "transmutable_sticker",
	pos = { x = 0, y = 0 },
	badge_colour = Multiverse.TRANSMUTED_GRADIENT,
	rate = 0,
	default_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.mul_thaumaturgy_energy_per_joker or 10 } }
	end,
	sets = { Joker = true },
	draw = function(self, card, layer)
		local sprite = Sprite(
			0,
			0,
			G.CARD_W,
			G.CARD_H,
			G.ASSET_ATLAS["mul_transmutable_sticker"],
			{ x = Multiverse.clamp(math.floor(Multiverse.transmutable_sticker_anim_state), 0, 18), y = 0 }
		)
		sprite.role.draw_major = card
		sprite:draw_shader("dissolve", nil, nil, nil, card.children.center)
		sprite:draw_shader("voucher", nil, G.ARGS.send_to_shader, nil, card.children.center)
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.blueprint and not context.game_over and context.main_eval then
			Multiverse.ease_thaumaturgy_energy(G.GAME.mul_thaumaturgy_energy_per_joker, { from_charge = true })
			return {
				message = localize({
					type = "variable",
					key = "a_mul_thaumaturgy_energy",
					vars = { G.GAME.mul_thaumaturgy_energy_per_joker },
				}),
				colour = Multiverse.TRANSMUTED_GRADIENT,
			}
		end
	end,
})

function Multiverse.update_transmutable_sticker_anim_state()
	Multiverse.transmutable_sticker_anim_state = Multiverse.transmutable_sticker_anim_state + (G.real_dt * 18 / 0.9)
	if Multiverse.transmutable_sticker_anim_state >= 18 then
		Multiverse.transmutable_sticker_anim_state = Multiverse.transmutable_sticker_anim_state - 18
	end
end

SMODS.Sticker({
	key = "traitorous",
	atlas = "temp_sticker",
	pos = { x = 0, y = 0 },
	badge_colour = HEX("BF244C"),
	default_compat = true,
	needs_enabled_flag = true,
	sets = { Joker = true },
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			if G.jokers.cards[1] then
				SMODS.destroy_cards(G.jokers.cards[1], true)
			end
		end
	end,
})
