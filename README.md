# ndw

Node.js version manager.

## Installation

```
bash <(curl -s https://raw.githubusercontent.com/kkoudev/ndw/master/install.sh)
```

Please add "/usr/local/bin" to global PATH if not included "/usr/local/bin" in global PATH.

## Uninstallation

```
bash <(curl -s https://raw.githubusercontent.com/kkoudev/ndw/master/uninstall.sh)
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
ndw local [<version>]
```

This command creates ".node-version" file in current directory.
Show current local version if no specify version.

### Set Node.js global version

```
ndw global [<version>]
```

This command creates global Node.js version file.
The global version is used if ".node-version" file not found.
Show current global version if no specify version.

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

There is alias command as "nodew".

### Execute npm command in current Node.js version.

```
ndw npm
```

There is alias command as "npmw".

### Execute npx command in current Node.js version.

```
ndw npx
```

There is alias command as "npxw".

### Execute yarn command in current Node.js version.

```
ndw yarn
```

There is alias command as "yarnw".

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
