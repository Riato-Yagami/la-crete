class_name FollowCamera
extends Camera2D

@export var target : Node2D
@export var active : bool = true
#@export var offset : Vector2 = Vector2.ZERO

func _process(delta):
	if(target and active):
		position = target.position
