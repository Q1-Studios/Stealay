extends Button
class_name ButtonTouchControl

var btn_pressed: bool = false
var is_just_pressed: bool = false
var is_just_released: bool = false

var _prev_pressed: bool = true


func _process(_delta: float) -> void:
	if btn_pressed and not _prev_pressed:
		is_just_pressed = true
		_prev_pressed = true
	else:
		is_just_pressed = false
	
	if not btn_pressed and _prev_pressed:
		is_just_released = true
		_prev_pressed = false
	else:
		is_just_released = false


func _on_button_down() -> void:
	btn_pressed = true

func _on_button_up() -> void:
	btn_pressed = false
