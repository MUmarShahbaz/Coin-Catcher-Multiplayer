extends Spawner
class_name CoinFairy

@export var Speed: float = 50

func _process(delta: float) -> void:
	super._process(delta)
	global_position.x += Speed*delta
