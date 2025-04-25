class_name FollowCamera
extends Camera2D

@export var target : Node2D
@export var active : bool = true
@export var shakeFade : float = 5.0

#var rnd = RandomNumberGenerator.new()

var shake_strength : float = 0

func apply_shake(strength : float =  30.0): shake_strength = strength
func randomOffset() -> Vector2 : return Vector2(randf_range(-shake_strength,shake_strength),randf_range(-shake_strength,shake_strength))
#@export var offset : Vector2 = Vector2.ZERO

func _process(delta):
	#if(shake_strength > 0):
		#shake_strength = lerpf(shake_strength,0,shake_strength * delta)
		
	if(target and active):
		position = target.position + randomOffset()
