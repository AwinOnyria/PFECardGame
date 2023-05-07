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
	STILL,
	INCREASING,
	DECREASING
}

enum {
	InHand,
	InMouse,
	FocusInhand,
	MoveDrawnCardToHand,
	PlayingCard,
	ReorganiseHand
}

var max_energy = INF
var energy = INF
var special_effects = {"energy": 0, "spying": 0, "covering": 0}
var discarded_cards = []

const MAX_CARDS_HAND = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Deck/Outline.scale *= CardSize/$Deck/Outline.texture.get_size()
	$Cards.size = Vector2(get_viewport_rect().size)
	$UIContainer/UserInterface/BottomBars/RightBar.left_to_right = false
	$UIContainer/UserInterface/BottomBars/RightBar.setup()
	$UIContainer/UserInterface/MiddleBars/RightBar.left_to_right = false
	$UIContainer/UserInterface/MiddleBars/RightBar.setup()
	$UIContainer/UserInterface/TopBars/RightBar.left_to_right = false
	$UIContainer/UserInterface/TopBars/RightBar.setup()
	
	if middle_bar:
		$UIContainer/UserInterface/TopBars.visible = false
		$UIContainer/UserInterface/UIGap1.visible = false
	else:
		$UIContainer/UserInterface/MiddleBar.visible = false


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


func play_card(no_card):
	var Card = $Cards.get_child(no_card)
	if Card.Cost <= energy:
		energy = energy - Card.Cost
		discarded_cards.append(Card.CardName)
		if Card.Effect1:
			if middle_bar:
				$UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.value += Card.Effect1.x
				if Card.Effect1.x > 0:
					$UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.state = INCREASING
				else:
					$UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.state = DECREASING
			else:
				$UIContainer/UserInterface/TopBars/LeftBar.value += Card.Effect1.x
				$UIContainer/UserInterface/TopBars/RightBar.value += Card.Effect1.y
				if Card.Effect1.x > 0:
					$UIContainer/UserInterface/TopBars/LeftBar.state = INCREASING
				elif Card.Effect1.x < 0:
					$UIContainer/UserInterface/TopBars/LeftBar.state = DECREASING
				if Card.Effect1.y > 0:
					$UIContainer/UserInterface/TopBars/RightBar.state = INCREASING
				elif Card.Effect1.y < 0:
					$UIContainer/UserInterface/TopBars/RightBar.state = DECREASING
		if Card.Effect2:
			$UIContainer/UserInterface/MiddleBars/LeftBar.value += Card.Effect2.x
			$UIContainer/UserInterface/MiddleBars/RightBar.value += Card.Effect2.y
			if Card.Effect2.x > 0:
				$UIContainer/UserInterface/MiddleBars/LeftBar.state = INCREASING
			elif Card.Effect2.x < 0:
				$UIContainer/UserInterface/MiddleBars/LeftBar.state = DECREASING
			if Card.Effect2.y > 0:
				$UIContainer/UserInterface/MiddleBars/RightBar.state = INCREASING
			elif Card.Effect2.y < 0:
				$UIContainer/UserInterface/MiddleBars/RightBar.state = DECREASING
		if Card.Effect3:
			$UIContainer/UserInterface/BottomBars/LeftBar.value += Card.Effect3.x
			$UIContainer/UserInterface/BottomBars/RightBar.value += Card.Effect3.y
			if Card.Effect3.x > 0:
				$UIContainer/UserInterface/BottomBars/LeftBar.state = INCREASING
			elif Card.Effect3.x < 0:
				$UIContainer/UserInterface/BottomBars/LeftBar.state = DECREASING
			if Card.Effect3.y > 0:
				$UIContainer/UserInterface/BottomBars/RightBar.state = INCREASING
			elif Card.Effect3.y < 0:
				$UIContainer/UserInterface/BottomBars/RightBar.state = DECREASING
		
		$Cards.remove_child(Card)
		Card.queue_free()
		NumberCardsHand -= 1
		organise_hand()
		check_game_status()


func end_turn():
	#make the ennemy act
	check_game_status()
	energy = max_energy


func shuffle_cards():
	Deck = discarded_cards.duplicate()
	DeckSize = Deck.size()
	$Deck/DeckDraw.DeckSize = DeckSize
	if DeckSize:
		$Deck/DeckDraw.disabled = false
		$Deck/DeckDraw.visible = true
	discarded_cards = []

func check_game_status():
	if middle_bar:
		if $UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.value == 0:
			print("Game Lost")
		if  $UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.value >= $UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.max_value:
			print("Game Won")
	else:
		if $UIContainer/UserInterface/TopBars/LeftBar.value == 0:
			print("Game Lost")
		if $UIContainer/UserInterface/TopBars/RightBar.value == 0:
			print("Game Won")
	if $UIContainer/UserInterface/BottomBars/LeftBar.value == 0:
		print("Game Lost")
	if $UIContainer/UserInterface/BottomBars/RightBar.value == 0:
		print("Game Won")
	if $UIContainer/UserInterface/MiddleBars/LeftBar.value == 0:
		print("Game Lost")
	if $UIContainer/UserInterface/MiddleBars/RightBar.value == 0:
		print("Game Won")
	
