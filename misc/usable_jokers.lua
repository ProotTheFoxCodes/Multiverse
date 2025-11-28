---@type Multiverse.UsableJoker
Multiverse.UsableJoker = SMODS.Joker:extend({
	can_use_ability = function(self, card)
		return true
	end,
	use_ability = function(self, card) end,
	ability_atlas = "mul_ability_placeholder",
	ability_pos = { x = 0, y = 0 },
	highlight_ui = function(self, card)
		return UIBox({
			definition = Multiverse.joker_use_ui_def(card),
			config = { align = "cl", offset = { x = 0.3, y = 0 }, parent = card, major = card, bond = "Strong" },
		})
	end,
})

---@param card Card
Multiverse.joker_use_ui_def = function(card)
	local obj = card.config.center
	local ability_sprite = Sprite(0, 0, 1.2, 1.2, G.ASSET_ATLAS[obj.ability_atlas], obj.ability_pos)
	ability_sprite:define_draw_steps({ {
		shader = "dissolve",
	} })
	ability_sprite.tilt_var = { mx = 0, my = 0, dx = 0, dy = 0, amt = 0 }
	ability_sprite.states.collide.can = true
	function ability_sprite:hover()
		self:juice_up(0.1, 0.1)
		Node.hover(self)
	end
	function ability_sprite:stop_hover()
		Node.stop_hover(self)
	end
	function ability_sprite:click()
		Node.click(self)
		local locked = (G.play and #G.play.cards > 0)
			or G.CONTROLLER.locked
			or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)
				and not (G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT)
		if obj:can_use_ability(card) and not locked then
			card:highlight(false)
			G.E_MANAGER:add_event(Event({
				func = function()
					obj:use_ability(card)
					return true
				end,
			}))
		end
	end
	local col = G.C.UI.BACKGROUND_INACTIVE
	local locked = (G.play and #G.play.cards > 0)
		or G.CONTROLLER.locked
		or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)
			and not (G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT)
	if obj:can_use_ability(card) and not locked then
		col = G.C.GREEN
	end
	return {
		n = G.UIT.ROOT,
		config = { colour = G.C.CLEAR, align = "cm" },
		nodes = {
			{
				n = G.UIT.C,
				config = {
					r = 0.08,
					align = "cl",
					padding = 0.1,
					hover = true,
					shadow = true,
					colour = col,
					minw = 1.63,
					func = "mul_check_usable",
					ref_table = card,
				},
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("k_mul_activate"),
									scale = 0.3,
									colour = G.C.UI.TEXT_LIGHT,
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("k_mul_ability"),
									scale = 0.3,
									colour = G.C.UI.TEXT_LIGHT,
								},
							},
						},
					},
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = ability_sprite,
									align = "cm",
								},
							},
						},
					},
				},
			},
		},
	}
end

function G.FUNCS.mul_check_usable(e)
	local card = e.config.ref_table
	local obj = card.config.center
	local locked = (G.play and #G.play.cards > 0)
		or G.CONTROLLER.locked
		or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)
			and not (G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT)
	if obj:can_use_ability(card) and not locked then
		e.config.colour = G.C.GREEN
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
	end
end

local highlight_hook = Card.highlight
function Card:highlight(is_highlighted)
	highlight_hook(self, is_highlighted)
	local obj = self.config.center
	if self.children.mul_joker_use_button then
		self.children.mul_joker_use_button:remove()
		self.children.mul_joker_use_button = nil
	end
	if
		self.area == G.jokers
		and is_highlighted
		and obj.highlight_ui
		and type(obj.highlight_ui) == "function"
		and self.ability.set == "Joker"
	then
		---@type UIBox
		self.children.mul_joker_use_button = obj:highlight_ui(self)
	end
end
