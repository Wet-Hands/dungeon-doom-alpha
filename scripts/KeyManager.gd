extends Node3D

var keyInv = "none"
var keyIntGroup = ["redInt", "greenInt", "blueInt", "noneInt"]
var keyTexGroup = ["res://assets/hud/redKey16.png", "res://assets/hud/greenKey16.png", "res://assets/hud/blueKey16.png"]
var lockGroup = ["redLock", "greenLock", "blueLock", "noneLock"]
var colGroup = ["redCol", "greenCol", "blueCol"]

func _ready(): #Called when the node enters the scene tree for the first time.
	$KeyArea/KeyCol.disabled = true
	if keyInv == "red":
		$KeyArea.add_to_group("redInt")
		$"../HUD/KeyRect".texture = ResourceLoader.load("res://assets/hud/redKey16.png")
	if keyInv == "green":
		$KeyArea.add_to_group("greenInt")
		$"../HUD/KeyRect".texture = ResourceLoader.load("res://assets/hud/greenKey16.png")
	if keyInv == "blue":
		$KeyArea.add_to_group("blueInt")
		$"../HUD/KeyRect".texture = ResourceLoader.load("res://assets/hud/blueKey16.png")

func _process(_delta): #Called every frame. 'delta' is the elapsed time since the previous frame.
	if Input.is_action_pressed("interact"):#when backspace is pressed
		if $"..".shield == false:
			$KeyArea/KeyCol.disabled = false
			var group = $KeyArea.get_groups()
	if Input.is_action_just_released("interact"):
		if $"..".shield == false:
			$KeyArea/KeyCol.disabled = true

func _on_key_area_area_entered(area):
	if keyInv == "redInt":
		if area.is_in_group("redLock"):
			keyReset("redInt")
	if keyInv == "greenInt":
		if area.is_in_group("greenLock"):
			keyReset("greenInt")
	if keyInv == "blueInt":
		if area.is_in_group("blueLock"):
			keyReset("blueInt")
	else:
		if area.is_in_group("noneLock"):
			keyInv = "noneInt"

	if area.is_in_group("redCol"):
		keyInv = "redInt"
		$KeyArea.add_to_group("redInt")
		$"../HUD/KeyRect".texture = ResourceLoader.load("res://assets/hud/redKey16.png")
	if area.is_in_group("greenCol"):
		keyInv = "greenInt"
		$KeyArea.add_to_group("greenInt")
		$"../HUD/KeyRect".texture = ResourceLoader.load("res://assets/hud/greenKey16.png")
	if area.is_in_group("blueCol"):
		keyInv = "blueInt"
		$KeyArea.add_to_group("blueInt")
		$"../HUD/KeyRect".texture = ResourceLoader.load("res://assets/hud/blueKey16.png")
	if area.is_in_group("healCol"):
		$"..".health(50)

func keyReset(_col):
	keyInv = "noneInt"
	$KeyArea.add_to_group("noneInt")
	$"../HUD/KeyRect".texture = null
