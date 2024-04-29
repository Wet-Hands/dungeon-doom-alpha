extends Node3D

@export var open = false
@export var chestItem = "none"
@export var key = "none"
@export var locked = false
signal chItem(chItemVar)

var keyCGroup = ["red", "green", "blue", "none"]
var keyGroup = ["redLock", "greenLock", "blueLock", "none"] #Key Lock Groups
var intGroup = ["redInt", "greenInt", "blueInt", "noneInt"] #Key Interaction Groups
var holeColors = ["ff1a16", "49ff17", "1749ff", "ffffff"] #Lock Color
var lockGroup = [true, true, true, false]
var num = 0

func _ready(): #Called when the node enters the scene tree for the first time.
	for i in range(len(keyCGroup)):
		if keyCGroup[i] == key:
			num = i
	if chestItem == "none":
		$Item.visible = false
	$OpenArea.add_to_group("chest")
	$ChestAnim.seek(0.0, true, false)
	emit_signal("chItem", chestItem)
	$OpenArea.add_to_group(keyGroup[num])
	$Keyhole.material_override.albedo_color = holeColors[num]
	locked = lockGroup[num]

	if locked == false:
		$Keyhole.visible = false

func _on_open_area_area_entered(area):
	if area.is_in_group(intGroup[3]):
		if locked == false:
			openFunc()
	if area.is_in_group(intGroup[num]):
		if $OpenArea.is_in_group(keyGroup[num]):
			locked = false
			$Keyhole.visible = false

func openFunc():
	if open == false:
		$OpenArea.remove_from_group("chest")
		$Key.play()
		$ChestAnim.play("open")
		open = true

func itemCollection():
	$Item/Area3D/CollisionShape3D.disabled = false
