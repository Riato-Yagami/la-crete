extends Node2D
class_name End

@export var walk_line : Walk_Line
@export var sprite : AnimatedSprite2D

@export var player : Player

func _process(delta):
	if(player.position.x > position.x - 10):
		var sheltered_state : Sheltered = player.state_machine.get_node("Sheltered")
		player.state_machine.change_state(sheltered_state)
		var game : Game = GameManager.main.get_node("ScreenMachine/Game")
		game.win_game()
		
func move_to_floor(offset : float = 0) -> void:
	var walk_line_y = walk_line.get_height(position.x)
	position.y = walk_line_y - offset
