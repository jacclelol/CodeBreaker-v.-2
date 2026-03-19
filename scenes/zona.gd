extends Area2D

# Zde si v Inspectoru přiřadíš tvé dva Marker2D uzly
@export var blizko: Marker2D
@export var daleko: Marker2D

# Nastavení velikostí
@export var max_velikost: Vector2 = Vector2(1.0, 1.0)
@export var min_velikost: Vector2 = Vector2(0.4, 0.4)

var hrac = null

func _process(_delta):
	# Pokud je hráč v zóně a máme nastavené body, počítáme velikost
	if hrac and blizko and daleko:
		var start = blizko.global_position
		var konec = daleko.global_position
		
		# Matematika pro výpočet pozice mezi dvěma body (funguje pro jakýkoliv směr)
		var vektor_chodby = konec - start
		var vektor_hrace = hrac.global_position - start
		
		var delka_chodby = vektor_chodby.length()
		var smer_chodby = vektor_chodby.normalized()
		
		# Zjistíme, jak daleko (0.0 až 1.0) je hráč podél naší pomyslné čáry
		var vzdalenost_na_primce = vektor_hrace.dot(smer_chodby)
		var procento = vzdalenost_na_primce / delka_chodby
		
		# Ořízneme hodnotu, aby nebyla menší než 0 nebo větší než 1
		procento = clamp(procento, 0.0, 1.0)
		
		# Změníme velikost hráče (lerp plynule přejde z jedné hodnoty do druhé)
		hrac.scale = max_velikost.lerp(min_velikost, procento)


# --- SIGNÁLY ---
# Nezapomeň tyto dvě funkce propojit přes záložku Node -> Signals vpravo!

func _on_body_entered(body):
	# Předpokládáme, že tvůj hráč se jmenuje "Player". 
	# Můžeš to změnit podle sebe, nebo použít skupiny (body.is_in_group("hrac"))
	if body.name == "Player":
		hrac = body
	print("Do zóny vošiel objekt: ", body.name) # Vypíše všetko, čo do zóny vstúpi

func _on_body_exited(body):
	if body == hrac:
		hrac = null
		# Zde můžeš volitelně vrátit velikost zpět na normál, pokud zónu opustí
		# body.scale = max_velikost
