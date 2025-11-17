SMODS.DrawStep({
	key = "active_consumable",
	order = 200,
	func = function(card, layer)
		if card.ability and type(card.ability.extra) == "table" and card.ability.extra.is_active then
		    Multiverse.check_active_particles(card, true)
			card.children.center:draw_shader("booster", nil, card.ARGS.send_to_shader)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})

SMODS.DrawStep({
	key = "transmutable_sticker",
	order = 96,
	func = function(card, layer)
		if card.ability and card.ability.mul_transmutable then
			if not Multiverse.transmutable_sticker then
				Multiverse.transmutable_sticker = Sprite(
					0,
					0,
					G.CARD_W,
					G.CARD_H,
					G.ASSET_ATLAS["mul_transmutable_sticker"],
					{ x = Multiverse.clamp(math.floor(Multiverse.transmutable_sticker_anim_state), 0, 18), y = 0 }
				)
			end
			Multiverse.transmutable_sticker.role.draw_major = card
			Multiverse.transmutable_sticker:draw_shader("dissolve", nil, nil, nil, card.children.center)
			Multiverse.transmutable_sticker:draw_shader(
				"voucher",
				nil,
				G.ARGS.send_to_shader,
				nil,
				card.children.center
			)
		end
	end,
	conditions = { vortex = false, facing = "front" },
})