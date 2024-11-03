extends Node

class_name CharacterStateMachine

@export var charcter : CharacterBody2D
@export var current_state : State

var states : Array[State]

func _ready() -> void:
	for child in get_children():
		if(child is State):
			states.append(child)
		else:
			push_warning("Child " + child.name + " is not a state")

func get_can_move():
	return current_state.can_move
