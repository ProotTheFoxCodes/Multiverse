---Effectively a cleaner take_ownership that makes taking ownership of modded Jokers and making them transmutable more convenient
---Note that I adhere to the standards implied by this function due to consumable behavior.
---Also note that calc must manually handle checking if the Joker is transmutable via Multiverse.transmute_check()
---@param key string Note that the Joker with this key must satisfy `type(modded_joker.ability.extra) == "table"`
---@param tracker_var number | table If this is a table, it must contain a key called `n` that maps to an integer value.
---@param requirement integer The requirement needed for a Joker to receive the sticker.
---@param calc fun(self, card, context): nil A calculation function used to increment transmute_progress. This should not return anything.
function Multiverse.transmutable_override(key, tracker_var, requirement, calc)
	local no_joker_prefix_key = key:sub(3)
	local calculate_hook = SMODS.Jokers[key].calculate
	local loc_vars_hook = SMODS.Jokers[key].loc_vars
	local update_hook = SMODS.Jokers[key].update
	local temp_config = SMODS.Jokers[key].config
	temp_config.extra = temp_config.extra or {}
	temp_config.extra.transmute_req = Multiverse.set_transmute_requirements(requirement)
	temp_config.extra.transmute_progress = tracker_var
	local temp_pools = SMODS.Jokers[key].pools
	temp_pools["mul_can_transmute"] = true
	SMODS.Joker:take_ownership(no_joker_prefix_key, {
		config = temp_config,
		loc_vars = function(self, info_queue, card)
			local ret = nil
			if loc_vars_hook then
				ret = loc_vars_hook(self, info_queue, card)
			end
			local transmute_vars = {}
			if type(card.ability.extra.transmute_progress) == "table" then
				transmute_vars[#transmute_vars + 1] = card.ability.extra.transmute_progress.n
			else
				transmute_vars[#transmute_vars + 1] = card.ability.extra.transmute_progress
			end
			transmute_vars[#transmute_vars + 1] = card.ability.extra.transmute_req
			table.insert(info_queue, {
				set = "Other",
				key = no_joker_prefix_key .. "hint",
				vars = transmute_vars,
			})
			return ret
		end,
		calculate = function(self, card, context)
			if not context.blueprint then
				calc(self, card, context)
			end
			if calculate_hook then
				calculate_hook(self, card, context)
			end
		end,
		pools = temp_pools,
	}, true)
end

--#region Manual vanilla overrides, which are annoying because of non-standardized config tables
SMODS.Joker:take_ownership("joker", {
	config = {
		extra = { mult = 4, transmute_progress = { n = 0 }, transmute_req = Multiverse.set_transmute_requirements(15) },
	},
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, {
			set = "Other",
			key = "mul_joker_hint",
			vars = { card.ability.extra.transmute_progress.n, card.ability.extra.transmute_req },
		})
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { mult = card.ability.extra.mult }
		end
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Tarot" then
			if not card.ability.extra.transmute_progress[context.consumeable.config.center.key] then
				card.ability.extra.transmute_progress[context.consumeable.config.center.key] = true
				card.ability.extra.transmute_progress.n = card.ability.extra.transmute_progress.n + 1
			end
			Multiverse.transmute_check(card)
		end
	end,
	pools = { ["mul_can_transmute"] = true },
}, true)

SMODS.Joker:take_ownership("pareidolia", {
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, {
			set = "Other",
			key = "mul_pareidolia_hint",
			vars = { card.ability.extra.transmute_progress.n, card.ability.extra.transmute_req },
		})
	end,
	config = { extra = { transmute_progress = { n = 0 }, transmute_req = Multiverse.set_transmute_requirements(6) } },
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if not card.ability.extra.transmute_progress[context.scoring_name] then
				card.ability.extra.transmute_progress[context.scoring_name] = true
				card.ability.extra.transmute_progress.n = card.ability.extra.transmute_progress.n + 1
			end
			Multiverse.transmute_check(card)
		end
	end,
	pools = { ["mul_can_transmute"] = true },
}, true)
-- Not really transmutation-related, more so for the funny factor
SMODS.Joker:take_ownership("chicot", {
	add_to_deck = function(self, card, from_debuff)
		Multiverse.play_video("chicot_summoning")
		Multiverse.start_animation("black_bg")
		Multiverse.very_important_thing = true
		G.E_MANAGER:add_event(Event({
			blockable = false,
			trigger = "after",
			delay = 12.7 * G.SPEEDFACTOR,
			func = function()
				Multiverse.very_important_thing = false
				Multiverse.stop_video("chicot_summoning")
				Multiverse.end_animation("black_bg")
				return true
			end,
		}))
		if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
			G.GAME.blind:disable()
			play_sound("timpani")
			SMODS.calculate_effect({ message = localize("ph_boss_disabled") }, card)
		end
	end,
}, true)
--#endregion
