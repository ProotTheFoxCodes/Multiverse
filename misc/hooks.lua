local get_rank_hook = Card.get_id
Card.get_id = function(self)
    if SMODS.has_enhancement(self, "m_mul_calling_card") then
        return 14
    else
        return get_rank_hook(self)
    end
end
local chip_bonus_hook = Card.get_chip_bonus
Card.get_chip_bonus = function(self)
    if SMODS.has_enhancement(self, "m_mul_calling_card") then
        return 11 + (self.ability.perma_bonus or 0)
    else
        return chip_bonus_hook(self)
    end
end
local is_suit_hook = Card.is_suit
Card.is_suit = function(self, suit, bypass_debuff, flush_calc)
    if SMODS.has_enhancement(self, "m_mul_calling_card") then
        if flush_calc then
            if next(SMODS.find_card("j_smeared", false)) then
                return suit == "Hearts" or suit == "Diamonds"
            end
            return suit == "Hearts"
        else
            if self.debuff and not bypass_debuff then return end
            if next(SMODS.find_card("j_smeared", false)) then
                return suit == "Hearts" or suit == "Diamonds"
            end
            return suit == "Hearts"
        end
    else
        return is_suit_hook(self, suit, bypass_debuff, flush_calc)
    end
end