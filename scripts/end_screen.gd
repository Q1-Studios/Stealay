extends Control

signal button_pressed

@export var first_button: Button
var prev_visible: bool = false

func _process(_delta: float) -> void:
	if visible != prev_visible:
		prev_visible = visible
		if visible:
			first_button.grab_focus()

func _on_button_pressed() -> void:
	button_pressed.emit()
