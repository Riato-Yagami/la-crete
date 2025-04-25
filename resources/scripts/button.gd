extends Sprite2D
class_name button
@export var on_texture : Texture2D
@export var off_texture : Texture2D
@export var input : String
@export var toggle : bool = true
var on : bool = false

func _process(delta):
	if(!input): return
	if(toggle):
		if(Input.is_action_just_pressed(input)):
			on = !on
			#print("push : ",input," on" if on else " off")
	else :
		on = Input.is_action_pressed(input)
	texture = on_texture if on else off_texture
