extends Node2D

enum {
	ECONOMICAL_CONFLICT,   #Capitalist conflicts
	POLITICAL_CONFLICT,
	INTERNAL_CONFLICT,
}

var event_tag = ""
var conflict_type = ECONOMICAL_CONFLICT

const CardBase = preload("res://Cards/card_base.tscn")
#const PlayerHand = preload("res://Gameplay/Player_Hand.gd")
const GameOverScreen = preload("res://GUI/game_over_screen.tscn")
const ACTION_DATABASE = preload("res://Gameplay/actions_database.gd")
const CardSize = Vector2(250, 350)
var CardSelected
var DeckSize = 0
var Deck = []

@onready var CenterHandOval = Vector2(get_viewport().size) * Vector2(0.5, 1.25)
@onready var HorRad = get_viewport().size.x * 0.45
@onready var VerRad = get_viewport().size.y * 0.4
var angle = 0
var CardSpread = 0.25
var NumberCardsHand = -1
var CardNumb = 0
var debug_focus
var OvalAngleVector = Vector2()

var middle_bar = false

@onready var action_list = ACTION_DATABASE.ACTION_DATA[conflict_type]

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

var max_energy = 3
var energy = 3
var special_effects = {"energy": 0, "spying": 0, "covering": 0}
var discarded_cards = []

const MAX_CARDS_HAND = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Deck/Outline.scale *= CardSize/$Deck/Outline.texture.get_size()
	$Cards.size = Vector2(get_viewport_rect().size)
	
	$UIContainer/UserInterface/TopBars/RightBar.icon_name = "market_influence_icon"
	$UIContainer/UserInterface/TopBars/LeftBar.icon_name = "market_influence_icon"
	$UIContainer/UserInterface/BottomBars/RightBar.icon_name = "cohesion_icon"
	$UIContainer/UserInterface/BottomBars/LeftBar.icon_name = "cohesion_icon"
	$UIContainer/UserInterface/MiddleBars/RightBar.icon_name = "money_icon"
	$UIContainer/UserInterface/MiddleBars/LeftBar.icon_name = "money_icon"
	
	$UIContainer/UserInterface/BottomBars/RightBar.left_to_right = false
	$UIContainer/UserInterface/MiddleBars/RightBar.left_to_right = false
	$UIContainer/UserInterface/TopBars/RightBar.left_to_right = false
	$UIContainer/UserInterface/MiddleBars/LeftBar.setup()
	$UIContainer/UserInterface/BottomBars/LeftBar.setup()
	$UIContainer/UserInterface/TopBars/LeftBar.setup()
	$UIContainer/UserInterface/MiddleBars/RightBar.setup()
	$UIContainer/UserInterface/BottomBars/RightBar.setup()
	$UIContainer/UserInterface/TopBars/RightBar.setup()
	
	if middle_bar:
		$UIContainer/UserInterface/TopBars.visible = false
		$UIContainer/UserInterface/UIGap1.visible = false
	else:
		$UIContainer/UserInterface/MiddleBar.visible = false
		
	update_energy()
	auto_draw()


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func draw_card():
	if DeckSize > 0:
		var new_card = CardBase.instantiate()
		$SoundEffects/DrawingCard.play()
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
#		return(DeckSize)
	else:
		$Deck/DeckDraw.disabled = true
		shuffle_cards()


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


func update_energy():
	$Energy.text = "Énergie : " + str(energy) + "/" + str(max_energy)


func compute_action(effect_1, effect_2, effect_3):
	if effect_1:
			if middle_bar:
				$UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.value += effect_1.x
				if effect_1.x > 0:
					$UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.state = INCREASING
				else:
					$UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.state = DECREASING
			else:
				$UIContainer/UserInterface/TopBars/LeftBar.value += effect_1.x
				$UIContainer/UserInterface/TopBars/RightBar.value += effect_1.y
				if effect_1.x > 0:
					$UIContainer/UserInterface/TopBars/LeftBar.state = INCREASING
				elif effect_1.x < 0:
					$UIContainer/UserInterface/TopBars/LeftBar.state = DECREASING
				if effect_1.y > 0:
					$UIContainer/UserInterface/TopBars/RightBar.state = INCREASING
				elif effect_1.y < 0:
					$UIContainer/UserInterface/TopBars/RightBar.state = DECREASING
	if effect_2:
		$UIContainer/UserInterface/MiddleBars/LeftBar.value += effect_2.x
		$UIContainer/UserInterface/MiddleBars/RightBar.value += effect_2.y
		if effect_2.x > 0:
			$UIContainer/UserInterface/MiddleBars/LeftBar.state = INCREASING
		elif effect_2.x < 0:
			$UIContainer/UserInterface/MiddleBars/LeftBar.state = DECREASING
		if effect_2.y > 0:
			$UIContainer/UserInterface/MiddleBars/RightBar.state = INCREASING
		elif effect_2.y < 0:
			$UIContainer/UserInterface/MiddleBars/RightBar.state = DECREASING
	if effect_3:
		$UIContainer/UserInterface/BottomBars/LeftBar.value += effect_3.x
		$UIContainer/UserInterface/BottomBars/RightBar.value += effect_3.y
		if effect_3.x > 0:
			$UIContainer/UserInterface/BottomBars/LeftBar.state = INCREASING
		elif effect_3.x < 0:
			$UIContainer/UserInterface/BottomBars/LeftBar.state = DECREASING
		if effect_3.y > 0:
			$UIContainer/UserInterface/BottomBars/RightBar.state = INCREASING
		elif effect_3.y < 0:
			$UIContainer/UserInterface/BottomBars/RightBar.state = DECREASING


