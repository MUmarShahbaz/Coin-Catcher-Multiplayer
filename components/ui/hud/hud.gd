extends Control

@onready var coin_count : Label = $CoinCounter/count
@onready var time: Label = $time
@onready var coin_sfx : AudioStreamPlayer = $coin
@onready var GameManager = get_tree().get_current_scene().get_node("GameManager")

var started: bool = true

func coin_collected(player : Player):
	if player.is_multiplayer_authority():
		coin_count.text = str(int(coin_count.text) + 1)
		coin_sfx.play()

@export var duration: int = 120
@onready var t : float = duration

func _process(delta: float) -> void:
	if not GameManager.started: return
	t -= delta
	time.text = formatted_time(t)

func formatted_time(s: float):
	var total_s = int(s)
	var minutes = int(total_s / 60)
	var seconds = total_s % 60
	return "%d:%d" % [minutes, seconds]
