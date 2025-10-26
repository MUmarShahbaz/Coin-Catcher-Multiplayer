extends CharacterBody2D
class_name Player

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@onready var sprite: AnimatedSprite2D = $sprite
@onready var jump_sfx: AudioStreamPlayer = $jump
@onready var die_sfx: AudioStreamPlayer = $die

var facing: int = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func kill():
	global_position = Vector2(0, -80)
	velocity = Vector2.ZERO
	die_sfx.play()
