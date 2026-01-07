SMODS.Shader({
	key = "enchantment",
	path = "enchantment.fs",
})

---@type table<string, Multiverse.DeckEnchantment>
Multiverse.DeckEnchantments = {}
---@type boolean
Multiverse.generate_dummy_enchant = false

---@type Multiverse.DeckEnchantment
Multiverse.DeckEnchantment = SMODS.GameObject:extend({
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
		"enchantment_type",
	},
	calculate = function(self, enchantment, context) end,
	add_to_deck = function(self) end,
	remove_from_deck = function(self) end,
	in_pool = function(self)
		return true
	end,
	on_change_level = function(self) end,
	get_level = function(self)
		return (
			not Multiverse.generate_dummy_enchant
			and G.GAME.mul_deck_enchantments
			and G.GAME.mul_deck_enchantments[self.key]
			and G.GAME.mul_deck_enchantments[self.key].level
		) or 0
	end,
	calc_dollar_bonus = function(self, enchantment) end,
	legendary = false,
	get_weight = function(self)
		return self.base_weight
	end,
	base_weight = 4,
	create_fake_card = function(self)
		return {
			ability = (
				not Multiverse.generate_dummy_enchant
				and G.GAME.mul_deck_enchantments
				and G.GAME.mul_deck_enchantments[self.key]
				and G.GAME.mul_deck_enchantments[self.key].ability
			) or copy_table(self.config),
			fake_card = true,
			level = self:get_level(),
		}
	end,
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if not card then
			card = self:create_fake_card()
		end
		local target = {
			type = "descriptions",
			key = self.key,
			set = self.set,
			nodes = desc_nodes,
			AUT = full_UI_table,
			vars = specific_vars or {},
		}
		local res = {}
		if self.loc_vars and type(self.loc_vars) == "function" then
			res = self:loc_vars(info_queue, card) or {}
			target.vars = res.vars or target.vars
			target.key = res.key or target.key
			target.set = res.set or target.set
			target.scale = res.scale
			target.text_colour = res.text_colour
		end
		if desc_nodes == full_UI_table.main and not full_UI_table.name then
			full_UI_table.name = self.set == "Enhanced" and "temp_value"
				or localize({
					type = "name",
					set = target.set,
					key = res.name_key or target.key,
					nodes = full_UI_table.name,
					vars = res.name_vars or target.vars or {},
				})
		elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name and self.set ~= "Enhanced" then
			desc_nodes.name = localize({ type = "name_text", key = res.name_key or target.key, set = target.set })
		end
		desc_nodes.name = Multiverse.parse_vars(desc_nodes.name, target.vars)
		if specific_vars and specific_vars.debuffed and not res.replace_debuff then
			target = {
				type = "other",
				key = "debuffed_" .. (specific_vars.playing_card and "playing_card" or "default"),
				nodes = desc_nodes,
				AUT = full_UI_table,
			}
		end
		if res.main_start then
			desc_nodes[#desc_nodes + 1] = res.main_start
		end
		localize(target)
		if res.main_end then
			desc_nodes[#desc_nodes + 1] = res.main_end
		end
		desc_nodes.background_colour = res.background_colour
	end,
	inject = function(self, i) end,
})

---@param obj Multiverse.DeckEnchantment
---@param colours table
---@param active_colour table
---@param inactive_colour? table
function Multiverse.handle_deck_enchantment_loc_colours(obj, colours, active_colour, inactive_colour)
	for i = 1, obj.max_level do
		if obj:get_level() == i or obj:get_level() == 0 then
			colours[#colours + 1] = active_colour
		else
			colours[#colours + 1] = inactive_colour or G.C.UI.TEXT_INACTIVE
		end
	end
end

function Multiverse.init_deck_enchantments()
	---@type table<string, EnchantmentData?>
	G.GAME.mul_deck_enchantments = G.GAME.mul_deck_enchantments or {}
	---@type integer
	G.GAME.mul_enchantment_luck = G.GAME.mul_enchantment_luck or 0
end

---Checks if an enchantment is compatible with current selected deck.
---@param enchantment string
---@return boolean
function Multiverse.is_deck_compat(enchantment)
	for _, key in ipairs(Multiverse.DeckEnchantments[enchantment].deck_incompat) do
		if G.GAME.selected_back.effect.center.key == key then
			return false
		end
	end
	return true
end

---Checks if an enchantment is compatible with any other enchantments on current deck.
---Will also check for compat with other enchantments being simultaneously applied.
---@param enchantment string
---@param other string[]
---@return boolean
function Multiverse.is_enchant_compat(enchantment, other)
	for _, key in ipairs(Multiverse.DeckEnchantments[enchantment].enchant_incompat) do
		if
			(G.GAME.mul_deck_enchantments[key] and G.GAME.mul_deck_enchantments[key].level > 0)
			or Multiverse.contains_value(other, enchantment)
		then
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
			local data = G.GAME.mul_deck_enchantments[key]
			if data and data.level > 0 then
				results[#results + 1] =
					Multiverse.DeckEnchantments[key]:calculate(G.GAME.mul_deck_enchantments[key], context)
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
	G.GAME.mul_deck_enchantments[enchantment] =
		{ level = final_level, key = enchantment, ability = copy_table(obj.config) }
	SMODS.calculate_context({
		mul_modify_deck_enchantments = true,
		amount = delta,
		mul_enchantment_removed = removed,
		mul_enchantment_applied = added,
	})
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

function Multiverse.parse_vars(str, vars)
	return string.gsub(str, "(#%d+#)", function(matched)
		return tostring(vars[tonumber(string.gsub(matched, "[#%s]", ""), 10)])
	end)
end

function Multiverse.number_to_roman(num)
	if num >= 4000 then
		sendWarnMessage("Attempt to convert " .. num .. " >= 4000 into Roman numeral")
		return "ERROR"
	end
	if num == 1000 then
		return "M"
	elseif num == 500 then
		return "D"
	elseif num == 100 then
		return "C"
	elseif num == 50 then
		return "L"
	elseif num == 10 then
		return "X"
	elseif num == 5 then
		return "V"
	elseif num <= 0 then
		return ""
	end
	if num > 1000 then
		return "M" .. Multiverse.number_to_roman(num - 1000)
	elseif num % 500 >= 400 then
		return "C" .. Multiverse.number_to_roman(num + 100)
	elseif num > 500 then
		return "D" .. Multiverse.number_to_roman(num - 500)
	elseif num > 100 then
		return "C" .. Multiverse.number_to_roman(num - 100)
	elseif num % 50 >= 40 then
		return "X" .. Multiverse.number_to_roman(num + 10)
	elseif num > 50 then
		return "L" .. Multiverse.number_to_roman(num - 50)
	elseif num > 10 then
		return "X" .. Multiverse.number_to_roman(num - 10)
	elseif num % 5 >= 4 then
		return "I" .. Multiverse.number_to_roman(num + 1)
	elseif num > 5 then
		return "V" .. Multiverse.number_to_roman(num - 5)
	else
		return "I" .. Multiverse.number_to_roman(num - 1)
	end
end

function Multiverse.deck_enchantment_info_UI_def()
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.UI.OUTLINE_LIGHT, r = 0.1, align = "cm", padding = 0.05 },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					colour = G.C.RED,
					r = 0.1,
					padding = 0.05,
					align = "cm",
					minw = 0.55,
					minh = 0.55,
					emboss = 0.05,
				},
				nodes = {
					{
						n = G.UIT.O,
						config = {
							object = DynaText({
								string = "i",
								colours = { G.C.UI.TEXT_LIGHT },
								scale = 0.4,
							}),
							align = "cm",
						},
					},
				},
			},
		},
	}
