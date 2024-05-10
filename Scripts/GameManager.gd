extends Node

#Game Scene Variables
@export_category("Game Scenes")
@export var mainMenu: PackedScene
@export var gamePlay: PackedScene
var loadedScene

#UI varaibles
@export_category("UI Scenes")
@export var mainMenuUI: PackedScene
@export var pauseUI: PackedScene
@export var gameOverUI: PackedScene
@export var GameplayUI: PackedScene
var activeUI: Control

#Player Variables
var playerVelocity: Vector3 = Vector3(0, 0, 0)
var playerSpeed: float = 0
var playerMaxSpeed: float = 0
var playerScore: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loadedScene = mainMenu
	activeUI = mainMenuUI.instantiate() as Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pause"):
		Pause()

func StartGame() -> void:
	LoadScene(gamePlay)

func Pause() -> void:
	
	if(loadedScene.is_in_group("GameplayScene")):
		if get_tree().paused != true:
			get_tree().paused = true
			ChangeUI(pauseUI)
		else:
			ChangeUI(GameplayUI)
			get_tree().paused = false

func EndGame() -> void:
	
	get_tree().paused = true
	ChangeUI(gameOverUI)

func ReturnToMainMenu() -> void:
	LoadScene(mainMenu)

func ExitGame() -> void:
	get_tree().quit()

func LoadScene(sceneToLoad: PackedScene) -> void:
	get_tree().change_scene_to_packed(sceneToLoad)
	loadedScene = sceneToLoad
	
	if(loadedScene.is_in_group("GameplayScene")):
		ChangeUI(GameplayUI)
	else:
		ChangeUI(mainMenuUI)

func ChangeUI(newUI: PackedScene) -> void:
	activeUI.queue_free()
	activeUI = newUI.instantiate() as Control

