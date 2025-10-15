extends Node2D

@export var force_show: bool = false

func _ready() -> void:
	_on_input_changed(InputSrcDetector.current_src)
	InputSrcDetector.input_changed.connect(_on_input_changed)

func _on_input_changed(type: InputSrcDetector.InputSrc) -> void:
	if type == InputSrcDetector.InputSrc.TOUCH or force_show:
		show()
	else:
		hide()
