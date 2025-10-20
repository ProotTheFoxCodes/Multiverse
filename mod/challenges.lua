SMODS.Challenge {
	key = 'waterfall',
	rules = {
		custom = {
			{ id = "mul_waterfall1" }
		}
	},
	restrictions = {
		banned_cards = {
			{ id = "v_directors_cut"},
			{ id = "v_retcon"}
		},
        banned_tags = {
            {id = "tag_boss"}
        }
	}
}

_boss_old = get_new_boss
function get_new_boss()

	ret = _boss_old()

	if G.GAME.challenge == "c_mul_waterfall" or G.GAME.challenge == "c_mul_monsoon" or G.GAME.challenge == "c_mul_merg" then
		ret = "bl_mul_undying"
	end

	return ret

end

SMODS.Challenge {
	key = 'monsoon',
	rules = {
		custom = {
			{id = "mul_waterfall1" },
			{ id = "mul_waterfall2" }
		}
	},
	restrictions = {
		banned_cards = {
			{ id = "v_directors_cut"},
			{ id = "v_retcon"}
		},
        banned_tags = {
            {id = "tag_boss"}
        }
	}
}

SMODS.Challenge {
	key = 'merg',
	rules = {
		custom = {
			{id = "mul_waterfall1" },
			{ id = "mul_waterfall3" }
		}
	},
	restrictions = {
		banned_cards = {
			{ id = "v_directors_cut"},
			{ id = "v_retcon"}
		},
        banned_tags = {
            {id = "tag_boss"}
        }
	}
}
