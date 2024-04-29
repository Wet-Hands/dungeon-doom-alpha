extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = $"../Player"
@onready var hitbox = $Hitbox
@onready var atkAnim = $Sketchfab_Scene/Sketchfab_model/MovementAnim
@onready var atkHitbox = $attack/MeshInstance3D/skeleAtkHitbox
var speed = 100 #Skeleton Walking Speed
#var speed = 50
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") #Gravity from Physics

@export var level = 1 #Skeleton Level
var maxHealth = [25, 50, 75, 100] #Maximum Skeleton Health based on Level
var curHealth #Current Skeleton Health
var curHit = false #Has Skeleton been hit during swing? (No)
var dead = false #Is skeleton dead? (No)
var inLight = false #is skeleton in Light
var inEdgeLight = false #is skeleton on edge of Light
var playerInfront = false #is player infront of skeleton
var doAtk = false

var detected = false

@export var shaderL = 4.5
@onready var ob34 = $Sketchfab_Scene/Sketchfab_model/skeleton_fbx/RootNode/rig/Object_4/Skeleton3D/Object_34

func _ready():
	ob34.material_override.set_shader_parameter("LightStrength", 0) #Update Shader on Skeleton
	curHealth = maxHealth[level] #Skeleton Starting Health at 100%
	hitbox.monitoring = true #Skeleton can be Attacked by Player

func _process(delta): #If Game is runnong
	if dead == false: #If Skeleton is alive
		if not is_on_floor(): #If Skeleton is in-air
			velocity.y -= gravity * delta #Gravity
		else: #If Skeleton on ground?
			velocity.y -= 2 #Weak Gravity?
		var next_location = nav_agent.get_next_path_position()
		var current_location = global_position #Finds skeletons current location
		var new_velocity = current_location.direction_to(next_location) * speed * delta
		if inLight == true:
			velocity.x = new_velocity.x * -1
			velocity.z = new_velocity.z * -1
		elif inEdgeLight == true: #checks if the skeleton is on the edge of the Light
			velocity = new_velocity * 0 #stops the skeleton's movement
		else:
			velocity = new_velocity #sets skeleton's velocity to default
			
		if playerInfront == true && doAtk == false:
			$attack/MeshInstance3D.visible = false
			$attack/MeshInstance3D/skeleAtkHitbox/skeleAtkCollision.disabled = true
			atkHitbox.monitoring = false
			doAtk = true
			$attackCooldown.start()
		move_and_slide()

func update_target_location(target_location):
	if detected == true:
		nav_agent.target_position = target_location #changes target for path finding to players current location

func _physics_process(_delta): #While Physics is happening (Always)
	if dead == false:
		look_at(player.global_position) #Look at Player

func health(num): #Change Player health
	curHealth += num #Update Current Health by num
	if curHealth <= 0: #If Health reaches 0
		dead = true #Skeleton Dead
		$CollisionShape3D.position = Vector3(0, 100, 0) #sends collision shape to hell before the skeleton
		call_deferred("_disableCol")
		ob34.material_override.set_shader_parameter("LightStrength", 1) #Update Shader on Skeleton
		$ShaderTimer.start() #Shader Update Timer Starts
		$ShaderAnim.play("shader") #Play Shader Animation
		$Death1.play() #Play Death Animation

func _disableCol():
	$Hitbox.monitoring = false
	$CollisionShape3D.disabled = true
	$Hitbox/HitBoxCollision.disabled = true

func _on_shader_timer_timeout(): #When Shader Update is Ready
	$ShaderTimer.stop() #Stop Timer
	if shaderL > 1.0: #If Shader is complete
		ob34.material_override.set_shader_parameter("ShaderTime", shaderL) #Update Shader on Skeleton
		$ShaderTimer.start() #Start Timer (Looped)
	if shaderL == 1.0: #If Shader is complete
		goToHell() #Send Skeleton back to where he came from

func goToHell():
	position = Vector3(0, 100, 0) #TEMP FIX - Sends Skeleton back to Hell

func _on_hitbox_area_entered(area): #If hit by sword
	if area.is_in_group("Light"): #If in Light
		inLight = true #skele is in Light
		inEdgeLight = true #skele is in Edge (to check for exit later)
	if area.is_in_group("sword"): #If it's hit by sword
		if curHit == false: #If the swing hasn't already damaged the skeleton
			health(-25) #Lose 25 Health
			curHit = true #Skeleton Been Hit in Swing
			$HitTimer.start() #Start Timer 'til next swing

func _on_hit_timer_timeout(): #SWINGIN' TIME!
	$HitTimer.stop() #Stop Timer when complete
	curHit = false #Skeleton can be hit

func _on_hitbox_area_exited(area): #checks if anything has left the skeleton's hitbox
	if area.is_in_group("Light"): #if the skele leaves the Light area
		inLight = false #sets skeleton in light to false
	if area.is_in_group("EdgeLight"): #if the skele leaves the edge of the light
		inEdgeLight = false #sets skeleotn in edge of light to false

func _on_attack_cooldown_timeout(): #When Cooldown is Over
	$attackCooldown.stop() #Stop Timer
	doAtk = false
	$attack/MeshInstance3D.visible = true
	$attack/MeshInstance3D/skeleAtkHitbox/skeleAtkCollision.disabled = false
	atkHitbox.monitoring = true

func _on_skele_atk_hitbox_area_entered(area):
	if area.is_in_group("player"):
		playerInfront = true

func _on_skele_atk_hitbox_area_exited(area):
	if area.is_in_group("player"):
		playerInfront = false

func _on_detection_area_entered(area):
	if area.is_in_group("player"):
		detected = true

func _on_detection_area_exited(area):
	if area.is_in_group("player"):
		detected = false
