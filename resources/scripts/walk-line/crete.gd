extends Line2D
class_name Crete

#var walk_line : Walk_Line

func init(walk_line : Walk_Line, point_id : int, point_count = 2):
	#print(walk_line.points.size())
	for i in range(point_count):
		if(point_id + i < walk_line.get_point_count() - 1):
			add_point(walk_line.points[point_id + i])
