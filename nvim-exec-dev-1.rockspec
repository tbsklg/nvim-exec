package = "nvim-exec"

version = "dev-1"

source = {
   url = "https://github.com/tbsklg/nvim-exec",
}

dependencies = {
}

description = {
   license = "MIT",
}

build = {
   type = "builtin",
   modules = {
      ["exec.view"] = "lua/exec/view.lua",
      ["exec.helpers"] = "lua/exec/helpers.lua",
      ["exec.init"] = "lua/exec/init.lua"
   },
   copy_directories = {
      "tests"
   }
}
