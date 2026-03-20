extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var control: Control = $UI/Control
@onready var inventory: PanelContainer = $UI/Control/Inventory

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	control.set_player_inventory_data(player.inventory_data)

func toggle_inventory_interface() -> void:
	inventory.visible = not inventory.visible
	
	if inventory.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
