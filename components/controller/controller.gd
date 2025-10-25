extends Node
class_name Controller

@onready var player: Player = get_parent()

signal cam(dir: Vector2)

func _ready() -> void:
	var myCAM = CAM.new()
	add_sibling.call_deferred(myCAM)
	cam.connect(Callable(myCAM, "set_target_offset"))

func _physics_process(delta: float) -> void:
	var cam_offset := Vector2.ZERO
	cam_offset.x = Input.get_axis("cam_left", "cam_right")
	cam_offset.y = Input.get_axis("cam_up", "cam_down")
	emit_signal("cam", cam_offset)
	
	var x_dir = Input.get_axis("left", "right")
	player.velocity.x = x_dir if x_dir != 0 else move_toward(player.velocity.x, 0, delta)
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y += player.JUMP_VELOCITY
		player.jump_sfx.play()
	
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.SPEED
		player.sprite.play("walk")
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
		player.sprite.play("default")

	if player.facing * direction < 0:
		player.sprite.flip_h = !player.sprite.flip_h
		player.facing *= -1
