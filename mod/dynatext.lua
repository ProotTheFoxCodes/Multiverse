SMODS.DynaTextEffect {
    key = "unstable",
    func = function (dynatext, index, letter)
        local speed_adjust = 1.5 + math.cos(index + G.TIMERS.REAL)
        local opp_speed_adjust = 3 - speed_adjust
        letter.scale = 1 + 0.1 * math.sin(0.21 * speed_adjust * G.TIMERS.REAL + index)
        letter.offset.x = 3 * math.cos(0.19 * opp_speed_adjust * G.TIMERS.REAL - index)
        letter.offset.y = 3 * math.sin(0.2 * speed_adjust * G.TIMERS.REAL - index)
        letter.r = 0.09 * math.sin(opp_speed_adjust * 0.18 * G.TIMERS.REAL - index)
    end
}