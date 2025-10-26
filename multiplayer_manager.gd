extends Node

var player_scene : PackedScene = preload("res://components/player/player.tscn")
var spawn_root : Node2D

var port = 8080
var ip = "127.0.0.1"

func host():
	spawn_root = get_tree().get_current_scene().get_node("Players")
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(port)
	multiplayer.multiplayer_peer = server_peer

	multiplayer.peer_connected.connect(Callable(self, "add_player"))
	multiplayer.peer_disconnected.connect(Callable(self, "del_player"))
	
	add_player(1)

func join():
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(ip, port)
	multiplayer.multiplayer_peer = client_peer

func add_player(id : int):
	var new_player : Player = player_scene.instantiate()
	new_player.player_id = id
	new_player.name = str(id)
	spawn_root.add_child(new_player, true)

func del_player(id : int):
	pass
