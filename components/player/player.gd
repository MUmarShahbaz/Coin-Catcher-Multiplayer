extends CharacterBody2D
class_name Player

@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@onready var sprite: AnimatedSprite2D = $sprite
@onready var bg_music: AudioStreamPlayer = $bg_music
@onready var jump_sfx: AudioStreamPlayer = $jump
@onready var die_sfx: AudioStreamPlayer = $die
@onready var GameManager = get_tree().get_current_scene().get_node("GameManager")

var facing: int = 1
var coins_collected = 0

signal cam(dir: Vector2)

func _enter_tree() -> void:
	set_multiplayer_authority(int(name))

func _ready() -> void:
	if is_multiplayer_authority():
		var myCAM = CAM.new()
		myCAM.target = self
		add_sibling.call_deferred(myCAM)
		cam.connect(Callable(myCAM, "set_target_offset"))
		bg_music.play()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_multiplayer_authority() and GameManager.started: control(delta)
	move_and_slide()

func control(delta):
	var cam_offset := Vector2.ZERO
	cam_offset.x = Input.get_axis("cam_left", "cam_right")
	cam_offset.y = Input.get_axis("cam_up", "cam_down")
	emit_signal("cam", cam_offset)
	
	var x_dir = Input.get_axis("left", "right")
	velocity.x = x_dir if x_dir != 0 else move_toward(velocity.x, 0, delta)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
		if is_multiplayer_authority(): jump_sfx.play()
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("default")

	if facing * direction < 0:
		sprite.flip_h = !sprite.flip_h
		facing *= -1

func kill():
	global_position = Vector2(0, -80)
	velocity = Vector2.ZERO
	if is_multiplayer_authority(): die_sfx.play()
