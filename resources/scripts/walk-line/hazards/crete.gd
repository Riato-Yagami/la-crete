extends Hazard
class_name Crete

@export var line : Line2D
	
func _init_hazard(point_id : int, length : int = 1):
	#print("Init Crete, id :",point_id," - lenght :",length)
	for i in range(length + 1):
		line.add_point(parent.walk_line.points[point_id + i])
