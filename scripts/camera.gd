extends Camera3D

@onready var head = $"../../Head"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = head.position
