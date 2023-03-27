extends MeshInstance

export var text = ''
export var comment = ''

var check = true

func read():
	if text:
		if check == true:
			G.root_gui.read_show(text)
			char_react()
	else:
		G.root_gui.read_hide()

func char_react():
	G.root_gui.char_react(comment)
