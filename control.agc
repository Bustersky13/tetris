/*
W   S   A   D   E   Q   R   T
87, 83, 65, 68, 69, 81, 82, 84

*/

global id as integer = 0
global infos as integer[3]
global state as integer = 0

function rotate()
	temp as integer[3]
	temp = infos
	o = temp[2]
	if GetRawKeyPressed(69)
		if blocks[id,o+1] = 0
			o = 0
		else
			o = o + 1
		endif
	elseif GetRawKeyPressed(81)
		if temp[2] > 0
			o = temp[2] - 1
		else
			for x = 3 to 0 step -1
				if blocks[id,x] <> 0
					o = x
					exit
				endif
			next
		endif
	endif
	temp[2] = o
	if CheckColision(temp)
		 infos = temp
	endif
endfunction
	
function move()
	temp as integer[3]
	temp = infos
	temp[0] = temp[0] + GetRawKeyState(68) - GetRawKeyState(65)	
	
	if CheckColision(temp)
		infos = temp
	endif
	
	if GetRawKeyState(87) and state
		state = 0
		PlaceBlock(1)
		infos[2] = 0
		infos[1] = 0
		infos[0] = 3
		next_block()
		md = GetMilliseconds()
	else
		state = 1-GetRawKeyState(87)
	endif
	
endfunction
	
function movedown()
	infos[1] = infos[1] + 1
	if CheckColision(infos) = 0
		infos[1] = infos[1] - 1
		PlaceBlock(0)
		infos[2] = 0
		infos[1] = 0
		infos[0] = 3
		next_block()
		md = GetMilliseconds()
	endif
endfunction

function BlockInsideGrid(gridw,gridh,infos as integer[],block as integer)
	inside = 1
	maxx = 0
	maxy = 0
	minx = -1
	miny = -1
	for y = 0 to 3
		for x = 0 to 3
			if BitIndex(block,y*4+x) = 1
				if minx > x or minx = -1
					minx = x
				endif
				if maxx < x
					maxx = x
				endif
				if miny > y or miny = -1
					miny = y
				endif
				if maxy < y
					maxy = y
				endif				
			endif
		next
	next	
endfunction infos[0]+minx>=0 and infos[1]+miny >=0 and infos[0]+maxx < gridw and infos[1]+maxy < gridh

function CheckColision(infos as integer[])
	blk = blocks[id,infos[2]]
	if BlockInsideGrid(grid.length,grid[0].length,infos,blk)
		move = 1
		bmax = 0
		curr as string = ""
		for y = 0 to 3
			for x = 0 to 3	
				if BitIndex(blk,y*4+x) = 1
					if grid[infos[0]+x,infos[1]+y] <> 0
						move = 0
						exit
					endif
				endif
			next
		next
	else
		move = 0
	endif
endfunction move

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
endfunction
