extends Area3D

const speed = 12

@onready var mesh = $MeshInstance3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	print(rotation_degrees)

func _process(delta):
	position += transform.basis * Vector3(0, 0, -speed) * delta

func _on_area_entered(area):
	if area.is_in_group("player") || area.is_in_group("door") || area.is_in_group("trapCOL"):
		pass 
	else:
		queue_free()
		print(area.get_groups())
