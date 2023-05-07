# Conflict Database here


enum {
	ECONOMICAL_CONFLICT,   #Capitalist conflicts
	POLITICAL_CONFLICT,
	INTERNAL_CONFLICT,
}


# conflict_info = [string, string  , bool          , [str, str], [str, str], [str, str]]
# conflict_info = [name  , fullname, has_middle_bar, bar_name_1, bar_name_2, bar_name_3]
# conflict_info = [0     , 1       , 2             , 3         , 4         , 5         ]

# NAB means Not A Bar, it will disable the display of said bar

const CONFLICT_DATA = {
	ECONOMICAL_CONFLICT:
		["ECONOMICAL_CONFLICT", "Conflit Économique", true, ["Parts de marché", "Parts de marché"],
			["Ressources économiques", "Ressources économiques"], ["Temps", "NAB"]],
	POLITICAL_CONFLICT:
		["POLITICAL_CONFLICT", "Conflit Politique", true, ["Soutien", "Soutien"],
			["Ressources économiques", "Ressources économiques"], ["Temps", "NAB"]],
	INTERNAL_CONFLICT:
		["INTERNAL_CONFLICT", "Conflit Interne", false, ["Pertes maximales", "Caisses de grève"],
			["Soutien des cadres", "Force"], ["Ressources économiques", "Radicalité"]],
}


#color_info = [ [fill_color, border_color, change_color, background_color],  -> bar n°1
#				[fill_color, border_color, change_color, background_color],  -> bar n°2
#				...

const COLOR_DATA = {
	ECONOMICAL_CONFLICT:
		[
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)],
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)],
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)]
		],
	POLITICAL_CONFLICT:
		[
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)],
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)],
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)]
		],
	INTERNAL_CONFLICT:
		[
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)],
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)],
			[Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1), Color(1, 1, 1, 1)]
		],
}


const CONFLICT_ACTIONS = {
	ECONOMICAL_CONFLICT:
		[],
	POLITICAL_CONFLICT:
		[],
	INTERNAL_CONFLICT:
		[],
}
