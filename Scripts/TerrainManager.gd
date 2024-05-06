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
var even: bool

#Runtime variables
var terrainVelocity: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	InitialGeneration()
	terrainVelocity = Vector3(0, 0, 0)
	
	if(int(gridSize.x) % 2 == 0):
		even = true
	else:
		even = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	MoveTerrain(delta)
	ProcessTiles()

func _physics_process(delta: float) -> void:
	ProcessVelocity(player.GetVelocity())

#function that movees the terrain
func MoveTerrain(delta: float) -> void:
	for tile in generatedTiles:
		tile.position += terrainVelocity * delta

#function that gets the velocity of the terrain from an input value
func ProcessVelocity(velocity: Vector3) -> void:
	terrainVelocity.x = velocity.x * 0.277778
	terrainVelocity.z = -velocity.z * 0.277778
	terrainVelocity.y = velocity.y * 0.277778

#function that manages spawning and despawning of tiles
func ProcessTiles() -> void:
	var zBoundry: float
	var xBoundry: float
	zBoundry = -tileSize
	xBoundry = floori(gridSize.x/2.0)
	
	if(even): 
		xBoundry -= 0.5
	
	xBoundry *= tileSize
	
	for tile in generatedTiles:
		var tilePosition: Vector3
		tilePosition = tile.position
		
		#right border check
		if(tilePosition.x > xBoundry):
			print("right border call, (%.2f > %.2f == %s) %s id %d" % [tilePosition.x, xBoundry, tilePosition.x > xBoundry, tile.position,tile.get_instance_id()])
			SpawnTile(Vector3((tilePosition.x - gridSize.x * (tileSize * 0.5)), tilePosition.y, tilePosition.z))
			RemoveTile(tile)
		
		#left border check
		elif(tilePosition.x < -xBoundry):
			print("left border call, (%.2f < %.2f == %s) %s %d" % [tilePosition.x, -xBoundry, tilePosition.x < -xBoundry, tile.position, tile.position,tile.get_instance_id()])
			SpawnTile(Vector3((tilePosition.x + gridSize.x * (tileSize * 0.5)), tilePosition.y, tilePosition.z))
			RemoveTile(tile)
		
		#back border check
		elif(tilePosition.z < zBoundry):
			print("back border call, " + str(tile.position))
			SpawnTile(Vector3(tilePosition.x, tilePosition.y, (tilePosition.z + gridSize.y*tileSize)))
			RemoveTile(tile)

#function that calls the initial generation of the grid
func InitialGeneration() -> void:
	#check to see if x-axis number of tiles is even or odd
	if(even):
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

#function that despawns an input tile
func RemoveTile(targetTile: Node3D) -> void:
	#remove from list and de-spawn
	generatedTiles.erase(targetTile)
	print("Remove tile instance id %d %s" % [targetTile.get_instance_id(), targetTile.position])
	targetTile.queue_free()

#function that spawns a tile at the desired location
func SpawnTile(spawnPosition: Vector3) -> void:
	
	#Instantiate spawned tile
	var spawnedTile := tiles.pick_random().instantiate() as Node3D
	
	#parent tile and add it to list
	add_child(spawnedTile)
	generatedTiles.append(spawnedTile)
	
	#setting position of tile
	spawnedTile.position = spawnPosition
	print("Spawned tile instance id %d %s" % [spawnedTile.get_instance_id(),spawnPosition])

