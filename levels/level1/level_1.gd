extends Node3D

@onready var player = $Player
@onready var grid = $NavigationRegion3D/GridMap

var test = Vector3(0, 0, 0)
func _ready():
	print("Cell: " + str(grid.get_cell_item(test)))

func _physics_process(_delta):
	get_tree().call_group("skeleton" , "update_target_location" , player.global_position)
	
