extends Control

@onready var coin : Label = $CoinCounter/count

func coin_collected(player : Player):
	if player.is_multiplayer_authority():
		coin.text = str(int(coin.text) + 1)
