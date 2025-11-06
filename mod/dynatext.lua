SMODS.DynaTextEffect({
    key = "rotate",
    func = function(dynatext, index, letter)
        letter.r = G.TIMERS.REAL / 1.2
    end,
    
})