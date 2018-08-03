# ndw

NodeJS version manager.

## Installation

```
curl -s https://raw.githubusercontent.com/kkoudev/ndw/master/install.sh | bash
```

Please add "/usr/local/bin" to global PATH if not included "/usr/local/bin" in global PATH.

## Usage

### Install NodeJS

```
ndw install <version>
```

### List available NodeJS versions

```
ndw list -r
```

### List installed NodeJS versions

```
ndw list -l
```

### Set NodeJS local version

```
ndw local <version>
```

This command creates ".node-version" file in current directory.

### Set NodeJS global version

```
ndw global <version>
```

This command creates global NodeJS version file.  
The global version is used when ".node-version" file not found.

### Execute node command in current NodeJS version.

```
ndw node
```

There is alias command as "nodew".

### Execute npm command in current NodeJS version.

```
ndw npm
```

There is alias command as "npmw".

### Execute npx command in current NodeJS version.

```
ndw npx
```

There is alias command as "npxw".

### Execute yarn command in current NodeJS version.

```
ndw yarn
```

There is alias command as "yarnw".

### Install or upgrade yarn in current NodeJS version.

```
ndw install-yarn <yarn version>
```

If no specify yarn version, install the latest version.

### Uninstall NodeJS

```
ndw uninstall <version>
```

## [Changelog](CHANGELOG.md)

## [License](LICENSE)
