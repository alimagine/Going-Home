extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var control: Control = $UI/Control

func _ready() -> void:
	control.set_player_inventory_data(player.inventory_data)
