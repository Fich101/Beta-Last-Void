extends Area

export var action_name = ''
export var action_id = ''

export var delete_parent = true
export var delete_on_action = true
export var parent_function = ''

func action():
	G.inv[action_id] = {
		'name' : action_name,
		'id' : action_id
	}
	
	if parent_function:
		get_parent().call(parent_function)

	if delete_parent:
		get_parent().queue_free()
	elif delete_on_action:
		queue_free()
