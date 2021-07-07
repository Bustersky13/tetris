global md as integer = 0
global mv as integer = 0
global press as integer = 0
function GameTick()
	
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
