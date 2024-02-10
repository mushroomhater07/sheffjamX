extends CharacterBody2D

@export var target: Player

enum State {PATROL, CHASE}
var speed = 150
var acceleration = 7
var state : State

@onready var navigation_agent: NavigationAgent2D = $Navigation2D/NavigationAgent2D
@onready var line2d : Line2D = $Line2D
@onready var detectionArea : Area2D = $DetectionArea

var patrol_position : Vector2


func _ready():
	state = State.PATROL
	patrol_position = global_position

func _physics_process(delta):

	var direction = to_local(navigation_agent.get_next_path_position()).normalized()
	velocity = direction * speed
	match state:
		State.PATROL:
			if navigation_agent.distance_to_target() < 10:
				velocity = Vector2.ZERO
		State.CHASE:
			pass
	
	move_and_slide()

	
func init(new_target):
	target = new_target

func _on_timer_timeout():
	navigation_agent.target_position = target.global_position


func _on_detection_area_area_entered(area):
	print("Player detected")
	target = area.get_parent()
	$Navigation2D/Timer.start()


func _on_detection_area_area_exited(area):
	target = null
	$Navigation2D/Timer.stop()
	navigation_agent.target_position
	navigation_agent.target_position = patrol_position


func _on_patrol_timer_timeout():
	var direction = randi_range(-1, 1)
	
	navigation_agent.target_position = global_position + Vector2(50 * direction, 0)
