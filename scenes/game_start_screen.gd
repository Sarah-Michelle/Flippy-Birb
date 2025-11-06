extends CanvasLayer

signal play_game

func _on_play_button_pressed():
	play_game.emit()
