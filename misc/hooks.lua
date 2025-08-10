local get_rank_hook = Card.get_id
function Card:get_id()
    if SMODS.has_enhancement(self, "m_mul_calling_card") then
        return 14
    else
        return get_rank_hook(self)
    end
end
local chip_bonus_hook = Card.get_chip_bonus
function Card:get_chip_bonus()
    if SMODS.has_enhancement(self, "m_mul_calling_card") then
        return 11 + (self.ability.perma_bonus or 0)
    else
        return chip_bonus_hook(self)
    end
end
local is_face_hook = Card.is_face
function Card:is_face(from_boss)
    if SMODS.has_enhancement(self, "m_mul_calling_card") then
        if self.debuff and not from_boss then return end
        if next(SMODS.find_card("j_pareidolia")) then return true end
    else
        return is_face_hook(self, from_boss)
    end
end
local is_suit_hook = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
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
local draw_hook = love.draw
function love.draw()
    draw_hook()
    for key, anim in pairs(Multiverse.all_animations) do
        if anim.is_active then
            if anim.is_continuous then
                anim.progress = anim.progress + G.real_dt * #anim.frames / anim.duration
                if anim.progress >= #anim.frames then
                    anim.progress = anim.progress - #anim.frames
                end
                -- anim_progress \in [0, #anim_frames)
                -- anim_progress + 1 \in [1, anim_frames + 1)
            else
                if anim.progress < #anim.frames then
                    anim.progress = anim.progress + G.real_dt * #anim.frames / anim.duration
                else
                    anim.is_active = false
                    anim.progress = 0
                end
            end
            --print(Multiverse.clamp(math.floor(anim.progress) + 1, 1, #anim.frames))
            love.graphics.setColor(1,1,1,1)
            love.graphics.draw(
                anim.image,
                anim.frames[Multiverse.clamp(math.floor(anim.progress) + 1, 1, #anim.frames)],
                Multiverse.anchors.x[anim.anchor.x_alignment] + (anim.anchor.y_offset or 0),
                Multiverse.anchors.y[anim.anchor.y_alignment] + (anim.anchor.y_offset or 0),
                anim.rotation,
                anim.x_scale,
                anim.y_scale,
                Multiverse.base_offsets.x[anim.anchor.x_alignment](anim),
                Multiverse.base_offsets.y[anim.anchor.y_alignment](anim),
                0,
                0
            )
        end
    end
end