extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/museum_game.tscn")



func _on_texture_button_2_button_up():
	pass # Replace with function body.


func _on_texture_button_button_up():
	pass # Replace with function body.


func _on_texture_button_4_button_up():
	pass # Replace with function body.


func _on_texture_button_3_button_up():
	pass # Replace with function body.


func _on_texture_button_4_button_down():
	pass # Replace with function body.
