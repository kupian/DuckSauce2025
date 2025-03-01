extends Node2D

enum Period {PAST, PRESENT}
var time = Period.PRESENT :
	set(value):
		time = value
		if time == Period.PRESENT:
			remove_child(past)
			add_child(present)
			%CanvasModulate.color = Color("4566a0")
		else:
			remove_child(present)
			add_child(past)
			%CanvasModulate.color = Color("8e5741")
			
var past : Node2D
var present : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	past = %Past
	present = %Present
	%CanvasModulate.color = Color("4566a0")
	remove_child(past)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("change_time"):
		advance_time()
	
func advance_time():
	time = (time + 1) % Period.size()
