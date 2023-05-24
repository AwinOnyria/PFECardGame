enum {
	ECONOMICAL_CONFLICT,   #Capitalist conflicts
	POLITICAL_CONFLICT,
	INTERNAL_CONFLICT,
}

const ACTION_DATA = {
	ECONOMICAL_CONFLICT:
		[
			[Vector2i(-15, 0), Vector2i(0, -5), Vector2i(0, -5)],
			[Vector2i(-15, 0), Vector2i(0, -10), Vector2i(0, 0)],
			[Vector2i(-15, 0), Vector2i(0, 0), Vector2i(0, -10)],
			[Vector2i(+10, 0), Vector2i(0, +10), Vector2i(0, +10)],
			[Vector2i(+10, 0), Vector2i(0, +20), Vector2i(0, 0)],
			[Vector2i(+10, 0), Vector2i(0, 0), Vector2i(0, +20)],
			[Vector2i(+10, 0), Vector2i(-10, 0), Vector2i(-5, 0)],
			[Vector2i(+10, 0), Vector2i(-5, 0), Vector2i(-10, 0)],
			[Vector2i(+5, 0), Vector2i(-15, 0), Vector2i(0, 0)],
			[Vector2i(+5, 0), Vector2i(0, 0), Vector2i(-15, 0)],
			[Vector2i(0, 0), Vector2i(0, +15), Vector2i(0, 0)],
			[Vector2i(0, 0), Vector2i(0, +15), Vector2i(0, 0)],
			[Vector2i(0, 0), Vector2i(0, 0), Vector2i(0, +15)],
			[Vector2i(0, 0), Vector2i(0, 0), Vector2i(0, +15)],
		],
	POLITICAL_CONFLICT:
		[
			[Vector2i(0, 0), Vector2i(0, 0), Vector2i(0, 0)],
		],
	INTERNAL_CONFLICT:
		[
			[Vector2i(0, 0), Vector2i(0, 0), Vector2i(0, 0)],
		]
}
