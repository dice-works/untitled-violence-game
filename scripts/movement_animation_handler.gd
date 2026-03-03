extends Node2D

@onready var body = get_parent().get_node("BodySprite")
var moving = false
var input_dir = Vector2.ZERO
var body_tweening = false
var body_tween_position = "down"
var body_tween:Tween

func _body_animation() -> void:
	if input_dir.x < 0:
		body.rotation_degrees = 4.5
		body.flip_h = true
	else:
		body.rotation_degrees = -4.5
		body.flip_h = false
	
	if moving and not body_tweening and body_tween_position == "down":
		body_tween = create_tween().set_ease(Tween.EASE_IN_OUT)
		var target_position = body.position
		target_position.y -= 15
		body_tween.tween_property(body, "position", target_position, 0.2)
		body_tweening = true
		body_tween.finished.connect(_body_tween_finished)
	if moving and not body_tweening and body_tween_position == "up":
		body_tween = create_tween().set_ease(Tween.EASE_IN_OUT)
		var target_position = body.position
		target_position.y += 15
		body_tween.tween_property(body, "position", target_position, 0.2)
		body_tweening = true
		body_tween.finished.connect(_body_tween_finished)
		
func _body_tween_finished() -> void:
	if body_tween_position == "down":
		body_tween_position = "up"
	else:
		body_tween_position = "down"
	body_tweening = false

func _physics_process(_delta: float) -> void:
	moving = get_parent().moving
	input_dir = get_parent().input_dir
	_body_animation()
