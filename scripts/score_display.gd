extends Node2D

@onready var turns_taken_label: Label = $MovesTakenTitle/Label
@onready var prev_best_label: Label = $PreviousBestTitle/Label
@onready var highscore_beaten_label: Label = $NewBestHeist


func _on_won() -> void:
	var run_turns: int = Globals.run_turns
	var prev_best_turns: int = Globals.prev_best_turns
	
	turns_taken_label.text = str(run_turns)
	if(prev_best_turns > 0):
		prev_best_label.text = str(prev_best_turns)
	else:
		prev_best_label.text = "-"
		
	if(prev_best_turns < 0 or run_turns < prev_best_turns):
		highscore_beaten_label.show()
	else:
		highscore_beaten_label.hide()
