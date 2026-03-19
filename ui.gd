extends Control

@onready var inventory: PanelContainer = $Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Coin/Label.text = "Coin : " + str(Global.coin)

func set_player_inventory_data(inventory_data: InventoryData) -> void:
	inventory.set_inventory_data(inventory_data)
