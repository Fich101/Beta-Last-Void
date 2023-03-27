extends Node

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if G.root_gui.check == false:
			G.root_gui.read_hide()
		elif G.root_gui.pause == true:
			G.root_gui.show_pause()
		elif G.root_gui.pause == false:
			G.root_gui.hide_pause()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().change_scene("res://Scenes/main_menu.tscn")

func _ready():
	G.root_game = self
	G.load_level('labirint')
	G.root_player.translate(Vector3(190,0,-183.606))
