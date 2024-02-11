extends Node


var muted : bool;
var datafile :Dictionary;
# Called when the node enters the scene tree for the first time.
func _ready():
	data_init()
	$options.hide();$options/mute.hide();$options/stat.hide();$options/optionchoice.hide();

func data_init():
	datafile = JSON.parse_string(FileAccess.open("res://data/userdata.json",FileAccess.READ).get_as_text())
	#var datafile = JSON.parse_string(FileAccess.get_file_as_string("res://data/userdata.json"))
	muted = datafile.setting.mute
	mute(false);
	var gameobjecttemplate = preload("res://Scenes/label.tscn")
	var gameobject2 = gameobjecttemplate.instantiate()
	gameobject2.setlabel1("Balance: ")
	gameobject2.setlabel2(datafile.current_stat["money"])
	print($"idle/label placeholder")
	reparent($"idle/label placeholder")
	$"idle/label placeholder".add_child(gameobject2)
	gameobject2 = gameobjecttemplate.instantiate()
	gameobject2.setlabel1("Mute: ")
	gameobject2.setlabel2(muted)
	reparent($"idle/label placeholder2")
	$"idle/label placeholder2".add_child(gameobject2)

	for key in datafile.all_time_stat:
		var gameobject1 = gameobjecttemplate.instantiate()
		gameobject1.setlabel1(key)
		gameobject1.setlabel2(datafile.all_time_stat[key])
		reparent($options/stat/ScrollContainer/VFlowContainer)
		$options/stat/ScrollContainer/VFlowContainer.add_child(gameobject1)
#func _unhandled_input(event):
	#if event.is_action_pressed("ui_accept"):
		

func _on_texture_button_2_button_up():
	pass # Replace with function body.


func _on_texture_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/museum_game.tscn")


func _on_texture_button_4_button_down():
	$options.show();
	$options/optionchoice.show();


func _on_texture_button_3_button_up():
	pass # Replace with function body.


func _on_sound_button_up():
	$options/mute.show();$options/optionchoice.hide();

func _on_stat_button_up():
	$options/stat.hide();$options.hide();


func _on_button_button_up():
	$options.hide();$options/mute.hide();$options/stat.hide();$options/optionchoice.hide();


func _on_stats_button_up():
	$options/stat.show();$options/optionchoice.hide();

func _on_mute_button_up():
	mute(true);
	pass
func mute(change: bool):
	if (change):
		if(muted):
			muted = false
			get_node("options/mute").texture_normal = preload("res://Assets/nmuted.png")
			datafile.setting.mute = false
			FileAccess.open("res://data/userdata.json", FileAccess.WRITE).store_string ( JSON.stringify(datafile))
		else:
			muted = true
			get_node("options/mute").texture_normal = preload("res://Assets/muted.png")
			datafile.setting.mute = true
			FileAccess.open("res://data/userdata.json", FileAccess.WRITE).store_string ( JSON.stringify(datafile))
	else:
		if(muted):
			get_node("options/mute").texture_normal = preload("res://Assets/muted.png")
		else:
			get_node("options/mute").texture_normal = preload("res://Assets/muted.png")
	







