extends Area

export var action_name = ''

export var delete_parent = true
export var delete_on_action = true
export var parent_func = ''

func action():
		if parent_func:
			get_parent().call(parent_func)
		if delete_parent:
			get_parent().queue_free()
		elif delete_on_action:
			queue_free()
