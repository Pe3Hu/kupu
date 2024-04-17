extends MarginContainer


#region vars
@onready var syllables = $Syllables

var warzone = null
var mask = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	warzone = input_.warzone
	mask = input_.mask
	
	init_basic_setting()


func init_basic_setting() -> void:
	#custom_minimum_size = Global.vec.size.card.zone
	init_syllables()


func init_syllables() -> void:
	for length in mask:
		add_syllable(length)


func add_syllable(length_: int) -> void:
	var input = {}
	input.proprietor = self
	input.length = length_

	var syllable = Global.scene.syllable.instantiate()
	syllables.add_child(syllable)
	syllable.set_attributes(input)
#endregion
