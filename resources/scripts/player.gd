class_name Player
extends Node2D

@onready var animation : AnimatedSprite2D = $Animation
@onready var state_machine : StateMachine = $StateMachine

@export var spawn : Spawn

@export var player_camera : FollowCamera

@export var walk_line : Walk_Line
@export var walk_line_y_offset : float = 0

@export var balance_bar : BalanceBar

var height : float :
	get : return -position.y

var walk_input : bool :
	get : return Input.is_action_pressed("move_forward") or Input.is_action_pressed("move_backward")
	
var is_on_crete : bool :
	get : return walk_line.crete_parent.is_on_crete(walk_line.get_point_id(position.x))
	
var direction : int :
	get :
		var _direction : int = 0
		if(Input.is_action_pressed("move_forward")): _direction = 1
		if(Input.is_action_pressed("move_backward")): _direction = -1
		return _direction

var balance_input : int :
	get :
		var _balance : int = 0
		if(Input.is_action_pressed("balance_left")): _balance = -1
		if(Input.is_action_pressed("balance_right")): _balance = 1
		return _balance
		
var climb_input : int :
	get :
		var _climb_input : int = 0
		if(Input.is_action_just_pressed("balance_left")): _climb_input = -1
		if(Input.is_action_just_pressed("balance_right")): _climb_input = 1
		return _climb_input

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	position.x = spawn.position.x
	state_machine.init(self)

func input(event: InputEvent) -> void:
	state_machine.process_input(event)

#func _physics_process(delta: float) -> void:
	#state_machine.process_physics(delta * Debug.time_scale)

func _process(delta: float) -> void:
	state_machine.process_frame(delta * Debug.time_scale)

func move_to_floor(offset : float = walk_line_y_offset) -> void:
	var walk_line_y = walk_line.get_height(position.x)
	position.y = walk_line_y - offset
