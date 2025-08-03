extends Node
class_name PressablesSet

var ctrls_set: Array[Pressable]

func _init(controls: Array[Pressable]) -> void:
	ctrls_set = controls

func is_pressed() -> bool:
	for ctrl in ctrls_set:
		if ctrl.is_pressed():
			return true
	return false

func is_just_pressed() -> bool:
	for ctrl in ctrls_set:
		if ctrl.is_just_pressed():
			return true
	return false

func is_just_released() -> bool:
	for ctrl in ctrls_set:
		if ctrl.is_just_released():
			return true
	return false

func is_just_released_inside() -> bool:
	for ctrl in ctrls_set:
		if ctrl.is_just_released_inside():
			return true
	return false
