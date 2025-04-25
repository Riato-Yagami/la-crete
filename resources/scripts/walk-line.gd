class_name Walk_Line

extends Line2D

var path_bound : Vector2 = Vector2(-540,1000)
var distance : float :
	get : return path_bound.y - path_bound.x
	
var point_rate : float = 30
var point_count : int :
	get : return (path_bound.y - path_bound.x) / point_rate
	
var height_bound : Vector2 = Vector2(-100,1000)

@export var cretes_parent : CretesParent

@export var spawn : Spawn
@export var end : End

var height : float
var x : float

func _ready():
	height = - spawn.position.y
	path_bound.x = spawn.position.x - 200
	path_bound.y = end.position.x + 400
	#print("Spawn height :" + str(height))
	x = path_bound.x
	#var next_x = x + 300
	_create_path(300,Vector2(-5,5))
	#x = next_x; next_x = x + 200
	_create_path(250,Vector2(-10,20))
	#x = next_x; next_x = x + 100
	_create_path(100,Vector2(-30,100))
	#x = next_x; next_x = x + 100
	_create_path(100,Vector2(-30,30))
	_create_path(300,Vector2(-100,10))
	_create_path(100,Vector2(-10,10))
	_create_path(50,Vector2(10,300))
	_create_path(200,Vector2(10,10))
	_create_path(200,Vector2(-100,300))
	_create_path(200,Vector2(-50,50))
	_create_path(path_bound.y - x,Vector2(-5,5))
	
	spawn.move_to_floor()
	end.move_to_floor()
	#_create_path(Vector2(-1000,1000))
	cretes_parent.add_cretes(self)
	
func get_point_id(_x : float) :
	var id : int = 0
	for point in points:
		if(point.x > _x): return id-1
		id+=1
	return id
	#var point_id : int = (x - path_bound.x) / point_rate
	#return point_id
	
func get_height(_x : float) -> float :
	var point_id : int = get_point_id(_x)
	#print("Point id :" + str(point_id) + "/" + str(point_count))
	var portion_x : Vector2 = Vector2(get_point_position(point_id).x, get_point_position(point_id+1).x)
	var portion_y : Vector2 = Vector2(get_point_position(point_id).y, get_point_position(point_id+1).y)
	var portion_progress : float = (_x - portion_x.x) / (portion_x.y - portion_x.x)
	return lerpf(portion_y.x, portion_y.y,portion_progress)

func get_portion_elevation_gain(point_id : int) -> float :
	# Y coord is growing as it go down
	if(point_id+1 > get_point_count() -1): return 0
	var portion_y : Vector2 = Vector2(get_point_position(point_id).y, get_point_position(point_id+1).y)
	#print("Portion Y : " + str(portion_y))
	return -(portion_y.y - portion_y.x)
	
func get_slant(_x : float) -> float :
	# Angle between -90 and 90
	# Positive if going up
	var point_id : int = get_point_id(_x)
	var _elevation_gain : float = get_portion_elevation_gain(point_id)
	#var cos : float = point_rate / _elevation_gain #CAH
	var tan : float = _elevation_gain / point_rate #TOA
	var angle = atan(tan) * 180 / PI
	return angle
	
func get_slant_by_id(point_id : int) -> float :
	var _elevation_gain : float = get_portion_elevation_gain(point_id)
	#var cos : float = point_rate / _elevation_gain #CAH
	var tan : float = _elevation_gain / point_rate #TOA
	var angle = atan(tan) * 180 / PI
	return angle
	
func _create_path(
	_distance : float = path_bound.y - x,
	#_path_bound : Vector2 = path_bound,
	_height_incr : Vector2 = Vector2(-20,20),
	_height_bound : Vector2 = height_bound
	) -> float:
	
	#var _height = height
	var _x : float = x
	#var _distance : float = _path_bound.y - _path_bound.x
	#var incr : float = distance / point_count
	var _point_count = (_distance / distance) * point_count
	for i in range(_point_count):
		add_point(Vector2(_x,-height))
		height += randf_range(_height_incr.x, _height_incr.y)
		height = clamp(height,
		_height_bound.x + 10 + randf_range(-10, 10),
		_height_bound.y - 10 + randf_range(-10, 10))
		_x += point_rate
	
	x = _x
	return height

var screen_height := 600 # Or get_viewport_rect().size.y
var fill_color := Color.RED
