extends HBoxContainer
@onready var control = $Control
@onready var label = $Control/Label
@onready var label_2 = $Control/Label2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func setlabel1(text : String):
	label.text = text
func setlabel2(text : String):
	label_2.text = text
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
