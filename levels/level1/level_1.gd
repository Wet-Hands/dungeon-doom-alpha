extends Node3D

@onready var player = $Player

func _physics_process(_delta):
	get_tree().call_group("skeleton" , "update_target_location" , player.global_position)
	
