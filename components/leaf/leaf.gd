extends AnimatedSprite2D

var dir : Vector2

func _ready() -> void:
	z_index = 2 if randi_range(0, 1) == 1 else 0
	dir = Vector2.DOWN.rotated(randf_range(-PI/3, PI/3))

func _process(delta: float) -> void:
	global_position += dir * delta * 100
	if global_position.y > 200:
		queue_free()
