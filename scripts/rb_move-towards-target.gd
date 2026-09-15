extends RigidBody2D

@export var stiffness: float = 1200
@export var damping: float = 2 * sqrt(stiffness * mass)
var spring = true

func _physics_process(_delta: float) -> void:
	var target_position: Vector2 = %Target.global_position
	var target_distance: Vector2 = target_position - global_position
	print(linear_velocity)
	if spring:
		apply_central_force(target_distance * stiffness - linear_velocity * damping)
		apply_central_force(-get_gravity() * mass)
func disspring() -> void:
	if spring == true:
		spring = false
	else:
		spring = true

func _ready() -> void:
	get_parent().disable_spring.connect(disspring)
