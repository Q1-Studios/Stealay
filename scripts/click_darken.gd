extends Sprite2D

var _mouse_inside: bool = false

func _process(_delta: float) -> void:
	if _mouse_inside and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		modulate.v = 0.5
	else:
		modulate.v = 1

func _on_mouse_entered() -> void:
	_mouse_inside = true
	

func _on_mouse_exited() -> void:
	_mouse_inside = true
