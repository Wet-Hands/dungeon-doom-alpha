extends Node3D

@export var speed : Vector3

var off : Vector3 = Vector3.ZERO
@onready var lavaNoise = preload("res://shaders/lavaNoise.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	off += speed * delta
	lavaNoise.offset.x = off.x
	lavaNoise.offset.y = off.y
	lavaNoise.offset.z = off.z
	#set_shader_parameter("offsetParam", off)
