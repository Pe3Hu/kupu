extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_dict()
	init_color()
	init_scene()
	init_font()


func init_arr() -> void:
	arr.feature = ["group", "shade"]
	arr.letter = ["a", "b", "c", "d", "e", "x", "y", "z"]
	arr.tone = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]


func init_num() -> void:
	num.index = {}
	num.index.card = 0
	
	num.warzone = {}
	num.warzone.n = 3
	
	num.deck = {}
	num.deck.n = 12
	
	num.point = {}
	num.point.group = 8
	num.point.tone = 7


func init_dict() -> void:
	init_neighbor()
	init_season()
	init_area()
	
	init_letter()
	init_tone()
	init_tag()


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]



func init_season() -> void:
	dict.season = {}
	dict.season.phase = {}
	dict.season.phase["spring"] = ["incoming"]
	dict.season.phase["summer"] = ["selecting", "outcoming"]
	dict.season.phase["autumn"] = ["wounding"]
	dict.season.phase["winter"] = ["wilting", "sowing"]


func init_area() -> void:
	dict.area = {}
	dict.area.next = {}
	dict.area.next[null] = "discharged"
	dict.area.next["discharged"] = "available"
	dict.area.next["available"] = "hand"
	dict.area.next["hand"] = "discharged"
	dict.area.next["broken"] = "discharged"
	
	dict.area.prior = {}
	dict.area.prior["available"] = "discharged"
	dict.area.prior["hand"] = "available"


func init_letter() -> void:
	dict.letter = {}
	dict.letter.title = {}
	
	var exceptions = ["title"]
	var path = "res://asset/json/kupu_letter.json"
	var array = load_data(path)
	
	for letter in array:
		var data = {}
		
		for key in letter:
			if !exceptions.has(key):
				if !dict.letter.has(key):
					dict.letter[key] = {}
				
				data[key] = letter[key]
				
				if !dict.letter[key].has(letter[key]):
					dict.letter[key][letter[key]] = []
				
				dict.letter[key][letter[key]].append(letter.title)
			
			dict.letter.title[letter.title] = data


func init_tone() -> void:
	dict.tone = {}
	dict.tone.title = {}
	dict.tone.spectrum = {}
	
	var exceptions = ["title", "hue"]
	var path = "res://asset/json/kupu_tone.json"
	var array = load_data(path)
	
	for tone in array:
		var data = {}
		data.hue = tone.hue
		
		for key in tone:
			if !exceptions.has(key):
				var words = tone[key].split(",")
				data[key] = words
				
				for spectrum in words:
					if !dict.tone.spectrum.has(spectrum):
						dict.tone.spectrum[spectrum] = []
					
					dict.tone.spectrum[spectrum].append(tone.title)
			
			dict.tone.title[tone.title] = data


func init_tag() -> void:
	dict.tag = {}
	dict.tag.title = {}
	
	var exceptions = ["title", "type"]
	var path = "res://asset/json/kupu_tag.json"
	var array = load_data(path)
	
	for tag in array:
		var data = {}
		
		for key in tag:
			if !exceptions.has(key):
				data[key] = tag[key]
			
			dict.tag.title[tag.title] = data


func init_scene() -> void:
	scene.token = load("res://scene/0/token.tscn")
	
	scene.pantheon = load("res://scene/1/pantheon.tscn")
	scene.god = load("res://scene/1/god.tscn")
	
	scene.planet = load("res://scene/2/planet.tscn")
	scene.area = load("res://scene/2/area.tscn")
	
	scene.card = load("res://scene/3/card.tscn")
	
	scene.zone = load("res://scene/4/zone.tscn")
	
	scene.rune = load("res://scene/5/rune.tscn")
	scene.syllable = load("res://scene/5/syllable.tscn")
	scene.spot = load("res://scene/5/spot.tscn")


func init_vec():
	vec.size = {}
	vec.size.sixteen = Vector2(16, 16)
	vec.size.number = Vector2(vec.size.sixteen)
	
	vec.size.token = Vector2(48, 48)
	vec.size.rune = Vector2(vec.size.token)
	
	#vec.size.card = {}
	#vec.size.card.market = Vector2(vec.size.token.x * 2, vec.size.token.y)
	#vec.size.card.deck = Vector2(vec.size.token.x, vec.size.token.y)
	vec.size.bar = Vector2(128, 16)
	#vec.size.deck = Vector2(vec.size.token.x * 6, vec.size.token.y * 5)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.card = {}
	color.card.selected = {}
	color.card.selected[true] = Color.from_hsv(160 / h, 0.4, 0.7)
	color.card.selected[false] = Color.from_hsv(60 / h, 0.2, 0.9)
	
	color.indicator = {}
	color.indicator.health = {}
	color.indicator.health.fill = Color.from_hsv(0 / h, 0.9, 0.7)
	color.indicator.health.background = Color.from_hsv(0 / h, 0.5, 0.9)
	color.indicator.endurance = {}
	color.indicator.endurance.fill = Color.from_hsv(270 / h, 0.9, 0.7)
	color.indicator.endurance.background = Color.from_hsv(270 / h, 0.5, 0.9)
	
	color.tone = {}
	
	for tone in dict.tone.title:
		color.tone[tone] = Color.from_hsv(dict.tone.title[tone].hue / h, 0.9, 0.7)


func init_font():
	dict.font = {}
	dict.font.size = {}
	#dict.font.size["resource"] = 24
	#dict.font.size["card"] = 24
	dict.font.size["season"] = 18
	dict.font.size["phase"] = 18
	dict.font.size["moon"] = 18


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null


func get_all_constituents_based_on_limit(array_: Array, limit_: int) -> Dictionary:
	var constituents = {}
	constituents[0] = []
	constituents[1] = []
	
	for child in array_:
		constituents[0].append(child)
		
		if child.value <= limit_:
			constituents[1].append([child])
	
	for _i in array_.size()-2:
		set_constituents_based_on_size_and_limit(constituents, _i+2, limit_)
	
	var value = 0
	
	for constituent in array_:
		value += constituent.value
	
	if value <= limit_:
		constituents[array_.size()] = [constituents[0]]
	
	constituents.erase(0)
	
	for _i in range(constituents.keys().size()-1,-1,-1):
		var key = constituents.keys()[_i]
		
		if constituents[key].is_empty():
			constituents.erase(key)
	
	return constituents


func set_constituents_based_on_size_and_limit(constituents_: Dictionary, size_:int, limit_: int) -> void:
	var parents = constituents_[size_-1]
	constituents_[size_] = []
	
	for parent in parents:
		var value = 0
		
		for constituent in parent:
			value += constituent.value
		
		for child in constituents_[0]:
			if !parent.has(child) and value + child.value <= limit_:
				var constituent = []
				constituent.append_array(parent)
				constituent.append(child)
				constituent.sort_custom(func(a, b): return constituents_[0].find(a) < constituents_[0].find(b))
				
				if !constituents_[size_].has(constituent):
					constituents_[size_].append(constituent)
