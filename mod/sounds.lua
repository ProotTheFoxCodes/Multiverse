SMODS.Sound {
    key = "gerson_laugh",
    path = "gerson_sfx.wav"
}
SMODS.Sound {
    key = "prophecy",
    path = "Creo_Prophecy.wav",
    select_music_track = function(self)
        if G.jokers then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.mul_transmutable then
                    return 5
                end
            end
        end
    end,
    sync = false
}