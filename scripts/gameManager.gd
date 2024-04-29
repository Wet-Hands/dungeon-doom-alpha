extends Node

class_name GameManger

signal toggle_game_paused(is_paused)

var game_paused= false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_game_paused", game_paused)

func _input(event : InputEvent):
	if(event.is_action_pressed("ui_cancel")):
		if game_paused == false:
			game_paused = true
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
