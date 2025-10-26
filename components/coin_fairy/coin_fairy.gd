extends Spawner
class_name CoinFairy

@export var Speed: float = 50
@export var HUD: Control
@export var started: bool = false

func _process(delta: float) -> void:
	if not started: return
	if multiplayer.is_server():
		super._process(delta)
	global_position.x += Speed*delta

func start():
	started = true

func spawn():
	var coin:Coin = super.spawn()
	rpc("spawn_remote", coin.global_position)
	coin.collected.connect(Callable(HUD, "coin_collected"))

@rpc("any_peer")
func spawn_remote(new_position):
	var new_coin:Coin = element.instantiate()
	new_coin.global_position = new_position
	add_sibling(new_coin)
	new_coin.collected.connect(Callable(HUD, "coin_collected"))
