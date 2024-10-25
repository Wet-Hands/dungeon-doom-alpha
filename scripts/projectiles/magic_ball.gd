extends Area3D

var speed = 10

@onready var mesh = $MeshInstance3D
var start = false
var reversed = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	print(rotation_degrees)
	start = false

func _process(delta):
	if start == true:
		position += transform.basis * Vector3(0, 0, -speed) * delta

#func _on_area_entered(area):
	#if start == true && area.is_in_group() != "chestopenArea" && area.is_in_group() != "doorIntArea":
		#queue_free()

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

func _on_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index):
	if start == true:
		await get_tree().create_timer(.1)
		if reversed == false:
			queue_free()
		if reversed == true:
			print("PARRY TIME")
			speed = -10
			$ExpireTimer.stop()
			$ExpireTimer.start()
		print("grid removal?")
