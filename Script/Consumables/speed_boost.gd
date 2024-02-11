extends Consumable

var speed_multiplier = 2.0
var player_previous_speed : float

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	description = "Sneaking around really quickly"
	price = 10
	is_powerup = true
	powerup_duration = 10.0
	is_used = false
	timer.wait_time = powerup_duration


func use():
	if is_used:
		return
	var player : Player = get_parent().get_parent()
	player_previous_speed = player.max_speed
	var new_speed = player.max_speed * speed_multiplier
	player.max_speed = clamp(new_speed, 70, 600)
	player.ghost_timer.one_shot = false
	player.ghost_timer.start()
	timer.start()
	is_used = true

func _on_timer_timeout():
	var player : Player = get_parent().get_parent()
	player.max_speed = clamp(player.max_speed / speed_multiplier, 70, 300)
	player.ghost_timer.one_shot = true
	player.ghost_timer.stop()
