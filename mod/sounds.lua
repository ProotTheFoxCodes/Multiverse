SMODS.Sound {
    key = "gerson_laugh",
    path = "gerson_sfx.ogg"
}
SMODS.Sound {
    key = "prophecy_music",
    path = "Creo_Prophecy.wav",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Prophecy"] then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.mul_transmutable then
                    return 2
                end
            end
        end
    end,
    sync = false,
    volume = 0.85,
    pitch = 1
}
SMODS.Sound {
    key = "pigstep_music",
    path = "LenaRaine_Pigstep.wav",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Pigstep"] then
            if next(SMODS.find_card("j_mul_steve")) then
                return 3
            end
        end
    end,
    sync = false,
    volume = 0.85,
    pitch = 1
}
SMODS.Sound {
    key = "lifewillchange_music",
    path = "P5_LifeWillChange.wav",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Life Will Change"] then
            if next(SMODS.find_card("j_mul_ren_amamiya")) then
                return 3
            end
        end
    end,
    sync = false,
    volume = 0.85,
    pitch = 1
}
SMODS.Sound {
    key = "hammerofjustice_music",
    path = "TobyFox_HammerOfJustice.wav",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Hammer of Justice"] then
            if next(SMODS.find_card("j_mul_gerson")) then
                return 3
            end
        end
    end,
    sync = false,
    volume = 0.85,
    pitch = 1,
}
SMODS.Sound {
    key = "presage_music",
    path = "MIRAR_Presage.wav",
    select_music_track = function(self)
        if G.GAME and G.GAME.round_resets.ante > 8 then
            if G.GAME.round_resets.ante % 8 == 0 then
                return 4
            end
            return 1
        end
    end
}
SMODS.Sound {
    key = "deltarune_explosion",
    path = "deltarune_explosion.ogg"
}