extends Control

var tutorial_progress: int = 0

@export var heist_planner: Control
@export var movement_hint: Control
@export var undo_hint: Control
@export var start_hint: Control
@export var hide_hint: Control

@export var mobile_start: Control
@export var mobile_hide: Control
@export var mobile_undo: Control
@export var skip_control: TouchControl

@export var skip_duration: float = 1.5

@onready var chats: Array[ChatSection] = [
	$Chat,
	$Chat2,
	$Chat3,
	$Chat4,
	$Chat5
]
@onready var clickable_area: TouchControl = $ClickableArea
@onready var skip_progress: ProgressBar = $SkipProgressBar
@onready var instructions: Label = $Instructions
@onready var player_arrow: Sprite2D = $Arrow

var tutorial_completed: bool = false

var current_chat: ChatSection

func _ready() -> void:
	set_hint_visibility(false)
	for chat in chats:
		chat.hide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("SkipTutorial") or skip_control.pressed:
		skip_progress.value += delta * (skip_progress.max_value / skip_duration)
		Globals.require_mouse_release = true
		if(skip_progress.value >= 100):
			Globals.tutorial_enabled = false
	if Input.is_action_just_released("SkipTutorial") or skip_control.just_released:
		skip_progress.value = 0
	
	if Globals.tutorial_enabled and not tutorial_completed:
		show()
		
		if tutorial_progress == 0:
			current_chat = chats[0]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 1:
			current_chat = chats[1]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 2:
			instructions.text = "Plan your moves using the arrow keys."
			instructions.show()
			player_arrow.show()
			movement_hint.show()
			heist_planner.allow_move = true
			
			if heist_planner.move_history.size() > 1:
				tutorial_progress += 1
				heist_planner.allow_move = false
				Globals.require_mouse_release = true
				instructions.hide()
				player_arrow.hide()
		
		if tutorial_progress == 3:
			current_chat = chats[2]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 4:
			current_chat = chats[3]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 5:
			current_chat = chats[4]
			current_chat.show()
			if current_chat.done:
				current_chat.hide()
				
				tutorial_progress += 1
				instructions.text = "Finish your plan, then execute it by pressing enter."
				instructions.show()
				heist_planner.allow_move = true
				heist_planner.allow_commit = true
				tutorial_completed = true
				Globals.tutorial_enabled = false
				
		if (Input.is_action_just_pressed("PlannerCommit") or
		clickable_area.just_pressed and not Globals.require_mouse_release):
			current_chat.advance_dialogue()
			Globals.require_mouse_release = true
	
	else:
		hide()
		if current_chat != null:
			current_chat.silence()
		set_hint_visibility(true)
		heist_planner.allow_move = true
		heist_planner.allow_commit = true

func set_hint_visibility(visibility: bool) -> void:
	movement_hint.visible = visibility
	undo_hint.visible = visibility
	start_hint.visible = visibility
	hide_hint.visible = visibility
	
	mobile_start.visible = visibility
	mobile_hide.visible = visibility
	mobile_undo.visible = visibility
