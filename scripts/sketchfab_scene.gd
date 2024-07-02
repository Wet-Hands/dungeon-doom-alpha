extends Node3D

@onready var animPlay = $Sketchfab_model/MovementAnim
var magic = preload("res://scenes/projectiles/magic_ball.tscn")
var curInst
func _process(_delta):
	var inLight = $"..".inLight
	var inEdgeLight = $"..".inEdgeLight
	var doAtk = $"..".doAtk
	var dead = $"..".dead
	
	if dead == true:
		animPlay.speed_scale = 1
		animPlay.play("Death")
	elif doAtk == true:
		animPlay.speed_scale = 5
		animPlay.play("Magic")
	elif inLight == true && inEdgeLight == true:
		animPlay.play("Backwards")
	elif inLight == false && inEdgeLight == true:
		animPlay.play("Idle")
	else:
		animPlay.play("Walk")

func magPlay():
	var inst = magic.instantiate()
	curInst = inst
	inst.position = $MagicPoint.position
	$Balls.add_child(inst)

func _on_movement_anim_animation_finished(_anim_name):
	animPlay.speed_scale = 1
