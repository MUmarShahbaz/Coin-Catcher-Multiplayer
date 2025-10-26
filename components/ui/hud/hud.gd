extends Control

@onready var coin_counter = $CoinCounter

@onready var coin_count : Label = $CoinCounter/count
@onready var time: Label = $time
@onready var coin_sfx : AudioStreamPlayer = $coin
@onready var results_label : Label = $results
@onready var GameManager = get_tree().get_current_scene().get_node("GameManager")
@onready var players_root = get_tree().get_current_scene().get_node("Players")

signal end()

func coin_collected(player : Player):
	if player.is_multiplayer_authority():
		coin_count.text = str(int(coin_count.text) + 1)
		coin_sfx.play()

@export var duration: int = 120
@export var t : float = duration

func _ready() -> void:
	t = duration
	end.connect(Callable(GameManager, "end_game"))
	GameManager.display.connect(Callable(self, "results"))

func _process(delta: float) -> void:
	if not GameManager.started: return
	t -= delta
	time.text = formatted_time(t)
	if t <= 0:
		emit_signal("end")

func formatted_time(s: float):
	var total_s = int(s)
	var minutes = int(total_s / 60)
	var seconds = total_s % 60
	return "%d:%d" % [minutes, seconds]

func results(result_message):
	$CoinCounter.queue_free()
	$coin.queue_free()
	$time.queue_free()
	results_label.text = result_message
	results_label.show()
