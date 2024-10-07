extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	text = get_local_ip()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_local_ip() -> String:
	var ip_adress: String

	if OS.has_feature("windows"):
		if OS.has_environment("COMPUTERNAME"):
			ip_adress =  IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)
	elif OS.has_feature("x11"):
		if OS.has_environment("HOSTNAME"):
			ip_adress =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	elif OS.has_feature("OSX"):
		if OS.has_environment("HOSTNAME"):
			ip_adress =  IP.resolve_hostname(str(OS.get_environment("HOSTNAME")),1)
	
	return ip_adress
