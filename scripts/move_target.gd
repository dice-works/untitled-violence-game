extends Node2D

signal disable_spring
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	print("disabled")
	#disable_spring.emit()
	await get_tree().create_timer(0.2).timeout
	#disable_spring.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Target.global_position = get_global_mouse_position()
