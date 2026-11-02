extends Sprite2D

func _process(_delta: float) -> void:
	var mouse_pos_x = get_global_mouse_position().x
	if mouse_pos_x < global_position.x:
		flip_h = true
	else:
		flip_h = false
