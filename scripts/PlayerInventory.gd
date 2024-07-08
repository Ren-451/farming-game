extends Node

signal active_item_updated

const SlotClass = preload("res://scripts/slot.gd")
const iClass = preload("res://scripts/item.gd")
const NUM_INV_SLOTS = 36
const NUM_HOTBAR_SLOTS = 12

var inventory = {
	0: ['Empty Glass', 1], # slot_index : [item_name, item_quantity]
	1: ['Empty Glass', 1],
	2: ['Egg', 63]

}

var hotbar = {
	0 : ['Egg', 10],
	1 : ['Empty Glass', 2]
}

var active_item_slot = 0

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(Jsondata.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quantity = item_quantity - able_to_add
			
	# if item does not exist in the inventory (add to empty slot)
	for i in range(NUM_INV_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return

func update_slot_visual(slot_index, item_name, new_quantity):
	var inventoryscene = get_tree().get_first_node_in_group("Inventory")
	var gridcontainer = inventoryscene.get_node("GridContainer")
	var slot = gridcontainer.get_node("slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name, new_quantity)
	else:
		slot.initialize_item(item_name, new_quantity)

func remove_item(slot : SlotClass):
	inventory.erase(slot.slot_index)

func add_item_to_empty_slot(item : iClass, slot : SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]

func add_item_quantity(slot : SlotClass, quantity_to_add : int):
	inventory[slot.slot_index][1] += quantity_to_add

func active_item_scroll_up():
	active_item_slot = (active_item_slot + 1) % NUM_HOTBAR_SLOTS
	emit_signal("active_item_updated")
func active_item_scroll_down():
	if active_item_slot == 0:
		active_item_slot = NUM_HOTBAR_SLOTS - 1
	else: 
		active_item_slot -= 1
	emit_signal("active_item_updated")
