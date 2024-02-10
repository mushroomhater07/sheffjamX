extends Node

var mute : bool;
# Called when the node enters the scene tree for the first time.
func _ready():
	#var datafile = JSON.parse_string(FileAccess.open("res://data/userdata.json",FileAccess.READ).get_as_text())
	var datafile = JSON.parse_string(FileAccess.get_file_as_string("res://data/userdata.json"))
	print(datafile)
	$options.hide();$options/mute.hide();

#func _unhandled_input(event):
	#if event.is_action_pressed("ui_accept"):
		

func _on_texture_button_2_button_up():
	pass # Replace with function body.


func _on_texture_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/museum_game.tscn")


func _on_texture_button_4_button_down():
	$options.show();


func _on_texture_button_3_button_up():
	pass # Replace with function body.





func _on_mute_button_up():
	#if()
	pass
