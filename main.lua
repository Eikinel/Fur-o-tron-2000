-- Fur-o-tron game --

local utf8 = require("utf8")

function love.load()
   -- Sprites --

   background = love.graphics.newImage("sprites/background.jpg")
   chatbox = love.graphics.newImage("sprites/chatbox.png")

   versus = {
      name = "Versus",
      color = {192, 229, 127},
      happy = love.graphics.newImage("sprites/versus/happy.png"),
      laughing = love.graphics.newImage("sprites/versus/laughing.png"),
      embarrassed = love.graphics.newImage("sprites/versus/embarrassed.png"),
      surprised = love.graphics.newImage("sprites/versus/surprised.png")
   }
   
   -- Font --

   font = {
      getname = love.graphics.newFont("font/Gilles_Handwriting.ttf", 60),
      text = love.graphics.newFont("font/Gilles_Handwriting.ttf", 50),
      name = love.graphics.newFont("font/Gilles_Handwriting.ttf", 40),
      choice = love.graphics.newFont("font/Gilles_Handwriting.ttf", 30),
   }

   -- Texte --

   username = ""

   user = {
      color = {255, 255, 255},
      gender = 0,
      face_shape = 0,
      eye = 0,
      mouth = 0,
      eyebrow_pos = 0,
      hair = 0,
      hair_color = 0,
      nose = 0,
      
   }
   
   dialogue = {
      text = {
	 { versus.name, versus.happy, versus.color, "Salut l'ami ! Je suis Versus, je serai ton visagiste personnel pour cette session.\n\nQuel est ton nom ?", {}, 2},
	 { versus.name, versus.laughing, versus.color, "@@username ? C'est un joli nom !\nBien, nous allons pouvoir commencer !\nJe vais te poser quelques questions, ton avatar en furry apparaitra a la fin ! Es-tu pret ?" , {"Oui", "Non"}, {4, 3}},
	 { versus.name, versus.surprised, versus.color, "Oh, c'est bien dommage... A une autre fois alors !", {}, function() love.event.quit() end},
	 { versus.name, versus.happy, versus.color, "Super ! Voici la premiere question.\n\nEs-tu un garcon ou une fille ?", {"Un garcon", "Une fille"}, function() user.gender = user_choice return (5 + user_choice) end},
	   
	 { "@@username", nil, user.color, "Sans contrefacon, je suis un garcon !", {}, 7},
	 { "@@username", nil, user.color, "Je suis une fille. G-A-R-C-O-N. Une fille.", {}, 8},
	 { versus.name, versus.happy, versus.color, "Donc tu es un garcon. C'est bon a savoir !\n\nEntre male on se comprend.", {}, 9},
	 { versus.name, versus.happy, versus.color, "Donc tu es une fille. C'est bon a savoir !\n\nJe sens qu'on va bien s'entendre tous les deux.", {}, 9},
	 
	 { versus.name, versus.happy, versus.color, "Mais dis moi, physiquement parlant, t'es plutot du genre bucheron canadien ou petit bambou que je pourrais delicieusement croquer ?", {"Je suis un OURS BIEN VIRIL !", "On m'appelle \"Appetit d'oiseau\"", "Pile dans la moyenne ! Un vrai felin agile."}, function() user.face_shape = user_choice return (10 + user_choice) end},

	 { "@@username", nil, user.color, "Tu m'as bien regarde ? J'ai l'air d'une p'tite brindille ?\nJe \"pese\" dans le milieu, haha !", {}, 13},
	 { "@@username", nil, user.color, "Ne me mange pas trop vite s'il te plait, j'ai encore beaucoup a vivre...", {}, 13},
	 { "@@username", nil, user.color, "Je suis dans le vert ! Pas trop gros pour passer dans le terrier du lapin mais je passe difficilement quand meme !", {}, 13},
	 { versus.name, versus.happy, versus.color, "Hum, je vois.\nLe plus important quand on parle de son poids n'est pas de savoir ce que les autres pensent de toi mais d'etre bien dans ta peau.", {}, 14},
	 { versus.name, versus.laughing, versus.color, "D'ailleurs, le savais-tu ? Tous les ours ne sont pas gros. La race des ours a collier font entre 50 et 100kg pour la femelle tandis que les ours blanc peuvent aller jusqu'a 700kg et plus chez le male !", {}, 15},
	 { versus.name, versus.happy, versus.color, "Bon, je te rassure, en tant qu'ours antropomorphe, je pese pour ma part 90kg, je ne risque pas de t'ecraser. Et encore moins de te mordre.", {}, 16},
	 { versus.name, versus.embarrassed, versus.color, "Oups, mais je m'egare... Question suivante !", {}, 17},
	 
	 { versus.name, versus.happy, versus.color, "De maniere sociale, comment te sens-tu avec ton entourage ?", {"Si seulement les free hugs ne se faisait pas qu'en convention...", "Si tu me touches, garre aux morsures !", "Je... Je ne parle pas beaucoup aux gens."}, function() user.eye = user_choice return (18 + user_choice) end},

	 { "@@username", nil, user.color, "Si seulement les free hugs ne se faisait pas qu'en convention... Tiens d'ailleurs, viens par la mon p'tit ourson !", {}, 21},
	 { "@@username", nil, user.color, "Si tu me touches, garre aux morsures ! Je peux me mettre en colere tres facilement, alors mieux vaut ne pas trop me deranger.", {}, 22},
	 { "@@username", nil, user.color, "Je... Je ne parle pas beaucoup aux gens. C'est deja enorme pour moi d'etre venu te parler, je suis de nature plutot timide.", {}, 23},
	 { versus.name, versus.embarrassed, versus.color, "Aaah... Ahem. Bon, un petit calin alors et on reprend.", {}, 24},
	 { versus.name, versus.surprised, versus.color, "Wow ! OK, je tacherai de m'en souvenir, je ne voudrais pas entacher notre amitie naissante.", {}, 24},
	 { versus.name, versus.happy, versus.color, "Je comprends, ca peut faire peur d'aller vers les gens. C'est super que tu viennes me parler, j'adore discuter avec des gens gentils. La communication est la meilleur facon de se comprendre !", {}, 24},

	 { versus.name, versus.happy, versus.color, "Troisieme question !\nPour moi, l'humour est une chose essentielle. Il nous fait nous sentir bien et vivant, en plus de partager un moment de detente entre amis. Mais pour toi, qu'en est-il ?", {"Je suis le roi des blagues !", "Je ne suis pas du genre bon public.", "Rigoler, c'est bien !"}, function() user.mouth = user_choice user.eyebrow_pos = user_choice return (25 + user_choice) end},

	 { "@@username", nil, user.color, "Carambar, embauchez-moi !\nNon, vraiment, sans rire, rire c'est ma passion. Rire ca fait du bien, alors pourquoi s'en priver ?", {}, 28},
	 { "@@username", nil, user.color, "Malheureusement, ce n'est pas mon cas. Je rigole peu, tant que je vis ca me suffit amplement.", {}, 29},
	 { "@@username", nil, user.color, "C'est bon de rire ! Toutefois il faut savoir etre serieux. J'aime bien rire et faire rire, mais sans plus.", {}, 30},
	 { versus.name, versus.laughing, versus.color, "Haha oui ! C'est le genre d'etat d'esprit que j'aime bien voir !\nAu fait, tu la connais celle-la ?", {}, 31},
	 { versus.name, versus.happy, versus.color, "Soit, apres tout nous vivons comme on veut. Si ca te convient comme ca je n'ai aucune raison de vouloir te faire changer d'avis.", {}, 35},
	 { versus.name, versus.happy, versus.color, "C'est vrai, tu as bien raison. Tout le temps faire le clown peut vite deranger certaines personnes autour de toi. Rire, oui, mais dans le respect !", {}, 35},
	 { versus.name, versus.happy, versus.color, "Quel est le comble pour un dentiste ?\n........\n........", {}, 32},
	 { versus.name, versus.laughing, versus.color, "C'est de trouver sa femme au lit avec un MALE DEDANS !\n\nHAHAHAHAHAHA !", {}, 33},
	 { "@@username", nil, user.color, "...\nHAHAHA ! Oh mon dieu elle etait terrible celle-la ! Apres cet interrogatoire, il faudra vraiment que je te raconte tout ce que je connais !", {}, 34},
	 { versus.name, versus.laughing, versus.color, "Avec plaisir mon ami @@username !", {}, 35},

	 { versus.name, versus.happy, versus.color, "Allez, question suivante ! Numero quatre.\nDe quelle taille son tes cheveux ?", {"Tout court.", "Long, long, long.", "Mi-long, a peu pres jusqu'au epaules.", "Je n'en ai pas."}, function() user.hair = user_choice return (36 + user_choice) end},
	 { "@@username", nil, user.color, "Ils sont plutot court. Un peu de poil sur le caillou c'est juste ce qu'il faut !", {}, 41},
	 { "@@username", nil, user.color, "Je l'aime longue et lourde.\nWait, je parlais de ma chevelure, coquin.", {}, 41},
	 { "@@username", nil, user.color, "Petit ou grand cheveux... Foutaises ! C'est so 2012.\nMi-long, ca c'est le style !", {}, 41},
	 { "@@username", nil, user.color, "Je ne fais pas les choses a moitie. C'est tout ou rien !\nBah pour moi j'ai choisi rien. Je suis a 200% pour la fourrure, mais des poils glabres comme les humains... Berk !", {}, 40},
	 { versus.name, versus.laughing, versus.color, "La fourrure, c'est tout ce qu'il y a de mieux !\nC'est doux, c'est chaud, c'est beau. Que demander de plus ?", {}, 42},
	 { versus.name, versus.happy, versus.color, "Sympa ! C'est un style qui se vaut.", {}, 42},

	 { versus.name, versus.happy, versus.color, "Dans la foulee, que peux-tu me dire sur la couleur de tes cheveux ?", {"Ils sont noirs", "Ils sont marrons", "Ils sont blonds", "Ils sont blancs", "Ils sont roux", "Ils sont bleus", "Ils sont verts", "Ils sont violets", "Ils sont pas"}, function() user.hair_color = user_choice return (43 + user_choice) end},
	 { "@@username", nil, user.color, "Ils sont noirs comme la nuit.", {}, 52},
	 { "@@username", nil, user.color, "Ils sont marrons comme ta fourrure.", {}, 52},
	 { "@@username", nil, user.color, "Ils sont blonds comme les bles.", {}, 52},
	 { "@@username", nil, user.color, "Ils sont blancs comme neige.", {}, 53},
	 { "@@username", nil, user.color, "Ils sont roux. Et j'ai une ame.", {}, 52},
	 { "@@username", nil, user.color, "Ils sont bleus comme... du bleu.", {}, 53},
	 { "@@username", nil, user.color, "Ils sont verts, et non, je n'ai pas essaye de faire du Cetelem.", {}, 53},
	 { "@@username", nil, user.color, "Ils sont violets. (Couleur preferee du dev, respectez !)", {}, 53},
	 { "@@username", nil, user.color, "Ils sont pas, je suis chauve !", {}, 54},
	 { versus.name, versus.happy, versus.color, "C'est une belle couleur ! J'aime beaucoup.", {}, 55},
	 { versus.name, versus.surprised, versus.color, "Oh tiens ! C'est pas commun comme couleur de cheveux ca !\nJ'ai hate de voir ce que ca va donner sur ton avatar...", {}, 55},
	 { versus.name, versus.embarrassed, versus.color, "Oups, question debile du coup, il est vrai.\nVite, passons a autre chose avant que j'ai l'air trop bete !", {}, 55},
	 { versus.name, versus.happy, versus.color, "Encore une petite anecdote ursidesque.\nSavais-tu que les ours blancs n'etaient pas vraiment blanc ? En realite, ses poils sont non pigmentes, translucide et creux. L'impression de blanc est uniquement du a la reflexion de la lumiere sur la partie interne du poil. Les ours blancs sont memes noir de peau !", {}, 56},
	 { versus.name, versus.embarrassed, versus.color, "Mais je m'egare encore. Decidement, je n'arreterai jamais de parler. Je suis une vraie pipelette !", {}, 57},
	 
	 { versus.name, versus.happy, versus.color, "Un... deux... trois... SIX ! Question numero six ! C'est que je perds le fil moi.\nParmi toutes ces familles d'animaux, lequel preferes-tu ?", {"Le felin.", "Le canide. (renard inclus)", "Les ursides.", "Les rapaces.", "Les porcides.", "Les equides.", "Le DRAGON."}, function() user.nose = user_choice return (58 + user_choice) end},
	 { "@@username", nil, user.color, "Les felins, ce sont mes boules de poils favorites.\nAvec leurs petits coussinets tout mignon, leur petite tete quand ils sont a la recherche de calins, leur facon de se frotter a toi...\nAaaah, je foooonds !", {}, 64},
	 { "@@username", nil, user.color, "Les canides, ils sont vraiment top ! Que ce soit la loyaute du chien ou la sauvagerie du loup ou meme la mignonitude du renard, ils ont tout pour plaire ces animaux !", {}, 65},
	 { "@@username", nil, user.color, "Les tous gros tout mignon nounours comme toi ! De toutes les couleurs ou de toutes les tailles, ils me font craquer. J'ai juste envie de leur faire un gros calin tout poilu !\n(Bon choix, joueur, bon choix. - Eikinel, The Dev)", {}, 66},
	 { "@@username", nil, user.color, "Les aigles, les pyguarges, les hiboux. Ces petits animaux a plumes ont tout ce qu'il y a de plus majestueux. Rapidite, precision et mignonnerie, ce sont de loin les meilleurs !", {}, 67},
	 { "@@username", nil, user.color, "Les porcides bien sur ! Le sanglier avec ses belles defenses, qui ne recule devant rien. Ou meme le porc avec ses manieres ! Je les adoooooooooooore !", {}, 68},
	 { "@@username", nil, user.color, "Les equides, il n'y a que ca de vrai ! Se balader sur son dada, l'elever et le dresser... Plus qu'un animal, c'est un ami fidele qui me comprend !", {}, 68},
	 { "@@username", nil, user.color, "Ils ont beau etre legendaires, je surkiffe les D R A G O N S. Il n'y a pas plus classe que ca ! Qui n'a jamais reve de voler sur le dos d'un dragon hein ? Qui ? Personne ! C'est normal, ce sont les meilleurs. Imposant et terriblement attirant, voila ce que j'aime !", {}, 68},
	 { versus.name, versus.happy, versus.color, "Ooooh un cat lover ! C'est vrai qu'ils sont mignons. Un classique qui marche a tous les coups !", {}, 76},
	 { versus.name, versus.laughing, versus.color, "Oh oui ! Un beau husky ou un petit renard comme RonRon (foxialzabul sur YouTube !), c'est teeeellement mignon !\nJ'ai un pote furry husky, Kouya. C'est une vraie creme !", {}, 76},
	 { versus.name, versus.embarrassed, versus.color, "Aaaah... Ah oui ?\nSi au moins quelqu'un me trouve attirant alors je suis content. Les calins, c'est une vraie drogue pour moi !", {}, 76},
	 { versus.name, versus.happy, versus.color, "Un animal a plumes donc ! Je les adore aussi, leur petit bec et leurs grandes ailes me font craquer. Pour sur que si j'en avais un je l'aurais deja pet depuis longtemps !", {}, 76},
	 { versus.name, versus.happy, versus.color, "Ce n'est pas commun ca ! Ce que j'aime le plus chez les sangliers, ce sont leurs defenses. Iozen, une connaissance a moi, est un sacre champion. Il est respecte de tous, et c'est quelqu'un de formidable !\n(Bakemono no Ko, allez voir le film !)", {}, 76},
	 { versus.name, versus.happy, versus.color, "Allez hu ! C'est beau un cheval. Vraiment tres intelligent !\nLe seul cheval que je connaisse est un peu arrogant sur les bords, mais je sais bien qu'ils ne sont pas tous comme ca.\n(P.S : Joue a Morenatsu, @@username !)", {}, 76},
      }
   }
   
   text = {
      name = dialogue.text[1][1],
      sprite = dialogue.text[1][2],
      color = dialogue.text[1][3],
      text = dialogue.text[1][4],
      x = 280,
      y = 750,
      n = 1,
      speed = 30,
      collide = 1350
   }

   -- Global variables --
   
   noxt = 1
   gamestate = "entername"
   user_choice = 0
   blink = 0
   wrong = false
   debog_bool = false
