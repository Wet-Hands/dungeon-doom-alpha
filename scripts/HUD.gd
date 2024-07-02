extends Control

func _ready():
	$Label2.text = " "

#func _on_area_3d_area_entered(area):
	#print("Area Entered")
	#if area.is_in_group("door"):
		#updateText("Open Door [E]")

func _on_hitbox_area_entered(area):
	if area.is_in_group("door"):
		updateText("Open Door [e]")
	if area.is_in_group("chest"):
		updateText("Open Chest [e]")
	if area.is_in_group("redCol"):
		updateText("Collect Red Key [e]")
	if area.is_in_group("greenCol"):
		updateText("Collect Green Key [e]")
	if area.is_in_group("blueCol"):
		updateText("Collect Blue Key [e]")
	if area.is_in_group("redLock"):
		updateText("Unlock Using Key [e]")
	if area.is_in_group("greenLock"):
		updateText("Unlock Using Key [e]")
	if area.is_in_group("blueLock"):
		updateText("Unlock Using Key [e]")
	if area.is_in_group("healCol"):
		updateText("Collect Heart [e]")
func _on_hitbox_area_exited(_area):
	$Label2.text = " "

func _on_player_damage(num):
	if num < 0:
		$DamageAnim.play("dmg")
	if num > 0:
		$DamageAnim.play("hlt")

#func _process(delta):
	##$Label.text = str(Vector3i($"..".global_position))

func updateText(string):
	$Label2.text = "[font=res://assets/fonts/Pixtura12.ttf][font_size=64][center]" + str(string)
	#var fullString = ""
	#for i in string.length():
		#fullString[i] = string[i]
		#if string[i+1] == " ":
			#fullString[i].add("[font_size=52]")
			#fullString[i+2].add("[font_size=86]")
	#$Label.text = "[center][font=res://assets/fonts/Pixtura12.ttf][font_size=86][outline_size=32][outline_color=black]" + string
	$Label2.position.x = ((1280-$Label2.size.x)/2)
