# Card Database


#Cardinfo = [0   , 1   , 2       , 3      , 4    , 5   , 6      , 7      , 8      ]

enum {
	ADS,
	LOWER_PRICES,
	FAKE_NEWS,
	OUTSOURCING,
	INVESTORS, 
	LAYOFFS,
	SUBCONTRACT,
	CRUNCH,
	UNPAID_HOURS,
	EXPAND,
	TEAM_COHESION,
	HIRING_CAMPAIGN,
	RETREAT,
	TAX_FRAUD,
	SELL_STOCKS,
	CORPORATE_SPYING,
	}

const DATA = {
	ADS:
		["capitalist", "ADS", "Campagne publicitaire", 
			"Augmente les\nparts de marché\nDiminue les ressources\néconomiques", true, 1, 
			Vector2i(0, -5), Vector2i(-10, 0), Vector2i(0, 0)],
	LOWER_PRICES:
		["capitalist", "LOWER_PRICES", "Baisse des prix",
			"Augmente les\nparts de marché\nDiminue les\nressources économiques", true, 1, 
			Vector2i(0, -10), Vector2i(-15, 0), Vector2i(0, 0)],
	FAKE_NEWS:
		["capitalist", "FAKE_NEWS", "Campagne de Diffamation", 
			"Augmente les\nparts de marché\nDiminue les\nressources économiques", 
			false, 1, Vector2i(0, -10), Vector2i(-10, 0), Vector2i(0, 0)],
	OUTSOURCING:
		["capitalist", "OUTSOURCING", "Délocalisation",
			"Augmente les\nparts de marché\nAugmente les\nressources économiques\nDiminue la\ncohésion",
			true, 2, Vector2i(0, -15), Vector2i(+15, 0), Vector2i(-20, 0)],
	INVESTORS:
		["capitalist", "INVESTORS", "Nouveaux investisseurs !", "Augmente les\nressources économiques",
			true, 1, Vector2i(0, 0), Vector2i(+10, 0), Vector2i(0, 0)],
	RETREAT:
		["capitalist", "RETREAT", "Retraite stratégique", 
			"Augmente les\nressources économiques\nDiminue les parts\nde marché", true, 1, 
			Vector2i(0, +5), Vector2i(+10, 0), Vector2i(0, 0)],
	TAX_FRAUD:
		["capitalist", "TAX_FRAUD", "Évasion fiscale", 
			"Augmente les\nressources économiques\nDiminue la cohésion", false, 2, 
			Vector2i(0, 0), Vector2i(+15, 0), Vector2i(-5, 0)],
	SELL_STOCKS:
		["capitalist", "SELL_STOCKS", "Vente d'actifs",
			"Diminue les\nparts de marché\nAugmente les\nressources économiques\nDiminue la\ncohésion",
			true, 2, Vector2i(-1, 0), Vector2i(+15, 0), Vector2i(-5, 0)],
	HIRING_CAMPAIGN:
		["capitalist", "HIRING_CAMPAIGN", "Campagne de recrutement",
		"Diminue les\nressources économiques\nAugmente la\ncohésion", true, 1,
			Vector2i(0, 0), Vector2i(-15, 0), Vector2i(+25, 0)],
	LAYOFFS:
		["capitalist", "LAYOFFS", "Licenciements", 
			"Augmente grandement les\nressources économiques\nDiminue significativement\nla cohésion",
			true, 1, Vector2i(0, 0), Vector2i(+25, 0), Vector2i(-15, 0)],
	CORPORATE_SPYING:
		["capitalist", "CORPORATE_SPYING", "Espionnage industriel",
			"Diminue les\nressources économiques\nPermet de voir\nles actions adverses\npendant 3 tours",
			false, 2, Vector2i(0, 0), Vector2i(-10, 0), Vector2i(0, 0)],
	TEAM_COHESION:
		["capitalist", "TEAM_COHESION", "Team building",
			"Augmente la\ncohésion",
			true, 1, Vector2i(0, 0), Vector2i(0, 0), Vector2i(+10, 0)],
	SUBCONTRACT:
		["capitalist", "SUBCONTRACT", "Soustraitance",
			"Prend des parts\n de marché\n\nDiminue la cohésion",
			true, 1, Vector2i(0, -5), Vector2i(0, 0), Vector2i(-10, 0)],
	CRUNCH:
		["capitalist", "CRUNCH", "Travaillez plus !",
			"Prend des parts\n de marché\n\nDiminue la cohésion",
			true, 1, Vector2i(0, -10), Vector2i(0, 0), Vector2i(-15, 0)],
	UNPAID_HOURS:
		["capitalist", "UNPAID_HOURS", "Travail non payé",
			"Prend des parts\n de marché\n\nDiminue la cohésion",
			false, 1, Vector2i(0, -10), Vector2i(0, 0), Vector2i(-10, 0)],
	EXPAND:
		["capitalist", "EXPAND", "Expansion",
			"Prend des parts\n de marché\n\nDiminue les ressources\n\nAugmente la\ncohésion",
			true, 2, Vector2i(0, -15), Vector2i(-20, 0), Vector2i(+15, 0)],
}
