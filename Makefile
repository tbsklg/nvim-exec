fmt:
	stylua lua/ --config-path=.stylua.toml

lint:
	lua_modules/bin/luacheck lua/ --globals vim

test:
	nvim --headless --noplugin -u scripts/minimal.vim \
        -c "PlenaryBustedDirectory tests/exec {minimal_init = 'scripts/minimal.vim'}"
