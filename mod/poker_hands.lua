SMODS.PokerHand {
    key = "thunderstrike",
    mult = 5,
    chips = 50,
    l_mult = 3,
    l_chips = 30,
    example = {
        {"S_7", true},
        {"H_9", true},
        {"C_J", true},
        {"D_K", true},
        {"S_K", true}
    },
    evaluate = function(parts, hand)
        if not next(parts._2) or not next(parts.mul_lightning) then return {} end
        return {SMODS.merge_lists(parts._2, parts.mul_lightning)}
    end
}

SMODS.PokerHand {
    key = "lightning",
    mult = 3,
    chips = 35,
    l_mult = 2,
    l_chips = 25,
    example = {
        {"H_A", true},
        {"S_Q", true},
        {"S_T", true},
        {"D_9", false},
        {"C_8", true}
    },
    evaluate = function(parts, hand)
        return parts.mul_lightning
    end
}

SMODS.PokerHand {
    key = "flush_thunderstrike",
    visible = false,
    mult = 15,
    chips = 180,
    l_mult = 5,
    l_chips = 60,
    example = {
        {"H_6", true},
        {"H_8", true},
        {"H_T", true},
        {"H_T", true},
        {"H_Q", true}
    },
    evaluate = function(parts, hand)
        if not next(parts._2) or not next(parts.mul_lightning) or not next(parts._flush) then return {} end
        return {SMODS.merge_lists(parts._2, parts.mul_lightning, parts._flush)}
    end
}

SMODS.PokerHandPart {
    key = "lightning",
    func = function(hand)
        -- get a sorted table of cards by rank
        ---@type Card[]
        local cards = {}
        for _, card in ipairs(hand) do
            if not SMODS.has_no_rank(card) then
                table.insert(cards, card)
            end
        end
        if #cards < 4 then return {} end
        table.sort(cards, function (a, b)
            return a:get_id() < b:get_id()
        end)
        local returned_hand = {}
        local max_streak = 0
        for i = 1, #cards - 3 do
            local last_rank = cards[i]:get_id()
            local temp = {cards[i]}
            local streak = 1
            for j, card in ipairs(cards) do
                if card:get_id() == last_rank + 2 then
                    temp[#temp+1] = card
                    last_rank = card:get_id()
                    streak = streak + 1
                end
            end
            if streak > max_streak then
                max_streak = streak
                returned_hand = temp
            end
        end
        if max_streak >= 4 then
            return {returned_hand}
        else return {} end
    end
}