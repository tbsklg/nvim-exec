package = "nvim-exec"
version = "v0.1.0"
source = {
   url = "https://github.com/tbsklg/nvim-exec",
}
description = {
   license = "MIT",
}
build = {
   type = "builtin",
   modules = {
      ["exec.helpers"] = "lua/exec/helpers.lua",
      ["exec.init"] = "lua/exec/init.lua"
   },
   copy_directories = {
      "tests"
   }
}
