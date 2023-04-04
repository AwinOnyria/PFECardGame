# Card Database

#Cardinfo = [Type, Name, FullName, Effects, Legal, Cost, Effect1, Effect2, Effect3]
#Cardinfo = [0   , 1   , 2       , 3      , 4    , 5   , 6      , 7      , 8      ]

enum {Investors, StratRetreat}

const DATA = {
	Investors:
		["capitalist", "Investors", "Nouveaux investisseurs !", "Augmente les\nressources économiques\n\nPrend du temps", true, 1, 0, +1, -1],
	StratRetreat:
		["capitalist", "StratRetreat", "Retraite stratégique", "Augmente les\nressources économiques\n\nDiminue les parts\nde marché", false, 2, -1, +1, 0]
}
