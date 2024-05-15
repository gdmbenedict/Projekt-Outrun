class_name RepairPickup
extends Pickup

@export_category("Repair Variables")
@export var healing: int = 1

func UsePickup() -> void:
	GameManager.playerHealth.Repair(healing)
	super.UsePickup()
