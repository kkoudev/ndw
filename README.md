# ndw

Node.js version manager.

## Installation

ndw requires bash, curl and awk.

```
# bash, zsh
bash <(curl -s https://raw.githubusercontent.com/kkoudev/ndw/master/install.sh)

# fish
bash (curl -s https://raw.githubusercontent.com/kkoudev/ndw/master/install.sh | psub)
```

Add "$HOME/.ndw/bin" to global PATH automatically.

## Uninstallation

```
# bash, zsh
bash <(curl -s https://raw.githubusercontent.com/kkoudev/ndw/master/uninstall.sh)

# fish
bash (curl -s https://raw.githubusercontent.com/kkoudev/ndw/master/uninstall.sh | psub)
```

## Supports ".env" file

The ".env" file defines environment variables during command execution.

```
# 1. Creates a .env file in project root directory.
# .env

# Environment type
NODE_ENV=production

# 2. Executes ndw command or alias node commands.
ndw node example.js

or

node example.js
```

## Usage

### Install Node.js

```
ndw install <version>
```

Skip displaying the prompt for reinstall specified version by option "-s" if the current version already installed.

### Install current version of Node.js

```
ndw install -c
```

The current version is version specified by "ndw local" or "ndw global".

### Uninstall Node.js

```
ndw uninstall <version>
```

### List available Node.js versions

```
ndw list -r
```

### List installed Node.js versions

```
ndw list -l
```

### Set Node.js local version

```
ndw local [<version> or "system"]
```

This command creates ".node-version" file in current directory.
Show current local version if no specify version.

### Set Node.js global version

```
ndw global [<version> or "system"]
```

This command creates global Node.js version file.
The global version is used if ".node-version" file not found.
Show current global version if no specify version.

### Print export statements for definition variables from ".env" file.

```
ndw env [<shell name>]
```

#### Example

```
# .env file
EXEC_FILE="./main.js"

# specify a execution script by definition variable.
eval $(ndw env bash)
node ${EXEC_FILE}
```

### Execute global module commands in current Node.js version.

```
ndw exec <command>
```

#### Example

```
ndw npm i -g serverless
ndw exec sls --version
```

### Execute node command in current Node.js version.

```
ndw node
```

### Execute npm command in current Node.js version.

```
ndw npm
```

### Execute npx command in current Node.js version.

```
ndw npx
```

### Execute yarn command in current Node.js version.

```
ndw yarn
```

### Install or upgrade yarn in current Node.js version.

```
ndw install-yarn [<yarn version>]
```

If no specify yarn version, install the latest version.

### Show current Node.js version

```
ndw current
```

This command shows the actually used Node.js version.

### Show ndw version number

```
ndw version
```

## [Changelog](CHANGELOG.md)

## [License](LICENSE)
