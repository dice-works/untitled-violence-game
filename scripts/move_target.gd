extends Node2D

var target_speed_bound = {"min": 150, "max": 350}
var mouse_dist_bound = {"min": 0, "max": 400}

func process_input(delta:float) -> void:
	var current_mouse_dist = clampf(
		abs($Target.global_position.x - get_global_mouse_position().x), 
		mouse_dist_bound["min"], mouse_dist_bound["max"])
	var target_speed_new = remap(
		current_mouse_dist, mouse_dist_bound["min"], mouse_dist_bound["max"],
		target_speed_bound["min"], target_speed_bound["max"]
	) * delta
	print("targetpos: " +str(%Target.global_position))
	print("mousepos: " +str(get_global_mouse_position()))
	print("targetnew: " +str(target_speed_new))
	print("currentmousedist: " +str(current_mouse_dist) + "\n")
	_move_target(target_speed_new)

func _move_target(target_speed:float) -> void:
	if PlayerInput.input_buffer.is_empty()==false:
		if PlayerInput.input_buffer.front()==-1:
			%Target.global_position.x -= target_speed 
		elif PlayerInput.input_buffer.front()==1:
			%Target.global_position.x += target_speed

func _ready() -> void:
	%Target.global_position.y = 300

func _process(delta:float) -> void:
	process_input(delta)
