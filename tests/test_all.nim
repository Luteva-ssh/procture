import std/[unittest, os]
import ../src/procture

suite "File Structure Generator Tests":
  
  test "parseIndentation":
    check parseIndentation("  hello") == 2
    check parseIndentation("    world") == 4
    check parseIndentation("no_indent") == 0
    check parseIndentation("") == 0
  
  test "parseLine":
    let (name1, isDir1, indent1) = parseLine("  folder:")
    check name1 == "folder"
    check isDir1 == true
    check indent1 == 2
    
    let (name2, isDir2, indent2) = parseLine("    - file.txt")
    check name2 == "file.txt"
    check isDir2 == false
    check indent2 == 4
    
    let (name3, isDir3, indent3) = parseLine("root_folder:")
    check name3 == "root_folder"
    check isDir3 == true
    check indent3 == 0

  test "file extension handling":
    # Test that files without extensions are handled correctly
    let (name1, isDir1, _) = parseLine("  - executable")
    check name1 == "executable"
    check isDir1 == false
    
    let (name2, isDir2, _) = parseLine("  - script.sh")
    check name2 == "script.sh"
    check isDir2 == false

suite "Integration Tests":
  
  setup:
    # Create a temporary directory for tests
    let testDir = "test_output"
    if dirExists(testDir):
      removeDir(testDir)
    createDir(testDir)
  
  teardown:
    # Clean up test directory
    let testDir = "test_output"
    if dirExists(testDir):
      removeDir(testDir)
  
  test "create simple structure":
    let testContent = """
simple_project:
  src:
    - main.nim
  - README.md
"""
    
    writeFile("test_input.yaml", testContent)
    
    # Here you would call your main function or structure creation logic
    # For now, we'll just test that the input file was created correctly
    check fileExists("test_input.yaml")
    check readFile("test_input.yaml") == testContent
    
    # Clean up
    removeFile("test_input.yaml")

when isMainModule:
  # Run the tests
  echo "Running File Structure Generator Tests..."