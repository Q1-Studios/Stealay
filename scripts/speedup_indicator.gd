extends Control

func _process(_delta: float) -> void:
	if Globals.allow_speedup:
		show()
	else:
		hide()
