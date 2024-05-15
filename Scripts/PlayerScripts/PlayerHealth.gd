extends CharacterBody3D

class_name PlayerHealth

@export_category("Player References")
@export var carStates: Array[Node3D]

var activeModel: Node3D

@export_category("Player Health Variables")
@export var health : int = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameManager.playerHealth = self
	GameManager.healthReady = true
	
	activeModel = carStates[health-1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#function called to damage  the vehicle
func TakeDamage() -> void:
	
	health -= 1
	GameManager.playerMovement.EmergencyShift()
	SwitchModel()
	
	GameManager.playerScore.ResetFlawless()
	
	if(health <= 0):
		GameManager.EndGame()

func SwitchModel() -> void:
	
	if(health > 0 && health <= carStates.size()):
		
		activeModel.visible = false
		activeModel = carStates[health-1]
		activeModel.visible = true
