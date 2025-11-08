extends Node  # Jeśli masz Node2D jako główny węzeł

@export var symbols : Array # Tablica z symbolami (np. lista nazw plików PNG)
@export var num_reels = 5
@export var row_reels = 4 # Liczba bębnów
@export var reel_speed = 10 # Prędkość obracania bębnów
@export var stop_delay = 0.5 # Opóźnienie przed zatrzymaniem bębna
@export var tickets = 100

var bet = 0
var reels = [] # Lista bębnów
var spinning = false # Czy bębny kręcą się?
var reel_positions = [] # Pozycje bębnów
var btn5modulate

# Funkcja inicjująca
func _ready():
	# Inicjalizuj bębny
	btn5modulate = $btn5.modulate
	for j in range(row_reels):
		for i in range(num_reels):
			var reel = Sprite2D.new()
			reel.texture = load("res://Assets/Dice/"+symbols[randi() % symbols.size()]) # Wybór losowego symbolu na start
			reel.position = Vector2(100 * i, 100 * j) # Przesuń bębny na ekranie
			add_child(reel)
			reels.append(reel)
			reel_positions.append(0)  # Początkowa pozycja bębna

	# Przycisk uruchamiający grę
func _process(_delta):
	if Input.is_action_just_pressed("add5"):
		# Działanie po naciśnięciu spacji
		print("Spacja naciśnięta!")
		# Możesz tu dodać inne działania, np. zmienić kolor
# Funkcja uruchamiająca obrót bębnów
func _on_spin_pressed():
	if spinning:
		return
	spinning = true
	# Rozpocznij obrót bębnów
	for i in range(num_reels*row_reels):
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

func updateTicketBetValue(ticketsUsed):
	tickets = tickets - ticketsUsed
	bet = bet + ticketsUsed
	updateTicketBet()

func updateButtons():
	if(tickets>1):
		$btn1.disabled = false
	else:
		$btn1.disabled = true
		
	if(tickets>5):
		$btn5.disabled = false
	else:
		$btn5.disabled = true
		
	if(tickets - bet*2 > 0):
		$btn2.disabled = false
	else:
		$btn2.disabled = true
		
	if(tickets - bet*10 > 0):
		$btn10.disabled = false
	else:
		$btn10.disabled = true
		
	if(tickets - bet*25 > 0):
		$btn25.disabled = false
	else:
		$btn25.disabled = true

func updateTicketBet():
	updateTickets()
	updateBet()
	updateButtons()

func updateTickets():
	$AvailablePanel/AvailableTickets.text = str(tickets)
	
func updateBet():
	$BetPanel/Bet.text = str(bet)

func _on_btn_1_pressed() -> void:
	updateTicketBetValue(1) # Replace with function body.

func _on_btn_5_pressed() -> void:
	updateTicketBetValue(5)
	$btn5.modulate = Color(1, 0, 0, 0.5)
	$btn5/btn5timer.start()

func _on_btn_5_timer_timeout() -> void:
	$btn5.modulate = btn5modulate

func _on_btn_2_pressed() -> void:
	updateTicketBetValue(bet*2)

func _on_btn_10_pressed() -> void:
	updateTicketBetValue(bet*10)


func _on_btn_25_pressed() -> void:
	updateTicketBetValue(bet*25)
