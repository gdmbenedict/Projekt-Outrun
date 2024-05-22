class_name MenuManager

extends Node

@export_category("UI Scenes")
@export var mainMenuUI: Control
@export var pauseMenuUI: Control
@export var gameOverUI: Control
@export var GameplayUI: Control
@export var ControlsMenuUI: Control
@export var CreditsMenuUI: Control
@export var OptionsMenu: Control

var activeUI: Control
var screenState: SharedEnums.ScreenState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	activeUI = mainMenuUI
	activeUI.process_mode = Node.PROCESS_MODE_INHERIT
	activeUI.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func ChangeUI(newScreenState: SharedEnums.ScreenState) -> void:
	activeUI.process_mode = Node.PROCESS_MODE_DISABLED
	activeUI.visible = false
	
	match newScreenState:
		
		SharedEnums.ScreenState.Controls:
			activeUI = ControlsMenuUI
			
		SharedEnums.ScreenState.Credits:
			activeUI = CreditsMenuUI
			
		SharedEnums.ScreenState.Gameplay:
			activeUI = GameplayUI
		
		SharedEnums.ScreenState.GameOver:
			activeUI = gameOverUI
		
		SharedEnums.ScreenState.MainMenu:
			activeUI = mainMenuUI
		
		SharedEnums.ScreenState.Options:
			activeUI = OptionsMenu
		
		SharedEnums.ScreenState.Pause:
			activeUI = pauseMenuUI
	
	screenState = newScreenState
	activeUI.process_mode = Node.PROCESS_MODE_INHERIT
	activeUI.visible = true
