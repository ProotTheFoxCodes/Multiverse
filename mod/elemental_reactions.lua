Multiverse.ElementalReactions = {}
Multiverse.ReactionElements = {}

function Multiverse.ElementalReaction(args)
    local reaction = {}
end

function Multiverse.ReactionElement(args)
    local element = {}
    element.key = "e_" .. (SMODS.current_mod.prefix or "") .. args.key
end