extends MarginContainer


#region vars
@onready var remoteness = $HBox/Remoteness
@onready var word = $HBox/Word

var zone = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	zone = input_.zone
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	init_tokens(input_)
	init_word(input_)


func init_tokens(input_: Dictionary) -> void:
	var input = {}
	input.proprietor = self
	input.type = "milestone"
	input.subtype = "remoteness"
	input.value = input_.remoteness
	remoteness.set_attributes(input)


func init_word(input_: Dictionary) -> void:
	var input = {}
	input.proprietor = self
	input.mask = Global.get_random_key(Global.dict.mask.length[input_.length])
	word.set_attributes(input)
#endregion
