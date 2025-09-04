extends TouchScreenButton

enum Direction {LEFT, RIGHT, UP, DOWN}
@export var cone_direction: Direction

@export var origin: Node2D
@export var origin_offset: Vector2 = Vector2(0, 0)
@export var cone_base_length: float
@export var bbox: ColorRect

var top_left: Vector2
var top_right: Vector2
var btm_left: Vector2
var btm_right: Vector2

var end_pt_dict: Dictionary[Direction, PackedVector2Array]

func _ready() -> void:
	shape = ConvexPolygonShape2D.new()
	
	var bbox_top: float = bbox.global_position.y
	var bbox_btm: float = bbox.global_position.y + bbox.size.y
	var bbox_left: float = bbox.global_position.x
	var bbox_right: float = bbox.global_position.x + bbox.size.x
	
	top_left = Vector2(bbox_left, bbox_top)
	top_right = Vector2(bbox_right, bbox_top)
	btm_left = Vector2(bbox_left, bbox_btm)
	btm_right = Vector2(bbox_right, bbox_btm)
	
	end_pt_dict = {
		Direction.LEFT: [btm_left, top_left],
		Direction.RIGHT: [btm_right, top_right],
		Direction.UP: [top_right, top_left],
		Direction.DOWN: [btm_right, btm_left]
	}

func _process(_delta: float) -> void:
	var cone_center: Vector2 = Vector2(origin.global_position.x + origin_offset.x, origin.global_position.y + origin_offset.y)
	
	var cone_pt_a: Vector2 = to_local(cone_center)
	var cone_pt_b: Vector2 = to_local(cone_center)
	
	assert(cone_base_length >= 0, "Length must be positive")
	
	if cone_direction == Direction.LEFT or cone_direction == Direction.RIGHT:
		cone_pt_a.y -= cone_base_length / 2
		cone_pt_b.y += cone_base_length / 2
	if cone_direction == Direction.UP or cone_direction == Direction.DOWN:
		cone_pt_a.x -= cone_base_length / 2
		cone_pt_b.x += cone_base_length / 2
	
	var points: PackedVector2Array = []
	
	points.append(cone_pt_a)
	if cone_pt_a != cone_pt_b:
		points.append(cone_pt_b)
	
	for point in end_pt_dict[cone_direction]:
		points.append(to_local(point))
	
	shape.points = points
