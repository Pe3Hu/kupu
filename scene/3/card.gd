extends MarginContainer


#region vars
@onready var runes = $Runes

var proprietor = null
var area = null
var selected = false
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	for key in input_:
		set(key, input_[key])
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	for _i in input_.letters.size():
		var letter = input_.letters[_i]
		var tone = input_.tones[_i]
		add_rune(letter, tone)


func add_rune(letter_: String, tone_: String) -> void:
	var input = {}
	input.proprietor = self
	input.letter = letter_
	input.tone = tone_

	var rune = Global.scene.rune.instantiate()
	runes.add_child(rune)
	rune.set_attributes(input)


func advance_area() -> void:
	var cardstack = null
	
	if area == null:
		area = Global.dict.area.next[area]
		advance_area()
	else:
		cardstack = proprietor.get(area)
		cardstack.cards.remove_child(self)
	
		area = Global.dict.area.next[area]
		cardstack = proprietor.get(area)
		cardstack.cards.add_child(self)


func set_deck_as_proprietor(deck_: MarginContainer) -> void:
	var cardstack = proprietor.get(area)
	var market = false
	
	if cardstack == null:
		cardstack = proprietor
		market = true
	
	cardstack.cards.remove_child(self)
	proprietor = deck_
	area = "discharged"
	
	cardstack = proprietor.get(area)
	cardstack.cards.add_child(self)
	
	if !market:
		advance_area()
#endregion
