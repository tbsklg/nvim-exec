fmt:
	stylua lua/ --config-path=.stylua.toml

lint:
	lua_modules/bin/luacheck lua/ --globals vim

test:
	nvim --headless --noplugin -u tests/minimal.vim \
        -c "PlenaryBustedDirectory tests/exec {minimal_init = 'tests/minimal.vim'}"
