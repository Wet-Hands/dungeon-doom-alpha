extends Control

@export var speed : Vector3

var off : Vector3 = Vector3.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	off += speed * delta
	$TextureRect.texture.noise.offset.x = off.x
	$TextureRect.texture.noise.offset.y = off.y
	$TextureRect.texture.noise.offset.z = off.z
