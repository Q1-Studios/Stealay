extends PressableButton
class_name PressableTouchScreenButton


func _ready() -> void:
	assert(is_class("TouchScreenButton"))
	connect("pressed", _on_button_down)
	connect("released", _on_button_up)
