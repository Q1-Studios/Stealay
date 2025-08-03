extends Pressable
class_name PressableButton

var _btn_pressed: bool = false
var _is_just_pressed: bool = false
var _is_just_released: bool = false

var _prev_pressed: bool = true


func _ready() -> void:
	assert(is_class("Button"))
	connect("button_down", _on_button_down)
	connect("button_up", _on_button_up)

func _process(_delta: float) -> void:
	if _btn_pressed and not _prev_pressed:
		_prev_pressed = true
		set_deferred("_is_just_pressed", false)
	
	if not _btn_pressed and _prev_pressed:
		_prev_pressed = false
		set_deferred("_is_just_released", false)


func _on_button_down() -> void:
	set_deferred("_btn_pressed", true)
	set_deferred("_is_just_pressed", true)

func _on_button_up() -> void:
	set_deferred("_btn_pressed", false)
	set_deferred("_is_just_released", true)

func is_pressed() -> bool:
	return _btn_pressed

func is_just_pressed() -> bool:
	return _is_just_pressed

func is_just_released() -> bool:
	return _is_just_released

func _is_just_released_inside() -> bool:
	# Not implemented (yet)
	return false
