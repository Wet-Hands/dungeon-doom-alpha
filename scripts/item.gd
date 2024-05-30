extends Node3D

var item = "none"
var items = ["none", "sword", "heal", "red", "green", "blue"]
var itemTextures = ["none", "sword", "res://assets/hud/health2/health100.png", "res://assets/hud/redKey16.png", "res://assets/hud/greenKey16.png", "res://assets/hud/blueKey16.png"]
var itemGroups = ["noneCol", "swordCol", "healCol", "redCol", "greenCol", "blueCol"] #Item Collision Group
var itemNum #Item Number in Array
@onready var chest = $".." #Chest Scene

func _on_area_3d_area_entered(area):
	if area.is_in_group("noneInt"):
		$Sprite3D.texture = null
		call_deferred("_disableCollisionShape3D") #Fix for Stupid Error

func _disableCollisionShape3D(): #Disable Item Collision Function
	$Area3D/CollisionShape3D.disabled = true #Disable Item Collision

func _on_chest_ch_item(chItemVar):
	print("Connected to Item" + str(chItemVar))
	item = chItemVar
	$Area3D/CollisionShape3D.disabled = true
	for i in range(len(items)):
		if items[i] == item:
			itemNum = i
	$Sprite3D.texture = ResourceLoader.load(itemTextures[itemNum]) #Load Item Texture from Array using ItemNum
	$Area3D.add_to_group(itemGroups[itemNum]) #Add Item Interaction Group from Array using ItemNum
