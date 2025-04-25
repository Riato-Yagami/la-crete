extends Node2D
class_name LineFill

@export var line : Line2D
var screen_height := 600 # Or get_viewport_rect().size.y
@export var fill_color : Color

func _draw():
	var line_points = line.points
	if line_points.size() < 2:
		return

	var polygon := []

	# Copy the line points
	for pt in line_points:
		polygon.append(pt)

	# Add bottom corners to close the shape
	polygon.append(Vector2(line_points[line_points.size()-1].x, screen_height))
	polygon.append(Vector2(line_points[0].x, screen_height))

	# Draw the polygon
	#print(polygon)
	draw_polygon(polygon, [fill_color])
