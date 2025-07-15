extends Node2D

func _ready() -> void:
	$Fills.hide()

func _on_focus_entered() -> void:
	$Fills.show()


func _on_focus_exited() -> void:
	$Fills.hide()
