extends Node2D

var looking_left:bool
var input_dir:Vector2
var input_buffer = []

func _check_looking_direction() -> void:
	if get_global_mouse_position().x < $Torso.global_position.x:
		looking_left = true
	else:
		looking_left = false

func _get_input_direction() -> void:
	if Input.is_action_just_pressed("player_left"):
		input_buffer.erase(-1)
		input_buffer.append(-1)
	if Input.is_action_just_pressed("player_right"):
		input_buffer.erase(+1)
		input_buffer.append(+1)
	if Input.is_action_just_released("player_left"):
		input_buffer.erase(-1)
	if Input.is_action_just_released("player_right"):
		input_buffer.erase(+1)
		
	if input_buffer.is_empty():
		input_dir.x = 0
	else:
		input_dir.x = input_buffer.back()

func _process(_delta: float) -> void:
	_check_looking_direction()
	_get_input_direction()
