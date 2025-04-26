extends GPUParticles2D
class_name Snow

var player : Player
func _ready():
	player = GameManager.main.get_node("ScreenMachine/Game/GameScreen/Player")
	#print(player)

func _process(delta):
	amount = max(20,-player.position.y)
	#amount = 500
	#process_material.direction = Vector3(-1 * abs(player.position.y) / 500,1,0)
	#speed_scale = abs(player.position.y) / 500
	#print("Snow amount : " , amount, "direction",process_material.direction)
