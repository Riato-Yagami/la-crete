extends State
class_name Sheltered

func _enter():
	AudioManager.stop_loop("walk")
	parent.visible = false
