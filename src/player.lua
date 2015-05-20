local player_mt = {}
local player = {}

function player.new()
	self = setmetatable({}, {__index = player_mt})
	
	self.x = 0
	self.y = 0
	self.truePX = 0
	self.truePY = 0
	self.name = "cake"
	self.speed = 10
	self.life = 3
	self.hurt = false
	self.img = love.graphics.newImage("img/cake.gif")
	self.height = 30
	self.width = 30
	
	return self
end

function player_mt:hit(hitTime)
	if hitTime % 10 == 0 then
		self.img = love.graphics.newImage("img/blank.gif")
	else
		self.img = love.graphics.newImage("img/cake.gif")
	end
end

function player_mt:detectCol(x1,y1,w1,h1,x2,y2,w2,h2)
	distX = (w1 + w2)/2
	distY = (h1 + h2)/2

	true1X = x1 + w1 / 2
	true1Y = y1 + h1 / 2
	
	true2X = x2 + w2 / 2
	true2Y = y2 + h2 / 2
	
	diffX = true1X - true2X
	diffY = true1Y - true2Y
	
	if diffX < 0 then
		diffX = diffX * -1
	end
	if diffY < 0 then
		diffY = diffY * -1
	end
	
	if diffX < distX and diffY < distY then
		return true
	else
		return false
	end	
end

return player