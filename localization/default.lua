return {
	descriptions = {
		Blind = {
			bl_mul_limbo = {
				name = "The Limbo",
				text = {
					"F O C U S",
					"(X#1# Blind size",
					"on failure)",
				},
			},
			bl_mul_undying = {
				name = "The Undying",
				text = {
					"Survive",
					"(Lose chips equal to",
					"#1#% of Blind size when hit)",
				},
			},
		},
		Enhanced = {
			m_mul_calling_card = {
				name = "Calling Card",
				text = {
					"Gives {X:mult,C:white}X#1#{} Mult",
					"per ante",
					"Always treated as an",
					"{C:attention}Ace{} of {C:hearts}Hearts{}",
					"Gives no base {C:chips}chips{}",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}",
				},
			},
			m_mul_netherite = {
				name = "Netherite Card",
				text = {
					"{X:mult,C:white}X#1#{} Mult per {C:money}$1{}",
					"when held in hand",
					"Gives {C:money}$#2#{} when held in",
					"hand at end of round",
					"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult){}",
				},
			},
			m_mul_normal = {
				name = "Normal Card",
				text = {
					"{C:chips}+#1#{} Chips",
					"Treated as",
					"a {C:attention}face card{}",
				},
			},
			m_mul_motivated = {
				name = "Motivated Card",
				text = {
					"Retrigger this",
					"card {C:attention}#1#{} time",
					"{C:green}#2# in #3#{} chance to",
					"lose enhancement",
				},
			},
			m_mul_waldo = {
				name = "Waldo Card",
				text = {
					"Retrigger this card {C:attention}#1#{}",
					"time for every {C:attention}#2#{} cards",
					"in full deck",
					"Gives no base {C:chips}chips{}",
					"Has no rank or suit",
					"Cannot be copied",
					"{C:inactive}(Currently {C:attention}#3#{C:inactive} retriggers){}",
					"{C:inactive}(Minimum of {C:attention}1{C:inactive} retrigger){}",
				},
			},
		},
		Edition = {
			e_mul_hyperdimensional = {
				name = "Hyperdimensional",
				text = {
					"{C:attention}+#1#{} card area slot",
					"Gain {C:attention}#2#%{} TP and{s:0.57} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#3#{} Thaumaturgy",
					"Energy at end of round",
				},
			},
		},
		mul_Myth = {
			c_mul_philosophers_stone = {
				name = "Philosopher's Stone",
				text = {
					"Gain{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} per",
					"{C:mul_transmuted}Transmuted{} Joker owned",
					"{C:mul_transmuted,E:1}Transmutes{} selected Joker that",
					"is currently {C:mul_transmuted}Transmutable{}",
					"{C:inactive}(Preserves Joker modifications){}",
					"{C:inactive}(Currently{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#2#{C:inactive}){}",
				},
			},
			c_mul_holy_grail = {
				name = "Holy Grail",
				text = {
					"Creates {C:attention}#1#{} {C:dark_edition}Negative{} consumables that",
					"are relevant to the {C:mul_transmuted}transmutation{}",
					"of selected Joker",
				},
			},
			c_mul_perpetual_motion = {
				name = "Perpetual Motion Machine",
				text = {
					"Doubles current",
					"Thaumaturgy Energy",
					"{C:inactive}(Max of{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{C:inactive})",
				},
			},
			c_mul_tree_of_eden = {
				name = "Tree of Eden",
				text = {
					"Creates a random Joker that is",
					"relevant to the {C:mul_transmuted}transmutation{}",
					"of selected Joker",
				},
			},
			c_mul_sphere = {
				name = "Sphere of Annhilation",
				text = {
					"{C:attention}Destroys{} all cards in hand",
					"Lose{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} per card destroyed",
					"{C:inactive}(Currently{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#2#{C:inactive}){}",
				},
			},
			c_mul_chaos_emeralds = {
				name = "Chaos Emeralds",
				text = {
					"{C:attention}Increases{} selected Joker's",
					"progress towards becoming",
					"{C:mul_transmuted}Transmutable{} by {C:attention}25%{}",
				},
			},
			c_mul_one_ring = {
				name = "One Ring",
				text = {
					"Sets Thaumaturgy",
					"Energy to{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}0{}",
					"Creates a random",
					"{C:red}Rare{} Joker",
				},
			},
			c_mul_theory = {
				name = "Theory of Everything",
				text = {
					"Creates a random Joker",
					"that can become {C:mul_transmuted}Transmutable{}",
				},
			},
			c_mul_rosetta_stone = {
				name = "Rosetta Stone",
				text = {
					"{C:attention}Flips{} all Jokers",
					"Gain{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} per",
					"Joker flipped",
					"{C:inactive}(Currently{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#2#{C:inactive}){}",
				},
			},
			c_mul_shadow_crystal = {
				name = "Shadow Crystal",
				text = {
					"Sets selected Joker's progress",
					"towards becoming {C:mul_transmuted}Transmutable{}",
					"to its requirement minus {C:attention}1{}",
					"Gives the selected Joker",
					"{C:attention}Traitorous{}",
				},
			},
			c_mul_one_piece = {
				name = "One Piece",
				text = {
					"Gain Thaumaturgy Energy",
					"equal to the total",
					"{C:attention}sell value{} of all Jokers",
					"{C:inactive}(Max of{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{C:inactive}){}",
					"{C:inactive}(Currently{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#2#{C:inactive}){}",
				},
			},
			c_mul_gnosis = {
				name = "Archon's Gnosis",
				text = {
					"{C:attention}Destroys{} selected Joker that",
					"can become {C:mul_transmuted}Transmutable{}",
					"Gain{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{}",
				},
			},
			c_mul_puzzle = {
				name = "Millenium Puzzle",
				text = {
					"While active, increases",
					"{C:attention}base{} Thaumaturgy Energy",
					"recharge rate by{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{}",
					"but {C:attention}halves{} money",
					"earned from all sources",
					"{C:inactive}(Currently #2#){}",
				},
			},
			c_mul_three_goddesses = {
				name = "Three Goddesses Statue",
				text = {
					"Sets Thaumaturgy Energy to{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}0{}",
					"{C:attention}Increases{} selected Joker's",
					"progress towards becoming",
					"{C:mul_transmuted}Transmutable{} by {C:attention}50%{}",
					"{C:inactive}(Cannot be used while Thaumaturgy{}",
					"{C:inactive}Energy is below{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{C:inactive}){}",
				},
			},
			c_mul_ufo = {
				name = "UFO",
				text = {
					"While active, increases",
					"{C:attention}base{} Thaumaturgy Energy",
					"recharge rate by{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} but {C:attention}-#2#{}",
					"card slots available in shop",
					"{C:inactive}(Currently #3#){}",
				},
			},
			c_mul_stand_arrow = {
				name = "Stand Arrow",
				text = {
					"While active, increases",
					"{C:attention}base{} Thaumaturgy Energy",
					"recharge rate by{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} but",
					"{C:red}debuffs{} all {V:1}#2#{} cards",
					"{C:inactive}(Suit changes at end of round){}",
					"{C:inactive}(Currently #3#){}",
				},
			},
			c_mul_moon_berry = {
				name = "Moon Berry",
				text = {
					"Adds {C:dark_edition}Polychrome{} to",
					"selected Joker",
					"Lose{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{}",
				},
			},
			c_mul_elder_scroll = {
				name = "Elder Scroll",
				text = {
					"While active, increases {C:attention}base{}",
					"Thaumaturgy Energy recharge",
					"rate by{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} but",
					"all playing cards are {C:attention}facedown{}",
					"{C:inactive}(Currently #2#){}",
				},
			},
			c_mul_master_sword = {
				name = "Master Sword",
				text = {
					"{C:attention}Destroys{} selected Joker",
					"with at least {C:attention}1{} sticker",
					"Gain{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} per sticker",
					"on selected Joker",
					"{C:inactive}(Can bypass Eternal){}",
					"{C:inactive}(Currently{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#2#{C:inactive}){}",
				},
			},
			c_mul_unicorn_horn = {
				name = "Unicorn's Horn",
				text = {
					"{C:red}Nullifies{} the next decrease",
					"in Thaumaturgy Energy",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive} nullifications){}",
				},
			},
			c_mul_kryptonite = {
				name = "Kryptonite",
				text = {
					"While active, increases {C:attention}base{}",
					"Thaumaturgy Energy recharge",
					"rate by{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} but",
					"{C:red}debuffs{} all {C:red}Rare{} Jokers",
					"{C:inactive}(Currently #2#){}",
				},
			},
			c_mul_infinity_gauntlet = {
				name = "Infinity Gauntlet",
				text = {
					"{C:attention}Increases{} selected Joker's",
					"progress towards becoming",
					"{C:mul_transmuted}Transmutable{} by {C:attention}50%{}",
					"Randomly destroys {C:attention}half{}",
					"of all other Jokers",
				},
			},
			c_mul_super_star = {
				name = "Super Star",
				text = {
					"While active, {C:blue}+#1#{} hands and",
					"{C:red}+#2#{} discards but decreases",
					"{C:attention}base{} Thaumaturgy Energy",
					"recharge rate by{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#3#{}",
					"{C:inactive}(Currently #4#){}",
				},
			},
			c_mul_matrix = {
				name = "Matrix",
				text = {
					"While active, {C:attention}+#1#{} Joker",
					"slots but decreases",
					"{C:attention}base{} Thaumaturgy Energy",
					"recharge rate by{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#2#{}",
					"{C:inactive}(Currently #3#){}",
				},
			},
			c_mul_time_machine = {
				name = "Time Machine",
				text = {
					"While active, all Jokers",
					"that can become {C:mul_transmuted}Transmutable{}",
					"gain {C:attention}#1#{} progress towards",
					"becoming {C:mul_transmuted}Transmutable{} at",
					"end of round but {C:red}nullify{}",
					"all Thaumaturgy Energy gain",
					"{C:inactive}(Currently #2#){}",
				},
			},
			c_mul_palace_treasure = {
				name = "Palace Treasure",
				text = {
					"Sets Thaumaturgy Energy to{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}0{}",
					"Earn {C:money}$1{} for every{s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} lost",
					"{C:inactive}(Currently {C:money}#2#{C:inactive}){}",
				},
			},
			c_mul_journal = {
				name = "Journal",
				text = {
					"Creates the last {C:mul_transmuted}Myth{}",
					"Card used during this run",
					"{s:0.8,C:mul_transmuted}Journal{s:0.8} excluded",
				},
			},
			c_mul_homunculus = {
				name = "Homunculus",
				text = {
					"Creates up to {C:attention}#1#{}",
					"random {C:mul_transmuted}Myth{} cards",
				},
			},
		},
		Joker = {
			j_mul_bloodbath = {
				name = "Bloodbath",
				text = {
					{
						"All cards give {X:mult,C:white}X#1#{} Mult when",
						"scored on {C:attention}last hand{} of round",
					},
					{
						"{C:inactive,s:0.8}The Michigun UFO part",
						"{C:inactive,s:0.8}gives me nightmares",
					},
				},
			},
			j_mul_cataclysm = {
				name = "Cataclysm",
				text = {
					{
						"All cards give {C:mult}+#1#{} Mult when",
						"scored on {C:attention}last hand{} of round",
					},
					{
						"{C:inactive,s:0.8}That first wave part is so stupid",
					},
				},
			},
			j_mul_magic_school_bus = {
				name = "Magic School Bus",
				text = {
					{
						"This Joker gains {C:mult}+#1#{} Mult per",
						"{C:attention}face{} card held in hand",
						"Resets if there are no",
						"{C:attention}face cards{} held in hand",
						"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					},
					{
						'{C:inactive,s:0.8}"Mrs. Frizzle, where are we going?"',
						'{C:inactive,s:0.8}"We\'re going gambling!"',
					},
				},
			},
			j_mul_v2 = {
				name = "V2",
				text = {
					{
						"When {C:attention}first hand{} of round is",
						"played, add a {C:attention}Gold Seal{} to",
						"first scored {C:hearts}Hearts{} card",
					},
					{
						"{C:inactive,s:0.8}Ultrakill fans will do anything",
						"{C:inactive,s:0.8}to screw the murder robot",
					},
				},
			},
			j_mul_villager = {
				name = "Villager",
				text = {
					{
						"{C:mult}+#1#{} Mult, lose {C:money}$#2#{}",
						"when hand is played",
					},
					{
						"{C:inactive,s:0.8}Oh, them? They're the villagers!",
					},
				},
			},
			j_mul_antimatter = {
				name = "Antimatter",
				text = {
					{
						"{C:mult}+#1#{} Mult?",
					},
					{
						"{C:inactive,s:0.8}The ninth dimension is",
						"{C:inactive,s:0.8}[DATA EXPUNGED],",
						"{C:inactive,s:0.8}trust me bro",
					},
				},
			},
			j_mul_red_bloon = {
				name = "Red Bloon",
				text = {
					{
						"Earn {C:money}$#1#{} when a card is scored",
						"{C:red,E:2}Self-destructs{} in {C:attention}#3#{} rounds",
						"{C:inactive}(Currently #2#/#3#){}",
					},
					{
						"{C:inactive,s:0.8}Who is paying the monkeys",
						"{C:inactive,s:0.8}to pop these bloons?",
					},
				},
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
						"{C:inactive}(Currently #1# times){}",
					},
					{
						"{C:inactive,s:0.8}You never see it coming",
					},
				},
			},
			j_mul_steve = {
				name = "Steve",
				text = {
					{
						"{C:attention}+#1#{} hand size",
						"When hand is played, convert",
						"all {C:attention}Enhanced{} cards in",
						"hand into {C:attention}Netherite{} cards",
					},
					{
						"{C:inactive,s:0.8}L-l-l-lava,{}",
						"{C:inactive,s:0.8}ch-ch-ch-chicken,",
						"{C:inactive,s:0.8}Steve's lava chicken yeah",
						"{C:inactive,s:0.8}it's tasty as hell",
					},
				},
			},
			j_mul_summoned_skull = {
				name = "Summoned Skull",
				text = {
					{
						"{X:mult,C:white}X#1#{} Mult",
						"{C:attention}Destroys{} a random",
						"Joker when purchased",
					},
					{
						"{C:inactive,s:0.8}Don't do the Mr. Bones",
						"{C:inactive,s:0.8}glitch or else you'll get",
						"{C:inactive,s:0.8}sent to the Shadow Realm",
					},
				},
			},
			j_mul_fifty_fifty = {
				name = "50/50",
				text = {
					{
						"{C:green}#1# in #2#{} chance",
						"to give {X:mult,C:white}X#3#{} Mult",
						"If this probability fails, instead",
						"give {C:mult}+#4#{} Mult",
					},
					{
						"{C:inactive,s:0.8}The 50/50 feels like a",
						"{C:inactive,s:0.8}10/90 because of how often",
						"{C:inactive,s:0.8}I get a Qiqi",
					},
				},
			},
			j_mul_victory_royale = {
				name = "Victory Royale",
				text = {
					{
						"{C:green}#1# in #2#{} chance for",
						"scored cards to create",
						"a random {C:dark_edition}Negative{}",
						"{C:spectral}Spectral{} card",
						"{C:green}Base odds{} decreases by",
						"{C:attention}#3#{} when a card is scored",
						"{C:green}Base odds{} resets to {C:attention}100{}",
						"after creating a {C:spectral}Spectral{} card",
					},
					{
						"{C:inactive,s:0.8}Who let Miku have a gun?",
					},
				},
			},
			j_mul_hammer_bro = {
				name = "Hammer Bro",
				text = {
					{
						"Scored cards {C:attention}randomly{} give",
						"either {C:mult}+#1#{} Mult",
						"or {X:mult,C:white}X#2#{} Mult",
					},
					{
						"{C:inactive,s:0.8}These turtles always",
						"{C:inactive,s:0.8}pick the worst time",
						"{C:inactive,s:0.8}to throw hammers at me",
					},
				},
			},
			j_mul_gerson = {
				name = "Gerson",
				text = {
					{
						"Disables every {C:attention}Boss Blind{}",
						"All Jokers each give",
						"{X:mult,C:white}X#1#{} Mult, increases by",
						"{X:mult,C:white}X#2#{} when entering",
						"a {C:attention}Boss Blind{}",
					},
					{
						"{C:inactive,s:0.8}I'm old!",
					},
				},
			},
			j_mul_stand_user = {
				name = "Stand User",
				text = {
					{
						"Prevents Death during",
						"a {C:attention}Boss Blind{}, then",
						"{C:attention}#1#{} Ante",
						"{C:red,E:2}Self-destructs{}",
					},
					{
						"{C:inactive,s:0.8}The stand user",
						"{C:inactive,s:0.8}could be anyone",
					},
				},
			},
			j_mul_waldo = {
				name = "Waldo",
				text = {
					{
						"Add a {C:attention}Waldo Card{} to",
						"deck when this card",
						"is obtained",
						"{C:attention}Waldo Cards{} give {X:mult,C:white}X#1#{} Mult",
						"per card in full deck",
						"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}",
					},
					{
						"{C:inactive,s:0.8}After years of searching,",
						"{C:inactive,s:0.8}we've finally found him",
					},
				},
			},
			j_mul_foddian_struggle = {
				name = "Foddian Struggle",
				text = {
					{
						"This Joker gains {C:mult}+#2#{} Mult",
						"per consecutive hand",
						"played without a {V:1}#1#{}",
						"{C:inactive}(Suit changes at end of round){}",
						"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
					},
					{
						"{C:inactive,s:0.8}Press F to pay respects",
						"{C:inactive,s:0.8}for the broken keyboards",
						"{C:inactive,s:0.8}and mice due to gamer rage",
					},
				},
			},
			j_mul_peashooter = {
				name = "Peashooter",
				text = {
					{
						"If played hand contains",
						"exactly {C:attention}1{} card,",
						"this Joker gains {C:mult}+#1#{} Mult",
						"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
					},
					{
						"{C:inactive,s:0.8}Dave must be feeding",
						"{C:inactive,s:0.8}them some crazy stuff",
						"{C:inactive,s:0.8}if their peas can",
						"{C:inactive,s:0.8}decapitate zombies",
					},
				},
			},
			j_mul_slime = {
				name = "Slime",
				text = {
					{
						"If played hand contains",
						"{C:attention}#1#{} scoring cards, earn {C:money}$#2#{}",
					},
					{
						"{C:inactive,s:0.8}Cute, squishy and flammable",
					},
				},
			},
			j_mul_jack_frost = {
				name = "Jack Frost",
				text = {
					{
						"First scored card",
						"in played hand",
						"becomes a {C:attention}Jack{}",
					},
					{
						"{C:inactive,s:0.8}Hee Ho{}",
					},
				},
			},
			j_mul_dragon = {
				name = "Dragon",
				text = {
					{
						"Destroy all discarded",
						"{C:attention}Kings{} and gain {X:mult,C:white}X#1#{} per",
						"{C:attention}King{} discarded",
						"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}"
					},
					{
						"{C:inactive,s:0.8}Currently in a romantic",
						"{C:inactive,s:0.8}relationship with a donkey"
					},
				},
			},
		},
		Spectral = {
			c_mul_eternity = {
				name = "Eternity",
				text = {
					"Select {C:attention}#1#{} card in hand",
					"Destroys all unselected",
					"cards in hand and gives",
					"all Jokers {C:attention}Eternal{}",
				},
			},
			c_mul_eternity_alt = {
				name = "Eternity",
				text = {
					"Select {C:attention}#1#{} card in hand",
					"Destroys all unselected",
					"cards in hand and gives",
					"all Jokers {C:attention}Eternal{}",
					"{C:inactive}(Destroys all Jokers that",
					"{C:inactive}cannot become Eternal)",
				},
			},
			c_mul_backstab = {
				name = "Backstab",
				text = {
					"Create a {C:dark_edition}Negative{} copy",
					"of a random Joker, then",
					"give {C:attention}Traitorous{} to the copy",
				},
			},
			c_mul_scheme = {
				name = "Pyramid Scheme",
				text = {
					"Gives {C:attention}triple{} the total sell",
					"value of all Jokers, then",
					"gives all Jokers {C:attention}Rental{}",
					"{C:inactive}(Will give {C:money}$#1#{C:inactive}){}",
				},
			},
		},
		Tag = {
			tag_mul_magnum_opus = {
				name = "Magnum Opus Tag",
				text = {
					"Creates a",
					"{C:mul_transmuted}Philosopher's Stone{}",
					"{C:inactive,s:0.8}Cannot be duplicated{}",
					"{C:inactive,s:0.8}Ignores consumable limit{}",
				},
			},
		},
		Tarot = {
			c_mul_lobotomized = {
				name = "The Lobotomized",
				text = {
					"Enhances {C:attention}#1#{}",
					"selected cards to",
					"{C:attention}Normal Cards{}",
				},
			},
			c_mul_chair = {
				name = "The Chair",
				text = {
					"Enhances {C:attention}#1#{} selected",
					"card into a",
					"{C:attention}Motivated Card{}",
				},
			},
			c_mul_apple = {
				name = "The Apple",
				text = {
					"Plays the entire",
					"{C:attention}Bad Apple{} video",
					"for no benefit",
				},
			},
			c_mul_burger = {
				name = "The Burger",
				text = {
					"Plays an {C:attention}animation{} of a",
					"member of the official",
					"Balatro Discord server eating",
					"a {C:attention}burger{} for {C:attention}1{} minute",
				},
			},
		},
		Other = {
			mul_transmutable = {
				name = "Transmutable",
				text = {
					"Can use {C:attention}Philosopher's Stone{}",
					"on this card to create",
					"{C:mul_transmuted,E:1}Transmuted{} Jokers",
					"Gain {s:0.58} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#1#{} at end of round",
				},
			},
			mul_traitorous = {
				name = "Traitorous",
				text = {
					"{C:attention}Destroys{} leftmost Joker",
					"at end of round",
					"{C:inactive}(Bypasses Eternal){}",
				},
			},
			undiscovered_mul_myth = {
				name = "Not Discovered",
				text = {
					"Purchase or use",
					"this card in an",
					"unseeded run to",
					"learn what it does",
				},
			},
			--#region Activated ability descriptions
			j_mul_steve_ability = {
				name = "Crafting",
				text = {
					"Cost: {C:attention}#1#{} TP",
					"Effect: Destroy any number",
					"of selected cards, then",
					"create an equal number",
					"of {C:attention}Netherite Cards{} with",
					"a random {C:attention}Seal{} and {C:attention}Edition{}",
				},
			},
			--#endregion
			--#region Transmutation hints
			mul_joker_hint = {
				name = "Hint",
				text = {
					"Use {C:attention}#2#{} distinct",
					"{C:tarot}Tarot{} cards",
					"{C:inactive}(#1#/#2#){}",
				},
			},
			mul_dragon_hint = {
				name = "Hint",
				text = {
					"Obtain {C:attention}#2#{} {C:attention}Gold{},",
					"{C:attention}Stone{} and {C:attention}Steel{} cards",
					"{C:inactive}(#1#/#2#){}",
				},
			},
			mul_hammer_bro_hint = {
				name = "Hint",
				text = {
					"Trigger this card",
					"{C:attention}#2#{} times",
					"{C:inactive}(#1#/#2#){}",
				},
			},
			mul_pareidolia_hint = {
				name = "Hint",
				text = {
					"Play {C:attention}#2#{} unique",
					"{C:attention}poker hands{}",
					"{C:inactive}(#1#/#2#){}",
				},
			},
			--#endregion
			--#region Mechanic descriptions
			mul_thaumaturgy_desc = {
				name = "Thaumaturgy Energy",
				text = {
					"#1#{s:0.57} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}#2#{} at end of round",
					"If Thaumaturgy Energy exceeds{s:0.57} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}100{} at",
					"end of round, set Thaumaturgy Energy",
					"to{s:0.57} {C:mul_transmuted,f:mul_thaum_icon,E:mul_rotate}+{C:mul_transmuted}0{} and create a {C:attention}Philosopher's Stone",
					"{C:inactive}(Must have room){}",
				},
			},
			mul_TP_desc = {
				name = "TP",
				text = {
					"If total score of played",
					"hand does not exceed current",
					"blind size, gain {C:attention}#1#-#2#%{} TP",
					"{C:inactive}(TP is capped at 100%){}",
				},
			},
			mul_active_consumable = {
				name = "Active Consumable",
				text = {
					"When used, this consumable will",
					"{C:attention}remain{} in your consumable slots",
					"and apply its {C:attention}active{} effects",
					"If used while active, this",
					"consumable is used like normal",
					"and will {C:attention}stop{} applying its effects",
					"{C:inactive}(Note that this card will receive{}",
					"{C:inactive}Eternal while it is active){}",
				},
			},
			--#endregion
			--#region Blind instructions
			mul_limbo_inst = {
				name = "Instructions",
				text = {
					"When Blind is selected, {C:attention}8{} keys",
					"will appear on the screen",
					" ",
					"Pay attention to the {C:attention}key{}",
					"that is flashing {C:green}green{}",
					" ",
					"In a moment, the keys will",
					"start to {C:attention}shuffle{} around",
					" ",
					"When the keys stop shuffling,",
					"{C:attention}click{} the key that was flashing",
					"{C:green}green{} at the start of the blind",
				},
			},
			mul_undying_inst = {
				name = "Instructions",
				text = {
					"When playing a hand, a",
					"{C:green}green{} heart will appear,",
					"as well as a {C:blue}blue{} shield",
					" ",
					"Use {C:attention}arrow keys{} to block",
					"the incoming spears by",
					"pointing the shield in",
					"the direction of the spear",
					" ",
					"Yellow spears will {C:attention}flip{}",
					"direction once they are",
					"about halfway to the heart",
				},
			},
			--#endregion
		},
		Abilities = {},
		Mod = {
			Multiverse = {
				name = "Multiverse",
				text = {
					"A {C:attention}conceptually crazy{} but {C:attention}mechanically balanced{} Balatro mod.",
					"This mod contains new {C:attention}Jokers{}, {C:tarot}Tarots{}, {C:spectral}Spectrals{}, {C:attention}Blinds{}, {C:attention}card",
					"{C:attention}enhancements{}, and {C:mul_transmuted}Myths{} (a new consumable type).",
					"{C:mul_transmuted}Myth{} cards can help you obtain {C:mul_transmuted,E:1}Transmuted{} Jokers that enable",
					"your runs to reach into high {C:attention}Antes{} in {C:attention}Endless Mode{} while doing so in a",
					"way that feels {C:attention}relatively vanilla{} and doesn't invalidate vanilla content.",
					"A {C:red}warning{} for those with {C:attention}Talisman{} installed:",
					"I have not tested my mod with {C:attention}Talisman{} very much.",
					"Considering that {C:attention}Talisman{} tends to cause lots of {C:red}crashes{}",
					"due to how it represents numbers in its code, I do not expect",
					"{C:mul_transmuted}Multiverse{} to play smoothly when {C:attention}Talisman{} is installed.",
					"I am willing to make bugfixes regarding {C:attention}Talisman{} crashes",
					"if {C:mul_transmuted}Multiverse{} is responsible for the crash, however these fixes",
					"will most likely not be implemented until a {C:attention}future{} content update.",
				},
			},
		},
	},
	misc = {
		poker_hands = {
			mul_storm = "Storm",
		},
		poker_hand_descriptions = {
			mul_storm = {
				"5 cards that each have different ranks",
				"and have 4 distinct suits among them",
			},
		},
		challenge_names = {
			c_mul_waterfall = "Waterfall",
			c_mul_monsoon = "But The Earth Refused.",
			c_mul_cant_touch_this = "Can't Touch This",
		},
		v_text = {
			ch_c_mul_waterfall1 = { "Every {C:attention}Boss Blind{} is replaced with {C:red}The Undying{}" },
			ch_c_mul_waterfall2 = {
				"If {C:chips}score{} is below {X:attention,C:white}X-0.5{} {C:attention}Blind Size{}, {C:red}lose instantly{}",
			},
			ch_c_mul_waterfall3 = {
				"You lose {C:attention}twice{} as many chips if hit by a spear",
			},
			ch_c_mul_waterfall4 = {
				"If you get hit by {C:red}The Undying{}, {C:red}lose instantly{}",
			},
		},
		dictionary = {
			k_mul_transmuted = "Transmuted",
			k_mul_missed_bus = "Missed the bus!",
			k_mul_antimatter_init = "And so it begins...",
			k_mul_antimatter_grow1 = "More!",
			k_mul_antimatter_grow2 = "Even more!",
			k_mul_antimatter_grow3 = "Is this too much?",
			k_mul_antimatter_grow4 = "What have we done?",
			k_mul_popped = "Popped!",
			k_mul_won_fifty_fifty = "Won!",
			k_mul_lost_fifty_fifty = "Lost...",
			k_mul_thaumaturgy_energy = "Thaumaturgy Energy",
			k_mul_make_room = "Must have at least 1 available consumable slot",
			k_mul_make_room2 = "in order to create a Philosopher's Stone...",
			k_mul_TP = "TP",
			k_mul_myth = "Myth",
			k_mul_activate = "Activate",
			k_mul_ability = "Ability",
			b_mul_myth_cards = "Myth Cards",
			b_mul_discord_server = "My Discord Server",
			b_mul_landing_page = "About Me",
			mul_stand_user = "Saved by Stand User via time reversal",
			mul_config_menu_text = {
				"Debug Mode affects several elements of the mod for easier debugging",
				"Debug Mode cannot be enabled, except if a certain file is loaded",
				"{C:inactive}(If you wish to help me debug this mod, DM me and I will send{}",
				"{C:inactive}you a copy of the file that allows you to enable Debug Mode){}",
				"If you change a setting here, the game will {C:attention}automatically{} restart",
				"and apply any changes associated with the setting, such as loading",
				"or unloading joke content and allowing debug functions to be called",
			},
			mul_config_menu_title = {
				"Change Multiverse's settings here",
			},
			mul_music_menu_text = {
				"Enable or disable certain songs that this mod uses",
				"Hover over the song details to see when the song plays",
			},
			mul_debug = "Enable Debug Mode",
			mul_joke = "Enable Joke Content",
			["mul_Prophecy"] = {
				"Plays when you have",
				"a Joker that has the",
				"{C:mul_transmuted}Transmutable{} sticker",
			},
			["mul_Life Will Change"] = {
				"Plays when you",
				"have {C:attention}Ren Amamiya{}",
			},
			["mul_Pigstep"] = {
				"Plays when you",
				"have {C:attention}Steve{}",
			},
			["mul_Hammer of Justice"] = {
				"Plays when you",
				"have {C:attention}Gerson{}",
			},
			["mul_Presage"] = {
				"Plays on {C:attention}Ante 8{}",
				"or higher",
			},
			["mul_Sneaky Snitch"] = {
				"Plays when you",
				"have {C:attention}Waldo{}",
			},
			["mul_Battle Against a True Hero"] = {
				"Plays when facing",
				"The Undying",
			},
		},
		labels = {
			mul_transmutable = "Transmutable",
			mul_traitorous = "Traitorous",
			myth = "Myth",
			k_mul_transmuted = "Transmuted",
			mul_hyperdimensional = "Hyperdimensional",
		},
		v_dictionary = {
			a_mul_thaumaturgy_energy = "+#1# Energy",
			a_mul_TP = "+#1# TP",
			a_mul_limbo_popup = "F O C U S (X#1# Blind size on failure)",
		},
	},
}
