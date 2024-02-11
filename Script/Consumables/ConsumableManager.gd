extends Node2D

@onready var player:CharacterBody2D = get_parent()

var name_convert:Dictionary =  {"Flashbang":"FlashBang",
								"LightsOut":"LightsOut",
								"SpeedBoost":"SpeedBoost",
								"Hammer":"Wrench",
								"Sneakers":"SilentShoes"}

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if player.item:
			var item:String = name_convert[player.item]
			var consumable : Consumable = player.get_node("ConsumableManager/"+item)
			consumable.use()
		
