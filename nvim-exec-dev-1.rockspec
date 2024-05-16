package = "nvim-exec"
version = "dev-1"
source = {
   url = "*** please add URL for source tarball, zip or repository here ***"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
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
