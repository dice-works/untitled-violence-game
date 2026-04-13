extends RigidBody2D

@onready var player = get_parent()
var looking_left:bool
var input_dir:Vector2
var y_anchor:float
var highest = 0.0
var lowest = 0.0
#idling vars
var idle_target
const idle_anchor_bounds = 6
#walking vars
var walk_target
const walk_anchor_bounds = 8


func _check_player_variables() -> void:
	input_dir = player.input_dir
	looking_left = player.looking_left

func _turn_torso_to_looking_direction() -> void:
	if looking_left:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func _idling() -> void:
	if idle_target == null:
		idle_target = y_anchor + idle_anchor_bounds
	linear_damp = 5.0
	var idle_strength: float = 5
	var offset = idle_target - global_position.y
	
	if abs(offset) < 1:
		if idle_target > y_anchor:
			idle_target = y_anchor - idle_anchor_bounds
		else:
			idle_target = y_anchor + idle_anchor_bounds
			
	apply_central_force(Vector2(0, offset * idle_strength))

func _walking() -> void:
	if walk_target == null:
		walk_target = y_anchor + walk_anchor_bounds
	linear_damp = 4.0
	var walk_strength: float = 1000
	var walk_bounce_strength: float = 10
	var arrival_threshold: float = 2
	var offset = walk_target - global_position.y
	
	if abs(offset) < arrival_threshold:
		if walk_target > y_anchor:
			walk_target = y_anchor - walk_anchor_bounds
		else:
			walk_target = y_anchor + walk_anchor_bounds
	apply_central_force(Vector2(0, offset * walk_bounce_strength))
	apply_central_force(Vector2(walk_strength * input_dir.x, 0))
	
	
func _highestlowest() -> void:
	var newhighest = position.y
	var newlowest = position.y
	if newhighest < highest:
		highest = newhighest
		print("highest: " + str(highest))
	if newlowest > lowest:
		lowest = newlowest
		print("lowest: " + str(lowest))

func _ready() -> void:
	y_anchor = global_position.y

func _process(_delta: float) -> void:
	_check_player_variables()
	_turn_torso_to_looking_direction()
	_highestlowest()
	print(linear_damp)

func _physics_process(_delta: float) -> void:
	if input_dir == Vector2.ZERO:
		_idling()
	else:
		_walking()
		pass
