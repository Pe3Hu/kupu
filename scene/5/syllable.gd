extends MarginContainer


#region vars
@onready var spots = $Spots

var proprietor = null
var length = null
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
	input.group = "vowel"
	input.shade = "tenor"
	input.order = "root"

	var spot = Global.scene.spot.instantiate()
	spots.add_child(spot)
	spot.set_attributes(input)
#endregion
