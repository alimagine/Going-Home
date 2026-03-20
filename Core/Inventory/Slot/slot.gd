extends PanelContainer

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var label: Label = $Label

func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.item_name, item_data.item_desc]
	
	if slot_data.quantity > 1:
		label.text = "x%s" % slot_data.quantity
		label.show()
