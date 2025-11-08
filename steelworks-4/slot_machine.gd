extends Node  # Jeśli masz Node2D jako główny węzeł

@export var symbols : Array # Tablica z symbolami (np. lista nazw plików PNG)
@export var num_reels = 3 # Liczba bębnów
@export var reel_speed = 10 # Prędkość obracania bębnów
@export var stop_delay = 0.5 # Opóźnienie przed zatrzymaniem bębna

var reels = [] # Lista bębnów
var spinning = false # Czy bębny kręcą się?
var reel_positions = [] # Pozycje bębnów

# Funkcja inicjująca
func _ready():
	# Inicjalizuj bębny
	for i in range(num_reels):
		var reel = Sprite2D.new()
		reel.texture = load("res://Assets/Dice/"+symbols[randi() % symbols.size()]) # Wybór losowego symbolu na start
		reel.position = Vector2(100 * i, 100) # Przesuń bębny na ekranie
		add_child(reel)
		reels.append(reel)
		reel_positions.append(0)  # Początkowa pozycja bębna

	# Przycisk uruchamiający grę

# Funkcja uruchamiająca obrót bębnów
func _on_spin_pressed():
	if spinning:
		return
	spinning = true
	# Rozpocznij obrót bębnów
	for i in range(num_reels):
		reel_positions[i] = 0
		var reel = reels[i]
		reel.texture = load("res://Assets/Dice/"+symbols[randi() % symbols.size()])
		# Uruchom animację obrotu
		start_reel_spin(i)

# Funkcja do rozpoczęcia obrotu bębna
func start_reel_spin(reel_index):
	
	stop_reel_spin(reel_index)

# Funkcja do zatrzymania bębna
func stop_reel_spin(reel_index):
	var reel = reels[reel_index]
	
	reel.texture = load("res://Assets/Dice/"+symbols[randi() % symbols.size()])  # Zmiana na losowy symbol po zatrzymaniu
	if reel_index == num_reels - 1:
		spinning = false
		check_result()

# Funkcja do sprawdzenia wyniku
func check_result():
	var result = []
	for reel in reels:
		if reel.texture != null:
			# Jeśli tekstura jest przypisana, uzyskaj resource_path
			var texture_path = reel.texture.resource_path
			var texture_name = texture_path
			result.append(texture_name)
		else:
			# Jeśli brak tekstury, dodaj pusty wynik lub placeholder
			result.append("Brak tekstury")
	print("Wynik: " + str(result))


func _on_button_pressed() -> void:
	_on_spin_pressed()
