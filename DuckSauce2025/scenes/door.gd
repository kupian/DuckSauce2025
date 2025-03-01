extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func open(body: Node2D):
	if body.is_in_group("Characters"):
		%AnimationPlayer.play("open")

func close():
	%AnimationPlayer.play_backwards("open")

func _on_pressure_pad_body_exited(body):
	if body.is_in_group("Characters"):
		close()
