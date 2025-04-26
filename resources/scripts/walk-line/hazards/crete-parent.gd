extends HazardParent
class_name CreteParent

@export var max_length = 10
@export var probability = 0.6
var cretes_points : Array = []

func is_on_crete(point_id) -> bool :
	return cretes_points.has(point_id)

func get_length(point_id : int = 0) -> int :
	var _max_length: int = 1 + max_length * walk_line.get_fraction(point_id)
	return randi_range(2,_max_length)

func get_probability(point_id : int = 0) -> float :
	return 0.3 + walk_line.get_fraction(point_id) * 0.75

func _init_hazard(point_id : int, length : int):
	for i in range(length):
		cretes_points.push_front(point_id + i)
