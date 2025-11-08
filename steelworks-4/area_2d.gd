extends RigidBody2D

func _ready():
	# Ustawienie trybu na kinetyczny
	# Zatrzymanie wpływu grawitacji na obiekt
	gravity_scale = 0  # Zatrzymanie grawitacji
	
	# Opcjonalnie: Zatrzymanie prędkości, aby nie poruszał się samodzielnie
	linear_velocity = Vector2.ZERO  # Zatrzymanie prędkości początkowej
