class_name FuelPickup
extends Pickup

@export_category("Fuel")
@export var fuel: float = 10

func UsePickup() -> void:
	GameManager.playerMovement.AddFuel(fuel)
	super.UsePickup()
