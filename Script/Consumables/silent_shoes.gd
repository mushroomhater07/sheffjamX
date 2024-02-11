extends Consumable

@onready var timer : Timer = $Timer

var player_previous_speed : float

func _ready():
	description = "For sneaking around"
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
	var new_speed = player.max_speed * 0.5
	player.max_speed = clamp(new_speed, 70, 300)
	player.sneaking = true
	timer.start()
	is_used = true

func _on_timer_timeout():
	var player : Player = get_parent().get_parent()
	player.max_speed = player_previous_speed
	player.sneaking = false
	player.emit_signal("stopped_sneaking")
