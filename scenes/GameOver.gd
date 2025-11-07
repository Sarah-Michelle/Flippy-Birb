extends CanvasLayer
	
func _ready():
	self.hide()

func game_over():
	AudioController.play_game_over()
	self.show()
	$TotalScore.text = str(Globals.score)
	display_titles()

func _on_restart_button_pressed():
	AudioController.play_reset()
	self.hide() 
	get_parent().new_game()

func display_titles():
	if Globals.score == 0: 
		$Title.text = str("Yikes...couldn't even get 1?")
	elif Globals.score <= 10:
		$Title.text = "Better luck next time"
	elif Globals.score <= 50:
		$Title.text = "Progress...I guess"
	else:
		$Title.text = "Huwaw! Galing mo naman!"

func _on_quit_pressed():
	get_tree().quit()
