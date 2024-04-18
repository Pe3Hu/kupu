extends MarginContainer


#region vars
@onready var syllables = $Syllables

var proprietor = null
var mask = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	mask = input_.mask
	
	init_basic_setting()


func init_basic_setting() -> void:
	#custom_minimum_size = Global.vec.size.card.zone
	init_syllables()


func init_syllables() -> void:
	for morpheme in mask:
		var lengths = Global.dict.mask.syllable[int(mask[morpheme])]
		lengths.shuffle()
		
		for length in lengths:
			add_syllable(morpheme, length)


func add_syllable(morpheme_: String, length_: int) -> void:
	var input = {}
	input.proprietor = self
	input.morpheme = morpheme_
	input.length = length_

	var syllable = Global.scene.syllable.instantiate()
	syllables.add_child(syllable)
	syllable.set_attributes(input)
#endregion
