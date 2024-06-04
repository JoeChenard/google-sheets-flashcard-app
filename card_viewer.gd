extends Control

var card = 0
var side = 0
var correct = 0
var incorrect = 0
var startcount = 0
var incorrectCards = []
# Called when the node enters the scene tree for the first time.
func _ready():
	if global.settings['flipped']:
		for i in global.currentDeck:
			i.reverse()
	startcount = len(global.currentDeck)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$card/cardtext.text = global.currentDeck[0][side]
	$score.text = str(correct) + '/' + str(card)


func _on_home_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_correct_pressed():
#	print(global.currentDims)
	if not incorrectCards.has(global.currentDeck.pop_front()):
		correct += 1
	card += 1
	side = 0
	
	deckFinish()


func _on_card_button_pressed():
#	print(len(global.currentDeck[0]))
	side += 1
	if side >= len(global.currentDeck[0]):
		side = 0


func _on_incorrect_pressed():
	if global.settings['repeatIncorrect']:
		var tempincorrect = global.currentDeck.pop_front()
#		print(tempincorrect)
		global.currentDeck.append(tempincorrect)
#		print(global.currentDeck)
		global.currentDeck.shuffle()
		if not incorrectCards.has(tempincorrect):
			incorrectCards.append(tempincorrect)
#			incorrect += 1
			print(incorrectCards)
#		card -= 2
	else:
		global.currentDeck.pop_front()
		card += 1
	side = 0
	
	deckFinish()

func deckFinish():
#	if card >= len(global.currentDeck):
	if len(global.currentDeck) <= 0:
		for i in global.sheetDic[global.currentID]:
			if i[0] == global.currentSheet:
				
				i[1] = str(correct) + '/' + str(startcount)
				break
		global.save_data()
		get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_back_pressed():
	card -= 1


func _on_forward_pressed():
	card += 1


func _on_flip_back_pressed():
	side -= 1
	if side < 0:
		side = len(global.currentDims)
