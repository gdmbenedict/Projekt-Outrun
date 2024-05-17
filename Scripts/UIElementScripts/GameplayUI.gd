extends Control
 
@export_category("Gameplay UI Elements")
@export var scoreText: Label

@export_category("Speedometer Settings")
@export var speedometerNeedle: TextureRect
@export var speedometerReading: Label
@export var sAngularDistance: float = 269 #angle distance between min and max values
@export var sMinAngle: float = -3.5 #minimum angle of rotation for the needle

@export_category("Fuel Guage Settings")
@export var fuelGaugeNeedle: TextureRect
@export var fuelGaugeReading: Label
@export var fAngularDistance: float = 135 #angle distance between min and max values
@export var fMinAngle: float = 65 #minimum angle of rotation for the needle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	HandleSpeedometer()
	HandleFuelGauge()
	HandleScoreText()

func HandleSpeedometer() -> void:
	speedometerNeedle.rotation_degrees = sMinAngle + (GameManager.playerMovement.GetSpeed()/GameManager.playerMovement.GetMaxSpeed())*sAngularDistance
	speedometerReading.text = "%03d" % (int)(GameManager.playerMovement.GetSpeed())

func HandleFuelGauge() -> void:
	fuelGaugeNeedle.rotation_degrees = fMinAngle + (GameManager.playerMovement.GetFuel()/GameManager.playerMovement.GetMaxFuel())*fAngularDistance
	
	var remainingTime = GameManager.playerMovement.GetFuel()/GameManager.playerMovement.GetFuelCon()
	var minReading: int = (int)(remainingTime)
	var secReading: int = (int)((remainingTime - (int)(remainingTime))*60)
	
	fuelGaugeReading.text = "%02d:%02d" % [minReading, secReading]

func HandleScoreText() -> void:
	scoreText.text = "Score: %.0f" % GameManager.playerScore.GetScore()

