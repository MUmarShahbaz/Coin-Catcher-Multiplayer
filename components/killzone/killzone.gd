extends Area2D
class_name Killzone

signal player_died(player: Player)

func _on_player_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("player_died", body)
		body.kill()
		return
	body.queue_free()
