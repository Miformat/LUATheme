function love.load(args)
	math.randomseed(os.time())
	cakePlayer = require("player")
	cakeNPC = require("NPC")
	player = cakePlayer.new()
	player.img = love.graphics.newImage("img/cake.gif")
	NPCTab = {}
	timer = 0
	maxTime = 100
	actionTime = 10
end

function love.update(dt)
	timer = timer + 1
	if timer % maxTime == 0 then
		NewNPC = cakeNPC.new(0)
		NewNPC.move = love.math.random(4)
		table.insert(NPCTab,NewNPC)
	end
	for _,NPC in ipairs(NPCTab) do
		if NPC.move == 1 then
			NPC.x = NPC.x + NPC.speed
		elseif NPC.move == 2 then
			NPC.y = NPC.y - NPC.speed
		elseif NPC.move == 3 then
			NPC.x = NPC.x - NPC.speed
		elseif NPC.move == 4 then
			NPC.y = NPC.y + NPC.speed
		end
		if timer % actionTime == 0 then
			NPC.move = love.math.random(4)
		end
	end
	if love.keyboard.isDown("right") then
	   player.x = player.x + player.speed
	end
	if love.keyboard.isDown("left") then
		player.x = player.x - player.speed
	end
	if love.keyboard.isDown("down") then
		player.y = player.y + player.speed
	end
	if love.keyboard.isDown("up") then
		player.y = player.y - player.speed
	end
end

function love.draw()
	--love.graphics.rectangle("fill", i*tileSize, j*tileSize, tileSize, tileSize)
	love.graphics.draw(player.img, player.x, player.y)
	for _,NPC in ipairs(NPCTab) do
		love.graphics.draw(NPC.img, NPC.x, NPC.y)
	end
	--love.graphics.setColor(0, 0, 0)
end