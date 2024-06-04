extends Node

var flashcard_data = "user://flashcard_data.save"

var loading: bool = false

var cardOrd: Array[int] = []
var dimOrd: Array[int] = []
var currentDeck = []
var currentDims = 0
var currentID = ''
var currentSheet = ''

var settings = {'flipped': false, 'repeatIncorrect' : false, 'useXcards' : 10}

#'54g45ge': [['georgestuffs',3,4],['xeorgestuffs',3,4]], 'asgrerhttd': [['jorgestuffs',7,4],['qeorgestuffs',3,4]],
#	'fasrg5g': [['Wyattstuffs', 0, 1],['keorgestuffs',3,4]]
var sheetDic: Dictionary = {} #spreadsheet_ID: [[sheet_name, accuracy, time], etc]
var sheetNameDic: Dictionary = {}#spreadsheet_ID: name
#'54g45ge': 'george', 'asgrerhttd': 'jorge',
#	'fasrg5g': 'Wyatt'


var aothKey = ''

func _ready():
	pass
#	load_data()
#	$HTTPRequest.request_completed.connect(_on_request_completed)
#	
	

#---auth
#---spreadsheet ID
#---sheet names
#---saved score

func save_data():
	var savetuple = [aothKey, sheetDic, sheetNameDic, settings]
	var file = FileAccess.open(flashcard_data, FileAccess.WRITE)
	file.store_var(savetuple)
	
func load_data():
	var file = FileAccess.open(flashcard_data, FileAccess.READ)
	if FileAccess.file_exists(flashcard_data):
		var content = file.get_var()
		aothKey = content[0]
		sheetDic = content[1]
		sheetNameDic = content[2]
		settings = content[3]

#{
#  "range": "Hiragana!A1:Z1000",
#  "majorDimension": "ROWS",
#  "values": [
#    [
#      "col1",
#      "col2"
#    ],
#    [
#      "hi",
#      "ho"
#    ],
#    [
#      "yes",
#      "no"
#    ],
#    [
#      "red",
#      "blue"
#    ],
#    [
#      "あか",
#      "あお"
#    ],
#    [
#      "hi",
#      "what!?"
#    ],
#    [
#      "旅人",
#      "traveler"
#    ]
#  ]
#}
