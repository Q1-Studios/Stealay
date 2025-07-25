extends CollisionShape2D

@export var grow_left: bool = false
@export var grow_right: bool = false
@export var grow_up: bool = false
@export var grow_down: bool = false

@export var origin: Node2D
@export var origin_offset: Vector2 = Vector2(0, 0)
@export var bbox: ColorRect
@export var base_size: Vector2 = Vector2(100, 100)

@onready var rect: RectangleShape2D = shape

var bbox_top: float
var bbox_btm: float
var bbox_left: float
var bbox_right: float

func _ready() -> void:
	bbox_top = bbox.global_position.y
	bbox_btm = bbox.global_position.y + bbox.size.y
	bbox_left = bbox.global_position.x
	bbox_right = bbox.global_position.x + bbox.size.x

func _process(_delta: float) -> void:
	var length_left: float = sanitize_length(grow_left, (origin.global_position.x + origin_offset.x) - bbox_left)
	var length_right: float = sanitize_length(grow_right, bbox_right - (origin.global_position.x + origin_offset.x))
	var length_up: float = sanitize_length(grow_up, (origin.global_position.y + origin_offset.y) - bbox_top)
	var length_down: float = sanitize_length(grow_down, bbox_btm - (origin.global_position.y + origin_offset.y))
	
	if grow_left or grow_right:
		rect.size.x = length_left + length_right
	else:
		rect.size.x = base_size.x
	
	if grow_up or grow_down:
		rect.size.y = length_up + length_down
	else:
		rect.size.y = base_size.y
	
	position.x = (length_right-length_left) / 2 + origin_offset.x
	position.y = (length_down-length_up) / 2 + origin_offset.y


func sanitize_length(affected: bool, length: float) -> float:
	# Lengths may not be negative
	if length < 0:
		return 0
	
	# If the given length is supposed to grow
	if affected:
		return length
	
	return 0
