# Card Database

#Cardinfo = [Type, Name, FullName, Effects, Legal, Cost, Effect1, Effect2, Effect3]
#Cardinfo = [0   , 1   , 2       , 3      , 4    , 5   , 6      , 7      , 8      ]

enum {
	INVESTORS, 
	RETREAT,
	ADS,
	TAX_FRAUD,
	LOWER_PRICES,
	FAKE_NEWS,
	SELL_STOCKS,
	HIRING_CAMPAIGN,
	TEAM_COHESION,
	CORPORATE_SPYING,
	LAYOFFS,
	OUTSOURCING
	}

const DATA = {
	INVESTORS:
		["capitalist", "INVESTORS", "Nouveaux investisseurs !", 
			"Augmente les\nressources économiques", true, 1, Vector2i(0, 0), 
			Vector2i(+10, 0), Vector2i(0, 0)],
	RETREAT:
		["capitalist", "RETREAT", "Retraite stratégique", 
			"Augmente les\nressources économiques\nDiminue les parts\nde marché", true, 1, 
			Vector2i(-10, 0), Vector2i(+10, 0), Vector2i(0, 0)],
	ADS:
		["capitalist", "ADS", "Campagne publicitaire", 
			"Augmente les\nparts de marché\nDiminue les ressources\néconomiques", true, 1, 
			Vector2i(+5, 0), Vector2i(-10, 0), Vector2i(0, 0)],
	TAX_FRAUD:
		["capitalist", "TAX_FRAUD", "Évasion fiscale", 
			"Augmente les\nressources économiques\nDiminue la cohésion", false, 2, 
			Vector2i(0, 0), Vector2i(+15, 0), Vector2i(-5, 0)],
	LOWER_PRICES:
		["capitalist", "LOWER_PRICES", "Baisse des prix",
			"Augmente les\nparts de marché\nDiminue les\nressources économiques", true, 2, 
			Vector2i(+10, 0), Vector2i(-15, 0), Vector2i(0, 0)],
	FAKE_NEWS:
		["capitalist", "FAKE_NEWS", "Campagne de Diffamation", 
			"Augmente les\nparts de marché\nDiminue les\nressources économiques\nDiminue la\ncohésion adverse", 
			false, 2, Vector2i(+10, 0), Vector2i(-10, 0), Vector2i(0, -10)],
	SELL_STOCKS:
		["capitalist", "SELL_STOCKS", "Vente d'actifs",
			"Diminue les\nparts de marché\nAugmente les\nressources économiques\nDiminue la\ncohésion",
			true, 2, Vector2i(-15, 0), Vector2i(+15, 0), Vector2i(-5, 0)],
	HIRING_CAMPAIGN:
		["capitalist", "HIRING_CAMPAIGN", "Campagne de recrutement",
		"Diminue les\nressources économiques\nAugmente la\ncohésion", true, 2,
			Vector2i(0, 0), Vector2i(-15, 0), Vector2i(+15, 0)],
	LAYOFFS:
		["capitalist", "LAYOFFS", "Licenciements", 
			"Augmente grandement les\nressources économiques\nDiminue significativement\nla cohésion",
			true, 2, Vector2i(0, 0), Vector2i(+20, 0), Vector2i(-15, 0)],
	OUTSOURCING:
		["capitalist", "OUTSOURCING", "Délocalisation",
			"Augmente les\nparts de marché\nAugmente les\nressources économiques\nDiminue la\ncohésion",
			true, 1, Vector2i(+5, 0), Vector2i(+15, 0), Vector2i(-10, 0)],
	CORPORATE_SPYING:
		["capitalist", "CORPORATE_SPYING", "Espionnage industriel",
			"Diminue les\nressources économiques\nPermet de voir\nles actions adverses\npendant 3 tours",
			false, 2, Vector2i(0, 0), Vector2i(-10, 0), Vector2i(0, 0)],
	TEAM_COHESION:
		["capitalist", "TEAM_COHESION", "Team building",
			"Augmente la\ncohésion",
			true, 1, Vector2i(0, 0), Vector2i(0, 0), Vector2i(+10, 0)],
}
