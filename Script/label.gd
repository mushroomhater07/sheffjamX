extends HBoxContainer
@onready var control = $Control
@onready var label : Label = $Control/Label
@onready var label_2 : Label= $Control/Label2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func setlabel1(text1):
	#print("run")
	label.text = text1
#func setlabel2(text1 : String):
	#label_2.text = text1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
