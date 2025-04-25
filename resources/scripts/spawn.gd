extends Node2D
class_name Spawn

@export var walk_line : Walk_Line
@export var sprite : Sprite2D

func move_to_floor(offset : float = 7) -> void:
	var walk_line_y = walk_line.get_height(sprite.position.x)
	sprite.position.y = walk_line_y - offset
