extends Consumable
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	description = "Lights out!"
	price = 10
	is_powerup = true
	powerup_duration = 3
	is_used = false
	timer.wait_time = powerup_duration

func use():
	if is_used:
		return
	var light_holders = get_tree().get_nodes_in_group("has_light")
	for light : PointLight2D in light_holders:
		light.energy = 0
		if light.get_parent().is_in_group("guard"):
			light.get_parent().timer.stop()
			light.get_parent().reset_pos()
	is_used = true
	$Timer.start()


func _on_timer_timeout():
	print("Lights on")
	var light_holders = get_tree().get_nodes_in_group("has_light")
	for light : PointLight2D in light_holders:
		if light.get_parent().is_in_group("guard"):
			light.get_parent().timer.stop()
		light.energy = 0.2
