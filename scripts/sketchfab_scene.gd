extends Node3D

func _process(_delta):
	var inLight = $"..".inLight
	var inEdgeLight = $"..".inEdgeLight
	var doAtk = $"..".doAtk
	var dead = $"..".dead
	var animPlay = $Sketchfab_model/MovementAnim
	if dead == true:
		animPlay.play("Death")
	elif doAtk == true:
		animPlay.play("Magic")
	elif inLight == true && inEdgeLight == true:
		animPlay.play("Backwards")
	elif inLight == false && inEdgeLight == true:
		animPlay.play("Idle")
	else:
		animPlay.play("Walk")
