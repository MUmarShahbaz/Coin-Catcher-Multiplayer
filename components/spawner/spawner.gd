extends Area2D
class_name Spawner

@export var element: PackedScene
@onready var collider: CollisionShape2D = $spawn_area
@export var root: Node
@export_range(0, 2) var base_drop_time: float = 1

var t:= 0.0

func _process(delta: float) -> void:
	t+= delta
	if t > base_drop_time + randf_range(-0.3, 0.3):
		t = 0
		spawn()

func spawn():
	var rect: RectangleShape2D = collider.shape
	var extents = rect.extents
	var rand_x = randf_range(-extents.x, extents.x)
	var rand_y = randf_range(-extents.y, extents.y)
	var local_pos = Vector2(rand_x, rand_y)
	var new_element: Node = element.instantiate()
	new_element.global_position = local_pos + global_position
	if root == null:
		add_sibling(new_element)
	else:
		root.add_child(new_element)
	return new_element
