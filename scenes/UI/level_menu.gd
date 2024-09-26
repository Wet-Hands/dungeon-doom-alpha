extends Control

var slide1 : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_button_pressed():
	if slide1 == false:
		slide1 = true
		$Text1.visible = false
		$Text2.visible = true
	elif slide1 == true:
		get_tree().change_scene_to_file("res://levels/level1/level_1.tscn")
