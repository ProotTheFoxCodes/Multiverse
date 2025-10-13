SMODS.current_mod.calculate = function(self, context)
    if context.end_of_round and not context.blueprint and not context.game_over and context.main_eval then
        Multiverse.ease_thaumaturgy_energy(G.GAME.mul_thaumaturgy_energy_rate, {from_charge = true})
        if G.GAME.mul_thaumaturgy_energy >= 100 then
            Multiverse.ease_thaumaturgy_energy(-G.GAME.mul_thaumaturgy_energy, {from_magnum_opus = true})
            add_tag(Tag("tag_mul_magnum_opus", false, "Small"))
        end
    end
end

---Changes the current amount of Thaumaturgy Energy, and also triggers the relevant context.
---@param amt number
---@param args {immediate: boolean?, silent: boolean?, from_magnum_opus: boolean?, from_charge: boolean?}
function Multiverse.ease_thaumaturgy_energy(amt, args)
    args = args or {}
    local function change_thaumaturgy_energy(num)
        num = num or 0
        if num == 0 then return end
        local thaum_UI = G.hand_text_area.mul_thaumaturgy_energy
        local text = '+'
        local col = Multiverse.TRANSMUTED_GRADIENT
        if num < 0 then
            text = '-'
        end
        G.GAME.mul_thaumaturgy_energy = G.GAME.mul_thaumaturgy_energy + num
        thaum_UI.config.object:update()
        G.HUD:recalculate()
        attention_text({
            text = text..tostring(math.abs(num)),
            scale = 1,
            hold = 0.7,
            cover = thaum_UI.parent,
            cover_colour = col,
            align = 'cm',
        })
        if not args.silent then
            play_sound('generic1')
        end
    end
    if args.immediate then
        change_thaumaturgy_energy(amt)
    else
        G.E_MANAGER:add_event(Event({
            trigger = "immediate",
            func = function()
                change_thaumaturgy_energy(amt)
                return true
            end
        }))
    end
    SMODS.calculate_context({
        mul_thaumaturgy_charge_altered = true,
        amount = amt,
        from_magnum_opus = args.from_magnum_opus,
        from_charge = args.from_charge
    })
end

