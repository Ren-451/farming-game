extends Control
@onready var hotbar = $HotbarSlots

@onready var slots = hotbar.get_children()

func _ready():
	var slots = hotbar.get_children()
	for i in range(slots.size()):
		# slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
	initialize_hotbar()

func initialize_hotbar():
	var slots = hotbar.get_children()
	for i in range(slots.size()):
		if PlayerInventory.hotbar.has(i):
			slots[i].initialize_item(PlayerInventory.hotbar[i][0], PlayerInventory.hotbar[i][1])

