extends CharacterBody3D

const speed = 4 #Movement Velocity? [THIS IS A JOKE, unless if i was right]
var speedMulti = 1.0 #Movement Multiplier
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") #Gravity from Project Settings (9.81)

var anim_names #changed depending on what animation needs to be used (this is for my sanity in checking what animation is currently playing there is probably a better way but its late and I'm tired)
@onready var cam = $Head/Camera3D #Camera Variable
@onready var swordAnim = $Head/SwordAnimation #movement animation variable

@onready var SwordHitbox = $Head/Camera3D/Items/Sword/SwordMesh/SwordHitbox #hitbox of the sword
@onready var LightHitbox = $Head/Camera3D/Items/Shield/ShieldHitbox #hitbox for the Light

var fs = false #Is fullscreen on or off
var camSens = .25 #Camera Speed Sensitivity

@export var maxHealth = 100 #Max Health
var currentHealth #Health Player is at
var maxFuel = 100 #Max Fuel
var currentFuel #Fuel Player is at

var initPos #Initial Position of Player

signal pause
signal damage
signal magic

var light #Is lantern on or off
var shield = false
var shieldUp = false

func _ready():
	shield = false
	Engine.max_fps = 60 #Set FPS to 60
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN #Temp Fix for working on Virtual Machine
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #How mouse movement SHOULD work
	currentHealth = maxHealth #Set Current Health to Max
	$HUD/ProgressBar.max_value = maxHealth #Set Max Health Visually
	$HUD/HeartRect.texture = ResourceLoader.load("res://assets/hud/health/heartFull16.png")
	initPos = global_position
	light = false
	$Head/Camera3D/Items/Shield.position.y = -1.25
	switched = false

@onready var magicBall = preload("res://scenes/projectiles/magic_ball.tscn")
func _input(event): #When any input is made, better than checking constantly with _process
	if event is InputEventMouseMotion: #If mouse is moving
		$Head.rotate_y(-event.relative.x * camSens * get_process_delta_time()) #Look left and right
		cam.rotate_x(-event.relative.y * camSens * get_process_delta_time()) #Look up and down
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-50), deg_to_rad(60)) #Stop turning so player's neck doesn't break
	if Input.is_action_just_pressed("action1"): #If Left Mouse Click is pressed
		if shield == false:
			swordAnim.play("Attack") #Play Attack Animation
			$Swing.play() #Swing Sound Plays
			anim_names = "Attack"
			$Head/Camera3D/Items/Sword/SwordMesh/SwordHitbox/CollisionShape3D.disabled = false #Enable swordHitbox
			SwordHitbox.monitoring = true #turns the hitbox monitoring on
	if Input.is_action_pressed("action2"): #If Right Mouse Click is pressed
		shield = true
		if shieldUp == false:
			speedMulti = .33
			$Head/ShieldAnimation.play("switch")
			shieldUp = true
	
	if Input.is_action_just_released("action2"):
		$Head/ShieldAnimation.play_backwards("switch")
		speedMulti = 1
		shield = false
		shieldUp = false
	if Input.is_action_just_pressed("fullScreen"): #If "f" or "f11" are pressed
		if fs == false: #If Fullscreen is off
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) #Full Screen
			fs = true #Fullscreen is on
		else: #If Fullscreen is on
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) #Windowed
			fs = false #Fullscreen is off
	if Input.is_action_just_pressed("exit"):#when backspace is pressed
		get_tree().quit() #quits game
	if Input.is_action_just_pressed("pause"):#when backspace is pressed
		emit_signal("pause")

