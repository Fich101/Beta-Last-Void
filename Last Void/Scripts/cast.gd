extends RayCast

var object = null

func _physics_process(delta):
	var n = get_collider()
	if !n:
		G.action_object = null
		object = null
	elif 'action_name' in n && n != object:
		object = n
		G.action_object = n
