extends Consumable

@onready var sprite_2d = $Sprite2D
@onready var point_light_2d = $Sprite2D/PointLight2D
@onready var animation_player = $Sprite2D/AnimationPlayer
@onready var hitbox = $Sprite2D/Hitbox

# Called when the node enters the scene tree for the first time.
func _ready():
	description = "Throwing flash"
	price = 10
	is_powerup = false
	powerup_duration = 0
	is_used = false
	sprite_2d.visible = false
	point_light_2d.energy = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func use():
	if is_used:
		return
	var location = sprite_2d.global_position
	sprite_2d.global_position = location
	
	sprite_2d.visible = true
	sprite_2d.get_child(0).play("throw")
	is_used = true


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "throw"):
		var location = sprite_2d.global_position
		remove_child(sprite_2d)
		get_tree().root.get_child(0).add_child(sprite_2d)
		sprite_2d.global_position = location
		animation_player.play("flash")
	if(anim_name == "flash"):
		for body in hitbox.get_overlapping_bodies():
			if body.is_in_group("guard"):
				body.stun()
		sprite_2d.queue_free()
