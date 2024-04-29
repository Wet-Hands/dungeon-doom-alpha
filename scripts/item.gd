extends Node3D

var item = "none"
var items = ["none", "sword", "heal", "red", "green", "blue"]
var itemTextures = ["none", "sword", "heal", "res://assets/hud/redKey16.png", "res://assets/hud/greenKey16.png", "res://assets/hud/blueKey16.png"]
var itemGroups = ["noneCol", "swordCol", "healCol", "redCol", "greenCol", "blueCol"]
var itemNum
@onready var chest = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_area_3d_area_entered(area):
	if area.is_in_group("noneInt"):
		$Sprite3D.texture = null
		call_deferred("_disableCollisionShape3D")

func _disableCollisionShape3D():
	$Area3D/CollisionShape3D.disabled = true

func _on_chest_ch_item(chItemVar):
	print("Connected to Item" + str(chItemVar))
	item = chItemVar
	$Area3D/CollisionShape3D.disabled = true
	for i in range(len(items)):
		if items[i] == item:
			itemNum = i
	$Sprite3D.texture = ResourceLoader.load(itemTextures[itemNum])
	$Area3D.add_to_group(itemGroups[itemNum])
