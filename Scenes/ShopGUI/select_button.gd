extends Control

signal select_button_pressed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	select_button_pressed.emit()

func set_frame(frame):
	$AnimatedSprite2D.frame = frame
