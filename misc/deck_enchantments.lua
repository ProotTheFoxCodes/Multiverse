---@type table<string, Multiverse.DeckEnchantment>
Multiverse.DeckEnchantments = {}

Multiverse.DeckEnchantment = SMODS.Center:extend({
	set = "mul_DeckEnchantment",
	max_level = 1,
	obj_buffer = {},
	obj_table = Multiverse.DeckEnchantments,
	unlocked = true,
	discovered = false,
	config = {},
	class_prefix = "de",
	back_incompat = {},
	required_params = {
		"key",
	},
	calculate = function(self, context, level) end,
	add_to_deck = function(self) end,
	remove_from_deck = function(self) end,
	in_pool = function(self)
		return not Multiverse.is_deck_incompat(self)
	end,
	on_change_level = function(self) end,
	get_level = function(self)
        return G.GAME.mul_deck_enchantments[self.key] or 0
    end,
})

function Multiverse.init_deck_enchantments()
	---@type table<string, number?>
	G.GAME.mul_deck_enchantments = G.GAME.mul_deck_enchantments or {}
end

---Checks if an enchantment is incompatible with current selected deck.
---@param enchantment string
---@return boolean
function Multiverse.is_deck_incompat(enchantment)
	for _, key in ipairs(Multiverse.DeckEnchantments[enchantment].back_incompat) do
		if G.GAME.selected_back.effect.center.key == key then
			return true
		end
	end
	return false
end

---Calculates all applied deck enchantments.
---@param context CalcContext
---@param results table
function Multiverse.calculate_deck_enchantments(context, results)
	for key, level in pairs(G.GAME.mul_deck_enchantments) do
		if level and level > 0 then
			results[#results + 1] = Multiverse.DeckEnchantments[key]:calculate(context, level)
		end
	end
end

function Multiverse.level_up_deck_enchantment(enchantment, amt)
	local obj = Multiverse.DeckEnchantments[enchantment]
	if not obj then
		error("Attempt to level up nonexistent deck enchantment")
	end
	local init_level = obj:get_level()
	local final_level = Multiverse.clamp(init_level + amt, 0, obj.max_level)
	local delta = final_level - init_level
	if delta == 0 then
		return
	end
	local msg = ""
	if init_level == 0 then
		msg = localize("k_mul_enchanted")
		obj:add_to_deck()
	elseif final_level == 0 then
		msg = localize("k_mul_disenchanted")
		obj:remove_from_deck()
	elseif delta > 0 then
		msg = localize("k_mul_level_up")
        obj:on_change_level(delta)
	elseif delta < 0 then
		msg = localize("k_mul_level_down")
        obj:on_change_level(delta)
	end
    SMODS.calculate_context({mul_modify_deck_enchantments = true})
	G.GAME.mul_deck_enchantments[enchantment] = final_level
    return msg
end
