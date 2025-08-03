extends Pressable
class_name PressableArea2D

var _pressed: bool = false
var _just_pressed: bool = false
var _just_released: bool = false
var _just_released_inside: bool = false

var _mouse_inside: bool = false
var _block_pressed : bool = false

func _ready() -> void:
	assert(is_class("Area2D"))
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _process(_delta: float) -> void:
	# Don't allow "sliding" into a button - a button must be directly pressed
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not _mouse_inside:
		_block_pressed = true
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_block_pressed = false
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and _mouse_inside and not _block_pressed:
		if not _pressed:
			_just_pressed = true
		else:
			_just_pressed = false
		_pressed = true
	else:
		if _pressed:
			_just_released = true
			if _mouse_inside:
				_just_released_inside = true
		else:
			_just_released = false
			_just_released_inside = false
		_just_pressed = false
		_pressed = false

func _on_mouse_entered() -> void:
	_mouse_inside = true

func _on_mouse_exited() -> void:
	_mouse_inside = false

func is_pressed() -> bool:
	return _pressed

func is_just_pressed() -> bool:
	return _just_pressed

func is_just_released() -> bool:
	return _just_released

func is_just_released_inside() -> bool:
	return _just_released_inside
