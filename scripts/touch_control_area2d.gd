extends Area2D
class_name TouchControl

var pressed: bool = false
var just_pressed: bool = false
var just_released: bool = false
var _mouse_inside: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and _mouse_inside:
		if not pressed:
			just_pressed = true
		else:
			just_pressed = false
		pressed = true
	else:
		if pressed:
			just_released = true
		else:
			just_released = false
		just_pressed = false
		pressed = false

func _on_mouse_entered() -> void:
	_mouse_inside = true

func _on_mouse_exited() -> void:
	_mouse_inside = false
