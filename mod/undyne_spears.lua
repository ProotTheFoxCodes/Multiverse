Multiverse.undyne_spears = {}

local near_spear_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/near_spear.png"))
local near_spear_data = assert(love.image.newImageData(near_spear_file))
Multiverse.NEAR_SPEAR_SPRITE = assert(love.graphics.newImage(near_spear_data))

local far_spear_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/far_spear.png"))
local far_spear_data = assert(love.image.newImageData(far_spear_file))
Multiverse.FAR_SPEAR_SPRITE = assert(love.graphics.newImage(far_spear_data))

local reverse_spear_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/reverse_spear.png"))
local reverse_spear_data = assert(love.image.newImageData(reverse_spear_file))
Multiverse.REVERSE_SPEAR_SPRITE = assert(love.graphics.newImage(reverse_spear_data))

local green_soul_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/green_soul.png"))
local green_soul_data = assert(love.image.newImageData(green_soul_file))
Multiverse.GREEN_SOUL_SPRITE = assert(love.graphics.newImage(green_soul_data))

local soul_background_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/soul_background.png"))
local soul_background_data = assert(love.image.newImageData(soul_background_file))
Multiverse.SOUL_BACKGROUND_SPRITE = assert(love.graphics.newImage(soul_background_data))

---@class Multiverse.undyne_spear
---@field velocity number
---@field dir "l" | "r" | "u" | "d"
---@field is_reversed boolean
---@field r number
---@field theta number
---@field rotating boolean

Multiverse.in_undyne = nil
