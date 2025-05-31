# File Structure Generator - Usage Guide

## Quick Start

1. Create a structure file (e.g., `my_project.yaml`)
2. Run: `structgen my_project.yaml`
3. Your file structure is created!

## Syntax Reference

### Basic Syntax Rules

- **Indentation**: Use exactly 2 spaces for each level
- **Directories**: End with a colon `:`
- **Files**: Start with `- ` (dash followed by space)
- **Empty lines**: Ignored
- **Comments**: Not supported (yet)

### Directory Declaration

```yaml
folder_name:
```

Creates an empty directory named `folder_name`.

### File Declaration

```yaml
- filename.ext
```

Creates an empty file named `filename.ext`.

### Nested Structure

```yaml
parent_folder:
  child_folder:
    - file_in_child.txt
  - file_in_parent.txt
```

Creates:
```
parent_folder/
├── child_folder/
│   └── file_in_child.txt
└── file_in_parent.txt
```

## Advanced Examples

### Mixed Structure

```yaml
my_app:
  src:
    core:
      - engine.nim
      - types.nim
    ui:
      - widgets.nim
    - main.nim
  assets:
    images:
    sounds:
  config:
    - settings.json
    - database.yaml
  - README.md
  - .gitignore
```

### Files Without Extensions

Perfect for executables and scripts:

```yaml
project:
  bin:
    - myapp          # executable
    - install        # script
  scripts:
    - build          # build script
    - deploy         # deployment script
```

### Deep Nesting

```yaml
deep_project:
  level1:
    level2:
      level3:
        level4:
          - deep_file.txt
```

## Command Line Usage

### Basic Commands

```bash
# Create structure in current directory
structgen structure.yaml

# Create in specific directory
structgen -o /path/to/output structure.yaml

# Preview without creating (dry run)
structgen --dry-run structure.yaml

# Verbose output
structgen --verbose structure.yaml
```

### Options Reference

| Option | Short | Description |
|--------|-------|-------------|
| `--help` | `-h` | Show help message |
| `--output DIR` | `-o DIR` | Output directory |
| `--dry-run` | `-d` | Preview mode |
| `--verbose` | `-v` | Verbose output |

## Common Use Cases

### 1. New Project Setup

```yaml
my_new_project:
  src:
    - main.nim
  tests:
    - test_main.nim
  docs:
    - README.md
  - .gitignore
  - project.nimble
```

### 2. Directory Organization

```yaml
organize_files:
  documents:
    work:
      - todo.txt
    personal:
      - notes.txt
  downloads:
    software:
    documents:
    media:
```

### 3. Template Creation

```yaml
web_template:
  public:
    css:
      - style.css
    js:
      - main.js
    images:
    - index.html
  src:
    - server.nim
    - routes.nim
  - README.md
```

## Best Practices

### 1. Consistent Indentation

✅ **Good:**
```yaml
project:
  src:
    - main.nim
  tests:
    - test.nim
```

❌ **Bad:**
```yaml
project:
   src:
     - main.nim
  tests:
      - test.nim
```

### 2. Logical Grouping

Group related files and folders together:

```yaml
web_app:
  frontend:
    - index.html
    - style.css
    - script.js
  backend:
    - server.nim
    - api.nim
  shared:
    - types.nim
```

### 3. Use Descriptive Names

```yaml
# Clear and descriptive
user_management_system:
  models:
    - user.nim
    - permissions.nim
  controllers:
    - auth_controller.nim
```

### 4. Consider Empty Directories

Sometimes you need placeholder directories:

```yaml
project:
  data:
    input:
    output:
    cache:
  logs:
  temp:
```

## Troubleshooting

### Common Errors

#### 1. Indentation Error
```
Error: Inconsistent indentation at line 5
```
**Solution**: Use exactly 2 spaces for each level.

#### 2. Invalid Character
```
Error: Invalid character in filename
```
**Solution**: Avoid special characters like `<>:"|?*` in filenames.

#### 3. Permission Denied
```
Error: Permission denied creating directory
```
**Solution**: Check write permissions or use `-o` to specify a different output directory.

### Debugging Tips

1. **Use dry-run**: Always test with `--dry-run` first
2. **Check indentation**: Use a text editor that shows spaces
3. **Start simple**: Begin with a basic structure and add complexity
4. **Validate syntax**: Ensure colons and dashes are in the right places

## Integration

### With Version Control

Add structure files to your repository:

```bash
git add project_structure.yaml
git commit -m "Add project structure template"
```

### With Build Scripts

```bash
#!/bin/bash
# setup.sh
structgen project_template.yaml
cd my_project
git init
# ... other setup commands
```

### With Makefiles

```makefile
setup:
	structgen project.yaml
	cd $(PROJECT_NAME) && git init

.PHONY: setup
```

## Tips and Tricks

### 1. Environment-Specific Structures

Create different structure files for different environments:

- `dev_structure.yaml` - Development setup
- `prod_structure.yaml` - Production deployment
- `test_structure.yaml` - Testing environment

### 2. Modular Structures

Break large structures into smaller, reusable components:

```yaml
# base_project.yaml
base_project:
  src:
    - main.nim
  - README.md

# Add more specific structures as needed
```

### 3. Documentation as Code

Keep your structure files alongside your documentation:

```
docs/
├── structure_templates/
│   ├── web_app.yaml
│   ├── cli_tool.yaml
│   └── library.yaml
└── README.md
```

This completes the comprehensive usage guide for the File Structure Generator tool!