global md as integer = 0
global mv as integer = 0
global press as integer = 0

function GameTick()
	
	if md = 0 and mv = 0
		md = GetMilliseconds()
		mv = GetMilliseconds()
	endif
	
	currtime = GetMilliseconds()
	
	rotate()
	
	if currtime - md > 800-780*GetRawKeyState(83)-cleared*4
		md = currtime
		movedown()
	endif
	
	if currtime - mv > 80
		mv = currtime
		move()
	endif
	
endfunction
