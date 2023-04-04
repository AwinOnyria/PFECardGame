extends Node2D


const CardBase = preload("res://Cards/card_base.tscn")
const PlayerHand = preload("res://Gameplay/Player_Hand.gd")
const CardSize = Vector2(250, 350)
var CardSelected
@onready var DeckSize = PlayerHand.Deck.size()
@onready var Deck = PlayerHand.Deck.duplicate()

@onready var CenterHandOval = Vector2(get_viewport().size) * Vector2(0.5, 1.25)
@onready var HorRad = get_viewport().size.x * 0.45
@onready var VerRad = get_viewport().size.y * 0.4
var angle = 0
var CardSpread = 0.25
var NumberCardsHand = -1
var CardNumb = 0
var debug_focus
var OvalAngleVector = Vector2()

var middle_bar = true

enum {
	InHand,
	InMouse,
	FocusInhand,
	MoveDrawnCardToHand,
	PlayingCard,
	ReorganiseHand
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Deck/Outline.scale *= CardSize/$Deck/Outline.texture.get_size()
	$Cards.size = Vector2(get_viewport_rect().size)


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func DrawCard():
	var new_card = CardBase.instantiate()
	CardSelected = randi() % DeckSize
	new_card.CardName = Deck[CardSelected]
	new_card.position = $Deck.position - CardSize / 4
	new_card.scale *= CardSize/new_card.size
	Deck.erase(Deck[CardSelected])
	new_card.state = MoveDrawnCardToHand	
	
	$Cards.add_child(new_card)
	angle += 0.25
	DeckSize -= 1
	NumberCardsHand += 1
	organise_hand()
	return(DeckSize)


func organise_hand():
	CardNumb = 0
	for Card in $Cards.get_children():
		angle = PI/2 + CardSpread*(float(NumberCardsHand) / 2 - CardNumb)
		OvalAngleVector = Vector2(HorRad * cos(angle), -VerRad * sin(angle))
		Card.targetpos = CenterHandOval + OvalAngleVector - Card.size / 2
		Card.CardPos = Card.targetpos
		Card.startrot = Card.rotation
		Card.targetrot = (deg_to_rad(90) - angle) / 4
		Card.CardNumb = CardNumb
		if Card.state == InHand:
			Card.setup = true
			Card.state = ReorganiseHand
		elif Card.state == MoveDrawnCardToHand:
			Card.startpos = Card.targetpos - ((Card.targetpos - Card.position) / (1 - Card.t))
		CardNumb += 1


func delete_card(no_card):
	print(no_card)
	var Card = $Cards.get_child(no_card)
	$Cards.remove_child(Card)
	Card.queue_free()
	NumberCardsHand -= 1
	organise_hand()
