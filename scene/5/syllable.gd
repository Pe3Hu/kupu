extends MarginContainer


#region vars
@onready var spots = $Spots

var proprietor = null
var length = null
var morpheme = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	for key in input_:
		set(key, input_[key])
	
	init_basic_setting()


func init_basic_setting() -> void:
	for _i in length:
		add_spot()


func add_spot() -> void:
	var input = {}
	input.syllable = self
	input.group = roll("group")
	input.shade = roll("shade")
	input.morpheme = morpheme

	var spot = Global.scene.spot.instantiate()
	spots.add_child(spot)
	spot.set_attributes(input)


func roll(type_: String) -> String:
	return Global.get_random_key(Global.dict.tag.type[type_])
#endregion
