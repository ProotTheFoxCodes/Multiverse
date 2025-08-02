return {
    descriptions = {
        Enhanced = {
            m_mul_calling_card = {
                name = "Calling Card",
                text = {
                    "{X:mult,C:white}X#1#{} Mult",
                    "Increases to {X:mult,C:white}X#2#{} Mult",
                    "during a Boss Blind",
                    "Always treated as an {C:attention}Ace{} of {C:hearts}Hearts{}",
                }
            },
            m_mul_netherite = {
                name = "Netherite",
                text = {
                    "{C:chips}+#1#{} Chips when held in",
                    "hand or played",
                    "{X:mult,C:white}X#2#{} Mult when held",
                    "in hand",
                    "Gives {C:money}$#3#{} when held in",
                    "hand at end of round",
                }
            }
        },
        Myth = {
            c_mul_philosophers_stone = {
                name = "Philosopher\'s Stone",
                text = {
                    "{C:mul_transmuted,E:1}Transmutes{} {C:attention}#1#{} selected Joker",
                    "that is currently {C:mul_transmuted}Transmutable{}",
                    "{C:inactive}(Must have room, bypasses Eternal){}"
                }
            },
            c_mul_holy_grail = {
                name = "Holy Grail",
                text = {
                    "Creates {C:attention}#1#{} {C:dark_edition}Negative{} consumables",
                    "relevant to the {C:mul_transmuted}transmutation{}",
                    "of selected Joker"
                }
            }
        },
        Joker = {
            j_mul_bloodbath = {
                name = "Bloodbath",
                text = {
                    {
                        "All cards give {X:mult,C:white}X#1#{} Mult when",
                        "scored on {C:attention}last hand{} of round"
                    },
                    {
                        "{C:inactive,s:0.8}\"I hate the Michigun ufo part\""
                    }
                }
            },
            j_mul_cataclysm = {
                name = "Cataclysm",
                text = {
                    {
                        "All cards give {C:mult}+#1#{} Mult when",
                        "scored on {C:attention}last hand{} of round"
                    },
                    {
                        "{C:inactive,s:0.8}\"That first wave is so stupid\""
                    }
                }
            },
            j_mul_aftermath = {
                name = "Aftermath",
                text = {
                    {
                        "All cards give {C:chips}+#1#{} Chips when",
                        "scored on {C:attention}last hand{} of round"
                    },
                    {
                        "{C:inactive,s:0.8}\"Who even remembers this level?\""
                    }
                }
            },
            j_mul_magic_school_bus = {
                name = "Magic School Bus",
                text = {
                    {
                        "This Joker gains {C:mult}+#1#{} Mult per",
                        "{C:attention}face{} card held in hand",
                        "Resets if there are no",
                        "{C:attention}face cards{} held in hand",
                        "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                    },
                    {
                        "{C:inactive,s:0.8}\"Mrs. Frizzle, where are we going?\"",
                        "{C:inactive,s:0.8}\"We're going gambling!\""
                    }
                }
            },
            j_mul_v1 = {
                name = "V1",
                text = {
                    {
                        "When {C:attention}first hand{} of round is",
                        "played, add a {C:attention}Gold Seal{} to",
                        "a random scoring card",
                        "Cards with a {C:attention}Gold Seal{} give",
                        "{X:mult,C:white}X#1#{} Mult when scored"
                    },
                    {
                        "{C:inactive,s:0.8}\"Ultrakill fans will do anything",
                        "{C:inactive,s:0.8}to screw the murder robot\""
                    }
                }
            },
            j_mul_villager = {
                name = "Villager",
                text = {
                    {
                        "{C:mult}+#1#{} Mult, lose {C:money}$#2#{}",
                        "when hand is played",
                        "{C:inactive}(#3#/#4#?){}"
                    },
                    {
                        "{C:inactive,s:0.8}\"Oh, them? They're the villagers!\""
                    }
                }
            },
            j_mul_antimatter = {
                name = "Antimatter",
                text = {
                    {
                        "{C:mult}+#1#{} Mult?"
                    },
                    {
                        "{C:inactive,s:0.8}\"The ninth dimension is",
                        "{C:inactive,s:0.8}[DATA EXPUNGED], trust me bro\""
                    }
                }
            },
            j_mul_red_balloon = {
                name = "Red Balloon",
                text = {
                    {
                        "Earn {C:money}$#1#{} when a card is scored",
                        "{C:red,E:2}Self-destructs{} in {C:attention}#3#{} rounds",
                        "{C:inactive}(Currently #2#/#3#){}"
                    },
                    {
                        "{C:inactive,s:0.8}\"The hardest balloon to pop,",
                        "{C:inactive,s:0.8}especially if it's camoflauged,",
                        "{C:inactive,s:0.8}regenerating and fortified\""
                    }
                }
            },
            j_mul_ren_amamiya = {
                name = "Ren Amamiya",
                text = {
                    {
                        "The {C:attention}first{} played card that",
                        "scores becomes a {C:attention}Calling Card{}",
                        "Retrigger all played {C:attention}Calling Cards{}",
                        "a number of times equal to the",
                        "number of {C:attention}distinct{} {C:tarot}Tarot{} cards",
                        "in your consumable area",
                        "{C:inactive}(Currently #1# times){}"
                    },
                    {
                        "{C:inactive,s:0.8}\"You never see it coming\""
                    }
                }
            },
            j_joker = {
                name = "Joker",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:inactive}(#2#/#3#?){}"
                }
            },
            j_mul_steve = {
                name = "Steve",
                text = {
                    {
                        "All played cards with {C:diamonds}#1#{}",
                        "suit become {C:attention}Netherite{} cards",
                        "{C:attention}+#2#{} hand size"
                    },
                    {
                        "{C:inactive,s:0.8}\"L-l-l-lava,{}",
                        "{C:inactive,s:0.8}ch-ch-ch-chicken,",
                        "{C:inactive,s:0.8}ooh lava chicken now you're",
                        "{C:inactive,s:0.8}ringing the bell\""
                    }
                }
            },
            j_mul_summoned_skull = {
                name = "Summoned Skull",
                text = {
                    {
                        "{X:mult,C:white}X#1#{} Mult",
                        "Destroys a {C:attention}random{} Joker",
                        "when purchased"
                    },
                    {
                        "{C:inactive,s:0.8}\"Yugi should've used this",
                        "{C:inactive,s:0.8}as his ace monster",
                        "{C:inactive,s:0.8}instead of Dark Magician,",
                        "{C:inactive,s:0.8}needs 1 less tribute for the same",
                        "{C:inactive,s:0.8}amount of attack power\""
                    }
                }
            },
            j_mul_fifty_fifty = {
                name = "50/50",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance",
                        "to give {X:mult,C:white}X#3#{} Mult",
                        "If this probability fails, instead",
                        "give {C:mult}+#4#{} Mult"
                    },
                    {
                        "{C:inactive,s:0.8}\"The 50/50 feels like a",
                        "{C:inactive,s:0.8}10/90 because of how often",
                        "{C:inactive,s:0.8}I get a Qiqi\""
                    }
                }
            },
            j_mul_victory_royale = {
                name = "Victory Royale",
                text = {
                    {
                        "{C:green}#1# in #2#{} chance for scored cards",
                        "to create a random {C:spectral}Spectral{} card",
                        "{C:inactive}(Must have room){}"
                    },
                    {
                        "{C:inactive,s:0.8}\"Who let Miku have a gun?\""
                    }
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
            },
            mul_joker_hint = {
                name = "Hint",
                text = {
                    "Use a variety of",
                    "{C:tarot}Tarot{} cards"
                }
            },
            mul_villager_hint = {
                name = "Hint",
                text = {
                    "Get lots of {C:attention}Gold{},",
                    "{C:attention}Stone{} and {C:attention}Steel{}"
                }
            },
            undiscovered_myth = {
                name = "Not Discovered",
                text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
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
            k_mul_popped = "Popped!",
            k_mul_won_5050 = "Won!",
            k_mul_lost_5050 = "Lost...",
            k_myth = "Myth",
            b_myth_cards = "Myth Cards"
        },
        labels = {
            mul_transmutable = "Transmutable",
            myth = "Myth",
            k_mul_transmuted = "Transmuted",
        }
    }
}