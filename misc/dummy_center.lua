Multiverse.DummyCenter = SMODS.Center:extend({
    set = "mul_Dummy",
    obj_buffer = {},
    in_pool = function(self, args)
        return false
    end,
    no_collection = true,
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table) end
})