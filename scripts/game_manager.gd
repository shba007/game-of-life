extends Node

var coins_collected = 0

func add_coin():
	coins_collected += 1
	print(coins_collected)
	
func remove_coin():
	coins_collected -= 1
	print(coins_collected)
