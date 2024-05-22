extends Node

#Game Scene Variables
@export_category("Game Scenes")
@export var mainMenu: PackedScene
@export var gamePlay: PackedScene
var isInGameplay: bool

#UI varaibles
@export_category("UI")
@export var menuManager: MenuManager

#Player Variables
var playerMovement: PlayerMovement
var playerScore: Score
var playerHealth: PlayerHealth

#Bool for loads
var movementReady: bool
var scoreReady: bool
var healthReady: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isInGameplay = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(movementReady && scoreReady && healthReady):
		ReadyToPlay()
	
	if Input.is_action_just_pressed("pause"):
		Back()

# function that starts the game
func StartGame() -> void:
	isInGameplay = true
	LoadScene(gamePlay)

#function that loads elements once gameplay scene is ready
func ReadyToPlay() -> void:
	
	menuManager.ChangeUI(SharedEnums.ScreenState.Gameplay)
	get_tree().paused = false
	movementReady = false
	healthReady = false
	scoreReady = false

#function that pauses or un pauses the game
func TogglePause() -> void:
	
	if(isInGameplay):
		if get_tree().paused != true:
			get_tree().paused = true
			menuManager.ChangeUI(SharedEnums.ScreenState.Pause)
		else:
			menuManager.ChangeUI(SharedEnums.ScreenState.Gameplay)
			get_tree().paused = false

#function that ends the game state
func EndGame() -> void:
	
	isInGameplay = false
	get_tree().paused = true
	menuManager.ChangeUI(SharedEnums.ScreenState.GameOver)

#function that returns the game to the main menu
func ReturnToMainMenu() -> void:
	isInGameplay = false
	LoadScene(mainMenu)

#function that closes the application
func ExitGame() -> void:
	get_tree().quit()

#function that loads a specified scene
func LoadScene(sceneToLoad: PackedScene) -> void:
	get_tree().change_scene_to_packed(sceneToLoad)
	
	if(!isInGameplay):
		menuManager.ChangeUI(SharedEnums.ScreenState.MainMenu)

#function used for "back button" operations
func Back() -> void:
	
	match(menuManager.screenState):
		
		SharedEnums.ScreenState.Gameplay:
			TogglePause()
		
		SharedEnums.ScreenState.Pause:
			TogglePause()
		
		SharedEnums.ScreenState.MainMenu:
			ExitGame()
		
		SharedEnums.ScreenState.GameOver:
			ReturnToMainMenu()
		
		SharedEnums.ScreenState.Options:
			ToggleOptionsMenu()
		
		SharedEnums.ScreenState.Credits:
			ToggleCredits()
		
		SharedEnums.ScreenState.Controls:
			ToggleControls()

#function that toggles the option menu
func ToggleOptionsMenu() -> void:
	
	if(menuManager.screenState != SharedEnums.ScreenState.Options):
		menuManager.ChangeUI(SharedEnums.ScreenState.Options)
	else:
		if(isInGameplay):
			menuManager.ChangeUI(SharedEnums.ScreenState.Pause)
		else:
			menuManager.ChangeUI(SharedEnums.ScreenState.MainMenu)

#function that toggles the credits menu
func ToggleCredits() -> void:
	
	if(menuManager.screenState != SharedEnums.ScreenState.Credits):
		menuManager.ChangeUI(SharedEnums.ScreenState.Credits)
	else:
		menuManager.ChangeUI(SharedEnums.ScreenState.MainMenu)

#function that toggles the controls menu
func ToggleControls() -> void:
	
	if(menuManager.screenState != SharedEnums.ScreenState.Controls):
		menuManager.ChangeUI(SharedEnums.ScreenState.Controls)
	else:
		if(isInGameplay):
			menuManager.ChangeUI(SharedEnums.ScreenState.Pause)
		else:
			menuManager.ChangeUI(SharedEnums.ScreenState.MainMenu)
