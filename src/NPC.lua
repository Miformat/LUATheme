local NPC_mt = {}
local NPC = {}
local enemy_mt = setmetatable({},{__index = NPC_mt})
local friendly_mt = setmetatable({},{__index = NPC_mt})

NPC_mt.x = 0
NPC_mt.y = 0
NPC_mt.speed = 5
NPC_mt.id = -1
NPC_mt.move = -1

NPC.img = {
	Fork = "img/fork.gif",
	Strawberry = "image/strawberry.gif"
}

function NPC.new(id)
	local self = setmetatable({},{__index=NPC_mt})
	self.x = 0
	self.y = 0
	self.id = id
	if id == 0 then
		self = newEnemy();
	else
		self = newFriendly();
	end

	return self
end

function newEnemy()
	local self = setmetatable({},{__index = enemy_mt})
	self.x = love.math.random(800)
	self.y = love.math.random(600)
	self.img = love.graphics.newImage(NPC.img.Fork)
	return self
end
function newFriendly()
	local self = setmetatable({},{__index = friendly_mt})
	self.img = love.graphics.newImage(NPC.img.Strawberry)
	return self
end

return NPC