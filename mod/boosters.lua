SMODS.Booster({
	key = "enchantment_table_normal",
	atlas = "enchantment_table",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 1, y = 0 },
	config = {
		extra = 3,
		choose = 1,
	},
	weight = 1.5,
	draw_hand = false,
	group_key = "enchantment_table",
	kind = "enchantment",
	cost = 10,
	create_card = function(self, card, i)
		local c = SMODS.create_card({ key = "c_mul_enchanted_book", area = G.pack_cards, skip_materialize = true })
		c.ability.extra.enchant_list = Multiverse.poll_deck_enchantments({
			source = "ench_book",
			key_append = "ench_book",
		})
		return c
	end,
})
