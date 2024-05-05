extends Node3D

@export_category("Player")
@export var playerPos: Node3D
@export var player: PlayerMovement

@export_category("Tiles")
@export var tileSize: float
@export var tiles: Array[PackedScene]

@export_category("Generation Parameters")
@export var gridSize: Vector2
@export var startPosOffset: float
var generatedTiles = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InitialGeneration()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#function that calls the initial generation of the grid
func InitialGeneration() -> void:
	
	#check to see if x-axis number of tiles is even or odd
	if(int(gridSize.x) % 2 == 0):
		EvenInitGeneration()
	else:
		OddInitGeneration()
	

#function that initialized and places randomized tiles at start of game for an odd sized X-axis of the tile grid
func OddInitGeneration() -> void:
	
	var horizontalStep: int = gridSize.x/2 
	
	#generates row of tiles
	for i in gridSize.y:
		
		#generates each tile in row
		for j in range(-horizontalStep, horizontalStep):
			
			#grab tile and instantiate it 
			var spawnedTile := tiles.pick_random().instantiate() as Node3D
			
			#parents the object and adds to the list of spawned tiles
			add_child(spawnedTile)
			generatedTiles.append(spawnedTile)
			
			#setting position of tile
			var posX: float = playerPos.position.x + j*tileSize
			var posZ: float = playerPos.position.z + tileSize/2 + i*tileSize - startPosOffset
			spawnedTile.global_position = Vector3(posX, 0.0, posZ)

#function that initialized and places randomized tiles at start of game for an even sized X-axis of the tile grid
func EvenInitGeneration() -> void:
	
	var horizontalStep: int = gridSize.x/2 
	
	#generates row of tiles
	for i in gridSize.y:
		
		#generates each tile in row
		for j in range(-horizontalStep, horizontalStep):
			
			#grab tile and instantiate it 
			var spawnedTile := tiles.pick_random().instantiate() as Node3D
			
			if( j != 0):
				#parents the object and adds to the list of spawned tiles
				add_child(spawnedTile)
				generatedTiles.append(spawnedTile)
				
				#setting position of tile
				var posX: float
				if(j<0):
					posX = playerPos.position.x + j*tileSize + tileSize/2
				else:
					posX = playerPos.position.x + j*tileSize - tileSize/2
				
				var posZ: float = playerPos.position.z + tileSize/2 + i*tileSize - startPosOffset
				spawnedTile.global_position = Vector3(posX, 0.0, posZ)
