extends Consumable # Child of consumable

@onready var use_radius : Area2D = $UseRadius


func _ready():
	description = "Make a quick exit!"
	price = 10
	is_powerup = false
	powerup_duration = 0.0
	is_used = false

func use():
	print("using hammer")
	if is_used:
		return
	if use_radius.has_overlapping_areas():
		var window : EscapeWindow = use_radius.get_overlapping_areas()[0].get_parent()
		window.break_glass()
		is_used = true
	else:
		print("No window nearby")

