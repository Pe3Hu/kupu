extends MarginContainer


#region vars
@onready var group = $VBox/Group
@onready var shade = $VBox/Shade
@onready var order = $VBox/Order

var syllable = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	syllable = input_.syllable
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	#custom_minimum_size = Global.vec.size.card.zone
	init_icons(input_)


func init_icons(input_: Dictionary) -> void:
	var exceptions = ["syllable"]
	
	for key in input_:
		if !exceptions.has(key):
			var icon = get(key)
			var input = {}
			input.proprietor = self
			input.type = "tag"
			input.subtype = input_[key]
			icon.set_attributes(input)
			icon.custom_minimum_size = Global.vec.size.rune
			icon.visible = true
#endregion
