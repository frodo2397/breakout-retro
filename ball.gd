extends Node2D

signal collided_with_entity(entity)

var direction = Vector2.ZERO
var speed = 0.5


func _ready():
	direction = Vector2(500, -500)

func _physics_process(delta):
	speed += delta / 60
	
	var collision = %Ball_body.move_and_collide(direction*delta * speed)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		direction = direction.bounce(collision.get_normal())
		%Ball_body.move_and_collide(reflect)
		collided_with_entity.emit(collision.get_collider())
