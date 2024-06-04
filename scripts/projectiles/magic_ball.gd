extends Area3D

const speed = 12

@onready var mesh = $MeshInstance3D
var start = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	print(rotation_degrees)
	start = false

func _process(delta):
	if start == true:
		position += transform.basis * Vector3(0, 0, -speed) * delta

func _on_area_entered(area):
	if area.is_in_group("player"):
		queue_free()

func _on_timer_timeout():
	start = true
