extends Control

@export_category("Gameplay References")
@export var player: PlayerMovement
@export var score: Score

@export_category("Gameplay UI Elements")
@export var speedometerNeedle: TextureRect
@export var scoreText: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speedometerNeedle.rotation_degrees = -10 + (player.GetSpeed()/player.GetMaxSpeed())*278 #278 is degrees between max and min speeds
	scoreText.text = "Score: %.0f" % [score.GetScore()]
