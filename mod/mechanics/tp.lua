function Multiverse.show_TP_meter()
	G.mul_TP_meter = UIBox({
		definition = Multiverse.create_TP_ui(),
		config = { align = "tri", offset = { x = 5.3, y = -0.55 }, major = G.ROOM_ATTACH },
	})
	ease_value(G.mul_TP_meter.config.offset, "x", -4, nil, nil, true, 0.6, "quad")
	G.mul_TP_meter:recalculate()
end

function Multiverse.hide_TP_meter()
	if G.mul_TP_meter then
		ease_value(G.mul_TP_meter.config.offset, "x", 4, nil, nil, true, 0.6, "quad")
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 1,
			blocking = false,
			blockable = false,
			func = function()
				G.mul_TP_meter:remove()
				G.mul_TP_meter = nil
				return true
			end,
		}))
	end
end

---Changes the current amount of TP, and also triggers the relevant context.
---This function will automatically adjust the amount of TP earned/lost if doing the modification would cause TP to be negative or more than 100.
---This function will also not do anything if called outside of a blind.
function Multiverse.ease_TP(amt, args)
	if not G.GAME.blind.blind_set then
		return
	end
	local actual_change = Multiverse.clamp(amt, -G.GAME.mul_TP, 100 - G.GAME.mul_TP)
	args = args or {}
	SMODS.calculate_context({
		--True if the amount of TP was changed.
		mul_TP_altered = true,
		amount = actual_change,
		--True if the change in TP came from a played hand.
		from_hand = args.from_scored_hand,
	})
	local TP_UI = G.mul_TP_meter:get_UIE_by_ID("TP_display")
	if args.instant then
		G.GAME.mul_TP = G.GAME.mul_TP + actual_change
		TP_UI.config.object:update()
		G.HUD:recalculate()
	else
		G.E_MANAGER:add_event(Event({
			trigger = "ease",
			ref_table = G.GAME,
			ref_value = "mul_TP",
			ease_to = G.GAME.mul_TP + actual_change,
			delay = 1.5,
			ease = "quad",
			func = function(n)
				TP_UI.config.object:update()
				G.HUD:recalculate()
				return math.floor(n)
			end,
		}))
	end
end

function Multiverse.create_TP_ui()
	local col = {}
	for i = 1, 20 do
		col[#col + 1] = {
			n = G.UIT.R,
			config = {
				align = "cm",
				minw = 0.85,
			},
			nodes = {
				{
					n = G.UIT.B,
					config = {
						colour = G.C.DYN_UI.BOSS_DARK,
						w = 0.5,
						h = 0.1,
						r = 0.2,
					},
				},
			},
		}
	end
	local display = {
		n = G.UIT.R,
		config = { padding = 0.05, align = "cr" },
		nodes = {
			{
				n = G.UIT.C,
				config = { colour = G.C.DYN_UI.BOSS_DARK, r = 0.1, padding = 0.05, align = "cm", minw = 0.85 },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = { localize("k_mul_TP") },
										colours = { G.C.UI.TEXT_LIGHT },
										scale = 0.35,
									}),
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = { colour = G.C.DYN_UI.BOSS_MAIN, padding = 0.05, align = "cm", minw = 0.7, r = 0.05 },
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = { { ref_table = G.GAME, ref_value = "mul_TP" } },
										colours = { G.C.IMPORTANT },
										scale = 0.35,
									}),
									id = "TP_display",
								},
							},
						},
					},
				},
			},
		},
	}
	return {
		n = G.UIT.ROOT,
		config = { align = "cm", colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					r = 0.1,
					colour = lighten(G.C.JOKER_GREY, 0.5),
					padding = 0.05,
					detailed_tooltip = { set = "Other", key = "mul_TP_desc" },
					detailed_tooltip_align = "cl",
					detailed_tooltip_offset = { x = -0.1, y = 0 },
				},
				nodes = {
					{
						n = G.UIT.C,
						config = {
							align = "cm",
							r = 0.1,
							colour = G.C.DYN_UI.BOSS_MAIN,
							emboss = 0.05,
							padding = 0.01,
						},
						nodes = {
							display,
							{
								n = G.UIT.R,
								config = { align = "cr", padding = 0.01 },
								nodes = {
									{
										n = G.UIT.C,
										config = { align = "r", func = "mul_update_TP_bar", padding = 0.05 },
										nodes = col,
									},
								},
							},
						},
					},
				}
			}
		},
	}
end

function G.FUNCS.mul_update_TP_bar(e)
	if e.children then
		for i, node in ipairs(e.children) do
			local is_floating = (#e.children - i) < math.ceil(G.GAME.mul_TP / 100 * #e.children)
			node.children[1].config.colour = is_floating and Multiverse.RAINBOW_GRADIENT or G.C.DYN_UI.BOSS_DARK
		end
	end
end
