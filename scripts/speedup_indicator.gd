extends Control

func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	if Globals.allow_speedup and not Globals.stop_moving:
		show()
	else:
		hide()
