extends Camera3D

@onready var cam = $"../../../Camera3D"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = cam.position
	rotation = cam.rotation
