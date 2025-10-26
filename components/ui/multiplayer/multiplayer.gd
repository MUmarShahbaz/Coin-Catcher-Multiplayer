extends Control

signal started()

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
		emit_signal("started")
		queue_free()
