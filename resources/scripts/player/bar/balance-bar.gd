extends Sprite2D
class_name BalanceBar

var value : float = 0 #range between -1 and 1
var balance_force : float = 0
var unbalance_start : float = 1

@export var shake_strength : float = 10

@export var unbalance_force : float = 0.5
@export var rebalance_force : float = 1

@export var max_balance_force : float = 3

@export var cursor : Sprite2D
@export var length : float = 16

@export var player : Player

var is_unbalanced : bool :
	get : return abs(value) > 0.6

var is_over : bool :
	get : return abs(value) > 1.1
	
func _process(delta):
	if(visible):
		if(value == 0):
			value = randf_range(-0.2,0.2)
			
		balance_force += sign(value) * unbalance_force * delta
		balance_force += player.balance_input * rebalance_force * delta
		
		balance_force = clamp(balance_force,-max_balance_force,max_balance_force)
		value += balance_force * delta
		#print("Balance Force = ",balance_force)
		#print("Balance Value = ",value)
		
		update()
	else :
		value = 0
		
	player.player_camera.apply_shake(value * shake_strength)

func update():
	cursor.position.x = value * length
	
	if(abs(value) > 0.9) : RumbleManager.big()
	else : if(abs(value) > 0.75) : RumbleManager.medium()
	else : if(abs(value) > 0.5) : RumbleManager.small()
	else : if(abs(value) > 0.25) : RumbleManager.tiny()
