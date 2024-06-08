extends Area3D

const speed = 10

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
	if area.is_in_group("player") && start == true:
		queue_free()

func _on_timer_timeout():
	start = true
	$ExpireTimer.start()

func cancel():
	if start == false:
		remove_from_group("magi")
		visible = false
		$OmniLight3D.light_energy = 0

func _on_expire_timer_timeout():
	queue_free()
