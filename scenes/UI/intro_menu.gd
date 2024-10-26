extends Control

var slide1 : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://levels/level1/level_1.tscn")
