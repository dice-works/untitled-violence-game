extends CharacterBody2D

@onready var player = get_parent()
var looking_left:bool
var input_dir:Vector2
var walking = false
var bouncing = false
var torso_start_y:float
var time_passed = 0.0
var target_tilt = 0.0
const move_speed = 400
const move_accel = 1000
const bounce_height = 6.5
const bounce_speed = 12
const tilt_speed = 1.25

func _check_player_variables() -> void:
	input_dir = player.input_dir
	looking_left = player.looking_left

func _turn_torso_to_looking_direction() -> void:
	if looking_left:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
		
func _torso_tilt_animation(delta) -> void:
	if input_dir.x > 0 and looking_left:
		target_tilt = deg_to_rad(-6)
	elif input_dir.x > 0 and not looking_left:
		target_tilt = deg_to_rad(-6)
	elif input_dir.x < 0 and looking_left:
		target_tilt = deg_to_rad(6)
	elif input_dir.x < 0 and not looking_left:
		target_tilt = deg_to_rad(6)
	else:
		target_tilt = deg_to_rad(0)
	$Sprite2D.rotation = move_toward($Sprite2D.rotation, target_tilt, tilt_speed * delta)
		
func _torso_walking_animation(delta) -> void:
	if input_dir.x == 0:
		walking = false
	if input_dir.x != 0 and not bouncing:
		torso_start_y = $Sprite2D.position.y
		walking = true
		bouncing = true
		time_passed = 0.0
	if walking and bouncing:
		time_passed += delta
		$Sprite2D.position.y = torso_start_y + sin(time_passed * bounce_speed) * bounce_height
	if not walking and bouncing:
		$Sprite2D.position.y = move_toward($Sprite2D.position.y, torso_start_y, bounce_speed * delta)
	if not walking and bouncing and $Sprite2D.position.y == torso_start_y:
		bouncing = false
	
func _process(_delta: float) -> void:
	_check_player_variables()
	_turn_torso_to_looking_direction()

func _physics_process(delta: float) -> void:
	velocity.x = move_toward(velocity.x, input_dir.x * move_speed, move_accel * delta)
	move_and_slide()
	_torso_walking_animation(delta)
	_torso_tilt_animation(delta)
