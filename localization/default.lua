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
                    "{C:inactive}(#3#/#4#?){}"
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
                    "{C:red,E:2}Self-destructs{} in {C:attention}#3#{} rounds",
                    "{C:inactive}(Currently #2#/#3#){}"
                }
            },
            j_mul_ren_amamiya = {
                name = "Ren Amamiya",
                text = {
                    "The {C:attention}first{} played card that",
                    "scores becomes a {C:attention}Calling Card{}",
                    "Retrigger all played {C:attention}Calling Cards{}",
                    "a number of times equal to the",
                    "number of {C:attention}distinct{} {C:tarot}Tarot{} cards",
                    "in your consumable area",
                    "{C:inactive}(Currently #1# times){}"
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
                    "All played cards with {C:diamonds}#1#{}",
                    "suit become {C:attention}Netherite{} cards",
                    "{C:attention}+#2#{} hand size"
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