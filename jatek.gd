extends Node2D

const BLOKK_MERET := Vector2(70, 24)
const TAVOLSAG := 8.0

func _ready():
	blokkok_letrehozasa()

func blokkok_letrehozasa():
	var oszlopok := 10
	var sorok := 5
	var teljes_szelesseg := oszlopok * BLOKK_MERET.x + (oszlopok - 1) * TAVOLSAG
	var kezdo_x := (960.0 - teljes_szelesseg) / 2.0 + BLOKK_MERET.x / 2.0

	for sor in range(sorok):
		for oszlop in range(oszlopok):
			var blokk := StaticBody2D.new()
			blokk.name = "Blokk_%d_%d" % [sor + 1, oszlop + 1]
			blokk.add_to_group("blokkok")

			var utkozes := CollisionShape2D.new()
			var teglalap := RectangleShape2D.new()
			teglalap.size = BLOKK_MERET
			utkozes.shape = teglalap
			blokk.add_child(utkozes)

			var kep := Polygon2D.new()
			kep.polygon = PackedVector2Array([
				Vector2(-35, -12),
				Vector2(35, -12),
				Vector2(35, 12),
				Vector2(-35, 12)
			])
			kep.color = Color.MEDIUM_VIOLET_RED
			blokk.add_child(kep)

			blokk.position = Vector2(
				kezdo_x + oszlop * (BLOKK_MERET.x + TAVOLSAG),
				80 + sor * (BLOKK_MERET.y + TAVOLSAG)
			)
			add_child(blokk)
