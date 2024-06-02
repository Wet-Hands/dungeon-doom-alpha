extends Node3D

@onready var player = $Player
@onready var grid = $NavigationRegion3D/GridMap

@onready var skeleton = preload("res://scenes/skeleton.tscn")
@onready var goblin = preload("res://scenes/goblin.tscn")
@onready var door = preload("res://scenes/door.tscn")
@onready var endor = preload("res://scenes/end_door.tscn")
@onready var chest = preload("res://scenes/chest.tscn")

@onready var magic = preload("res://scenes/projectiles/magic_ball.tscn")
func _ready():
	for z in range(-50, 50):
		for x in range(-50, 50):
			var i = grid.get_cell_item(Vector3i(x, 0, z))
			var io = grid.get_cell_item_orientation(Vector3i(x, 0, z))
			if i == 5:
				instGoblin(Vector3i(x, 0, z))
				grid.set_cell_item(Vector3i(x, 0, z), 2, io)
			if i == 4:
				instSkeleton(Vector3i(x, 0, z))
				grid.set_cell_item(Vector3i(x, 0, z), 2, io)
			if i == 12:
				instChest(Vector3i(x, 0, z), "red")
				grid.set_cell_item(Vector3i(x, 0, z), 2, 0)
			if i == 13:
				instChest(Vector3i(x, 0, z), "green")
				grid.set_cell_item(Vector3i(x, 0, z), 2, io)
			if i == 14:
				instChest(Vector3i(x, 0, z), "blue")
				grid.set_cell_item(Vector3i(x, 0, z), 2, io)

func _physics_process(_delta):
	get_tree().call_group("skeleton" , "update_target_location" , player.global_position)
	
func instGoblin(pos):
	var instance = goblin.instantiate()
	instance.position = pos
	instance.position.x += 6
	instance.position.y = 0.75
	instance.player = player
	$Enemies.add_child(instance)

func instChest(pos, color):
	print(color)
	var instance = chest.instantiate()
	instance.position = pos
	instance.position.y = 1.75
	instance.chestItem = color
	instance.locked = false
	$Objects.add_child(instance)

func instSkeleton(pos):
	var instance = skeleton.instantiate()
	instance.position = pos
	instance.position.y = 1.75
	instance.player = player
	$Enemies.add_child(instance)

func instDoor(pos, color, rot):
	var instance = door.instantiate()
	print(rot)
	if rot == 0:
		instance.rotation_degrees.y = 90
		instance.position = Vector3(pos.x+1.75, 3.25, pos.z+1.5)
	if rot == 10:
		instance.rotation_degrees.y = 90
		instance.position = Vector3(pos.x+.375, 3.25, pos.z-2.5)
	if rot == 16:
		instance.position = Vector3(pos.x+1.5, 3.25, pos.z)
	instance.key = color
	$Objects.add_child(instance)

func _on_player_magic():
	var inst = magic.instantiate()
	inst.position = player.position
	inst.rotation.x = $Player/Head/Camera3D.rotation.x
	inst.rotation.y = $Player/Head.rotation.y
	$Projectiles.add_child(inst)
