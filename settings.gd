extends Control


func _ready():
	$Tree.clear()
	$Tree.cell_selected.connect(treeConnect)
	var root = $Tree.create_item()
	root.set_text(0, 'Edit SpreadSheets:')
	for i in global.sheetNameDic:
		var item = $Tree.create_item(root)
		item.set_text(0, global.sheetNameDic[i])


func treeConnect():
	var id = $Tree.get_selected()
	if id.get_child_count() == 0:
		id = global.sheetNameDic.find_key(id.get_text(0)) #spreadsheet_ID: [[sheet_name, accuracy, time], etc]
		$sheetID.text = str(id)
		$sheetName.text = str(global.sheetNameDic[id])
		for i in global.sheetDic[id]:
			$subSheetList.text += str(i[0]) + ','
		$subSheetList.text = $subSheetList.text.left($subSheetList.text.length() - 1)

func _process(delta):
	$confirmationLabel.modulate.a -= .002


func _on_home_pressed():
	global.save_data()
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_aothconfirm_pressed():
	global.aothKey = $Aoth.text
	$confirmationLabel.modulate.a = 1


func _on_sheetconfirm_pressed():
	global.sheetNameDic[$sheetID.text] = $sheetName.text
	var subSheets = $subSheetList.text.split(',')
	var sheetlist = []
	for i in subSheets:
		sheetlist.append([i,0,0])
	global.sheetDic[$sheetID.text] = sheetlist
	$confirmationLabel.modulate.a = 1
