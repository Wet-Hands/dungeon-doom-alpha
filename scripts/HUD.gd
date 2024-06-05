extends Control

func _ready():
	$Label.text = " "

#func _on_area_3d_area_entered(area):
	#print("Area Entered")
	#if area.is_in_group("door"):
		#updateText("Open Door [E]")

func _on_hitbox_area_entered(area):
	if area.is_in_group("door"):
		updateText("Open Door [E]")
	if area.is_in_group("chest"):
		updateText("Open Chest [E]")
	if area.is_in_group("redCol"):
		updateText("Collect Red Key [E]")
	if area.is_in_group("greenCol"):
		updateText("Collect Green Key [E]")
	if area.is_in_group("blueCol"):
		updateText("Collect Blue Key [E]")
	if area.is_in_group("redLock"):
		updateText("Unlock Using Key [E]")
	if area.is_in_group("greenLock"):
		updateText("Unlock Using Key [E]")
	if area.is_in_group("blueLock"):
		updateText("Unlock Using Key [E]")

func _on_hitbox_area_exited(_area):
	$Label.text = " "

func _on_player_damage(num):
	if num < 0:
		$DamageAnim.play("dmg")
	if num > 0:
		$DamageAnim.play("hlt")

func _process(delta):
	$Label.text = str(Vector3i($"..".global_position))

func updateText(string):
	#var fullString = ""
	#for i in string.length():
		#fullString[i] = string[i]
		#if string[i+1] == " ":
			#fullString[i].add("[font_size=52]")
			#fullString[i+2].add("[font_size=86]")
	#$Label.text = "[center][font=res://assets/fonts/Pixtura12.ttf][font_size=86][outline_size=32][outline_color=black]" + string
	#$Label.position.x = ((1280-$Label.size.x)/2)
	pass
