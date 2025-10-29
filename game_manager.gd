extends Node
@export var started: bool = false
@export var scores : Array[Dictionary] = []
@onready var players = get_tree().get_current_scene().get_node("Players")
@export var player_dictionary : Array[Dictionary] = []

signal display(results)

func end_game():
	started = false
	for player in players.get_children():
		if player is not Player: continue
		scores.append({"player": get_player_num_from_id(player.name), "coins": player.coins_collected})
	var ordered_scores = order_scores()
	var message = "Player %s  Won!!!\n" % ordered_scores[0]["player"]
	for score in ordered_scores:
		if score == null: continue
		message += "\nPlayer %s collected %d coins" % [score["player"], score["coins"]]
	emit_signal("display", message)

func get_player_num():
	for player in players.get_children():
		if player is Player and player.is_multiplayer_authority():
			return get_player_num_from_id(player.name)

func get_player_num_from_id(id: String):
	for record in player_dictionary:
		if id == record["id"]:
			return record["num"]
	return null
			
func order_scores():
	var sorted = []
	for i in scores.size():
		var highest = 0
		var record
		for j in scores.size():
			if scores[j]["coins"] > highest and not sorted.has(scores[j]):
				highest = scores[j]["coins"]
				record = scores[j]
		sorted.append(record)
	return sorted
