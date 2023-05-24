extends MarginContainer

@onready var CardDatabase = preload("res://Cards/CardDatabase.gd")
@onready var CardDatabaseTemp = CardDatabase.new()
var CardName = "INVESTORS"
@onready var CardInfo = CardDatabaseTemp.DATA[CardDatabaseTemp.get(CardName)]
@onready var CardImg = str("res://Cards/Card Images/" + CardName + ".png")
var CardSize = size
var OrigScale = scale
var CardPos = Vector2()

var Cost = int()
var Effect1 = Vector2i()
var Effect2 = Vector2i()
var Effect3 = Vector2i()

var is_special = false

# Called when the node enters the scene tree for the first time.
func _ready():
	CardSize = size
	$Glow.visible = is_special
	$Border.scale *= CardSize/$Border.texture.get_size()
	$Card.texture = load(CardImg)
	$Card.scale *= CardSize/$Card.texture.get_size()
	$Glow.scale *= CardSize/$Glow/GlowSprite.texture.get_size() * Vector2(15, 1)
	$Card.scale.y *= .6
	$Card.scale.x *= .85
	$Card.position.x += CardSize.x * .075
	$Outline.scale *= CardSize/$Outline.texture.get_size()
	$Illegal.scale *= CardSize/$Illegal.texture.get_size()
	$CardBack.scale *= CardSize/$CardBack.texture.get_size()
	$InPlayIndicator.scale *= CardSize/$Card.texture.get_size()*Vector2(.8, .8)
	$InPlayIndicator.position += CardSize*.1
	$InPlayIndicator.visible = false
	var FullName = CardInfo[2]
	var Effects = CardInfo[3]
	Cost = CardInfo[5]
	if CardInfo[4]:
		$Illegal.visible = false
	$Bars/TopBar/Cost/CenterContainer/Cost.text = str(Cost)
	$Bars/TopBar/Name/CenterContainer/Name.text = FullName
	$Bars/CardEffects/Effects/CenterContainer/Effects.text = Effects
	Effect1 = CardInfo[6]
	Effect2 = CardInfo[7]
	Effect3 = CardInfo[8]


enum {
	InHand,
	InMouse,
	FocusInHand,
	MoveDrawnCardToHand,
	PlayingCard,
	ReorganiseHand
}

var state = InHand
const DRAWTIME = .75
const ORGANISETIME = .5
const ZOOMINGTIME = .2
const INMOUSETIME = .1
var ZoomInSize = 1.25
var ReorganiseNeighbours = true
var NumberCardsHand = 0
var CardNumb = 0

var t = 0
var setup = true
var startscale = Vector2()
var startpos = Vector2()
var targetpos = Vector2()
var startrot = 0
var targetrot = 0
var oldrot = 0

var CardSelect = true
var CanPlay = false

func _physics_process(delta):
	match state:
		InHand:
			pass
		InMouse:
			if setup:
				Setup()
			if t <= 1:
				position = startpos.lerp(get_global_mouse_position() - CardSize / 2, t)
				rotation = startrot * (1 - t) + 0 * t
				scale = startscale * (1-t) + OrigScale * t
				t += delta/float(INMOUSETIME)
			else:
				position = get_global_mouse_position() - CardSize / 2
				rotation = 0
			if get_global_mouse_position().y <= get_viewport().size.y * .5 and $"../..".energy >= Cost:
				if not CanPlay:
					CanPlay = true
					$InPlayIndicator.visible = true
			else:
				if CanPlay:
					CanPlay = false
					$InPlayIndicator.visible = false
		FocusInHand:
			if setup:
				Setup()
			if t <= 1:
				position = startpos.lerp(targetpos, t)
				rotation = startrot * (1 - t) + 0 * t
				scale = startscale * (1 - t) + OrigScale * t * ZoomInSize
				t += delta/float(ZOOMINGTIME)
			else:
				position = targetpos
				rotation = 0
				scale = OrigScale * ZoomInSize
		MoveDrawnCardToHand:
			if setup:
				Setup()
			if t <= 1:
				position = startpos.lerp(targetpos, t)
				rotation = startrot * (1 - t) + targetrot * t
				scale.x = abs(1 - 2 * t) * OrigScale.x
				t += delta/float(DRAWTIME)
				if $CardBack.visible:
					if t >= 0.5:
						$CardBack.visible = false
			else:
				position = targetpos
				rotation = targetrot
				state = InHand
				t = 0
		PlayingCard:
			pass
		ReorganiseHand:
			if setup:
				Setup()
			if t <= 1:
				position = startpos.lerp(targetpos, t)
				rotation = startrot * (1 - t) + targetrot * t
				scale = startscale * (1 - t) + OrigScale * t
				t += delta/float(ORGANISETIME)
			else:
				position = targetpos
				rotation = targetrot
				scale = OrigScale
				state = InHand
				t = 0


func _input(event):
	match state:
		FocusInHand, InMouse:
			if event.is_action_pressed("leftclick"):
				state = InMouse
				setup = true
				CardSelect = false
			if event.is_action_released("leftclick"):
				if CanPlay:
					$"../..".play_card(CardNumb)
				targetpos = CardPos
				setup = true
				state = ReorganiseHand
				CardSelect = true
				CanPlay = false
				$InPlayIndicator.restart()
				$InPlayIndicator.visible = false
				z_index = 0


func Setup():
	startpos = position
	startrot = rotation
	startscale = scale
	t = 0
	setup = false


func _on_mouse_entered():
	match state:
		InHand, ReorganiseHand:
			z_index = 1
			setup = true
			oldrot = targetrot
			targetpos = CardPos
			targetpos.y = get_viewport_rect().size.y - CardSize.y * ZoomInSize
			state = FocusInHand



func _on_mouse_exited():
	match state:
		FocusInHand:
			z_index = 0
			setup = true
			targetpos = CardPos
			targetrot = oldrot
			state = ReorganiseHand
