SMODS.Tag({
	atlas = "transmute_tag",
	key = "magnum_opus",
	pos = { x = 0, y = 0 },
	config = { type = "immediate" },
	in_pool = function(self, args)
		return false
	end,
	loc_vars = function(self, info_queue, tag)
		table.insert(info_queue, G.P_CENTERS.c_mul_philosophers_stone)
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			local card = SMODS.add_card({
				key = "c_mul_philosophers_stone",
				key_append = "mul_magnum_opus",
			})
			card.states.visible = false
			tag:yep("+", Multiverse.TRANSMUTED_GRADIENT, function()
				card:start_materialize()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
})

local apply_tag_ref = Tag.apply_to_run
function Tag:apply_to_run(_context)
	if _context.type == "tag_add" and _context.tag.key == "tag_mul_magnum_opus" then
		return
	end
	local ret = apply_tag_ref(self, _context)
	return ret
end
