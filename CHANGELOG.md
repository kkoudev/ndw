# 2.1.1 (2023-04-07)

### Fixed

-   Error "install-yarn" command.

### Added

-   Support for "corepack" command. Need to reinstall to use.

# 2.0.3 (2022-03-18)

### Fixed

-   Cannot install yarn if latest version in official website is differect latest version in npm repository.

# 2.0.2 (2022-01-06)

### Fixed

-   Cannot install binary on aarch64 for linux

# 2.0.1 (2021-07-06)

### Fixed

-   PATH is overwritten in certain cases.

# 2.0.0 (2021-05-15)

### Added

-   Support for arm64 binary. (Only supported since Node.js v16)

### Removed

-   c option of "install" command.
-   wrapper commands.

# 1.6.3 (2021-01-11)

### Fixed

-   Environment value included comments for .env.

# 1.6.2 (2021-01-08)

### Fixed

-   Environment value included line break for .env.

# 1.6.1 (2020-03-02)

### Fixed

-   Timeout when the binary to download on slow network.

# 1.6.0 (2020-02-18)

### Added

-   Support for "install-pnpm", "pnpm" and "pnpx" commands.

# 1.5.3 (2020-01-29)

### Fixed

-   Cannot executing "install-yarn" command.

# 1.5.2 (2019-02-11)

### Fixed

-   Binding incorrect values from ".env".

# 1.5.1 (2018-12-25)

### Fixed

-   Infinity loop bug when "yarn" command execution.

# 1.5.0 (2018-10-24)

### Added

-   Support for "env" command shells of bash, zsh and fish.
-   Support for ".env" file comments. Add a sharp(#) at the beginning of the line to use comments.

# 1.4.0 (2018-10-17)

### Changed

-   ndw work without git command.

# 1.3.2 (2018-10-16)

### Fixed

-   Cannot work linux.

### Added

-   Checks required commands. Print error message if no required commands.

# 1.3.1 (2018-10-15)

### Fixed

-   Cannot output "command not found" error message for "exec" sub command.

# 1.3.0 (2018-10-01)

### Added

-   Support for ".env" file. This file defines environment variables during command execution.

# 1.2.0 (2018-09-30)

### Added

-   Creates symbolic links for "node", "npm", "npx" and "yarn" command at installation.

# 1.1.0 (2018-09-19)

### Added

-   "-c" and "-s" options for "install" command.

# 1.0.2 (2018-08-19)

### Fixed

-   Cannot "install-yarn" to current version Node.js.
-   Error when reinstalling installed version.

# 1.0.1 (2018-08-04)

### Fixed

-   Some bugs.

# 1.0.0 (2018-08-04)

-   Initial release
