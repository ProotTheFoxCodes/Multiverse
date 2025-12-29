---@param card Card
---@param info_queue table
function Multiverse.transmute_info_queue(card, info_queue)
	if Multiverse.can_receive_transmutable(card) then
		local transmute_vars = {}
		if type(card.ability.extra.transmute_progress) == "table" then
			transmute_vars[#transmute_vars + 1] = card.ability.extra.transmute_progress.n
		else
			transmute_vars[#transmute_vars + 1] = card.ability.extra.transmute_progress
		end
		transmute_vars[#transmute_vars + 1] = card.config.center.transmute_req
		info_queue[#info_queue + 1] = {
			set = "Other",
			key = string.sub(card.config.center.key, 3) .. "_hint",
			vars = transmute_vars,
		}
	end
end

function Multiverse.increment_transmute_progress(card, amt, percent)
	if Multiverse.can_receive_transmutable(card) then
		if not amt then
			amt = math.floor(card.config.center.transmute_req * (percent or 0) / 100)
		end
		if type(card.ability.extra.transmute_progress) == "table" then
			card.ability.extra.transmute_progress.n = card.ability.extra.transmute_progress.n + amt
		else
			card.ability.extra.transmute_progress = card.ability.extra.transmute_progress + amt
		end
		Multiverse.transmute_check(card)
	end
end