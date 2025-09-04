extends Control

var tutorial_progress: int = 0

@export var heist_planner: Control
@export var instructions: Label
@export var movement_hints: Array[CanvasItem]
@export var undo_hints: Array[CanvasItem]
@export var start_hints: Array[CanvasItem]
@export var hide_hints: Array[CanvasItem]
@export var skip_control: Pressable

@export var skip_duration: float = 1.5

@onready var chats: Array[ChatSection] = [
	$Chat,
	$Chat2,
	$Chat3,
	$Chat4,
	$Chat5
]
@onready var clickable_area: Pressable = $ClickableArea
@onready var skip_progress: ProgressBar = $SkipProgressBar
@onready var player_arrow: Sprite2D = $Arrow

var tutorial_completed: bool = false

var current_chat: ChatSection

func _ready() -> void:
	set_hint_visibility(false)
	for chat in chats:
		chat.hide()
	visible = Globals.tutorial_enabled

func _process(delta: float) -> void:
	if Input.is_action_pressed("SkipTutorial") or skip_control.is_pressed():
		skip_progress.value += delta * (skip_progress.max_value / skip_duration)
		Globals.require_mouse_release = true
		if(skip_progress.value >= 100):
			Globals.tutorial_enabled = false
			instructions.hide()
	if Input.is_action_just_released("SkipTutorial") or skip_control.is_just_released():
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
				clickable_area.hide()
				tutorial_progress += 1
		
		if tutorial_progress == 2:
			if Globals.is_mobile:
				instructions.text = "Plan your moves by tapping the arrow buttons."
			else:
				instructions.text = "Plan your moves using the arrow keys."
			instructions.show()
			player_arrow.show()
			set_visibility(movement_hints, true)
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
			clickable_area.show()
			set_visibility(movement_hints, false)
			
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
				if Globals.is_mobile:
					instructions.text = "Finish your plan, then execute it by pressing 'Start'."
				else:
					instructions.text = "Finish your plan, then execute it by pressing enter."
				instructions.show()
				heist_planner.allow_move = true
				heist_planner.allow_hide = true
				heist_planner.allow_commit = true
				tutorial_completed = true
				Globals.tutorial_enabled = false
				
		if (Input.is_action_just_pressed("PlannerCommit") or
		clickable_area.is_just_pressed() and not Globals.require_mouse_release):
			current_chat.advance_dialogue()
			Globals.require_mouse_release = true
	
	else:
		hide()
		if current_chat != null:
			current_chat.silence()
		set_hint_visibility(true)
		heist_planner.allow_move = true
		heist_planner.allow_hide = true
		heist_planner.allow_commit = true

func set_hint_visibility(visibility: bool) -> void:
	set_visibility(movement_hints, visibility)
	set_visibility(undo_hints, visibility)
	set_visibility(start_hints, visibility)
	set_visibility(hide_hints, visibility)

func set_visibility(item_list: Array[CanvasItem], visibility: bool) -> void:
	for item in item_list:
		item.visible = visibility
