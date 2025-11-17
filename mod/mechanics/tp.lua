function Multiverse.ease_TP(amt, args)
    if not G.GAME.blind then return end
    args = args or {}
    SMODS.calculate_context({
		--True if the amount of TP was changed.
		mul_TP_altered = true,
		amount = amt,
		--True if the change in TP came from a played hand.
		from_hand = args.from_magnum_opus,
	})
end