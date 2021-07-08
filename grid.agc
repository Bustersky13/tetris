#constant gw 10
#constant gh 20

#constant bw 60
#constant bh 60

#constant xo 20
#constant yo -100

global grid as integer[gw,gh]
global cleared as float = 0
global score as integer = 0
global score_display as integer = 0

function ZeroGrid()
	for x = 0 to gw - 1
		for y = 0 to gh - 1
			grid[x,y] = 0
			index = y*gw+x+1
			createsprite(index,none_sprite)
			SetSpriteSize(index,bw,bh)
			SetSpritePosition(index,x*bw + xo,y*bh + yo)
		next
	next
endfunction

function ClearGrid()
	for x = 0 to gw - 1
		for y = 0 to gh - 1
			grid[x,y] = 0
		next
	next
endfunction

function DrawGrid()
	for x = 0 to gw - 1
		for y = 0 to gh - 1
			index = y*gw+x+1
			SetSpriteImage(index,GetColor(grid[x,y]))
			if grid[x,y]
				SetSpriteColorAlpha(index,255)
			else
				SetSpriteColorAlpha(index,100)
			endif
		next
	next
endfunction
	
function DrawBlock(infs as integer[],preview)
	blk = blocks[id,infos[2]]
	color = GetColor(id)
	for y = 0 to 3
		for x = 0 to 3
			if BitIndex(blk,y*4+x) = 1
				index = (y+infs[1])*gw+x+infs[0]+1
				SetSpriteImage(index,color)
				if preview
					SetSpriteColorAlpha(index,150)
				else
					SetSpriteColorAlpha(index,255)
				endif
			endif
		next
	next
endfunction

function PlaceRawBlock(color_id,block,px,py)
	for y = 0 to 3
		for x = 0 to 3
			if BitIndex(block,y*4+x) = 1
				grid[x+px,y+py] = color_id
			endif
		next
	next
endfunction

function GetColor(color as integer)
	if color = 1
		image = purple_sprite
	elseif color = 2
		image = orange_sprite
	elseif color = 3
		image = blue_sprite
	elseif color = 4
		image = green_sprite
	elseif color = 5
		image = red_sprite
	elseif color = 6
		image = yellow_sprite
	elseif color = 7
		image = cyan_sprite
	else
		image = none_sprite
	endif
endfunction image

function ClearLines()
	offset = 0
	for y = gh - 1 to 0 step -1
		clear = 1
		for x = 0 to gw - 1
			if grid[x,y] = 0
				clear = 0
			endif
			grid[x,y+offset] = grid[x,y]
		next
		if clear = 1
			offset = offset + 1
		endif
	next
	if offset = 4
		speed_time = Timer()+0.8 //TETRIS!!!
	endif
	if offset > 0
		cleared = cleared + offset
		for y = 0 to offset - 1
			for x = 0 to gw - 1
				grid[x,y] = 0
			next
		next
		addscore(offset)
	endif
endfunction

function addscore(lines)
	if lines = 1
		score = score + 40
	elseif lines = 2
		score = score + 100
	elseif lines = 3
		score = score + 300
	else
		score = score + 1200
	endif
	SetTextString(score_display,str(score))
endfunction
	
function PlaceBlock(instant)
	curr as string = ""
	blk = blocks[id,infos[2]]
	if instant
		change as integer = 0
		while CheckColision(infos)
			change = 1
			infos[1] = infos[1] + 1
		endwhile
		if change
			infos[1] = infos[1] - 1
		endif
	endif
	for y = 0 to 3
		for x = 0 to 3
			if BitIndex(blk,y*4+x) = 1
				grid[x+infos[0],y+infos[1]] = id
			endif
		next
	next
endfunction

function DrawPreview()
		temp as integer[3]
		temp = infos
		for y = infos[1] to gh - 1
			temp[1] = y
			if not CheckColision(temp)
				if y-1 > infos[1]
					temp[1] = y - 1
					DrawBlock(temp,1)
				endif
				exit
			endif
		next
endfunction
