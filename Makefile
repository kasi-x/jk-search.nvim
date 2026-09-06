.PHONY: test luacheck stylua check-stylua

test:
	busted .

luacheck:
	luacheck lua plugin spec

check-stylua:
	stylua lua plugin spec --color always --check

stylua:
	stylua lua plugin spec
