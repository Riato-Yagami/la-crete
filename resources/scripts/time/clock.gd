extends Node
class_name Clock

var time : float = 0
var enabled : bool = false

func _process(delta) -> void : if enabled: time += delta

func start() -> void : enabled = true

func pause() -> void : enabled = false

func reset() -> void: time = 0

func sort() -> Watch :
	var t : float = time
	var watch = Watch.new()
	watch.h = floor(t/3600)
	t -= 3600 * watch.h
	watch.m = floor(t/60)
	t -= 60 * watch.m
	watch.s = floor(t)
	t -= watch.s
	watch.ms = floor(t*1000)
	return watch
	
#func parse() -> String :
	#var w : Watch = sort()
	#return Parse.digit(w.h) + ":" + Parse.digit(w.m) + ":" + Parse.digit(w.s) + ":" + Parse.digit(w.ms,3)
