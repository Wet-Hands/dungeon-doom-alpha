extends Control

func _ready():
	$Label.text = " "

func _on_area_3d_area_entered(area):
	print("Area Entered")
	if area.is_in_group("door"):
		$Label.text = "Open Door"

func _on_hitbox_area_entered(area):
	if area.is_in_group("door"):
		$Label.text = "Open Door [E]"
	if area.is_in_group("chest"):
		$Label.text = "Open Chest [E]"
	if area.is_in_group("redCol"):
		$Label.text = "Collect Red Key [E]"
	if area.is_in_group("greenCol"):
		$Label.text = "Collect Green Key [E]"
	if area.is_in_group("blueCol"):
		$Label.text = "Collect Blue Key [E]"
	if area.is_in_group("redLock"):
		$Label.text = "Unlock Using Key [E]"
	if area.is_in_group("greenLock"):
		$Label.text = "Unlock Using Key [E]"
	if area.is_in_group("blueLock"):
		$Label.text = "Unlock Using Key [E]"

func _on_hitbox_area_exited(_area):
	$Label.text = " "

func _on_player_damage(num):
	if num < 0:
		$DamageAnim.play("dmg")
	if num > 0:
		$DamageAnim.play("hlt")
