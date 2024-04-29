extends Node3D

func _ready(): #Called when the node enters the scene tree for the first time.
	Engine.max_fps = 60 #Set FPS to 60
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) #Fullscren the Game
	$Audio.play() #Play Sound Effect
	$Timer.start() #Timer Starts (3.25s)

func _process(_delta): #Always Running
	$AnimationPlayer.play("fullSpin") #Play Spin Animation

func _on_timer_timeout(): #When Timer (3.25s) Stops
	$Timer.stop() #Stop Timer
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn") #Go to Main Menu
