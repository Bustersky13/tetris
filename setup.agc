
// Project: Tetris 
// Created: 2021-06-09

global none_sprite as integer = 0
global blue_sprite as integer = 0
global red_sprite as integer = 0
global yellow_sprite as integer = 0
global green_sprite as integer = 0
global orange_sprite as integer = 0
global purple_sprite as integer = 0
global cyan_sprite as integer = 0
global white_sprite as integer = 0
global dance_sprite as integer = 0
global dance_animation as integer = 0
global saber_dance_sprite as integer = 0
global saber_dance_animation as integer = 0
global id as integer = 0
global infos as integer[3]
global blocks as integer[8,4]
global block_stack as integer[7]
global stack_index = 0
global tick as integer = 0
global state as integer = 0
global game_over as integer = 0
global music_offset as float = 0
global speed_time as float = 0
global tetris_font as integer = 0
global game_over_text as integer = 0
global music as integer = 0
function setup()
	
	SetErrorMode(2)

	// set window properties
	SetWindowTitle( "Tetris" )
	SetWindowSize( 900, 800, 0 )
	SetWindowAllowResize( 0 ) // allow the user to resize the window

	// set display properties
	SetVirtualResolution( 1400, 1000 ) // doesn't have to match the window
	SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
	SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
	SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
	UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts
	
	music = LoadMusic("musics/song.mp3")
	music_sync()
	
	id = 1
	infos[0] = 5
	infos[1] = 0
	infos[2] = 0
	
	fonts = LoadFont("fonts/tetris.ttf")
	
	score_display = CreateText("0")
	SetTextSize(score_display,80)
	SetTextFont(score_display, fonts )
	SetTextPosition(score_display,630,0)
	SetTextColor(score_display,120,120,130,255)
	
	game_over_text = CreateText("GAME OVER")
	SetTextSize(game_over_text,93)
	SetTextFont(game_over_text, fonts )
	SetTextPosition(game_over_text,50,150)
	SetTextColor(game_over_text,255,255,0,255)
	SetTextBold(game_over_text,1)
	SetTextVisible(game_over_text,0)
	
	
endfunction

function music_sync()
	StopMusic()
	PlayMusic(music)
	music_offset = Timer()
endfunction

function reset()
	score = 0
	SetTextString(score_display,"0")
	SetTextVisible(game_over_text,0)
	ClearCrid()
	music_sync()
	speed_time = -music_offset
	id = 1
	infos[0] = 5
	infos[1] = 0
	infos[2] = 0
	stack_index = block_stack.length-1
	next_block()
	game_over = 0
	SetSpriteVisible(dance_animation,0)
	SetSpriteVisible(saber_dance_animation,0)
endfunction

function next_block()
	if block_stack[stack_index + 1] = 0
		populate_stack()
		stack_index = 0
	else
		stack_index = stack_index + 1
	endif
	id = block_stack[stack_index]
	if not GameOverCheck()
		game_over = 1
	endif
	if blocks[id,1] <> 0
		infos[2] = 1
	endif 
endfunction

function GameOverCheck()
	result = CheckColision(infos)
endfunction result

function display_stack()
	for x = 0 to block_stack.length - 1
		print(block_stack[x])
	next
endfunction

function populate_stack()
	flags = 0
	str as string = ""
	back as string = ""
	front as string = ""
	for x = 1 to block_stack.length
		indx = Random(0,len(str)-1)
		back = mid(str,1,indx)
		front = mid(str,indx+1,len(str) - indx)
		str = back + str(x) + front
	next
	for x = 0 to block_stack.length - 1
		block_stack[x] = val(mid(str,x+1,1))
	next
endfunction
	
function load_sprites()
	none_sprite = LoadImage("blocks/none.png")
	blue_sprite = LoadImage("blocks/blue.png")
	red_sprite = LoadImage("blocks/red.png")
	yellow_sprite = LoadImage("blocks/yellow.png")
	green_sprite = LoadImage("blocks/green.png")
	orange_sprite = LoadImage("blocks/orange.png")
	purple_sprite = LoadImage("blocks/purple.png")
	cyan_sprite = LoadImage("blocks/cyan.png")
	dance_sprite = LoadImage("dance/dance_1.png")
	saber_dance_sprite = LoadImage("saber_dance/dance_1.png")
	
	saber_dance_animation = createsprite(saber_dance_sprite)
	SetSpriteVisible(saber_dance_animation,0)
	
	dance_animation = createsprite(dance_sprite)
	SetSpriteVisible(dance_animation,0)
	
	for i = 2 to 12
		AddSpriteAnimationFrame(dance_animation,LoadImage("dance/dance_"+str(i)+".png"))
		AddSpriteAnimationFrame(saber_dance_animation,LoadImage("saber_dance/dance_"+str(i)+".png"))
	next
	
	SetSpriteSize(dance_animation,800,800)
	SetSpritePosition(dance_animation,480,0)
	
	SetSpriteSize(saber_dance_animation,420,420)
	SetSpritePosition(saber_dance_animation,640,160)
	
	SetImageTransparentColor(none_sprite,255,255,255)
	SetImageTransparentColor(blue_sprite,255,255,255)
	SetImageTransparentColor(red_sprite,255,255,255)
	SetImageTransparentColor(yellow_sprite,255,255,255)
	SetImageTransparentColor(green_sprite,255,255,255)
	SetImageTransparentColor(orange_sprite,255,255,255)
	SetImageTransparentColor(purple_sprite,255,255,255)
	SetImageTransparentColor(cyan_sprite,255,255,255)
	
endfunction



function playdance()
	
	tm as float
	tm = Timer()-music_offset

	curr_sprite = 0
	if tm >= 129.7
		curr_sprite = saber_dance_animation
		if not GetSpriteVisible(saber_dance_animation)
			SetSpriteVisible(dance_animation,0)
			StopSprite(dance_animation)
		
			SetSpriteVisible(saber_dance_animation,1)
			PlaySprite ( saber_dance_animation, 25, 1, 1, 12 )
		endif
	elseif tm >= 13.9
		curr_sprite = dance_animation
		if not GetSpriteVisible(dance_animation)
			
			SetSpriteVisible(saber_dance_animation,0)
			StopSprite(saber_dance_animation)
			
			SetSpriteVisible(dance_animation,1)
			PlaySprite( dance_animation, 25, 1, 1, 12 )
		endif
	endif
	if curr_sprite <> 0
		if speed_time-music_offset >= tm
			SetSpriteSpeed(curr_sprite,50)
		else
			SetSpriteSpeed(curr_sprite,25)
		endif
	endif
endfunction
