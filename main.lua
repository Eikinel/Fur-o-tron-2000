-- Shapeshifting game --

function love.load()
   -- Sprites --

   chatbox = love.graphics.newImage("sprites/chatbox.png")

   versus = {
      name = "Versus",
      happy = love.graphics.newImage("sprites/versus/happy.png"),
      laughing = love.graphics.newImage("sprites/versus/laughing.png"),
      embarrassed = love.graphics.newImage("sprites/versus/embarrassed.png"),
      surprised = love.graphics.newImage("sprites/versus/surprised.png")
   }
   
   -- Font --

   font = {
      text = love.graphics.newFont("font/Gilles_Handwriting.ttf", 50),
      name = love.graphics.newFont("font/Gilles_Handwriting.ttf", 40)
   }

   -- Texte --

   dialogue = {
      text = {
	 { versus.name, versus.happy, "Salut l'ami ! Je suis Versus, je serai ton visagiste personnel pour cette session.", {}, 2},
	 { versus.name, versus.laughing, "Bien, nous allons pouvoir commencer !\n\nJe vais te poser quelques questions, ton avatar en furry apparaitra a la fin ! Es-tu pret ?" , {"Oui", "Non"}, {4, 3}},
	 { versus.name, versus.surprised, "Oh, c'est bien dommage... A une autre fois alors !", {}, function() love.event.quit() end},
	 { versus.name, versus.happy, "Super ! Voici la premiere question.\n\nEs-tu un garcon ou une fille ?", {"Un garcon", "Une fille"}, {5, 100}},
	 { versus.name, versus.happy, "Donc tu es un garcon. C'est bon a savoir ! J'imagine que les chattes chaudes sont ta passion ?", {}, 1}
      }
   }
   
   text = {
      name = dialogue.text[1][1],
      sprite = dialogue.text[1][2],
      text = dialogue.text[1][3],
      x = 280,
      y = 750,
      n = 1,
      speed = 30,
      collide = 1350
   }
   noxt = 1
   gamestate = "normal"
   user_choice = 0
end

function debog()
   love.graphics.print(gamestate, 10, 10)
   love.graphics.print(noxt, 10, 50)
   love.graphics.print(user_choice, 10, 110)
end

function love.update(dt)
   if (text.n <= #text.text) then
      local char = text.text:sub(text.n, text.n)
      
      if (char == "." or char == "," or char == "?" or char == "!") then
	 text.n = text.n + dt * (text.speed / 10)
      else
	 text.n = text.n + dt * text.speed
      end
   end
end
   
function love.keypressed(key, isrepeat)
   if (key == "escape") then
      love.event.quit()
   end
   
   if (key == "space") then
      text.speed = text.speed * 3
   end

   if (key == "return" and text.n > #text.text) then
      if (gamestate == "normal") then
	 noxt = dialogue.text[noxt][5]
      else
      	 noxt = dialogue.text[noxt][5][user_choice + 1]
      end
      if (type(noxt) == "function") then
	 noxt = noxt()
      end
      if (dialogue.text[noxt][4][1]) then
	 gamestate = "choice"
	 user_choice = 0
      elseif (dialogue.text[noxt][4][1] == nil) then
	 gamestate = "normal"
      end

      changeText(dialogue.text[noxt][1], dialogue.text[noxt][3], dialogue.text[noxt][2], 280, 750, 1, 30)
   end

   if (gamestate == "choice") then
      if key == "down" then
	 user_choice = user_choice + 1
      elseif key == "up" then
	 user_choice = user_choice - 1
      end
      user_choice = user_choice % #dialogue.text[noxt][5]
   end

end

function love.keyreleased(key)
   if (key == "space") then
      text.speed = text.speed / 3
   end
end

function love.draw() 
   debog()
   love.graphics.draw(text.sprite, 1200, 238, 0, 0.7)
   love.graphics.draw(chatbox, 200, 650, 0, 0.9)
   love.graphics.setFont(font.name)
   love.graphics.printf(text.name, 375, 665, 100, "center", 0, 1.3, 1)
   love.graphics.setFont(font.text)
   love.graphics.printf(text.text:sub(1, math.floor(text.n)), text.x, text.y, text.collide)
   if (gamestate == "choice") then
      local x, y = 900, 650 / (#dialogue.text[noxt][4] + 1)
      for i = 1, #dialogue.text[noxt][4] do
	 love.graphics.printf(dialogue.text[noxt][4][i], x, y + (i * 30), 200, "center")
      end
   end
end

function changeText(_name, _text, _sprite, _x, _y, _n, _speed)
   text.name = _name
   text.text = _text
   text.sprite = _sprite
   text.x = _x
   text.y = _y
   text.n = _n
   speed = _speed
   collide = 1400
   user_choice = 0
end

-- function multipleChoices(key, choices, index)
--    if (key == "down") then
--       user_choice = (user_choice + 1) % #choices
--    end
--    return (index[user_choice + 1])
-- end
