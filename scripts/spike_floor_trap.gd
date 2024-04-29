extends Node3D

@onready var spikes = $Spikes
var started

# Called when the node enters the scene tree for the first time.
func _ready():
	spikes.position.y = -1.5
	started = false

func _on_area_3d_area_entered(area):
	if area.is_in_group("player"):
		$AnimationPlayer.play("start")
		started = true
		$Timer.start()

func _on_timer_timeout():
	$Timer.stop()
	$AnimationPlayer.play("end")
	started = false
