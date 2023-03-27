extends Spatial

export var need_key = ''

func open():
	var nk = need_key
	if !nk || (nk && G.is_inv(nk)):
		$anim.play("open")
		$action.queue_free()
	else:
		G.alert("Need flashlight")
