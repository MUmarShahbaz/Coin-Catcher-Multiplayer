extends CharacterBody2D
class_name Player

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@onready var sprite: AnimatedSprite2D = $sprite
@onready var jump_sfx: AudioStreamPlayer = $jump

var facing: int = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
