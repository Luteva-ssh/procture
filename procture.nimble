# Package

version       = "0.1.0"
author        = "Janni Adamski"
description   = "A simple tool to create a project structure (folders and files) from a given yaml structure."
license       = "MIT"
srcDir        = "src"
bin           = @["procture"]
binDir        = "bin"

# Dependencies

requires "nim >= 2.2.4"

# Tasks
task test, "Run tests":
  exec "nim c -r tests/test_all.nim"

task docs, "Generate documentation":
  exec "nim doc --project --index:on --git.url:https://github.com/Luteva-ssh/procture --git.commit:main src/procture.nim"

task release, "Build release version":
  exec "nim c -d:release --opt:size -o:bin/procture src/procture.nim"