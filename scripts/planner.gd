extends Control

signal heist_planned(sequence) # signal when done
signal add_movement(move: Globals.movement, pos: Vector2i)
signal remove_last_movement(pos: Vector2i)
signal place_skull(pos: Vector2i)

@export var player: Node3D
@export var input_delta: float = 0.125

@export_group("Touch Controls")
@export var left_btn: TouchControl
@export var right_btn: TouchControl
@export var up_btn: TouchControl
@export var down_btn: TouchControl
@export var on_player_btn: TouchControl
@export var hide_btn: TouchControl
@export var delete_btn: TouchControl
@export var commit_btn: TouchControl

@onready var invalid_sound: AudioStreamPlayer = $InvalidSound
@onready var turncount_label: Label = $Turncount

var input_sequence: Array[Globals.movement] = []

var allow_move: bool = false
var allow_commit: bool = false

var prev_require_mouse_release: bool = false

var delta_since_last_input: float = 0

var valid_pos: Array[Vector2i] = Globals.valid_pos.duplicate(true)
var current_pos: Vector2i #= starting_pos
var move_history: Array[Vector2i]# = [starting_pos]
var max_speedup_turns: int = Globals.previous_move_count

var starting_pos: Vector2i # = calculate_pos_vector_from_global_pos()

var init_done: bool = false
#-----------------------------------------------------------------------

func _on_player_ready() -> void:
	pass

func _ready() -> void:
	if not player:
		push_error("Player node missing even after defer!")
		return
		
	starting_pos = calculate_pos_vector_from_global_pos()
	current_pos = starting_pos
	move_history = [starting_pos]
	



func _process(delta: float) -> void:
	if not init_done and Globals.previous_sequence != [] and Globals.previous_move_count != 0:
		load_sequence()
		turncount_label.text = str(input_sequence.size())
		init_done = true
	elif not init_done:
		init_done = true
	
	var move: Globals.movement = Globals.movement.NULL
	delta_since_last_input += delta
	
	if allow_move:
		if action_pressed("PlannerUp") or control_pressed(up_btn):
			move = Globals.movement.UP
		elif action_pressed("PlannerDown") or control_pressed(down_btn):
			move = Globals.movement.DOWN
		elif action_pressed("PlannerLeft") or control_pressed(left_btn):
			move = Globals.movement.LEFT
		elif action_pressed("PlannerRight") or control_pressed(right_btn):
			move = Globals.movement.RIGHT
		elif action_pressed("PlannerHide") or control_pressed(on_player_btn) or control_pressed(hide_btn):
			move = Globals.movement.HIDE
		elif action_pressed("PlannerDelete") or control_pressed(delete_btn):
			remove_last_action()
		elif (Input.is_action_just_pressed("PlannerCommit", true) or control_pressed(commit_btn, true)
		and allow_commit):
			finalize_sequence()

	if move != Globals.movement.NULL:
		if (check_move(move)):
			add_action(move)
		else:
			# TODO: Signal user invalid move by shaking screen
			invalid_sound.play()
			pass
	
	turncount_label.text = str(input_sequence.size())
	
	# Allow acccess to mouse release requirement, intentionally delayed by one frame
	# This should prevent the mouse being released but a "past" click registering in the same frame
	prev_require_mouse_release = Globals.require_mouse_release
	

# Custom function that returns true either when an input is pressed just now
# Or when a key is held but only in allowed intervals
func action_pressed(action_name: String) -> bool:
	var allow_holding: bool = false

	if delta_since_last_input >= input_delta:
		allow_holding = true

	if (Input.is_action_just_pressed(action_name, true) or
	(Input.is_action_pressed(action_name, true) and allow_holding)):
		delta_since_last_input = 0
		return true
	
	return false

func control_pressed(touch_control: TouchControl, release_inside: bool = false):
	var allow_holding: bool = false

	if delta_since_last_input >= input_delta:
		allow_holding = true
	
	if not prev_require_mouse_release:
		if release_inside and touch_control.just_released_inside:
			delta_since_last_input = 0
			return true
		if (not release_inside and (touch_control.just_pressed or
		(touch_control.pressed and allow_holding))):
			delta_since_last_input = 0
			return true
	
	return false

func add_action(action: Globals.movement) -> void:
	input_sequence.append(action)
	emit_signal("add_movement", action, current_pos) 

func remove_last_action() -> void:
	if not input_sequence.is_empty():
		move_history.pop_back()
		
		if move_history.size() < max_speedup_turns:
			max_speedup_turns -= 1
		
		current_pos = move_history.get(len(move_history)-1)
		emit_signal("remove_last_movement", current_pos)
		input_sequence.pop_back() 
		print(input_sequence)

func finalize_sequence() -> void:
	if input_sequence.is_empty():
		print("Cannot finalize an empty sequence.")
		invalid_sound.play()
		return

	print("Sequence finalized: ", input_sequence)
	Globals.max_speedup_turns = max_speedup_turns
	emit_signal("heist_planned", input_sequence)

func clear_sequence() -> void:
	input_sequence.clear()
	

func check_move(move: Globals.movement) -> bool:
	var new_position = current_pos
	
	if (move == Globals.movement.HIDE):
		pass
	elif (move == Globals.movement.UP):
		new_position[0] += 1
	elif (move == Globals.movement.DOWN):
		new_position[0] -= 1
	elif (move == Globals.movement.RIGHT):
		new_position[1] += 1
	elif (move == Globals.movement.LEFT):
		new_position[1] -= 1
	else:
		push_error("MICHI is fett am cheaten")
		
	# TODO remove or true
	if new_position in valid_pos or Globals.dev_mode:
		current_pos = new_position
		move_history.append(new_position)
		return true
	
	return false


func calculate_pos_vector_from_global_pos() -> Vector2i:
	var pos: Vector2i = Vector2i(0, 0)
	pos.y = player.transform.origin.x
	pos.x = -player.transform.origin.z
	#print(player.transform.origin)
	#print(pos)
	return pos


func load_sequence() -> void:
	var old_input_sequence = Globals.previous_sequence.duplicate(true)
	#print(old_input_sequence)
	#print(Globals.previous_move_count)
	
	for i in range(Globals.previous_move_count-1):
		if (check_move(old_input_sequence[i])):
			add_action(old_input_sequence[i])
	
	emit_signal("place_skull", current_pos)
		
	
	print("hmm")
