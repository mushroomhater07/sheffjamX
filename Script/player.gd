extends CharacterBody2D
class_name Player



@export var max_speed:float = 300
var current_speed:Vector2 = Vector2(0, 0)

##### speed increase/decrease per sec
@export var acceleration:float = 10000
@export var deceleration:float = 10000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	##### x, y
	var frame_speed_vector:Vector2 = Vector2()
	var nothing_pressed:bool = true
	if Input.is_action_pressed("up"):
		frame_speed_vector[1] = -1
		nothing_pressed = false
	if Input.is_action_pressed("down"):
		frame_speed_vector[1] = 1
		nothing_pressed = false
	if Input.is_action_pressed("left"):
		frame_speed_vector[0] = -1
		nothing_pressed = false
	if Input.is_action_pressed("right"):
		frame_speed_vector[0] = 1
		nothing_pressed = false
	
	frame_speed_vector = frame_speed_vector.normalized()
	if nothing_pressed:
		##### deceleration
		for i in range(2):
			if current_speed[i]>0:
				current_speed[i] = max(0, current_speed[i]-deceleration*delta)
			elif current_speed[i]<0:
				current_speed[i] = min(0, current_speed[i]+deceleration*delta)
	
	current_speed += frame_speed_vector*acceleration*delta
	var scalar_speed:float = current_speed.length()
	if scalar_speed > max_speed:
		var max_scale:float = scalar_speed/max_speed
		current_speed /= max_scale
	
	velocity = current_speed
	move_and_slide()
	#var collision = move_and_collide(current_speed)
	#if collision:
		#velocity = velocity.slide(collision.get_normal())
	
