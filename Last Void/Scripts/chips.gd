extends MeshInstance

export var comment_text = ''

func comment():
	G.root_gui.char_react(comment_text)
