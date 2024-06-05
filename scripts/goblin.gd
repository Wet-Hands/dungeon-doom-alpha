extends CharacterBody3D

@export var shaderT = 4.5
var maxHealth = 50
var curHealth = maxHealth
var speed = 1.5

@onready var navAgent = $NavigationAgent3D
@onready var player
@onready var shaderMat = preload("res://shaders/dissolveGoblin.tres")

var isDead = false
var isAtk = false

var active = false
func _ready():
	$Skeleton3D/Goblin.material_override.set_shader_parameter("LightStrength", 0) #Update Shader on Skeleton
	shaderT = 4.5
	active = false

func _process(delta):
	velocity = Vector3.ZERO
	navAgent.set_target_position(player.global_transform.origin)
	var nextNavPoint = navAgent.get_next_path_position()
	velocity = (nextNavPoint - global_transform.origin).normalized() * speed
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	if active == true:
		move_and_slide()
	if isAtk == false && isDead == false:
		$AnimationPlayer.speed_scale = 1
		$AnimationPlayer.play("walk")

func health(num):
	curHealth += num
	if curHealth <= 0:
		isDead = true
		$Skeleton3D/Goblin.material_override.set_shader_parameter("LightStrength", 1) #Update Shader on Skeleton
		$ShaderTimer.start()
		$ShaderAnim.play("shaderOn")
		$Gdeath.play()

func _on_area_3d_area_entered(area):
	if area.is_in_group("sword"):
		$Ghurt.play()
		health(-25)

func _on_shader_timer_timeout():
	$ShaderTimer.stop()
	if shaderT > 1.0:
		$Skeleton3D/Goblin.material_override.set_shader_parameter("ShaderTime", shaderT) #Update Shader on Skeleton
		$ShaderTimer.start()
	if shaderT == 1.0:
		queue_free()

func _on_int_area_area_entered(area):
	if area.is_in_group("player"):
		active = true
