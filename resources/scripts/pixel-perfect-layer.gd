extends CanvasLayer
class_name PixelPerfectLayer

@export var main_camera : Camera2D
@export var pixel_perfect_camera : Camera2D

@export var sub_viewport : SubViewport

func _ready():
	#print(sub_viewport)
	await get_tree().process_frame
	
	var pixel_perfect_stuff = get_tree().get_nodes_in_group("PP")
	
	#print(pixel_perfect_stuff)
	for thing in pixel_perfect_stuff:
		thing.call_deferred("reparent", sub_viewport,true)

func _process(delta):
	if !pixel_perfect_camera or !main_camera :
		print("PP Cam ERROR")
		return
	pixel_perfect_camera.set_global_transform(main_camera.get_global_transform())
