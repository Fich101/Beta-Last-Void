extends Enemy_ai

func ready():
	set_state('idle', 'idle')

func idle():
	if _timer > 1:
		_timer = 0
		find_player()

func move():
	var dist = distance_to_node(G.root_player)
	if dist > 20:
		set_state('move_idle', 'move')
		return
	if dist > 6:
		rotate_to_node(G.root_player)
		move_ai(2)
	else:
		set_state('attack_move', 'attack_move')

func attack_move():
	if distance_to_node(G.root_player) < 6:
		if G.root_gui.pause == true:
			$AudioStreamPlayer3D.play(0.0)
		rotate_to_node(G.root_player, 3)
		move_ai(3)
	else:
		set_state('move_idle', 'move')

func attack():
	pass

func move_idle():
	move_ai()
	if _timer > 1:
		_timer = 0
		find_player()

func find_player():
	if distance_to_node(G.root_player) < 30:
		set_state('move', 'move')
		return
	if state == 'move_idle':
		set_state('idle', 'idle')
	elif state == 'idle':
		set_state('move_idle', 'move')
