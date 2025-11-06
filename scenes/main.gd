extends Node

@export var pipe_scene : PackedScene

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 4
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 150

func _ready():
	$game_start.play()
	#screen_size = get_window().size
	screen_size = get_viewport().get_visible_rect().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	#new_game()
	stop_game()

func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	pipes.clear()
	$GameOverScreen.hide()
	#$GameStartScreen.visibility_changed = true
	$ScoreLabel.text = str(score)
	get_tree().call_group('pipes', 'queue_free')
	
	generate_pipes()
	$Bird.reset()

func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()
						check_top()

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()

func check_top():
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()

func stop_game():
	$PipeTimer.stop()
	$Bird.flying = false
	$GameOverScreen.show()
	game_running = false
	game_over = true

func _process(_delta):
	if game_running:
		scroll += SCROLL_SPEED
		
		if scroll >= screen_size.x:
			scroll = 0
		
		$Ground.position.x = -scroll
		
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED

func _on_pipe_timer_timeout():
	generate_pipes()

func generate_pipes():
	var pipe = pipe_scene.instantiate()
	
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)

func scored():
	score += 1;
	$ScoreLabel.text = str(score)

func bird_hit():
	$Bird.falling = true
	$game_over.play()
	stop_game()

func _on_ground_hit():
	$Bird.falling = true
	stop_game()

func _on_game_over_screen_restart():
	$game_over.stop()
	new_game()

func _on_game_start_screen_play_game():
	$game_start.stop()
	$GameStartScreen.hide()
	new_game()
