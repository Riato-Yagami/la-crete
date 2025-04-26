extends Node2D
class_name Hazard

var parent : HazardParent

func init(_parent : HazardParent, point_id : int, length : int = 1):
	parent = _parent
	_init_hazard(point_id,length)
	
func _init_hazard(point_id : int, length : int = 1):
	pass
