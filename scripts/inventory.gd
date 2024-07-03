extends Node2D

const SlotClass = preload("res://scripts/slot.gd")
@onready var inv_slots = $GridContainer
var hold_item = null

func _ready():
	for inv_slot in inv_slots.get_children():
		inv_slot.gui_input.connect(slot_gui_input.bind(inv_slot))

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if hold_item != null:
				if !slot.item:
					slot.putIntoSlot(hold_item)
					hold_item = null
				else:
					var temp_item = slot.item
					slot.pickFromSlot()
					temp_item.global_position = event.global_position
					slot.putIntoSlot(hold_item)
					hold_item = temp_item
			elif slot.item:
				hold_item = slot.item
				slot.pickFromSlot()
				hold_item.global_position = get_global_mouse_position()

func _input(event):
	if hold_item:
		hold_item.global_position = get_global_mouse_position()
		
