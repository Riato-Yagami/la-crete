extends Node2D
class_name HazardParent

@export var resource : PackedScene
#var resource : PackedScene = preload("res://resources/scenes/hazards/cairn.tscn")
@export var walk_line : Walk_Line
@export var max_slant = 20

@export var hazard_bound : Vector2 = Vector2(7,10)

func get_length(point_id : int = 0) -> int :
	return 1
	
func get_probability(point_id : int = 0) -> float :
	return 1.0
	
func add_hazards() -> void:
	var point_id = hazard_bound.x
	while point_id < walk_line.get_point_count() - hazard_bound.y:
		var length = get_length(point_id)
		var can_be_placed = true
		for i in range(point_id, point_id + length + 1):
			if(abs(walk_line.get_slant_by_id(i)) > max_slant):
				can_be_placed = false
		if(can_be_placed and randf() < get_probability(point_id)):
			#print("Create Hazard")
			create_hazard(point_id,length)
		point_id += length
		
func create_hazard(point_id : int = 0, length : int = 0):
	var hazard : Hazard = resource.instantiate()
	#_init_hazard(walk_line, point_id)
	add_child(hazard)
	_init_hazard(point_id,length)
	hazard.init(self,point_id,length)

func _init_hazard(point_id : int, length : int):
	pass
