extends Consumable # Child of consumable

@onready var use_radius : Area2D = $UseRadius


func _ready():
	description = "Make a quick exit!"
	price = 10
	is_powerup = false
	powerup_duration = 0

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if use_radius.has_overlapping_areas():
			var window : EscapeWindow = use_radius.get_overlapping_areas()[0].get_parent()
			window.break_glass()
		else:
			print("No window nearby")

