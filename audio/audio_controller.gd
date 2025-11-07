extends Node2D

@export var mute: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	if not mute:
		play_music()

func play_music():
	if not mute:
		$BackgroundMusic.play()

func play_game_over() -> void:
	if not mute:
		$BackgroundMusic.stop()
		$GameOver.play()

func play_reset() -> void:
	if not mute: 
		$GameOver.stop()
		$BackgroundMusic.play()
