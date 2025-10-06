extends Node

@export var hide_initially: bool = false
@export var time_until_hide: float = 3

var since_last_move: float = 0

func _ready() -> void:
	if hide_initially:
		since_last_move = time_until_hide
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	if since_last_move >= time_until_hide:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else:
		since_last_move += delta

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		since_last_move = 0
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
