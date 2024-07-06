extends Node

const NUM_INV_SLOTS = 36

var inventory = {
	0: ['Empty Glass', 1], # slot_index : [item_name, item_quantity]
	1: ['Empty Glass', 1]

}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			# checks if slot is full
			inventory[item][1] += item_quantity
			return
			
	# if item does not exist in the inventory (add to empty slot)
	for i in range(NUM_INV_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return
