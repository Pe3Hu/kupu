extends MarginContainer


#region vars
@onready var vbox = $VBox
@onready var hbox = $HBox
@onready var group = $VBox/Group
@onready var morpheme = $VBox/Morpheme

var syllable = null
var letter = null
var shade = null
var tones = []
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	syllable = input_.syllable
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	init_icons(input_)


func init_icons(input_: Dictionary) -> void:
	var exceptions = ["syllable"]
	shade = input_.shade
	
	for key in input_:
		if !exceptions.has(key):
			if input_[key] == "tone":
				tones = [Global.arr.tone.pick_random()]
			
			if key == "shade":
				if Global.dict.tone.spectrum.has(input_[key]):
					tones.append_array(Global.dict.tone.spectrum[input_[key]])
				
				for _i in tones.size():
					var tone = hbox.get_child(_i)
					var style = StyleBoxFlat.new()
					style.bg_color = Global.color.tone[tones[_i]]
					tone.set("theme_override_styles/panel", style)
					tone.visible = true
			else:
				var icon = get(key)
				var input = {}
				input.proprietor = self
				input.type = "tag"
				input.subtype = input_[key]
				
				if input_[key] == "letter":
					letter = Global.arr.letter.pick_random()
					input.type = "letter"
					input.subtype = letter
			
				icon.set_attributes(input)
				icon.custom_minimum_size = Global.vec.size.rune
#endregion
