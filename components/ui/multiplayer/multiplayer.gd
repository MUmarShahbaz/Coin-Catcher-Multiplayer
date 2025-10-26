extends Control

@onready var GameManager = get_tree().get_current_scene().get_node("GameManager")

func _on_host() -> void:
	$"Button Container/Host".hide()
	$"Button Container/Join".hide()
	MultiplayerManager.host()
	if multiplayer.is_server():
		$"Button Container/Start".show()
 
func _on_join() -> void:
	$"Button Container/Host".hide()
	$"Button Container/Join".hide()
	MultiplayerManager.join()
	if multiplayer.is_server():
		$"Button Container/Start".show()

func _on_start() -> void:
	if multiplayer.is_server():
		GameManager.started = true
		$"../../temp_cam".queue_free()
		rpc("clear_temp_cam")
		queue_free()

@rpc("any_peer")
func clear_temp_cam():
	$"../../temp_cam".queue_free()
