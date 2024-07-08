extends CanvasLayer

var hold_item = null

@onready var inventory = $Inventory

func _input(event):
	if event.is_action_pressed("inventory"):
		inventory.visible = !inventory.visible
		inventory.initialize_inventory()
		
	if event.is_action_pressed("scroll_up"):
		PlayerInventory.active_item_scroll_down()
	elif event.is_action_pressed("scroll_down"):
		PlayerInventory.active_item_scroll_up()

