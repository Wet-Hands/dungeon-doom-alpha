extends Node3D

@export var open = false
@export var locked = true
@export var key = "none"
@export var endDoor = false

# Called when the node enters the scene tree for the first time.
func _ready(): #Called when the node enters the scene tree for the first time.
	$WhiteBack.visible = false
	$InteractArea.add_to_group("door")
	$InteractArea.add_to_group("endDoor")
	if key == "red":
		$InteractArea.add_to_group("redLock")
		$KeyholeRed.visible = true
		locked = true
	if key == "green":
		$InteractArea.add_to_group("greenLock")
		$KeyholeGreen.visible = true
		locked = true
	if key == "blue":
		$InteractArea.add_to_group("blueLock")
		$KeyholeBlue.visible = true
		locked = true
		
	if key == "none":
		locked = false
		
	if locked == false:
		$KeyholeRed.visible = false
		$KeyholeGreen.visible = false
		$KeyholeBlue.visible = false
		
	if endDoor == true:
		$RightTurnPoint/RightSide.material_override.albedo_color = "f2b834"
		$LeftTurnPoint/LeftSide.material_override.albedo_color = "f2b834" #f2bb78
		pass

func openFunc():
	if open == false:
		$Key.play()
		$DoorAnim.play("open")
		$Portal.add_to_group("portal")
		$SFX.play()
		$WhiteBack.visible = true
		open = true
		print("DOOR OPEN")
		$InteractArea.remove_from_group("door")
		$InteractArea.remove_from_group("endDoor")
		$InteractArea.add_to_group("endDoorOpen")

func _on_interact_area_area_entered(area):
	if area.is_in_group("redInt"):
			if $InteractArea.is_in_group("redLock"):
				locked = false
				$KeyholeRed.visible = false
				$Timer.start()
	if area.is_in_group("greenInt"):
		if $InteractArea.is_in_group("greenLock"):
			locked = false
			$KeyholeGreen.visible = false
			$Timer.start()
	if area.is_in_group("blueInt"):
		if $InteractArea.is_in_group("blueLock"):
			locked = false
			$KeyholeBlue.visible = false
			$Timer.start()
	if area.is_in_group("noneInt"):
		if locked == false:
			openFunc()
		else:
			$KeyFail.play()


func _on_timer_timeout():
	$InteractArea.remove_from_group("redLock")
	$InteractArea.remove_from_group("greenLock")
	$InteractArea.remove_from_group("blueLock")
