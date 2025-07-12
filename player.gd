extends CharacterBody2D

@export var speed = 5000

func _physics_process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	global_position.x = mouse_position.x
