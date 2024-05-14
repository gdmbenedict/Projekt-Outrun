extends Node

#Game Scene Variables
@export_category("Game Scenes")
@export var mainMenu: PackedScene
@export var gamePlay: PackedScene
var isInGameplay: bool

#UI varaibles
@export_category("UI Scenes")
@export var mainMenuUI: Control
@export var pauseUI: Control
@export var gameOverUI: Control
@export var GameplayUI: Control
var activeUI: Control

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
	activeUI = mainMenuUI
	activeUI.process_mode = Node.PROCESS_MODE_INHERIT
	activeUI.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if(playerMovement && playerScore && PlayerHealth):
		ReadyToPlay()
	
	if Input.is_action_just_pressed("pause"):
		Pause()

func StartGame() -> void:
	isInGameplay = true
	LoadScene(gamePlay)

func Pause() -> void:
	
	if(isInGameplay):
		if get_tree().paused != true:
			get_tree().paused = true
			ChangeUI(pauseUI)
		else:
			ChangeUI(GameplayUI)
			get_tree().paused = false

func EndGame() -> void:
	
	isInGameplay = false
	get_tree().paused = true
	ChangeUI(gameOverUI)

func ReturnToMainMenu() -> void:
	isInGameplay = false
	LoadScene(mainMenu)

func ExitGame() -> void:
	get_tree().quit()

func LoadScene(sceneToLoad: PackedScene) -> void:
	get_tree().change_scene_to_packed(sceneToLoad)
	
	if(!isInGameplay):
		ChangeUI(mainMenuUI)

func ChangeUI(newUI: Control) -> void:
	activeUI.process_mode = Node.PROCESS_MODE_DISABLED
	activeUI.visible = false
	
	activeUI = newUI
	
	activeUI.process_mode = Node.PROCESS_MODE_INHERIT
	activeUI.visible = true

func ReadyToPlay() -> void:
	
	ChangeUI(GameplayUI)
	get_tree().paused = false
	movementReady = false
	healthReady = false
	scoreReady = false
