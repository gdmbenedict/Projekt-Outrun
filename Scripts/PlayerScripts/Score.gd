extends Node

class_name Score

var score: float
var scoreMult: float

var playerSpeed: float
var flawlessTimer: float

@export_category("ScoreMult Base Values")
@export var baseSpeed: float = 100
@export var baseFlawless: float = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	GameManager.playerScore = self
	GameManager.scoreReady = true
	
	#setting score values to zero
	score = 0
	scoreMult = 0
	
	#setting tracked values to zero
	playerSpeed = 0
	flawlessTimer = 0 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#adding score per second
	score += 1 * delta * scoreMult
	
	#updating values
	playerSpeed = GameManager.playerMovement.GetSpeed()
	flawlessTimer += delta
	CalcScoreMult()
	
	#debug
	#print("%.2f" % score)

#Function that calculates the score multiplier
func CalcScoreMult() -> void:
	scoreMult = (playerSpeed/baseSpeed) + (flawlessTimer/baseFlawless)

func AddScore(scoreAdd: int) -> void:
	score += scoreAdd * scoreMult

#Function that resets the flawless timer
func ResetFlawless() -> void:
	flawlessTimer = 0

func GetScore() -> float:
	return score
