class_name PointPickup
extends Pickup

@export_category("Points")
@export var points: int = 100

func UsePickup() -> void:
	GameManager.playerScore.AddScore(points)
