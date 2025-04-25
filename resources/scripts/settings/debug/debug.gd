extends Object
class_name Debug

static var val : DebugValues = preload("res://resources/settings/debug.tres")

static var debug : bool = false

static var time_scale : float  :
	get : return val.time_scale if val.enabled else val.TIME_SCALE

static var climb_walk : bool  :
	get : return val.climb_walk if val.enabled else val.CLIMB_WALK
