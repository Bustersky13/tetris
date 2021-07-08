global game_start as integer = 0
global tetris_title as integer = 0
global tetris_option_1 as integer = 0
global tetris_option_2 as integer = 0
global tetris_back as integer = 0
global tetris_sound_name as integer = 0
function place_menu()
	ClearGrid()
	
	PlaceRawBlock(1,65535,0,3)
	PlaceRawBlock(1,65535,4,3)
	PlaceRawBlock(1,13107,8,3)
	
	PlaceRawBlock(5,119,2,9)
	PlaceRawBlock(5,119,5,9)
	
	PlaceRawBlock(6,119,2,12)
	PlaceRawBlock(6,119,5,12)
	
	tetris_title = CreateText("TETRIS")
	
	SetTextFont(tetris_title,fonts)
	SetTextSize(tetris_title,150)
	SetTextPosition(tetris_title,20,131)
	SetTextColor(tetris_title,255,255,255,255)
	
	
	tetris_option_1 = CreateText("PLAY")
	
	SetTextFont(tetris_option_1,fonts)
	SetTextSize(tetris_option_1,100)
	SetTextPosition(tetris_option_1,175,450)
	SetTextColor(tetris_option_1,255,255,255,255)
	
	tetris_option_2 = CreateText("MEDIA")
	
	SetTextFont(tetris_option_2,fonts)
	SetTextSize(tetris_option_2,100)
	SetTextPosition(tetris_option_2,160,632)
	SetTextColor(tetris_option_2,0,0,0,255)
	
	tetris_back = CreateText("BACK")
	
	SetTextFont(tetris_back,fonts)
	SetTextSize(tetris_back,75)
	SetTextPosition(tetris_back,28,1005)
	SetTextColor(tetris_back,0,0,0,255)
	SetTextVisible(tetris_back,0)
	
	tetris_sound_name = CreateText("techno - tetris (remix)")
	
	SetTextFont(tetris_sound_name,fonts)
	SetTextSize(tetris_sound_name,35)
	SetTextPosition(tetris_sound_name,45,632)
	SetTextColor(tetris_sound_name,255,255,255,255)
	SetTextVisible(tetris_sound_name,0)
	
endfunction

function show_menu()
	
	ClearGrid()
	
	PlaceRawBlock(1,65535,0,3)
	PlaceRawBlock(1,65535,4,3)
	PlaceRawBlock(1,13107,8,3)
	
	PlaceRawBlock(5,119,2,9)
	PlaceRawBlock(5,119,5,9)
	
	PlaceRawBlock(6,119,2,12)
	PlaceRawBlock(6,119,5,12)
	
	SetTextVisible(tetris_title,1)
	SetTextVisible(tetris_option_1,1)
	SetTextVisible(tetris_option_2,1)
	SetTextVisible(tetris_back,0)
	SetTextVisible(tetris_sound_name,0)
	
	DrawGrid()
endfunction


function check_click()
	
	box_corner_x = 2*bw+xo
	box_corner_y = 9*bh+yo
	box_w = 6*bw
	box_h = 2*bh
	
	mouse_x = GetPointerX()
	mouse_y = GetPointerY()
	
	
	if GetPointerPressed()
		if GetTextVisible(tetris_option_1)
			if box_corner_x <= mouse_x and box_corner_x+6*bw>=mouse_x
				if box_corner_y <= mouse_y and box_corner_y+2*bh>=mouse_y
					game_start = 1
					SetTextVisible(tetris_title,0)
					SetTextVisible(tetris_option_1,0)
					SetTextVisible(tetris_option_2,0)
					SetTextVisible(tetris_back,0)
					SetTextVisible(tetris_sound_name,0)
					reset()
				elseif box_corner_y+3*bh <= mouse_y and box_corner_y+5*bh>=mouse_y
					show_media()
				endif
			endif
		elseif GetTextVisible(tetris_back)
			if box_corner_x-2*bw <= mouse_x and box_corner_x+2*bw>=mouse_x
				if box_corner_y+9*bh  <= mouse_y and box_corner_y+11*bh>=mouse_y
					SetSpriteVisible(saber_dance_animation,0)
					StopSprite(saber_dance_animation)
					SetSpriteVisible(dance_animation,0)
					StopSprite(dance_animation)
					show_menu()
				endif
			endif
		endif
	endif
	
	if GetTextVisible(tetris_back)
		if mod(Timer(),4) < 2
			if not GetSpriteVisible(dance_animation)
				SetSpriteVisible(saber_dance_animation,0)
				StopSprite(saber_dance_animation)	
				SetSpriteVisible(dance_animation,1)
				PlaySprite( dance_animation, 25, 1, 1, 12 )
			endif
		else
			if not GetSpriteVisible(saber_dance_animation)
				SetSpriteVisible(dance_animation,0)
				StopSprite(dance_animation)
				SetSpriteVisible(saber_dance_animation,1)
				PlaySprite( saber_dance_animation, 25, 1, 1, 12 )
			endif
		endif
	endif
	
endfunction

function show_media()
	ClearGrid()
	PlaceRawBlock(7,255,0,18)
	
	for x = 1 to 7
		PlaceRawBlock(x,1,x+1,9)
	next
	
	
	SetTextVisible(tetris_title,0)
	SetTextVisible(tetris_option_1,0)
	SetTextVisible(tetris_option_2,0)
	SetTextVisible(tetris_sound_name,1)
	SetTextVisible(tetris_back,1)
	DrawGrid()
endfunction
