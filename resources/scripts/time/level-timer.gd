extends Control
class_name LevelTimer

@onready var clock : Clock = Clock.new()
@export var hms_label : Label
@export var ms_label : Label

func _ready():
	add_child(clock)

func _process(_delta):
	if(!clock.enabled) : return
	var w : Watch = clock.sort()
	var text : String = w.ph + ":" + w.pm + ":" + w.ps
	#print(text, "." + w.pms)
	hms_label.text = text
	ms_label.text = "." + w.pms
