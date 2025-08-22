-- Do main menu stuff here
-- Yoinked from Fool's Gambit
local main_menu_hook = Game.main_menu
function Game:main_menu(change_context)
    main_menu_hook(self, change_context)
    local scale = 1.7
    local card_area_initial = {
        h = G.CARD_H,
        w = G.CARD_W,
    }
    self.mul_title = CardArea(20, 20, card_area_initial.w, card_area_initial.h, {card_limit = 1, type = "title"})
    G.mul_title:set_alignment({
        major = G.SPLASH_LOGO,
        type = "cm",
        bond = "Strong",
        offset = {x = -4, y = 3.5}
    })
    local mul_card = Card(self.mul_title.T.x, self.mul_title.T.y, G.CARD_W * scale * 1.8, G.CARD_H * scale * 0.5, G.P_CENTERS.j_mul_mod_logo, G.P_CENTERS.j_mul_mod_logo)
    mul_card.no_ui = true
    self.mul_title:emplace(mul_card)
end

SMODS.Atlas {
    key = "mod_logo",
    px = 575,
    py = 250,
    path = "multiverse_logo.png"
}
SMODS.Joker {
    key = "mod_logo",
    atlas = "mod_logo",
    pos = {x = 0, y = 0},
    unlocked = true,
    discovered = true,
    no_collection = true,
    loc_txt = {
        name = "",
        text = {
            ""
        }
    },
    in_pool = function(self, args)
        return false
    end
}