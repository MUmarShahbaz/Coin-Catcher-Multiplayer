extends Control

@onready var coin_count : Label = $CoinCounter/count
@onready var coin_sfx : AudioStreamPlayer = $coin

func coin_collected(player : Player):
	if player.is_multiplayer_authority():
		coin_count.text = str(int(coin_count.text) + 1)
		coin_sfx.play()
