extends State
class_name Screen

@export var screen_ressource : Resource
var screen

func enter() -> void:
	#print("Load Screen")
	screen = screen_ressource.instantiate()
	#get_parent().transition.play()
	get_parent().hud.call_deferred("reparent", screen, true)
	#get_parent().transition.call_deferred("reparent", screen, true)
	add_child(screen)
	_enter()
	
func exit() -> void:
	screen.queue_free()
