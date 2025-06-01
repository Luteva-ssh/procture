# File Structure Generator

A Nim tool that creates file and folder structures from YAML-like configuration files.

## Features

- 🏗️ Create complex directory structures from simple text files
- 📁 Support for nested folders and files
- 🔍 Dry-run mode to preview changes
- 🎯 Customizable output directory
- 📝 YAML-like syntax that's easy to read and write
- ⚡ Fast and lightweight

## Installation

### From Source

```bash
git clone <repository-url>
cd file-structure-generator
nim c -d:release src/structgen.nim
```

### Using Nimble

```bash
nimble install
```

## Usage

### Basic Usage

```bash
structgen my_structure.yaml
```

### Advanced Usage

```bash
# Create structure in specific directory
structgen -o /path/to/output my_structure.yaml

# Dry run to see what would be created
structgen --dry-run my_structure.yaml

# Verbose output
structgen --verbose my_structure.yaml
```

### Command Line Options

- `-h, --help`: Show help message
- `-o, --output DIR`: Specify output directory (default: current directory)
- `-d, --dry-run`: Preview what would be created without actually creating
- `-v, --verbose`: Enable verbose output

## File Format

The tool uses a YAML-like syntax:

- **Directories**: End with a colon `:`
- **Files**: Start with a dash and space `- `
- **Indentation**: Use 2 spaces for each level (consistent indentation required)

### Example Structure File

```yaml
my_project:
  src:
    - main.nim
    - config.nim
    utils:
      - helper.nim
      - parser.nim
  bin:
    - app_executable
  tests:
    - test_main.nim
    - test_utils.nim
  docs:
    assets:
      - logo.png
    - README.md
  empty_folder:
  - LICENSE
  - .gitignore
```

This creates:
```
my_project/
├── src/
│   ├── main.nim
│   ├── config.nim
│   └── utils/
│       ├── helper.nim
│       └── parser.nim
├── bin/
│   └── app_executable
├── tests/
│   ├── test_main.nim
│   └── test_utils.nim
├── docs/
│   ├── assets/
│   │   └── logo.png
│   └── README.md
├── empty_folder/
├── LICENSE
└── .gitignore
```

## Examples

### Simple Web Project
```yaml
my_website:
  public:
    css:
      - styles.css
    js:
      - main.js
    - index.html
  src:
    - server.nim
  - README.md
```

### Nim Library Project
```yaml
my_lib:
  src:
    my_lib:
      - core.nim
      - utils.nim
    - my_lib.nim
  tests:
    - test_core.nim
    - test_utils.nim
  examples:
    - basic_usage.nim
  docs:
    - api.md
  - README.md
  - my_lib.nimble
  - .gitignore
```

### Empty Directories

To create empty directories, simply specify the directory name with a colon and no children:

```yaml
project:
  empty_dir:
  another_empty:
  - some_file.txt
```

## Error Handling

The tool provides clear error messages for common issues:

- **File not found**: When the input file doesn't exist
- **Parse errors**: When the YAML-like syntax is invalid
- **Permission errors**: When unable to create files/directories
- **Invalid paths**: When specified paths are invalid

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## Development

### Building

```bash
nim c src/structgen.nim
```

### Running Tests

```bash
nim c -r tests/test_all.nim
```

### Creating Release

```bash
nim c -d:release --opt:size src/structgen.nim
```

## License

MIT License - see LICENSE file for details.

