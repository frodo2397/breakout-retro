extends Node2D
const BRICK = preload("res://brick.tscn")
var score = 0
var bricks_created = 0
var bricks_destroyed = 0
const BRICK_ROWS = 3
const BRICK_COLS = 5



func _ready():
	update_score()
	set_bricks()
	

func set_bricks():
	for i in range(BRICK_ROWS):
		for j in range(BRICK_COLS):
			var brick = BRICK.instantiate()
			brick.position = Vector2(200+300*j, 200+200*i)
			bricks_created += 1
			add_child(brick)

func update_score():
	%Label.text = "Score: " + str(score)

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene.call_deferred()

func _on_ball_collided_with_entity(entity):
	%blip.play()
	
	if entity.name == "brick": 
		entity.queue_free()
		bricks_destroyed += 1
		score += 1
		update_score()
		
	if entity.name == "Floor":
		%Label.text = "You have died. F1 to restart. Your final score was " + str(score)
		%Ball.queue_free()
		%gameover.play()
	
	if bricks_created == bricks_destroyed and bricks_destroyed > 0:
		set_bricks()
