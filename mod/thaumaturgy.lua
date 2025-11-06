---Changes the current amount of Thaumaturgy Energy, and also triggers the relevant context.
---@param amt number
---@param args? {immediate: boolean?, silent: boolean?, from_magnum_opus: boolean?, from_charge: boolean?}
function Multiverse.ease_thaumaturgy_energy(amt, args)
	args = args or {}
	if G.GAME.mul_time_machine_active and amt >= 0 then return end
	if G.GAME.mul_unicorn_protections >= 1 and amt < 0 then
		G.GAME.mul_unicorn_protections = G.GAME.mul_unicorn_protections - 1
		return
	end
	SMODS.calculate_context({
		--True if the amount of Thaumaturgy Energy was changed.
		mul_thaumaturgy_energy_altered = true,
		amount = amt,
		--True if the change in Thaumaturgy Energy came from generation of a Magnum Opus tag.
		from_magnum_opus = args.from_magnum_opus,
		--True if the change in Thaumaturgy Energy came from the natural end of round bonus.
		from_charge = args.from_charge,
		--True if this change occured while "Time Machine" is active.
		active_time_machine = G.GAME.mul_time_machine_active
	})
	local function change_thaumaturgy_energy(num)
		num = num or 0
		if num == 0 then
			return
		end
		local thaum_UI = G.hand_text_area.mul_thaumaturgy_energy
		local text = "+"
		local col = Multiverse.TRANSMUTED_GRADIENT
		if num < 0 then
			text = "-"
			col = G.C.RED
		end
		G.GAME.mul_thaumaturgy_energy = G.GAME.mul_thaumaturgy_energy + num
		thaum_UI.config.object:update()
		G.HUD:recalculate()
		attention_text({
			text = text .. tostring(math.abs(num)),
			scale = 1,
			hold = 0.7,
			cover = thaum_UI.parent,
			cover_colour = col,
			align = "cm",
		})
		if not args.silent then
			play_sound("generic1")
		end
	end
	if args.immediate then
		change_thaumaturgy_energy(amt)
	else
		G.E_MANAGER:add_event(Event({
			func = function()
				change_thaumaturgy_energy(amt)
				return true
			end,
		}))
	end
end
