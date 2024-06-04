extends Node

func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)

		
	$HTTPRequest.request("https://sheets.googleapis.com/v4/spreadsheets/16wHLc9QVfcwz-iZ50SbzwpF6wgWyVuNZ9n5NAEmiG9o/values/Hiragana?alt=json&key=" + global.aothKey)
	
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json["values"][0][0])
	$Label.text = json["values"][0][0]
#	print(json)
#	printt(result, response_code, headers, body)
	
#	printt(result, response_code, headers)
#	var bod = ''
#	for i in body:
#		bod += char(i)
#	print(bod)
