import std/[os, strutils, sequtils, parseopt]

type
  StructNode = ref object
    name: string
    isDir: bool
    children: seq[StructNode]
    parent: StructNode

proc newStructNode(name: string, isDir: bool, parent: StructNode = nil): StructNode =
  result = StructNode(name: name, isDir: isDir, parent: parent, children: @[])

proc parseIndentation*(line: string): int =
  ## Count leading spaces for indentation level
  result = 0
  for c in line:
    if c == ' ':
      inc result
    else:
      break

proc parseLine*(line: string): tuple[name: string, isDir: bool, indent: int] =
  ## Parse a single line and extract name, type, and indentation
  let indent = parseIndentation(line)
  let trimmed = line.strip()
  
  if trimmed.endsWith(":"):
    # Directory
    result = (trimmed[0..^2], true, indent)
  elif trimmed.startsWith("- "):
    # File
    result = (trimmed[2..^1], false, indent)
  else:
    # Assume it's a directory without colon (for root level items)
    result = (trimmed, true, indent)

proc buildStructure(content: string): StructNode =
  ## Build the file/folder structure tree from YAML-like content
  let lines = content.splitLines().filterIt(it.strip().len > 0)
  if lines.len == 0:
    return nil
    
  var nodeStack: seq[StructNode] = @[]
  var root: StructNode = nil
  
  for line in lines:
    let (name, isDir, indent) = parseLine(line)
    
    # Find the correct parent based on indentation
    while nodeStack.len > 0 and nodeStack[^1].parent != nil:
      let expectedIndent = parseIndentation(nodeStack[^1].name) + 2
      if indent <= expectedIndent:
        discard nodeStack.pop()
      else:
        break
    
    let parent = if nodeStack.len > 0: nodeStack[^1] else: nil
    let node = newStructNode(name, isDir, parent)
    
    if parent != nil:
      parent.children.add(node)
    else:
      root = node
    
    if isDir:
      nodeStack.add(node)
  
  return root

proc createStructure(node: StructNode, basePath: string = "") =
  ## Recursively create the file/folder structure on disk
  if node == nil:
    return
    
  let fullPath = if basePath.len > 0: basePath / node.name else: node.name
  
  if node.isDir:
    echo "Creating directory: ", fullPath
    createDir(fullPath)
    
    # Create children
    for child in node.children:
      createStructure(child, fullPath)
  else:
    echo "Creating file: ", fullPath
    # Create parent directories if they don't exist
    let parentDir = fullPath.parentDir()
    if parentDir.len > 0 and not dirExists(parentDir):
      createDir(parentDir)
    
    # Create empty file
    writeFile(fullPath, "")

proc showHelp() =
  echo """
File Structure Generator v1.0

Usage:
  structgen [options] <input_file>
  structgen --help

Options:
  -h, --help          Show this help message
  -o, --output DIR    Output directory (default: current directory)
  -d, --dry-run       Show what would be created without actually creating
  -v, --verbose       Verbose output

Input file format:
  Uses YAML-like syntax where:
  - Directories end with ':'
  - Files start with '- '
  - Indentation defines hierarchy (2 spaces recommended)

Example:
  my_project:
    src:
      - main.nim
      - utils:
        - helper.nim
    bin:
      - executable
    - README.md
"""

proc main() =
  var 
    inputFile = ""
    outputDir = getCurrentDir()
    dryRun = false
    verbose = false
  
  # Parse command line arguments
  var p = initOptParser()
  while true:
    p.next()
    case p.kind
    of cmdEnd: break
    of cmdShortOption, cmdLongOption:
      case p.key
      of "h", "help":
        showHelp()
        return
      of "o", "output":
        outputDir = p.val
      of "d", "dry-run":
        dryRun = true
      of "v", "verbose":
        verbose = true
      else:
        echo "Unknown option: ", p.key
        quit(1)
    of cmdArgument:
      if inputFile.len == 0:
        inputFile = p.key
      else:
        echo "Multiple input files not supported"
        quit(1)
  
  if inputFile.len == 0:
    echo "Error: No input file specified"
    showHelp()
    quit(1)
  
  if not fileExists(inputFile):
    echo "Error: Input file '", inputFile, "' not found"
    quit(1)
  
  try:
    let content = readFile(inputFile)
    let structure = buildStructure(content)
    
    if structure == nil:
      echo "Error: Could not parse structure from input file"
      quit(1)
    
    # Change to output directory
    let originalDir = getCurrentDir()
    if outputDir != originalDir:
      if not dirExists(outputDir):
        createDir(outputDir)
      setCurrentDir(outputDir)
    
    if dryRun:
      echo "Dry run - would create the following structure:"
      # You could implement a preview function here
    else:
      echo "Creating structure in: ", outputDir
      createStructure(structure)
      echo "Structure created successfully!"
    
    # Restore original directory
    setCurrentDir(originalDir)
    
  except IOError as e:
    echo "Error reading file: ", e.msg
    quit(1)
  except OSError as e:
    echo "Error creating structure: ", e.msg
    quit(1)

when isMainModule:
  main()