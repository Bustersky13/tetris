#include "setup.agc"
#include "grid.agc"
#include "blocks.agc"
#include "control.agc"
#include "math.agc"
#include "engine.agc"

setup()
load_sprites()
setup_blocks()
ZeroGrid()
populate_stack()


do
	//playdance()
	if not game_over
		GameTick()
		ClearLines()
		DrawGrid()
		DrawPreview()
		DrawBlock(infos,0)
	else
		SetTextVisible(game_over_text,1)
		if GetRawKeyState(13)
			reset()
		endif
	endif
	sync()
loop
