SMODS.Shader({
	key = "enchantment",
	path = "enchantment.fs",
})

local draw_cardarea_hook = CardArea.draw
function CardArea:draw()
	draw_cardarea_hook(self)
	if self == G.deck then
		if self.states.collide.is or (G.buttons and G.buttons.states.collide.is and G.CONTROLLER.HID.controller) then
			if not self.children.hover_tooltip then
				local fake_card = {
					ability_UIBox_table = generate_card_ui(Multiverse.DummyCenters["du_mul_all_enchants"]),
					config = {
						center = Multiverse.DummyCenters["du_mul_all_enchants"]
					},
					T = (self.cards[1] or self).T
				}
				self.children.hover_tooltip = UIBox({
					definition = G.UIDEF.card_h_popup(fake_card),
					config = { align = "tm", offset = { x = 0, y = -0.1 }, parent = self.cards[1] or self },
				})
			end
			self.children.hover_tooltip.states.collide.can = false
		elseif self.children.hover_tooltip then
			self.children.hover_tooltip:remove()
			self.children.hover_tooltip = nil
		end
	end
	if
		Multiverse.count_deck_enchantments() > 0
		and self.children.hover_tooltip
		and (self.states.collide.is or (G.buttons and G.buttons.states.collide.is and G.CONTROLLER.HID.controller))
	then
		self.children.hover_tooltip:draw()
	end
end

---@type table<string, Multiverse.DeckEnchantment>
Multiverse.DeckEnchantments = {}

---@type Multiverse.DeckEnchantment
Multiverse.DeckEnchantment = SMODS.Center:extend({
	set = "mul_DeckEnchantment",
	max_level = 1,
	obj_buffer = {},
	obj_table = Multiverse.DeckEnchantments,
	unlocked = true,
	discovered = false,
	config = {},
	class_prefix = "de",
	deck_incompat = {},
	enchant_incompat = {},
	required_params = {
		"key",
		"enchantment_type"
	},
	calculate = function(self, enchantment, context) end,
	add_to_deck = function(self) end,
	remove_from_deck = function(self) end,
	in_pool = function(self)
		return true
	end,
	on_change_level = function(self) end,
	get_level = function(self)
		return G.GAME.mul_deck_enchantments and ((G.GAME.mul_deck_enchantments[self.key] or {}).level or 0) or 0
	end,
})

---@param obj Multiverse.DeckEnchantment
---@param colours table
---@param active_colour table
function Multiverse.handle_deck_enchantment_loc_colours(obj, colours, active_colour)
	for i = 1, obj.max_level do
		if obj:get_level() == i or obj:get_level() == 0 then
			colours[#colours + 1] = active_colour
		else
			colours[#colours + 1] = G.C.UI.TEXT_INACTIVE
		end
	end
end

function Multiverse.init_deck_enchantments()
	---@type table<string, EnchantmentData?>
	G.GAME.mul_deck_enchantments = G.GAME.mul_deck_enchantments or {}
end

---Checks if an enchantment is compatible with current selected deck.
---@param enchantment string
---@return boolean
function Multiverse.is_deck_compat(enchantment)
	for _, key in ipairs(Multiverse.DeckEnchantments[enchantment].back_incompat) do
		if G.GAME.selected_back.effect.center.key == key then
			return false
		end
	end
	return true
end

---Checks if an enchantment is compatible with any other enchantments on current deck.
---@param enchantment string
---@return boolean
function Multiverse.is_enchant_compat(enchantment)
	for _, key in ipairs(Multiverse.DeckEnchantments[enchantment].enchant_incompat) do
		if G.GAME.mul_deck_enchantments[key] and G.GAME.mul_deck_enchantments[key].level > 0 then
			return false
		end
	end
	return true
end

---Calculates all applied deck enchantments.
---@param context CalcContext
---@param results table
function Multiverse.calculate_deck_enchantments(context, results)
	if G.GAME.mul_deck_enchantments then
		for _, key in ipairs(Multiverse.DeckEnchantment.obj_buffer) do
			local level = G.GAME.mul_deck_enchantments[key] and G.GAME.mul_deck_enchantments[key].level or 0
			if level > 0 then
				results[#results + 1] = Multiverse.DeckEnchantments[key]:calculate(context, level)
			end
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
	local removed = false
	local added = false
	if init_level == 0 then
		msg = localize("k_mul_enchanted")
		obj:add_to_deck()
		added = true
	elseif final_level == 0 then
		msg = localize("k_mul_disenchanted")
		obj:remove_from_deck()
		removed = true
	elseif delta > 0 then
		msg = localize("k_mul_level_up")
	elseif delta < 0 then
		msg = localize("k_mul_level_down")
	end
	obj:on_change_level(delta, final_level)
	SMODS.calculate_context({
		mul_modify_deck_enchantments = true,
		amount = delta,
		mul_enchantment_removed = removed,
		mul_enchantment_applied = added,
	})
	G.GAME.mul_deck_enchantments[enchantment] =
		{ level = final_level, key = enchantment, config = copy_table(obj.config) }
	return msg
end

function Multiverse.count_deck_enchantments()
	local count = 0
	if G.GAME.mul_deck_enchantments then
		for _, key in ipairs(Multiverse.DeckEnchantment.obj_buffer) do
			local level = G.GAME.mul_deck_enchantments[key] and G.GAME.mul_deck_enchantments[key].level or 0
			if level > 0 then
				count = count + 1
			end
		end
	end
	return count
end

function Multiverse.count_deck_enchantment_levels()
	local count = 0
	if G.GAME.mul_deck_enchantments then
		for _, key in ipairs(Multiverse.DeckEnchantment.obj_buffer) do
			local level = G.GAME.mul_deck_enchantments[key] and G.GAME.mul_deck_enchantments[key].level or 0
			if level > 0 then
				count = count + level
			end
		end
	end
	return count
end
