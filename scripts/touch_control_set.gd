extends Node
class_name TouchControlSet

var ctrls_set: Array[TouchControl]

func _init(controls: Array[TouchControl]) -> void:
	ctrls_set = controls

func is_pressed() -> bool:
	for ctrl in ctrls_set:
		if ctrl.pressed:
			return true
	return false

func is_just_pressed() -> bool:
	for ctrl in ctrls_set:
		if ctrl.just_pressed:
			return true
	return false

func is_just_released() -> bool:
	for ctrl in ctrls_set:
		if ctrl.just_released:
			return true
	return false

func is_just_released_inside() -> bool:
	for ctrl in ctrls_set:
		if ctrl.just_released_inside:
			return true
	return false
