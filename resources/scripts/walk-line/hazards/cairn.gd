extends Hazard
class_name Cairn

@export var textures : Array[Texture]
@export var sprite : Sprite2D

@export var max_offset : Vector2 = Vector2(10,-2)

func _init_hazard(point_id : int, length : int = 1):
	#print("Init Cairn, id :",point_id," - lenght :",length)
	sprite.set_texture(textures.pick_random())
	position.x =parent.walk_line.get_point_position(point_id).x + randf_range(-max_offset.x,max_offset.x)
	parent.walk_line.move_to_floor(self,randf_range(max_offset.y,0))
