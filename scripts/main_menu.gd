extends Control

func toggle():
	visible = !visible
	get_tree().paused = visible

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE #How mouse movement SHOULD work
	$Video/HBoxContainer/Checks/BrightSlide.value = $"/root/Global".brightness
	$Video/HBoxContainer/Checks/Roll.button_pressed = $"/root/Global".roll

var levels = ["res://levels/level1/level_1.tscn", "res://level_2.tscn", "res://levels/level3/level_3.tscn", "res://levels/level4/level_4.tscn", "res://levels/level5/level_5.tscn"]
func _on_start_pressed():
	toggle()
	get_tree().change_scene_to_file("res://scenes/UI/level_menu.tscn") #Go to Next Level

func menuUpdate(first, second):
	first.show()
	second.hide()

func _on_settings_pressed():
	$Gui.play()
	menuUpdate($Settings, $Menu)
	$TitleRect.visible = false
	$CreditsButton.hide()

func _on_settingsback_pressed(): 
	$Gui.play()
	menuUpdate($Menu, $Settings)
	$TitleRect.visible = true
	$CreditsButton.show()

func _on_exit_pressed():
	get_tree().quit()

func _on_video_pressed():
	$Gui.play()
	menuUpdate($Video, $Settings)

func _on_audio_pressed():
	$Gui.play()
	menuUpdate($Audio, $Settings)

func _on_video_back_pressed():
	$Gui.play()
	menuUpdate($Settings, $Video)

func _on_fullscreen_toggled(toggled_on):
	$Gui.play()
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_audio_back_pressed():
	$Gui.play()
	menuUpdate($Settings, $Audio)

var Masterindex = AudioServer.get_bus_index("Master")
var IGindex = AudioServer.get_bus_index("In-Game")
var Monsterindex = AudioServer.get_bus_index("Monster")
var Musicindex = AudioServer.get_bus_index("Music")
func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(Masterindex, linear_to_db(value))

func _on_in_game_value_changed(value):
	AudioServer.set_bus_volume_db(IGindex, linear_to_db(value))

func _on_monsters_value_changed(value):
	AudioServer.set_bus_volume_db(Monsterindex, linear_to_db(value))

func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(Musicindex, linear_to_db(value))

func _on_credits_button_pressed():
	$Gui.play()
	menuUpdate($Credits, $Menu)
	$CreditsButton.hide()
	$TitleRect.hide()
	$CreditsBackButton.show()

func _on_credits_back_button_pressed():
	$Gui.play()
	menuUpdate($Menu, $Credits)
	$CreditsButton.show()
	$TitleRect.show()
	$CreditsBackButton.hide()

func _on_roll_toggled(toggled_on):
	$Gui.play()
	$"/root/Global".roll = toggled_on
	$CanvasLayer/ColorRect.material.set_shader_parameter("roll", toggled_on)
	if $"/root/Global".roll == false:
		$CanvasLayer/ColorRect.material.set_shader_parameter("roll_size", 0)
	else:
		$CanvasLayer/ColorRect.material.set_shader_parameter("roll_size", 9.34)

func _on_bright_slide_value_changed(value):
	$"/root/Global".brightness = value
	$CanvasLayer/ColorRect.material.set_shader_parameter("brightness", $"/root/Global".brightness)
