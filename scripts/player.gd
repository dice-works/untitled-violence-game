extends CharacterBody2D

const speed = 300
var moving = false
var input_dir = Vector2.ZERO

func _physics_process(delta: float) -> void:
	input_dir = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = velocity.move_toward(input_dir * speed, 4000 * delta)
	move_and_slide()
	if input_dir:
		moving = true
	else:
		moving = false
