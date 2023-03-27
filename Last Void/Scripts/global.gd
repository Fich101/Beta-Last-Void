extends Node

var root_level
var root_game
var root_gui
var root_player
var charge
var torch_check
var pause_read = true
var enemy_load = load("res://Scenes/Enemy.tscn").instance()


var inv = {}

var action_object = null

func to(scene):
	get_tree().change_scene("res://Scenes/"+scene+".tscn")

func load_level(level):
	root_level = load("res://Levels/Level_1/"+level+".tscn").instance()
	root_game.get_node('level').add_child(root_level)

func is_inv(id):
	return inv.has(id)
	
func alert(msg):
	root_gui.alert(msg)

func show_hp(i):
	G.root_gui.show_hp(i)

func stamina_bar(i):
	G.root_gui.stamina_bar(i)

func show_charge(i):
	G.root_gui.show_charge(i)

func hide_charge():
	G.root_gui.hide_charge()

func recharge():
	G.charge = G.charge + 20

func show_pause():
	G.root_gui.show_pause()
	torch_check = true

func hide_pause():
	G.root_gui.hide_pause()
	torch_check = false
