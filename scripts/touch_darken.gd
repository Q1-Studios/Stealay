extends Sprite2D


func _on_pressed() -> void:
	modulate.v = 0.5
	
func _on_released() -> void:
	modulate.v = 1
