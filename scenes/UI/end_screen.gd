extends Control

var slide1 : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE #How mouse movement SHOULD work

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