end

function Multiverse.update_deck_enchantments()
	if Multiverse.count_deck_enchantments() > 0 and G.deck and not G.mul_deck_enchantment_info then
		G.mul_deck_enchantment_info = UIBox({
			definition = Multiverse.deck_enchantment_info_UI_def(),
			config = { align = "bri", offset = { x = 1.05, y = 0 }, major = G.deck },
		})
		G.mul_deck_enchantment_info.states.collide.can = true
		if G.HUD_tags and G.HUD_tags[1] then
			G.HUD_tags[1].config.offset.y = -0.9
		end
	elseif Multiverse.count_deck_enchantments() == 0 and G.mul_deck_enchantment_info then
		G.mul_deck_enchantment_info:remove()
		G.mul_deck_enchantment_info = nil
		if G.HUD_tags and G.HUD_tags[1] then
			G.HUD_tags[1].config.offset.y = 0
		end
	end
	if
		G.mul_deck_enchantment_info
		and G.mul_deck_enchantment_info.states.collide.is
		and G.deck
		and not G.mul_deck_enchantment_tooltip
	then
		local fake_card = {
			ability_UIBox_table = generate_card_ui(Multiverse.DummyCenters["du_mul_all_enchants"]),
			config = {
				center = Multiverse.DummyCenters["du_mul_all_enchants"],
			},
			T = G.deck.T,
		}
		G.mul_deck_enchantment_tooltip = UIBox({
			definition = G.UIDEF.card_h_popup(fake_card),
			config = {
				align = "tm",
				offset = { x = #G.deck.cards * 0.004, y = -0.1 - #G.deck.cards * 0.004 },
				major = G.deck,
				instance_type = "POPUP",
			},
		})
		function G.mul_deck_enchantment_tooltip:update(dt)
			self:set_alignment({
				offset = { x = #G.deck.cards * 0.004, y = -0.1 - #G.deck.cards * 0.004 },
			})
			self:recalculate()
			UIBox.update(self, dt)
		end
		G.mul_deck_enchantment_tooltip.states.collide.can = false
		G.mul_deck_enchantment_tooltip:recalculate()
	elseif
		(not G.mul_deck_enchantment_info or not G.mul_deck_enchantment_info.states.collide.is)
		and G.mul_deck_enchantment_tooltip
	then
		G.mul_deck_enchantment_tooltip:remove()
		G.mul_deck_enchantment_tooltip = nil
	end
end

local add_tag_hook = add_tag
function add_tag(_tag)
	add_tag_hook(_tag)
	if Multiverse.count_deck_enchantments() > 0 then
		if G.HUD_tags and G.HUD_tags[1] then
			G.HUD_tags[1].config.offset.y = -0.9
		end
	end
end

---If this returns an empty table, then the enchantment with the given key should not spawn.
---@param key string
---@param other string[]
---@param source string
---@return integer[]
function Multiverse.get_valid_enchantment_level_ups(key, other, source)
	local obj = Multiverse.DeckEnchantments[key]
	if not obj then
		error("Tried to get data of nonexistent enchantment")
	end
	local levels = {}
	if
		not Multiverse.is_enchant_compat(key, other)
		or not Multiverse.is_deck_compat(key)
		or obj:get_weight() == 0
		or not obj:in_pool({ source = source })
	then
		return levels
	end
	local curr_level = obj:get_level()
	for i = 1, obj.max_level do
		if curr_level + i <= obj.max_level and obj:in_pool({ level_amt = i, source = source }) then
			levels[#levels + 1] = i
		end
	end
	return levels
end

---Generates a set of enchantments that would be generated for an enchantment book.
---Set `singular` to true to force this to generate exactly 1 enchantment with a random level increment.
---Set `no_legendary` to true to prevent any legendary enchantments from showing up.
---`key_append` functions similarly to other usages of key_append.
function Multiverse.poll_deck_enchantments(args)
	local temp = args or {}
	local singular = temp.singular
	local key_append = temp.key_append or "default"
	local no_legendary = temp.no_legendary
	local source = temp.source
	local ret = {}
	local polled = {}
	local luck_factor = Multiverse.clamp((G.GAME.mul_enchantment_luck or 0) / 100, 0, 1)
	local amt = singular and 1
		or Multiverse.weighted_pseudorandom("mul_ench_amt_" .. key_append, luck_factor, 0.3 + luck_factor / 5, 1, 3)
	if not singular and pseudorandom("mul_lucky_4_" .. G.GAME.round_resets.ante, 1, 1000) <= 3 then
		amt = 4
	end
	for i = 1, amt do
		local base_pool = {}
		local legendary_pool = {}
		local curse_pool = {}
		for _, key in ipairs(Multiverse.DeckEnchantment.obj_buffer) do
			local obj = Multiverse.DeckEnchantments[key]
			-- essentially acts as the in_pool check
			local valid_levels = Multiverse.get_valid_enchantment_level_ups(key, polled, source)
			if #valid_levels > 0 then
				local entry = {
					enchant_key = key,
					enchant_obj = obj,
					level_pool = valid_levels,
				}
				if obj.legendary then
					legendary_pool[#legendary_pool + 1] = entry
				elseif obj.enchantment_type ~= "negative" then
					base_pool[#base_pool + 1] = entry
				else
					curse_pool[#curse_pool + 1] = entry
				end
			end
		end
		local ench, index = Multiverse.weighted_poll(base_pool, function(item)
			return item.enchant_obj:get_weight()
		end, "mul_select_enchant_" .. key_append)
		if ench and index > 0 then
			local l_ench, l_index
			local generate_legendary = not no_legendary
				and pseudorandom("mul_legendary_ench_" .. G.GAME.round_resets.ante, 1, 1000) <= 3
			if generate_legendary then
				l_ench, l_index = Multiverse.weighted_poll(legendary_pool, function(item)
					return item.enchant_obj:get_weight()
				end, "mul_select_legendary_enchant_" .. key_append)
			end
			if l_ench and l_index and l_index ~= -1 then
				local level_index = Multiverse.weighted_pseudorandom(
					"mul_generate_level_" .. key_append,
					luck_factor,
					0.3 + luck_factor / 5,
					1,
					#l_ench.level_pool
				)
				ret[#ret + 1] = {
					key = l_ench.enchant_key,
					level_amt = l_ench.level_pool[level_index],
				}
				polled[#polled + 1] = l_ench.enchant_key
			else
				local level_index = Multiverse.weighted_pseudorandom(
					"mul_generate_level_" .. key_append,
					luck_factor,
					0.3 + luck_factor / 5,
					1,
					#ench.level_pool
				)
				ret[#ret + 1] = {
					key = ench.enchant_key,
					level_amt = ench.level_pool[level_index],
				}
				polled[#polled + 1] = ench.enchant_key
			end
		else
			ret[#ret + 1] = {
				key = "de_mul_overflow",
				level_amt = pseudorandom("mul_overflow_level", 1, 3),
			}
		end
		if i == amt then
			local has_curse = not singular
				and G.GAME.modifiers.mul_enable_curses
				and pseudorandom("mul_generate_curse_" .. key_append)
					> 0.9 + (G.GAME.mul_enchantment_luck or 0) * 0.09
			if has_curse then
				local curse, c_index = Multiverse.weighted_poll(curse_pool, function(item)
					return item.enchant_obj:get_weight()
				end, "mul_select_curse_" .. key_append)
				if curse and c_index then
					local level_index = Multiverse.weighted_pseudorandom(
						"mul_generate_level_" .. key_append,
						1 - luck_factor,
						0.3 + luck_factor / 5,
						1,
						#curse.level_pool
					)
					ret["curse"] = {
						key = curse.enchant_key,
						level_amt = curse.level_pool[level_index],
					}
				end
			end
		end
	end
	return ret
end
