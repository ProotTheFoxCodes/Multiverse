return {
    descriptions = {
        Myth = {
            c_philosophers_stone = {
                name = "Philosopher\'s Stone",
                text = {
                    "{C:mul_transmuted,E:1}Transmutes{} {C:attention}#1#{} selected Joker",
                    "that is currently {C:attention}Transmutable{}"
                }
            }
        },
        Joker = {
            j_mul_bloodbath = {
                name = "Bloodbath",
                text = {
                    "All cards give {X:mult,C:white}X#1#{} Mult when",
                    "scored on {C:attention}last hand{} of round"
                }
            },
            j_mul_cataclysm = {
                name = "Cataclysm",
                text = {
                    "All cards give {C:mult}+#1#{} Mult when",
                    "scored on {C:attention}last hand{} of round"
                }
            },
            j_mul_aftermath = {
                name = "Aftermath",
                text = {
                    "All cards give {C:chips}+#1#{} Chips when",
                    "scored on {C:attention}last hand{} of round"
                }
            },
            j_mul_magic_school_bus = {
                name = "Magic School Bus",
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult per",
                    "{C:attention}face{} card held in hand",
                    "Resets if there are no",
                    "{C:attention}face cards{} held in hand",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            j_mul_v1 = {
                name = "V1",
                text = {
                    "When {C:attention}first hand{} of round is",
                    "played, add a {C:attention}Gold Seal{} to",
                    "a random scoring card",
                    "Cards with a {C:attention}Gold Seal{} give",
                    "{X:mult,C:white}X#1#{} Mult when scored"
                }
            },
            j_mul_villager = {
                name = "Villager",
                text = {
                    "{C:mult}+#1#{} Mult, lose {C:money}$#2#{}",
                    "when hand is played",
                }
            },
            j_mul_antimatter = {
                name = "Antimatter",
                text = {
                    "{C:mult}+#1#{} Mult?"
                }
            },
            j_mul_red_balloon = {
                name = "Red Balloon",
                text = {
                    "Earn {C:money}$#1#{} when a card is scored",
                    "{C:red,E:2}Self-destructs{} at end of round"
                }
            },
            j_joker = {
                name = "Joker",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:inactive}(#2#/20?){}"
                }
            }
        },
        Other = {
            mul_transmutable = {
                name = "Transmutable",
                text = {
                    "Can use {C:attention}Philosopher's Stone{}",
                    "on this card to create",
                    "{C:mul_transmuted,E:1}Transmuted{} Jokers"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_mul_transmuted = "Transmuted",
            k_mul_missed_bus = "Missed the bus!",
            k_mul_antimatter_init = "And so it begins...",
            k_mul_antimatter_grow1 = "More!",
            k_mul_antimatter_grow2 = "Even more!",
            k_mul_antimatter_grow3 = "Is this too much?",
            k_mul_antimatter_grow4 = "What have we done?",
            k_mul_popped = "Popped!"
        },
        labels = {
            myth = "Myth",
            mul_transmutable = "Transmutable",

            k_mul_transmuted = "Transmuted",
        }
    }
}