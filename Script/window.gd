extends Node2D
class_name EscapeWindow

# Sprite texures
var broken_texture = preload("res://Assets/broken_window.png")

@onready var sprite2d : Sprite2D = $Sprite2D

var is_broken : bool = false

func break_glass():
	is_broken = true
	sprite2d.texture = broken_texture

func _on_area_2d_area_entered(area):
	if not is_broken:
		return
	if(area.get_parent() is Player):
		get_tree().change_scene_to_file("res://Scenes/control.tscn")
