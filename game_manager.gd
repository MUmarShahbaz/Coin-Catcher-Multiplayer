extends Node
@export var started: bool = false
@export var scores : Array[Dictionary] = []
@onready var players = get_tree().get_current_scene().get_node("Players")

signal display(results)

func end_game():
	started = false
	for player in players.get_children():
		if player is not Player: continue
		scores.append({"player": player.player_id, "coins": player.coins_collected})
	var ordered_scores = order_scores()
	var message = "Player %d Won!!!\n" % ordered_scores[0]["player"]
	for score in ordered_scores:
		if score == null: continue
		message += "\nPlayer %d collected %d coins" % [score["player"], score["coins"]]
	emit_signal("display", message)


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
