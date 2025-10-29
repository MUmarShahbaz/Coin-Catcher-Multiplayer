extends Control

@onready var GameManager = get_tree().get_current_scene().get_node("GameManager")
@onready var host_btn = $"Button Container/Host"
@onready var addr_in = $"Button Container/Address_Input"
@onready var join_btn = $"Button Container/Join"
@onready var addr_out = $"Button Container/Address_Output"
@onready var start_btn = $"Button Container/Start"


func _on_host() -> void:
	host_btn.hide()
	addr_in.hide()
	join_btn.hide()
	addr_out.text = MultiplayerManager.host()
	addr_out.show()
	start_btn.show()
 
func _on_join() -> void:
	host_btn.hide()
	addr_in.hide()
	join_btn.hide()
	MultiplayerManager.join(addr_in.text)

func _on_start() -> void:
	if multiplayer.is_server():
		GameManager.started = true
		$"../../temp_cam".queue_free()
		rpc("clear_temp_cam")
		queue_free()

@rpc("any_peer")
func clear_temp_cam():
	$"../../temp_cam".queue_free()
