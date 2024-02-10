extends Node2D

var time : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	position.y += sin(time * 4) * 1



func _on_area_2d_area_entered(area):
	var player : Player = area.get_parent()
	player.max_speed *= 0.9
	clampf(player.max_speed, 125, 300)
	
	queue_free()