end

function debog()
   if (debog) then
      love.graphics.setFont(font.text)
      love.graphics.print("Gamestate = "..gamestate, 10, 10)
      love.graphics.print("Noxt = "..noxt, 10, 60)
      love.graphics.print("User_choice = "..user_choice, 10, 110)
      love.graphics.print("Username = "..username, 10, 160)
      love.graphics.setFont(font.choice)
      love.graphics.print("Gender = "..user.gender, 10, 210)
      love.graphics.print("Face shape = "..user.face_shape, 10, 240)
      love.graphics.print("Eye = "..user.eye, 10, 270)
      love.graphics.print("Mouth = "..user.mouth, 10, 300)
      love.graphics.print("Eyebrow_pos = "..user.eyebrow_pos, 10, 330)
      love.graphics.print("Hair = "..user.hair, 10, 360)
      love.graphics.print("Hair color = "..user.hair_color, 10, 390)
      love.graphics.print("Nose = "..user.nose, 10, 420)
   end
end

function love.update(dt)
   if (text.n <= #text.text) then
      blink = 0
      local char = text.text:sub(text.n, text.n)
      
      if (char == "." or char == "," or char == "?" or char == "!") then
	 text.n = text.n + dt * (text.speed / 10)
      else
	 text.n = text.n + dt * text.speed
      end
   else
      blink = (blink + dt) % 1
   end
end
   
function love.keypressed(key, isrepeat)
   if (key == "f1") then
      debog_bool = not debog_bool
   end
   
   if (key == "escape") then
      love.event.quit()
   end
   
   if (key == "space") then
      text.speed = text.speed * #text.text--3
   end

   if (key == "return" and text.n > #text.text) then
      if #username < 2 then
	 wrong = true
      else
	 wrong = false
	 if (gamestate == "normal" or gamestate == "entername" or type(dialogue.text[noxt][6]) == "function") then
	    noxt = dialogue.text[noxt][6]
	 else
	    noxt = dialogue.text[noxt][6][user_choice + 1]
	 end
	 if (type(noxt) == "function") then
	    noxt = noxt()
	 end
	 if (noxt == 1) then
	    gamestate = "entername"
	 elseif (dialogue.text[noxt][5][1]) then
	    gamestate = "choice"
	    user_choice = 0
	 elseif (dialogue.text[noxt][5][1] == nil) then
	    gamestate = "normal"
	 end

      changeText(dialogue.text[noxt][1], dialogue.text[noxt][3], dialogue.text[noxt][4], dialogue.text[noxt][2], 280, 750, 1, 30)
      end
   end

   if (gamestate == "choice") then
      if key == "down" then
	 user_choice = user_choice + 1
      elseif key == "up" then
	 user_choice = user_choice - 1
      end
      user_choice = user_choice % #dialogue.text[noxt][5]
   end

   if (gamestate == "entername" and text.n > #text.text) then
      if key == "backspace" then
	 local byteoffset = utf8.offset(username, -1)

	 if byteoffset then
	    username = username:sub(1, byteoffset -1)
	 end
      end
   end
end

function love.keyreleased(key)
   if (key == "space") then
      text.speed = text.speed / #text.text--3
   end
end

function love.textinput(t)
   if (gamestate == "entername" and text.n > #text.text) then
      if (#username < 16) then
	 if ((t >= "a" and t <= "z") or (t >= "A" and t <= "Z") or t == "-") then
	    username = string.gsub("-"..username..t, "(-[a-zA-Z])([^-]*)", function (a, b) b = b or "" return string.upper(a)..string.lower(b) end):sub(2, -1)
	 end
      end
   end
end

function love.draw() 
   love.graphics.draw(background, 0, 0)
   if not (text.sprite == nil) then 
      love.graphics.draw(text.sprite, 1200, 238, 0, 0.7)
   end
   if (debog_bool) then
      debog()
   end
   love.graphics.draw(chatbox, 200, 650, 0, 0.9)
   love.graphics.setFont(font.name)
   love.graphics.printf({text.color, text.name}, 250, 665, 300, "center", 0, 1.3, 1)
   if (#text.text < 300) then
      love.graphics.setFont(font.text)
   else
      love.graphics.setFont(font.name)
   end
   love.graphics.printf({text.color, text.text:sub(1, math.floor(text.n))}, text.x, text.y, text.collide)

   if (gamestate == "normal" and text.n > #text.text and blink > 0.5) then
      love.graphics.print(">", text.collide, 950)
   end

   if (gamestate == "entername" and text.n > #text.text) then
      love.graphics.setFont(font.getname)
      love.graphics.printf("Ton nom est :\n" .. username, 500, 300, 600, "center")
      love.graphics.setFont(font.text)
      if (wrong) then
	 love.graphics.printf({{222, 17, 17}, "Ton nom doit contenir au moins deux caracteres !"}, 500, 475, 600, "center")
      end
   end
   
   if (gamestate == "choice" and text.n > #text.text) then
      local x, y = 500, (650 / (#dialogue.text[noxt][5] + 1))
      if (#dialogue.text[noxt][5] <= 2) then
	 love.graphics.setFont(font.getname)
      elseif (#dialogue.text[noxt][5] <= 6) then
	 love.graphics.setFont(font.name)
      else
	 love.graphics.setFont(font.choice)
      end
      for i = 1, #dialogue.text[noxt][5] do
	 if (user_choice == i - 1) then
	    love.graphics.printf({{161, 3, 185}, dialogue.text[noxt][5][i]}, x, y + (650 / (#dialogue.text[noxt][5] + 1)) * (i - 1), 600, "center")
	 else
	    love.graphics.printf(dialogue.text[noxt][5][i], x, y + (650 / (#dialogue.text[noxt][5] + 1)) * (i - 1), 600, "center")
	 end
      end
   end
end

function changeText(_name, _color, _text, _sprite, _x, _y, _n, _speed)
   text.name = myString(_name)
   text.color = _color
   text.text = myString(_text)
   text.sprite = _sprite
   text.x = _x
   text.y = _y
   text.n = _n
   speed = _speed
   user_choice = 0
end

function myString(str)
   return string.gsub(str, "@@([a-zA-Z_][_a-zA-Z0-9]*)", function (a) return _G[a] or "@@"..a end)
end
