extends Node2D
class_name CretesParent

var crete_r = preload("res://resources/scenes/hazards/crete.tscn")
@export var max_slant = 20

@export var max_crete_length = 10
@export var crete_probability = 1
var cretes_points : Array = []

func is_on_crete(point_id) -> bool :
	return cretes_points.has(point_id)

func add_cretes(walk_line : Walk_Line):
	var point_id : int = 10
	while point_id < walk_line.get_point_count()-20:
		var slant : float = walk_line.get_slant_by_id(point_id)
		#print("Slant : " + str(slant))
		if(abs(slant) < max_slant):
			#print("Slant : " + str(slant))
			if(randf() < crete_probability):
				var fraction : float = float(point_id) / float(walk_line.get_point_count())
				#print("Crete start WalkLine Fraction :",fraction)
				var _max_crete_length: int = 2 + max_crete_length * fraction
				#print("Crete Max Length :",_max_crete_length)
				var crete_length : int = randi_range(2,_max_crete_length)
				#print(crete_length)
				if(point_id + crete_length > walk_line.get_point_count()-1):
					crete_length = 2
				for s in range(point_id,point_id + crete_length):
					if(abs(walk_line.get_slant_by_id(point_id + crete_length)) > max_slant):
						crete_length = 2
				#if(abs(walk_line.get_slant_by_id(point_id + crete_length)) > max_slant):
					#crete_length = 2
				create_crete(walk_line,point_id,crete_length)
				point_id+=crete_length
		point_id+=1
	#print("Crete count : ",get_child_count())

func create_crete(walk_line,point_id : int = 0,crete_length : int = 2):
	var crete : Crete = crete_r.instantiate()
	for i in range(crete_length - 1):
		cretes_points.push_front(point_id + i)
	add_child(crete)
	crete.init(walk_line,point_id,crete_length)
