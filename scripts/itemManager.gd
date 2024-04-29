extends Control

var bobSpeed = 4.0
var bobAmount = 5.0
var bobTime = 0.0

var initialPosY = 0.0
var isMoving = false

func _ready():
	initialPosY = position.y

func _process(delta):
	isMoving = Input.is_action_pressed("moveForward") or Input.is_action_pressed("moveBack") or Input.is_action_pressed("moveLeft") or Input.is_action_pressed("moveRight")
	
	if isMoving == true:
		bobTime += delta * bobSpeed
		var bobbing = sin(bobTime) * bobAmount
		position.y = initialPosY + bobbing
	else:
		move_toward(position.y, initialPosY, delta)
