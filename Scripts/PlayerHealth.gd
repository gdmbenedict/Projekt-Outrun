extends CharacterBody3D

class_name PlayerHealth

@export_category("Player References")
@export var playerMovement: PlayerMovement
@export var carStates: Array[Node3D]

@export_category("Player Health Variables")
@export var health : int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#function called to damage  the vehicle
func TakeDamage() -> void:
	playerMovement.EmergencyShift()
