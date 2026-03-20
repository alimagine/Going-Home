extends Node3D

const ROT_SPEED = 2 # how many degre coin rotate per frame

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))


#func _on_body_entered(body: Node3D) -> void:
	#Global.coin += 1
	#print(Global.coin)
	#queue_free()
