extends Control

func toggle():
	visible = !visible
	get_tree().paused = visible

func _on_start_pressed():
	toggle()
	get_tree().change_scene_to_file("res://levels/level1/level_1.tscn")

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

var index = AudioServer.get_bus_index("Master")
func _on_volume_value_changed(value):
	AudioServer.set_bus_volume_db(index, linear_to_db(value))

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
