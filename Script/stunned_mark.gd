extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer : Timer = Timer.new()
	add_child(timer)
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.timeout.connect(queue_free)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
