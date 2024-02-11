extends CharacterBody2D

@export var target: Player

enum State {PATROL, CHASE}
var speed = 150
var acceleration = 7
var state : State

@onready var navigation_agent: NavigationAgent2D = $Navigation2D/NavigationAgent2D
@onready var detectionArea : Area2D = $DetectionArea
@onready var patrol_timer = $PatrolTimer
@onready var timer = $Navigation2D/Timer

@onready var stunned_mark_scene : PackedScene = preload("res://Scenes/stunned_mark.tscn")

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
	if direction.x > 0:
		$Sprite2D.scale.x = 6
	else:
		$Sprite2D.scale.x = -6
	move_and_slide()

func reset_pos():
	navigation_agent.target_position = patrol_position
	
func init(new_target):
	print(new_target)
	target = new_target

func _on_timer_timeout():
	navigation_agent.target_position = target.global_position


func _on_detection_area_area_entered(area):
	if(area.get_parent() is Player):
		var player : Player = area.get_parent()
		player.stopped_sneaking.connect(_on_detection_area_area_entered.bind(area))
		if player.sneaking:
			return
		target = area.get_parent()
		$Navigation2D/Timer.start()
	detectionArea.get_overlapping_areas()

func stun():
	speed = 0
	$Stun.start()
	var stunned_mark = stunned_mark_scene.instantiate()
	stunned_mark.global_position.y -= 100
	add_child(stunned_mark)

func _on_detection_area_area_exited(_area):
	target = null
	$Navigation2D/Timer.stop()
	reset_pos()


func _on_patrol_timer_timeout():
	var direction = randi_range(-1, 1)
	navigation_agent.target_position = global_position + Vector2(50 * direction, 0)


func _on_stun_timeout():
	speed = 150
	reset_pos()
