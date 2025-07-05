extends AudioStreamPlayer


var fadeout: bool = false

func _on_fadeout() -> void:
	fadeout = true

func _process(delta: float) -> void:
	if fadeout:
		volume_db -= 40 * delta