func _physics_process(delta): #If physics is happening (always)
	if not is_on_floor(): #If in the air
		velocity.y -= gravity * delta #Apply Gravity

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBack") #Input Vector based on inputs from WASD
	var direction = ($Head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() #Math shit
	if direction: #tf you mean "if direction" [THIS IS A JOKE, mostly]
		velocity.x = direction.x * (speed * speedMulti)
		velocity.z = direction.z * (speed * speedMulti)
	else:
		velocity.x = move_toward(velocity.x, 0, (speed * speedMulti))
		velocity.z = move_toward(velocity.z, 0, (speed * speedMulti))
	if input_dir.y>0: #If player is moving forward
		headBob()
	elif input_dir.y<0: #If player is moving backwards
		headBob()
	elif input_dir.x<0: #If player is moving left
		headBob()
	elif input_dir.x>0: #If player is moving right
		headBob()
	else:
		if anim_names != "Attack": #If Attack isn't happening
			SwordHitbox.monitoring = false #Turn off Hitbox
			swordAnim.play("Idle") #Play Idle Animation
			anim_names = "Idle" 
	move_and_slide() #Brings it all together
	
	for i in get_slide_collision_count(): #Collision Stuff
		var c = get_slide_collision(i) #Collision Stuff
		if c.get_collider() is RigidBody3D: #If Colliding with RigidBody
			c.get_collider().apply_central_impulse(-c.get_normal()) #Apply Force to RigidBodies

func headBob(): #Headbob Function
	if anim_names != "Attack": #If Attack isn't happening
		SwordHitbox.monitoring = false #Turn off Hitbox
		swordAnim.play("Walk") #Walk
		anim_names = "Walk" 
	$Head/Headbob.play("bob")

func playFootStep(): #Footstep sound for Headbob animation
	$Footstep.pitch_scale = randf_range(0.8, 1.0) #Change Pitch so you don't sound like you're banging your head against the wall
	$Footstep.play() #Play Footstep sound

func health(num): #Change Player health
	if shield == false || num > 0:
		currentHealth += num #Update Current Health by num
		emit_signal("damage", num) #Play Damage Flash
		if currentHealth <= 0: #If Player Dies
			position = initPos #Return to Start
			currentHealth = 100 #Reset Health back to Full
		if currentHealth >= 100:
			currentHealth = 100
		$HUD/HeartRect.texture = ResourceLoader.load("res://assets/hud/health2/health" + str(currentHealth) + ".png") #Update Health Meter

func fuel(num):
	currentFuel += num
	var cf = currentFuel #100, 91, 78, 65, 52, 39, 26, 13, 0
	if cf == 100 || cf == 92 || cf == 78 || cf == 64 || cf == 52 || cf == 38 || cf == 26 || cf == 12 || cf == 0:
		$HUD/FuelRect.texture = ResourceLoader.load("res://assets/hud/Fuel/Fuel" + str(cf) + ".png")

func _on_animation_player_animation_finished(anim_name): #plays after animation is finished
	if anim_name == "Attack": #if the annimation is "Attack" 
		swordAnim.play("Idle") #set animation to "Walk"
		anim_names = "Idle"
		$Head/Camera3D/Items/Sword/SwordMesh/SwordHitbox/CollisionShape3D.disabled = true #Disable Hitbox
		SwordHitbox.monitoring = false #sets hitbox monitoring to false

var inLava = false
func _on_hitbox_area_entered(area): #When Player Enters Area
		if area.is_in_group("goblinAtk"):
			health(-10) #Lose 10 Health
		if area.is_in_group("skeleAttack"): #If it's hit by Skeleton
			health(-10) #Lose 10 Health
		if area.is_in_group("lava"):
			inLava = true
			$LavaTimer.start()
		if area.is_in_group("magi"): #If Player Hit by Magic
			health(-20) #Lose 20 Health per Ball
		if area.is_in_group("portal"): #If Players Enters Portal
			$"/root/Global".level += 1 #Level Var +1
			if $"/root/Global".level == 5: #If Game is Beaten
				$"/root/Global".level = 0 #Return to Main Menu Num
			call_deferred("nextLevel") #Fix for Stupid Errors

func _on_hitbox_area_exited(area):
	if area.is_in_group("lava"):
		inLava = false
		$LavaTimer.stop()

func nextLevel(): #Next Level Function
	get_tree().change_scene_to_file(levels[$"/root/Global".level]) #Go to Next Level
	#get_tree().change_scene_to_file("res://scenes/UI/level_menu.tscn")

var levels = ["res://scenes/UI/main_menu.tscn", "res://level_2.tscn", "res://levels/level3/level_3.tscn", "res://levels/level4/level_4.tscn", "res://levels/level5/level_5.tscn"]

var switched

func _on_lava_timer_timeout():
	if inLava == true:
		health(-10)

var sTime = 0
func _on_timer_timeout():
	$SoundTimer.stop()
	sTime += 1
