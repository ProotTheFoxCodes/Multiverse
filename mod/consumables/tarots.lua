SMODS.Consumable({
	key = "lobotomized",
	set = "Tarot",
	atlas = "placeholder",
	pos = { x = 0, y = 1 },
	config = { max_highlighted = 2, mod_conv = "m_mul_normal" },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, G.P_CENTERS[card.ability.mod_conv])
		return { vars = { card.ability.max_highlighted } }
	end,
})
SMODS.Consumable({
	key = "chair",
	set = "Tarot",
	atlas = "placeholder",
	pos = { x = 0, y = 1 },
	config = { max_highlighted = 1, mod_conv = "m_mul_motivated" },
	loc_vars = function(self, info_queue, card)
		table.insert(info_queue, G.P_CENTERS[card.ability.mod_conv])
		return { vars = { card.ability.max_highlighted } }
	end,
})
SMODS.Consumable({
	key = "apple",
	set = "Tarot",
	atlas = "placeholder",
	pos = { x = 0, y = 1 },
	in_pool = function(self, args)
		return Multiverse.config["joke"]
	end,
	can_use = function(self, card)
		return true
	end,
	check_dependencies = function (self)
		return Multiverse.config["joke"]
	end,
	use = function(self, card, area, copier)
		Multiverse.play_video("bad_apple")
		Multiverse.start_animation("black_bg")
		Multiverse.very_important_thing = true
		G.E_MANAGER:add_event(Event({
			blockable = false,
			trigger = "after",
			delay = 218 * G.SPEEDFACTOR,
			func = function()
				Multiverse.very_important_thing = false
				Multiverse.stop_video("bad_apple")
				Multiverse.end_animation("black_bg")
				return true
			end,
		}))
	end,
})
SMODS.Consumable({
	key = "burger",
	set = "Tarot",
	atlas = "placeholder",
	pos = { x = 0, y = 1 },
	in_pool = function(self, args)
		return Multiverse.config["joke"]
	end,
	can_use = function(self, card)
		return true
	end,
	check_dependencies = function (self)
		return Multiverse.config["joke"]
	end,
	use = function(self, card, area, copier)
		Multiverse.start_animation("eating_burger")
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 60 * G.SPEEDFACTOR,
			blockable = false,
			blocking = false,
			func = function()
				Multiverse.end_animation("eating_burger")
				return true
			end,
		}))
	end,
})

Multiverse.EGGMAN_SPEECH = {
	"I'VE COME TO MAKE AN ANNOUNCEMENT",
	"THE PLANT IS A BITCH ASS MOTHERFUCKER",
	"IT DEBUFFED MY FUCKING FACE CARDS",
	"THAT'S RIGHT",
	"IT TOOK ITS GREEN FUCKING LEAVES AND DEBUFFED MY FACE CARDS",
	"AND IT SAID ITS BLIND WAS THIS BIG",
	"AND I SAID THAT'S DISGUSTING",
	"SO I'M MAKING A CALLOUT POST IN GENERAL CHAT",
	"THE PLANT, YOU'VE GOT A WEAK EFFECT",
	"IT'S AS POWERFUL AS THE SERPENT, EXCEPT WAY WEAKER",
	"AND GUESS WHAT",
	"HERE'S WHAT MY EFFECT LOOKS LIKE",
	"BOOM",
	"THAT'S RIGHT BABY",
	"ALL JOKERS",
	"NO DEBUFFS",
	"NO FLIPS",
	"LOOK AT THAT IT LOOKS LIKE ALL BLINDS ARE DISABLED",
	"IT DEBUFFED MY FACE CARDS SO GUESS WHAT I'M GONNA DISABLE THE BLIND",
	"THAT'S RIGHT THIS IS WHAT YOU GET",
	"MY SUPER LASER DISABLE",
	"EXCEPT I'M NOT GONNA DISABLE THIS BLIND",
	"I'M GONNA GO HIGHER",
	"I'M DISABLING EVERY BLIND",
	"HOW DO YA LIKE THAT, LOCALTHUNK?",
	"I DISABLED EVERY BLIND, YOU IDIOT",
	"YOU HAVE 7 ANTES BEFORE THE Boss Disabled! HITS THE VERDANT LEAF",
	"NOW GET REROLLED BEFORE I DISABLE YOU TOO",
}
