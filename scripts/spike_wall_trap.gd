extends Node3D

var active #Is Trap Active (True/False)

func _ready(): #Called when the node enters the scene tree for the first time.
	$Spikes.position.z = -1.6 #Spikes At Initial Position
	active = true #Trap is Active

func _on_area_3d_area_entered(area): #If Player Enters Spikes
	if area.is_in_group("player") && active == true: #If Player Enters Trap Area & Are Active
		$AnimationPlayer.play("start") #Spikes Shoot Out
		$SpikeAudio.pitch_scale = 1.5 #Spike Sound Setup
		$SpikeAudio.play() #Play Spike Sound
		active = false #Trap not Active
		$Timer.start() #Timer Starts (3s)

func _on_timer_timeout(): #Timer Stops
	$Timer.stop() #Stop Timer
	$AnimationPlayer.play("end") #Retract Spikes
	$SpikeAudio.pitch_scale = 1.0 #Spike Sound Setup
	$SpikeAudio.play() #Play Spike Sound
	await get_tree().create_timer(1.0).timeout #Wait 1s
	$Warning.pitch_scale = 1.00 #Warning Sound Setup
	$Warning.play() #Play Warning Tick (1/3)
	await get_tree().create_timer(1.0).timeout #Wait 1s
	$Warning.play() #Play Warning Tick (2/3)
	await get_tree().create_timer(1.0).timeout #Wait 1s
	$Warning.pitch_scale = 1.35 #Warning Sound Setup
	$Warning.play() #Play Final Warning Tick (3/3)
	await get_tree().create_timer(1.0).timeout #Wait 1s
	active = true #Trap is Active
