extends Spatial


func _ready():
	$AnimationPlayer.play("cut_scene_1")
	G.root_player.anim.play("walk_camera")
