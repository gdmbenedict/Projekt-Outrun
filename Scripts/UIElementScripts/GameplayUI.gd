extends Control
 
@export_category("Gameplay UI Elements")
@export var speedometerNeedle: TextureRect
@export var speedometerReading: Label
@export var scoreText: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	speedometerNeedle.rotation_degrees = -10 + (GameManager.playerMovement.GetSpeed()/GameManager.playerMovement.GetMaxSpeed())*270 #275 is degrees between max and min speeds
	speedometerReading.text = "%3.f" % GameManager.playerMovement.GetSpeed()
	scoreText.text = "Score: %.0f" % GameManager.playerScore.GetScore()
