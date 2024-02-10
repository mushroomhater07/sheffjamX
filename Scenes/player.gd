extends Node2D

var max_speed:float = 0.5
var current_speed:Vector2 = Vector2(0, 0)

##### speed increase/decrease per sec
var acceleration:float = 5
var deceleration:float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	position += current_speed
	
