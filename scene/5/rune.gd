extends MarginContainer


#region vars
@onready var bg = $BG
@onready var letter = $VBox/Letter
@onready var parity = $VBox/Tags/Parity
@onready var extreme = $VBox/Tags/Extreme
@onready var phase = $VBox/Tags/Phase

var proprietor = null
var tone = null
var tags = []
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	tone = input_.tone
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	init_icons(input_)
	init_bg()


func init_icons(input_: Dictionary) -> void:
	var input = {}
	input.proprietor = self
	input.type = "letter"
	input.subtype = input_.letter
	letter.set_attributes(input)
	letter.custom_minimum_size = Global.vec.size.rune
	
	input.type = "tag"
	tags.append_array(Global.dict.letter.title[input_.letter].tags)
	
	for type in Global.dict.letter.title[input_.letter]:
		input.subtype = Global.dict.letter.title[input_.letter][type]
		
		if tags.has(input.subtype):
			var icon = get(type)
			icon.set_attributes(input)
			icon.custom_minimum_size = Global.vec.size.rune


func init_bg() -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Global.color.tone[tone]
	letter.bg.set("theme_override_styles/panel", style)
	letter.bg.visible = true
#endregion
