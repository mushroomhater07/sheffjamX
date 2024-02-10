extends Node

var muted : bool;
var datafile :Dictionary;
# Called when the node enters the scene tree for the first time.
func _ready():
	datafile = JSON.parse_string(FileAccess.open("res://data/userdata.json",FileAccess.READ).get_as_text())
	#var datafile = JSON.parse_string(FileAccess.get_file_as_string("res://data/userdata.json"))
	muted = datafile.setting.mute
	mute();
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
func mute():
	if(muted):
		muted = false
		get_node("options/mute").set_normal_texture(preload("res://Assets/nmuted.png"))
	else:
		muted = true
		get_node("options/mute").set_normal_texture(preload("res://Assets/muted.png"))
