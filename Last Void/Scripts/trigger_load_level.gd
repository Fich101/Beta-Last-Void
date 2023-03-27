extends Area
export var on_off = false #Включає трігер

func _physics_process(delta):
	if on_off == true:
		change()

func distance_to_node(n):
	return global_transform.origin.distance_to(n.global_transform.origin)

func change():
	if distance_to_node(G.root_player) <= 9.2:
		G.root_game.get_node('level').remove_child(G.root_level)
		G.load_level('levelF')
		G.root_game.get_node('level').add_child(G.enemy_load)
		G.root_game.get_node('level').get_node('Player').translate(Vector3(0, 0, 0))
