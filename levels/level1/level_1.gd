extends Node3D

@onready var player = $Player
@onready var grid = $NavigationRegion3D/GridMap

@onready var skeleton = preload("res://scenes/skeleton.tscn")
@onready var goblin = preload("res://scenes/goblin.tscn")

@onready var door = preload("res://scenes/door.tscn")
@onready var endor = preload("res://scenes/end_door.tscn")

func _ready():
	for z in range(-25, 25):
		for x in range(-25, 25):
			var i = grid.get_cell_item(Vector3i(x, 0, z))
			var io = grid.get_cell_item_orientation(Vector3i(x, 0, z))
			if i == 5:
				instGoblin(Vector3i(x, 0, z))
				grid.set_cell_item(Vector3i(x, 0, z), 2, io)
			if i == 4:
				instSkeleton(Vector3i(x, 0, z))
				grid.set_cell_item(Vector3i(x, 0, z), 2, io)
			if i == 7:
				instDoor(Vector3i(x, 0, z), "none", io)
				grid.set_cell_item(Vector3i(x, 0, z), 0, io)

func _physics_process(_delta):
	get_tree().call_group("skeleton" , "update_target_location" , player.global_position)
	
func instGoblin(pos):
	var instance = goblin.instantiate()
	instance.position = pos
	instance.position.y = 1.75
	instance.player = player
	$Enemies.add_child(instance)

func instSkeleton(pos):
	var instance = skeleton.instantiate()
	instance.position = pos
	instance.position.y = 2.75
	instance.player = player
	$Enemies.add_child(instance)

func instDoor(pos, color, rot):
	var secPos = Vector3i(0, 0, 0)
	var test = [-1, 1]
	var xx = 0
	var zz = 0
	for z in range(0, 1):
		for x in range(0, 1):
			if grid.get_cell_item(Vector3i(pos.x+test[x], 0, pos.z+test[z])) == grid.get_cell_item(pos):
				secPos = Vector3i(pos.x+test[x], 0, pos.z+test[z])
				grid.set_cell_item(secPos, 0, rot)
				zz = test[z]
				xx = test[x]
	var instance = door.instantiate()
	instance.position = Vector3i(pos.x+xx, 3.25, pos.z+zz)
	instance.key = color
	$Objects.add_child(instance)
