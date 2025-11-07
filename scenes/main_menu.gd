extends Control

signal play_game

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	play_game.emit()


func _on_settings_pressed():
	print("settings")


func _on_quit_pressed():
	get_tree().quit()
