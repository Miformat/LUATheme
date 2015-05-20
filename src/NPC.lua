local NPC_mt = {}
local NPC = {}
local enemy_mt = setmetatable({},{__index = NPC_mt})
local friendly_mt = setmetatable({},{__index = NPC_mt})

NPC_mt.x = 0
NPC_mt.y = 0
NPC_mt.speed = 2
NPC_mt.id = -1
NPC_mt.move = -1
NPC_mt.width = -1
NPC_mt.height = -1
NPC_mt.life = -1

NPC.img = {
	Fork = "img/fork.gif",
	Strawberry = "img/strawberry.gif",
	Obstacle = "img/chocolate.gif"
}

function NPC.new(id)
	local self = setmetatable({},{__index=NPC_mt})
	self.x = 0
	self.y = 0
	if id == 0 then
		self = newEnemy(id);
	elseif id == 1 then
		self = newFriendly(id);
	elseif id == 2 then
		self = newObstacle(id);
	end

	return self
end

function newEnemy(id)
	local self = setmetatable({},{__index = enemy_mt})
	self.width = 10
	self.height = 30
	self.img = love.graphics.newImage(NPC.img.Fork)
	self.id = id
	return self
end

function newFriendly(id)
	local self = setmetatable({},{__index = friendly_mt})
	self.img = love.graphics.newImage(NPC.img.Strawberry)
	self.x = love.math.random(800)
	self.y = love.math.random(600)
	self.width = 10
	self.height = 30
	self.id = id
	return self
end

function newObstacle(id)
	local self = setmetatable({},{__index = friendly_mt})
	self.img = love.graphics.newImage(NPC.img.Obstacle)
	self.width = 30
	self.height = 30
	self.id = id
	return self
end

return NPC