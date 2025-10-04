extends Button

class_name SmartButton

@export var onready_grab_focus: bool = false


var mouse_inside: bool = false
var allow_return_grab: bool = false

func _ready() -> void:
	get_viewport().gui_focus_changed.connect(_on_focus_changed)
	if onready_grab_focus:
		grab_focus()

func _on_mouse_entered() -> void:
	mouse_inside = true
	grab_focus()

func _on_mouse_exited() -> void:
	mouse_inside = false
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_inside:
		grab_focus()
	
	# A UI input while no element is selected will return to this element
	# if it was the previously selected one
	elif (get_viewport().gui_get_focus_owner() == null and allow_return_grab and is_visible_in_tree()
	and (event.is_action_pressed("ui_up")
	or event.is_action_pressed("ui_down")
	or event.is_action_pressed("ui_left")
	or event.is_action_pressed("ui_right"))):
		grab_focus.call_deferred()

func _on_focus_changed(control: Control) -> void:
	if control == self:
		allow_return_grab = true
	elif control != null:
		allow_return_grab = false
