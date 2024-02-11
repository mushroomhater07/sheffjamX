extends Node2D

signal exit_reached

@onready var player : Node2D = $Player/PlayerCharacter
# Called when the node enters the scene tree for the first time.
func _ready():
	$Exit.exit_reached.connect(on_exit_reached)
	for window in $Museum/Windows.get_children():
		window.exit_reached.connect(on_exit_reached)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_exit_reached():
	player.game_over(true)
