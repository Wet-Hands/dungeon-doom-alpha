extends Node3D
var spins = 0
@onready var head = $head

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	playSpin()
	$Audio.play()
	$Timer.start()

func _process(delta):
	playSpin()

func playSpin():
	$AnimationPlayer.play("fullSpin")

func _on_timer_timeout():
	$Timer.stop()
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