func play_card(no_card):
	var Card = $Cards.get_child(no_card)
	if Card.Cost <= energy:
		energy = energy - Card.Cost
		update_energy()
		discarded_cards.append(Card.CardName)
		compute_action(Card.Effect1, Card.Effect2, Card.Effect3)
		$Cards.remove_child(Card)
		Card.queue_free()
		$SoundEffects/PlayingCard.position = Vector2(get_global_mouse_position())
		$SoundEffects/PlayingCard.play() #ok c'est drole
		NumberCardsHand -= 1
		organise_hand()
		check_game_status(false)


func ennemy_action():
	var check_suicide = true
	while check_suicide:
		var action_selected_id = randi() % action_list.size()
		var action_selected = action_list[action_selected_id]
		compute_action(action_selected[0], action_selected[1], action_selected[2])
		check_suicide = check_game_status(check_suicide)
		if check_suicide:
			compute_action(-action_selected[0], -action_selected[1], -action_selected[2])


func auto_draw():
	$Blocker.visible = true
	while $Cards.get_child_count() < MAX_CARDS_HAND:
		draw_card()
		await get_tree().create_timer(.5).timeout
	$Blocker.visible = false


func discard_hand():
	if energy:
		energy -= 1
		update_energy()
		while $Cards.get_child_count():
			var card = $Cards.get_child(0)
			discarded_cards.append(card.CardName)
			card.queue_free()
			NumberCardsHand -= 1
			await get_tree().create_timer(.1).timeout
		auto_draw()

func end_turn():
	ennemy_action()
	check_game_status(false)
	energy = max_energy
	update_energy()
	auto_draw()


func shuffle_cards():
	$SoundEffects/ShufflingDeck.play()
	Deck = discarded_cards.duplicate()
	await get_tree().create_timer(.75).timeout
	DeckSize = Deck.size()
	if DeckSize:
		$Deck/DeckDraw.disabled = false
		$Deck/DeckDraw.visible = true
	discarded_cards = []

func check_game_status(checking):
	if middle_bar:
		if $UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.value <= 0:
			if checking:
				return(false)
			else:
				handle_player_lose()
		if  $UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.value >= $UIContainer/UserInterface/MiddleBar/MiddleContainer/MiddleBar.max_value:
			if checking:
				return(true)
			else:
				handle_player_win()
	else:
		if $UIContainer/UserInterface/TopBars/LeftBar.value <= 0:
			if checking:
				return(false)
			else:
				handle_player_lose()
		if $UIContainer/UserInterface/TopBars/RightBar.value <= 0:
			if checking:
				return(true)
			else:
				handle_player_win()
	if $UIContainer/UserInterface/BottomBars/LeftBar.value <= 0:
		if checking:
			return(false)
		else:
			handle_player_lose()
	if $UIContainer/UserInterface/BottomBars/RightBar.value <= 0:
		if checking:
			return(true)
		else:
			handle_player_win()
	if $UIContainer/UserInterface/MiddleBars/LeftBar.value <= 0:
		if checking:
				return(false)
		else:
			handle_player_lose()
	if $UIContainer/UserInterface/MiddleBars/RightBar.value <= 0:
		if checking:
			return(true)
		else:
			handle_player_win()
	

func handle_player_win():
	$Blocker.visible = true
	await get_tree().create_timer(1).timeout
	get_tree().paused = true
	var game_over = GameOverScreen.instantiate()
	add_child(game_over)
	game_over.set_title()


func handle_player_lose():
	$Blocker.visible = true
	await get_tree().create_timer(1).timeout
	get_tree().paused = true
	var game_over = GameOverScreen.instantiate()
	game_over.has_won = false
	add_child(game_over)
	game_over.set_title()

