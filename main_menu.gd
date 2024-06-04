extends Control

var http = 'https://sheets.googleapis.com/v4/spreadsheets/'
var sheetVal = '/values/'
var sheetJson = '?alt=json&key='

func _ready():
	global.load_data()
	$loading.visible = false
	$Tree.clear()
	$Tree.cell_selected.connect(treeConnect)
	var root = $Tree.create_item()
	root.set_text(0, 'SpreadSheets:')
	for i in global.sheetNameDic:
		var item = $Tree.create_item(root)
		item.set_text(0, global.sheetNameDic[i])
		for j in len(global.sheetDic[i]):
			var itemI = $Tree.create_item(item)
			itemI.set_text(0, global.sheetDic[i][j][0])
			itemI.set_suffix(0, str(global.sheetDic[i][j][1]))

		
	$flipCardLabel.visible = global.settings['flipped']
	$repeatIncorrectCardsLabel.visible = global.settings['repeatIncorrect']
	$lastcardsLabel.text = 'last ' + str(global.settings['useXcards']) + ' cards used'

func treeConnect():
	var this = $Tree.get_selected()
#	printt(this.get_parent().get_text(0), this.get_text(0))
	if this.get_child_count() == 0:
		global.currentID = global.sheetNameDic.find_key(this.get_parent().get_text(0))
		global.currentSheet = this.get_text(0)
		http_request(global.currentSheet, global.currentID)

func http_request(pageName: String, sheetID: String):
	$loading.visible = true
	$HTTPRequest.request_completed.connect(_on_request_completed)
	print(http + sheetID + sheetVal + pageName + sheetJson + global.aothKey)
	$HTTPRequest.request(http + sheetID + sheetVal + pageName + sheetJson + global.aothKey)
	
func _on_request_completed(result, response_code, headers, body):
	print(response_code)
	var json = JSON.parse_string(body.get_string_from_utf8())
	var tempDeck =  json["values"]
	print(tempDeck)
	tempDeck.pop_front()
	var numCards = global.settings['useXcards']
	if numCards < len(tempDeck):
		for i in numCards:
			global.currentDeck.append(tempDeck.pop_back())
	else:
		global.currentDeck = tempDeck
	global.currentDeck.shuffle()
	print(global.currentDeck)
	#data comes in as list of lists: json["values"][0][0] gives first row first item
	get_tree().change_scene_to_file("res://card_viewer.tscn")

func _process(delta):
	pass
#	$debug.text = str(global.sheetDic)

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_text_edit_text_submitted(new_text):
	global.settings['useXcards'] = int(new_text)
	global.save_data()
	get_tree().reload_current_scene()


func _on_flip_card_button_pressed():
	global.settings['flipped'] = not global.settings['flipped']
	global.save_data()
	get_tree().reload_current_scene()


func _on_repeat_incorrect_button_pressed():
	global.settings['repeatIncorrect'] = not global.settings['repeatIncorrect']
	global.save_data()
	get_tree().reload_current_scene()
