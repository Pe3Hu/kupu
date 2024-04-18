extends MarginContainer


#region vars
@onready var milestones = $Milestones

var warzone = null
var mask = null
var remoteness = null
var queue = null
var rank = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	warzone = input_.warzone
	
	init_basic_setting()


func init_basic_setting() -> void:
	remoteness = 5
	queue = 1
	rank = 4
	#custom_minimum_size = Global.vec.size.card.zone
	refill_milestones()


func refill_milestones() -> void:
	while milestones.get_child_count() < queue:
		add_milestone()


func add_milestone() -> void:
	var input = {}
	input.zone = self
	input.length = Global.get_random_key(Global.dict.zone.rank[rank])
	input.remoteness = int(remoteness)

	var milestone = Global.scene.milestone.instantiate()
	milestones.add_child(milestone)
	milestone.set_attributes(input)
#endregion
