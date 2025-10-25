extends RigidBody2D
class_name Coin

signal collected(player: Player)

func player_collected_coin(body: Node2D):
	emit_signal("collected", body)
	self.queue_free()
