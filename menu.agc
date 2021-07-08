global game_start as integer = 0
global tetris_text2 as integer = 0
global tetris_text1 as integer = 0
function place_menu()
	PlaceRawBlock(1,65535,0,3)
	PlaceRawBlock(1,65535,4,3)
	PlaceRawBlock(1,13107,8,3)
	
	PlaceRawBlock(5,119,2,9)
	PlaceRawBlock(5,119,5,9)
	
	tetris_text2 = CreateText("TETRIS")
	
	SetTextFont(tetris_text2,fonts)
	SetTextSize(tetris_text2,150)
	SetTextPosition(tetris_text2,20,131)
	SetTextColor(tetris_text2,255,255,255,255)
	
	
	tetris_text1 = CreateText("PLAY")
	
	SetTextFont(tetris_text1,fonts)
	SetTextSize(tetris_text1,100)
	SetTextPosition(tetris_text1,175,450)
	SetTextColor(tetris_text1,255,255,255,255)
endfunction


function check_click()
	
	box_corner_x = 2*bw+xo
	box_corner_y = 9*bh+yo
	box_w = 6*bw
	box_h = 2*bh
	
	mouse_x = GetPointerX()
	mouse_y = GetPointerY()
	
	
	if GetPointerPressed()
		if box_corner_x <= mouse_x and box_corner_x+box_w>=mouse_x
			if box_corner_y <= mouse_y and box_corner_y+box_h>=mouse_y
				game_start = 1
				DeleteText(tetris_text1)
				DeleteText(tetris_text2)
				reset()
			endif
		endif
	endif
	
	
endfunction
