extends CharacterBody3D

class_name PlayerHealth

@export_category("Player References")
@export var playerMovement: PlayerMovement
@export var carStates: Array[Node3D]
@export var score: Score

var activeModel: Node3D

@export_category("Player Health Variables")
@export var health : int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activeModel = carStates[health-1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#function called to damage  the vehicle
func TakeDamage() -> void:
	
	health -= 1
	playerMovement.EmergencyShift()
	SwitchModel()
	
	score.ResetFlawless()

func SwitchModel() -> void:
	
	if(health > 0 && health <= carStates.size()):
		
		activeModel.visible = false
		activeModel = carStates[health-1]
		activeModel.visible = true
