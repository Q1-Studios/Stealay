@tool
extends Node

enum Platform {PC, MOBILE}

@export var pc_variant: Node
@export var mobile_variant: Node
@export var preview: Platform

var platform: Platform
var current: Node

func _ready() -> void:
	if not Engine.is_editor_hint():
		handle_input_change(InputSrcDetector.current_src)
		InputSrcDetector.input_changed.connect(handle_input_change)
	update_visibility()

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		platform = preview
		update_visibility()

# Switch layout when touch or PC input occurs
func handle_input_change(type: InputSrcDetector.InputSrc) -> void:
	if type == InputSrcDetector.InputSrc.TOUCH:
		platform = Platform.MOBILE
	else:
		platform = Platform.PC
	update_visibility()

func update_visibility() -> void:
	if platform == Platform.PC:
		current = pc_variant
		pc_variant.show()
		mobile_variant.hide()
	else:
		current = mobile_variant
		pc_variant.hide()
		mobile_variant.show()
