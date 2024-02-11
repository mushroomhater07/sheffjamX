extends CharacterBody2D
class_name Player

@onready var player_sprite = $PlayerSprite
@onready var ghost_timer = $GhostTimer

@export var max_speed:float = 300
var current_speed:Vector2 = Vector2(0, 0)

@export var bag_size:float = 1;

##### speed increase/decrease per sec
@export var acceleration:float = 10000
@export var deceleration:float = 10000

# Consumable related variables
var sneaking : bool
signal stopped_sneaking

var item:String

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
		player_sprite.scale.x = -2
		nothing_pressed = false
		$PlayerSprite/bag/Sprite2D.set_flip_h(false)
		$PlayerSprite/bag.set_scale(Vector2(bag_size/2,bag_size/2))
	if Input.is_action_pressed("right"):
		frame_speed_vector[0] = 1
		player_sprite.scale.x = 2
		nothing_pressed = false
		$PlayerSprite/bag/Sprite2D.set_flip_h(true)
		$PlayerSprite/bag.set_scale(Vector2(-bag_size/2,bag_size/2))
	
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
	if (velocity != Vector2.ZERO):
		$"../AnimationPlayer".play("move")

	move_and_slide()

func init(selected_item):
	if not selected_item:
		selected_item = ""
	item = selected_item
	
func _on_detection_hitbox_body_entered(_body):
	game_over(false)

func _on_ghost_timer_timeout():
	var afterimage = preload("res://Scenes/after_image.tscn").instantiate()
	afterimage.texture = player_sprite.sprite_frames.get_frame_texture("default", 0)
	afterimage.scale = Vector2(2,2)
	get_parent().add_child(afterimage)
	afterimage.global_position = global_position
	

func _on_bag_body_entered(body):
	game_over(false)

func game_over(victory):
	var game_over_node = load("res://Scenes/game_over.tscn").instantiate()
	game_over_node.init(victory)
	var control_node = get_node("/root")
	control_node.add_child(game_over_node)
	control_node.get_node("MuseumGame").queue_free()
	

