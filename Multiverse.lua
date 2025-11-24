Multiverse = {}
Multiverse = SMODS.current_mod
Multiverse.TRANSMUTED_GRADIENT = SMODS.Gradient({
	key = "transmuted_gradient",
	colours = {
		HEX("89C41B"),
		HEX("C5CC41"),
	},
	cycle = 1.5,
})
Multiverse.RAINBOW_GRADIENT = SMODS.Gradient({
	key = "rainbow_gradient",
	colours = {
		G.C.RED,
		G.C.ORANGE,
		G.C.YELLOW,
		G.C.GREEN,
		G.C.BLUE,
		G.C.PURPLE,
	},
	cycle = 3,
})
Multiverse.C = {}
Multiverse.C.PRIMARY1 = HEX("89C41B")
Multiverse.C.PRIMARY2 = HEX("C5CC41")
Multiverse.selected_music_page = 1
Multiverse.transmutable_sticker_anim_state = 0
Multiverse.debug = false

---Talisman compatibility?
to_big = to_big or function(x)
	return x
end
to_number = to_number or function(x)
	return x
end

SMODS.ObjectType({
	key = "mul_can_transmute",
	default = "j_joker",
})

SMODS.draw_ignore_keys.mul_draw_use_buttons = true

function Multiverse.check_philosophers_stone()
	if G.GAME.mul_thaumaturgy_energy >= 100 then
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			Multiverse.ease_thaumaturgy_energy(-G.GAME.mul_thaumaturgy_energy, { from_magnum_opus = true })
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card({
						key = "c_mul_philosophers_stone",
						key_append = "mul_thaumaturgy_charge",
					})
					return true
				end,
			}))
		else
			delay(2.2 * G.SPEEDFACTOR)
			attention_text({
				scale = 1.4,
				text = localize("k_no_room_ex"),
				hold = 2 * G.SPEEDFACTOR,
				align = "cm",
				offset = { x = 0, y = -1.7 },
				major = G.play,
			})
			attention_text({
				scale = 0.7,
				text = localize("k_mul_make_room"),
				hold = 2 * G.SPEEDFACTOR,
				align = "cm",
				offset = { x = 0, y = -0.5 },
				major = G.play,
			})
			attention_text({
				scale = 0.7,
				text = localize("k_mul_make_room2"),
				hold = 2 * G.SPEEDFACTOR,
				align = "cm",
				offset = { x = 0, y = 0.3 },
				major = G.play,
			})
		end
	end
end

function Multiverse.handle_debuffs(card)
	if Multiverse.is_kryptonite_debuffed(card) then
			return {
				debuff = true,
			}
		end
		if Multiverse.is_stand_arrow_debuffed(card) then
			return {
				debuff = true,
			}
		end
end

SMODS.current_mod.calculate = function(self, context)
	if context.end_of_round and not context.game_over and context.main_eval then
		Multiverse.hide_blind_instructions()
		Multiverse.hide_TP_meter()
		Multiverse.ease_thaumaturgy_energy(G.GAME.mul_thaumaturgy_energy_rate, { from_charge = true })
		Multiverse.check_philosophers_stone()
	end
	if context.debuff_card then
		return Multiverse.handle_debuffs(context.debuff_card)
	end
	if context.setting_blind then
		Multiverse.show_TP_meter()
	end
end

function Multiverse.is_kryptonite_debuffed(card)
	return card.area == G.jokers and G.GAME.mul_kryptonite_active and card:is_rarity(3)
end

---@param card Card
function Multiverse.is_stand_arrow_debuffed(card)
	return card.playing_card
		and G.GAME.mul_stand_arrow_active
		and card:is_suit(G.GAME.current_round.mul_stand_arrow_suit, true)
end

local function set_foddian_suit()
	G.GAME.current_round.mul_foddian_suit = "Hearts"
	local valid = {}
	for _, c in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(c) then
			table.insert(valid, c)
		end
	end
	local foddian_card = pseudorandom_element(valid, "mul_foddian" .. G.GAME.round_resets.ante)
	if foddian_card then
		G.GAME.current_round.mul_foddian_suit = foddian_card.base.suit
	end
end

local function set_stand_arrow_suit()
	if not G.GAME.current_round.mul_stand_arrow_suit then
		G.GAME.current_round.mul_stand_arrow_suit =
			pseudorandom_element(SMODS.Suit.obj_buffer, "mul_arrow" .. G.GAME.round_resets.ante)
		return
	end
	local valid = Multiverse.filter(SMODS.Suit.obj_buffer, function(item)
		return item ~= G.GAME.current_round.mul_stand_arrow_suit
	end)
	if next(valid) then
		G.GAME.current_round.mul_stand_arrow_suit = pseudorandom_element(valid, "mul_arrow" .. G.GAME.round_resets.ante)
	end
end

function SMODS.current_mod.reset_game_globals()
	set_foddian_suit()
	set_stand_arrow_suit()
end

---@param path string
function Multiverse.recursive_load(path)
	local files = NFS.getDirectoryItems(Multiverse.path .. path)
	for _, item in ipairs(files) do
		if string.sub(item, -4) == ".lua" then
			print("Multiverse: Loading " .. item:gsub("%d+_", ""))
			local f, err = SMODS.load_file(path .. "/" .. item)
			if err then
				error(err)
			elseif f then
				f()
			end
		elseif path:find("%.") == nil then
			Multiverse.recursive_load(path .. "/" .. item)
		end
	end
end

Multiverse.recursive_load("misc")
Multiverse.recursive_load("mod")

Multiverse.debug = false
local debug, err = SMODS.load_file("debug.lua")
if debug then
	debug()
	Multiverse.debug = true
end

Multiverse.debug_info = { ["Debug Mode"] = (Multiverse.debug and "Enabled" or "Disabled") }
