extends Control

@onready var player = get_node("..")
var paused = false

func _on_player_pause():
	$"../Soundtrack".volume_db = -30
	visible = !visible
	paused = visible
	get_tree().paused = paused
	if paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_quit_button_pressed():
	get_tree().quit()

func _on_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")


func _on_resume_button_pressed():
	$"../Soundtrack".volume_db = -20
	visible = !visible
	paused = visible
	get_tree().paused = paused
	print(paused)
	if paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
