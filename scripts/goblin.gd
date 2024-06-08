extends CharacterBody3D

@export var shaderT = 4.5 #Length of the Death Shader (Seconds)
@export var hurtT = 0.0 #Length of the Death Shader (Seconds)
var maxHealth = 60 #Maximum Goblin Health
var curHealth = maxHealth #Current Goblin Health
var speed = 1.5 #Goblin Speed
var curHurt = false

@onready var navAgent = $NavigationAgent3D #Navigation for Goblin
@onready var player #Player Reference
@onready var shaderMat = preload("res://shaders/dissolveGoblin.tres") #Shader Material

var isDead = false #Is Goblin Dead? (No)
var isAtk = false #Is Goblin Attacking? (No)
var active = false #Is Goblin Active? (No)

signal death

func _ready():
	$Skeleton3D/Goblin.material_override.set_shader_parameter("LightStrength", 0) #Disable Shader Light when Spawned
	shaderT = 4.5 #Set Shader Time
	active = false #Disable Goblin

func _process(delta): #While Goblin Scene is in Game
	velocity = Vector3.ZERO #Initial Velocity at Zero
	navAgent.set_target_position(player.global_transform.origin) #Set Target Position
	var nextNavPoint = navAgent.get_next_path_position() #Next Target Position
	velocity = (nextNavPoint - global_transform.origin).normalized() * speed #Move to Target
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP) #Look at Player
	if active == true: #If Goblin is Active
		move_and_slide() #Move Goblin
	if isAtk == false && isDead == false: #If Goblin is not Attacking or Dead
		$AnimationPlayer.speed_scale = 1 #Animation Speed at 1.0 (Base)
		$AnimationPlayer.play("walk") #Play Walk Animation

func health(num): #Goblin Health is Changed
	curHealth += num #Add Health to Current Health (Usually 'num' is negative)
	if curHealth <= 0 && isDead == false: #If Current Health is at Zero
		isDead = true #Goblin Is Dead
		$"/root/Global".kills += 1
		$Skeleton3D/Goblin.material_override.set_shader_parameter("LightStrength", 1) #Turn on Shader Health
		$ShaderTimer.start() #Start Shader Timer
		$AnimationPlayer.play("Death") #Play Death Animation
		$ShaderAnim.play("shaderOn") #Start Shader Animation
		$Gdeath.play() #Play Death Sound Effect
	if isDead == false:
		curHurt = true
		$HurtTimer.start()
		$ShaderAnim.play("hurt")
		$Ghurt.play() #Play Hurt Sound Effect

func _on_area_3d_area_entered(area): #If Goblin Hitbox Entered
	if area.is_in_group("sword"): #If Goblin is hit by Player's Sword
		health(-25) #Lose 25 Health

func _on_shader_timer_timeout(): #When Shader Timer runs out (0.1s)
	$ShaderTimer.stop() #Stop Shader Timer
	$AtkArea.remove_from_group("goblinAtk") #Disable Goblin Attack Range
	if shaderT > 1.0: #If ShaderTime is above 1s
		$Skeleton3D/Goblin.material_override.set_shader_parameter("ShaderTime", shaderT) #Update Shader Amount on Goblin
		$ShaderTimer.start() #Start Shader Timer
	if shaderT == 1.0: #If Shader Time is at 1.0s
		queue_free() #Send Goblin back to Hell

func _on_int_area_area_entered(area): #If Goblin Activiation Range is Entered
	if area.is_in_group("player"): #If Player enters Activiation Range
		active = true #Goblin is Active

func _on_atk_area_area_entered(area): #If Goblin Attack Range is Entered
	if area.is_in_group("player"): #If Goblin Attack Range is Entered by Player 
		if isDead == false: #If Goblin is Alive
			$AnimationPlayer.play("attack") #Play Attack Animation
			isAtk = true #Goblin Is Attacking

func _on_atk_area_area_exited(area): #If Goblin Attack Range is Exited
	isAtk = false #Goblin Isn't Attacking

func attackEnd(): #When Goblin Attack Animation Ends
	$AtkArea/CollisionShape3D.disabled = true #Disable Goblin Attack Collision
	if isAtk == true && isDead == false: #If Player is in Attack Range and Goblin is Alive
		$AnimationPlayer.play("attack") #Play Goblin Attack Animation
		$AtkArea/CollisionShape3D.disabled = false #Enable Goblin Attack Collision

func _on_hurt_timer_timeout():
	$HurtTimer.stop()
	$Skeleton3D/Goblin.material_overlay.set_shader_parameter("HurtTime", hurtT) #Update Shader Amount on Goblin
	$HurtTimer.start()

func _on_shader_anim_animation_finished(anim_name):
	if anim_name == "hurt":
		curHurt = false
