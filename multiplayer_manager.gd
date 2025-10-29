extends Node

var player_scene : PackedScene = preload("res://components/player/player.tscn")
var spawn_root : Node2D
@onready var GameManager = get_tree().get_current_scene().get_node("GameManager")

var port = 5555
var ip = "0.0.0.0"

func host():
	spawn_root = get_tree().get_current_scene().get_node("Players")
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(port)
	multiplayer.multiplayer_peer = server_peer

	multiplayer.peer_connected.connect(Callable(self, "add_player"))
	multiplayer.peer_disconnected.connect(Callable(self, "del_player"))
	
	add_player(1)
	
	return get_local_ip()

func join(addr: String):
	if not GameManager.started:
		var client_peer = ENetMultiplayerPeer.new()
		client_peer.create_client(addr, port)
		multiplayer.multiplayer_peer = client_peer

var num_players : int = 0

func add_player(id : int):
	num_players += 1
	var new_player : Player = player_scene.instantiate()
	new_player.name = str(id)
	GameManager.player_dictionary.append({"id": str(id), "num": num_players})
	spawn_root.add_child(new_player, true)

func del_player(id : int):
	pass

func get_local_ip() -> String:
	for addr in IP.get_local_addresses():
		if addr.begins_with("192.168.") or addr.begins_with("10.") or addr.begins_with("172."):
			return addr
	return "127.0.0.1"
