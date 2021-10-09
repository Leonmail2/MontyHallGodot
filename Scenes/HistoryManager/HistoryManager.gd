extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var trial_file_name = "montyhalltrials.json"
var trials_information = {}

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass

func store_trial_information(trial_won,switched):
	var results = retrive_json_file_information()
	if trial_won:
		if switched:
			results["trials_won_switching"] += 1
		else:
			results["trials_won_not_switching"] += 1
	else:
		if switched:
			results["trials_lost_switching"] += 1
		else:
			results["trials_lost_not_switching"] += 1
	write_file_with_information(JSON.print(results))

func retrive_json_file_information():
	var file = File.new()
	if not file.file_exists("user://"+trial_file_name):
		make_results_file()
	file.open("user://"+trial_file_name,file.READ)
	var content = file.get_as_text()
	if typeof(JSON.parse(content).result) == TYPE_DICTIONARY:
		if not JSON.parse(content).result.has_all(["trials_won_not_switching","trials_won_switching","trials_lost_not_switching","trials_lost_switching"]):
			content = "{\"trials_won_not_switching\":0,\"trials_won_switching\":0,\"trials_lost_not_switching\":0,\"trials_lost_switching\":0}"
	if JSON.parse(content).error != OK:
		content = "{\"trials_won_not_switching\":0,\"trials_won_switching\":0,\"trials_lost_not_switching\":0,\"trials_lost_switching\":0}"
	var json = JSON.parse(content)
	print(json.result)
	return json.result

func make_results_file():
	var file = File.new()
	file.open("user://"+trial_file_name,file.WRITE)
	file.store_string("{\"trials_won_not_switching\":0,\"trials_won_switching\":0,\"trials_lost_not_switching\":0,\"trials_lost_switching\":0}")
	file.close()

func write_file_with_information(string):
	var file = File.new()
	file.open("user://"+trial_file_name,file.WRITE)
	file.store_string(string)
	file.close()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
