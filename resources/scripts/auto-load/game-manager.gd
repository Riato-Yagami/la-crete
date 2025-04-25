extends Node

var root
var main : Node
	
var web : bool = false

func _ready() -> void:
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("Main")
	
func _process(delta):
	if(Input.is_action_just_pressed("escape")):
		quit_game()

func quit_game():
	get_tree().quit()
