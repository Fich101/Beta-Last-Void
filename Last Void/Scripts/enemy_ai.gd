extends KinematicBody
class_name Enemy_ai

var _delta = 0
var _timer = 0
var state = ''
var _detector:RayCast = null
var _detector_left:RayCast = null
var _detector_right:RayCast = null
var _animator = null
var sub_state = ''
var _animations = {}
var _prev_state = ''
var _prev_sub_state = ''
var _detected = null
var _detected_left = 0
var _detected_right = 0
var _turn_dir = 0

export(String, MULTILINE) var sub_state_anim = ''
export(NodePath) var detector_node
export(NodePath) var detector_right
export(NodePath) var detector_left
export(NodePath) var animator_node
export var speed_move = 3
export var speed_turn = 1

func idle(): pass

func _ready() -> void:
	if detector_node:
		_detector = get_node(detector_node)
	if detector_right:
		_detector_right = get_node(detector_node)
	if detector_left:
		_detector_left = get_node(detector_node)
	if animator_node:
		_animator = get_node(animator_node)
	if sub_state_anim:
		var all = sub_state_anim.split('\n')
		for a in all:
			var s = a.split(':')
			_animations[s[0]] = s[1]
	ready()

func _physics_process(delta: float) -> void:
	_delta = delta
	_timer += delta
	if _detector:
		if _detector.is_colliding():
			_detected = _detector.get_collider()
		else:
			_detector = null
	if _detector_left:
		if _detector_left.is_colliding():
			_detected_left = distance_to_point(_detector_left.get_collision_point())
		else:
			_detected_left = 0
	if _detector_right:
		if _detector_right.is_colliding():
			_detected_right = distance_to_point(_detector_right.get_collision_point())
		else:
			_detected_right = 0
	print(distance_to_node(G.root_player))

	call(state)
	process()

func set_state(s, sub = ''):
	_timer = 0
	if state != s:
		_prev_state = state
		state = s
	if sub:
		set_sub_state(sub)

func set_sub_state(sub):
	if sub_state != sub:
		_prev_sub_state = sub_state
		if _animator:
			_animator.play(_animations[sub], 0.2)
		sub_state = sub

func move_ai(add_speed = 0):
	if G.root_gui.pause == true:
		if _detected:
			set_state('tmp_rotate')
		if _detected_left || _detected_right:
			if _detector_left.get_collider() == G.root_player || _detector_right.get_collider() == G.root_player:
				pass
			else:
				_turn_dir = 1 if _detected_left < _detected_right else -1
				rotation.y += _turn_dir * speed_turn * add_speed * _delta
		move_angle(add_speed)

func move_angle(add_speed = 0):
	if G.root_gui.pause == true:
		move_and_slide(Vector3(0, -5, -(speed_move + add_speed)).rotated(Vector3.UP, rotation.y), Vector3.UP, true, 4, 1, false)

func rotate_to_node(n, add_speed = 1):
	if G.root_gui.pause == true:
		var a = global_transform
		var origin = n.global_transform.origin
		origin.y = a.origin.y
		var b = a.looking_at(origin, Vector3.UP)
		global_transform = global_transform.interpolate_with(b, (add_speed + speed_turn) * _delta)

func distance_to_node(n):
	return global_transform.origin.distance_to(n.global_transform.origin)

func distance_to_point(p):
	return global_transform.origin.distance_to(p)

func ready(): pass

func process(): pass

func tmp_rotate():
	rotate_y(_turn_dir * speed_turn * _delta)
	#if !_detected:
	if _timer > 1:
		set_state(_prev_state)
