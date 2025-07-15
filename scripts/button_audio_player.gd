extends Node2D

@onready var click_sound = $ClickSound
@onready var hover_sound = $HoverSound

func _on_click() -> void:
	if is_inside_tree():
		click_sound.play()

func _on_focus_entered() -> void:
	hover_sound.play()
