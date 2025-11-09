SMODS.DrawStep({
    key = "active_consumable",
    order = 200,
    func = function(card, layer)
        if card.ability and type(card.ability.extra) == "table" and card.ability.extra.is_active then
            card.children.center:draw_shader("booster", nil, card.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = "front" }
})