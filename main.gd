extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var control: Control = $UI/Control

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	control.set_player_inventory_data(player.inventory_data)

func toggle_inventory_interface() -> void:
	$UI/Control/Inventory.visible = not $UI/Control/Inventory.visible
	
	if $UI/Control/Inventory.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
