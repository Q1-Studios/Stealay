extends Button

class_name SmartButton

@export var onready_grab_focus: bool = false


var mouse_inside: bool = false

func _ready() -> void:
	if onready_grab_focus:
		grab_focus()

func _on_mouse_entered() -> void:
	mouse_inside = true
	grab_focus()

func _on_mouse_exited() -> void:
	mouse_inside = false
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_inside:
		grab_focus()
