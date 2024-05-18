fmt:
	stylua lua/ tests/ --config-path=.stylua.toml

lint:
	luacheck lua/ tests/ --globals vim

test:
	nvim --headless --noplugin -u scripts/minimal.vim \
        -c "PlenaryBustedDirectory tests/exec {minimal_init = 'scripts/minimal.vim'}"
