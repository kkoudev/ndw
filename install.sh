#!/bin/bash

#===========================================
# Usages.
#===========================================

set -e

#-------------------------------------------
# View usage install options.
#-------------------------------------------
usage() {

  cat << EOF
Usage: ${0##*/} [<args>]

    -h            Show this message.
    -v <version>  Set install version.
EOF

}


#===========================================
# Entry point of install script.
#===========================================

readonly INSTALL_DIR="$HOME/.ndw/bin"
readonly CLI_INSTALL_DIR="/usr/local/bin"
readonly CLI_INSTALL_NAME="ndw"
readonly ESCAPE_INSTALL_DIR='$HOME/.ndw/bin'
readonly ESCAPE_CLI_INSTALL_DIR='/usr/local/bin'
readonly SHELL_NAME="${SHELL##*/}"
INSTALL_TAG="master"
INSTALL_ALIAS_COMMANDS=(
node
npm
npx
yarn
pnpm
pnpx
corepack
)
INSTALL_SHELL_CONFIG_PATH=""
INSTALL_SHELL_CONFIG_BEGIN="## ${CLI_INSTALL_NAME} BEGIN"
INSTALL_SHELL_CONFIG_END="## ${CLI_INSTALL_NAME} END"
INSTALL_SHELL_CONFIG_BODY=""
SUDO_ACCESS=""

# Not exists install directory
if [[ ! -e ${INSTALL_DIR} ]]; then
  # create install directory
  mkdir -p "${INSTALL_DIR}"
fi

while getopts v:h OPTION "$@"
do
  case ${OPTION} in
    v)
      INSTALL_TAG="${OPTARG}"
      ;;
    *)
      usage
      exit 0
      ;;
  esac
done

# Require sudo access?
test -w "${CLI_INSTALL_DIR}" || SUDO_ACCESS="sudo"
if [[ -n ${SUDO_ACCESS} ]]; then
  echo "Please input your sudo password."
fi

# Download cli script
${SUDO_ACCESS} curl -s "https://raw.githubusercontent.com/kkoudev/ndw/${INSTALL_TAG}/ndw-cli" -o ${CLI_INSTALL_DIR}/${CLI_INSTALL_NAME}

# Set executing mode
${SUDO_ACCESS} chmod a+x ${CLI_INSTALL_DIR}/${CLI_INSTALL_NAME}

# Creates symbolic links for general commands
for CMD_NAME in ${INSTALL_ALIAS_COMMANDS[@]}
do

  # Creates symbolic link for general command
  ${SUDO_ACCESS} ln -sf ${CLI_INSTALL_DIR}/${CLI_INSTALL_NAME} ${INSTALL_DIR}/${CMD_NAME}

done

# Install shellenv
case "${SHELL_NAME}" in
bash)
  INSTALL_SHELL_CONFIG_PATH="$HOME/.bash_profile"
  INSTALL_SHELL_CONFIG_BODY=$(cat << EOF
eval "$(${ESCAPE_CLI_INSTALL_DIR}/${CLI_INSTALL_NAME} shellenv)"
EOF
)
  ;;

zsh)
  INSTALL_SHELL_CONFIG_PATH="$HOME/.zshrc"
  INSTALL_SHELL_CONFIG_BODY=$(cat << EOF
eval "$(${ESCAPE_CLI_INSTALL_DIR}/${CLI_INSTALL_NAME} shellenv)"
EOF
)
  ;;

fish)
  INSTALL_SHELL_CONFIG_PATH="$HOME/.config/fish/config.fish"
  INSTALL_SHELL_CONFIG_BODY=$(cat << EOF
${ESCAPE_CLI_INSTALL_DIR}/${CLI_INSTALL_NAME} shellenv | source
EOF
)
  ;;

*)
  echo "Not supported shell command for ${SHELL_NAME}"
  ;;
esac

SHELL_CONFIG_DIR="${INSTALL_SHELL_CONFIG_PATH%/*}"
if [[ ! -e ${SHELL_CONFIG_DIR} ]]; then
  mkdir -p ${SHELL_CONFIG_DIR}
fi

if [[ ! -e ${INSTALL_SHELL_CONFIG_PATH} ]]; then
  touch "${INSTALL_SHELL_CONFIG_PATH}"
fi

if ! grep -q "${INSTALL_SHELL_CONFIG_BEGIN}" ${INSTALL_SHELL_CONFIG_PATH}; then
  echo -n -e "\n" >> ${INSTALL_SHELL_CONFIG_PATH}
  echo "${INSTALL_SHELL_CONFIG_BEGIN}" >> ${INSTALL_SHELL_CONFIG_PATH}
  echo "${INSTALL_SHELL_CONFIG_BODY}" >> ${INSTALL_SHELL_CONFIG_PATH}
  echo "${INSTALL_SHELL_CONFIG_END}" >> ${INSTALL_SHELL_CONFIG_PATH}
fi

eval "$(${CLI_INSTALL_DIR}/${CLI_INSTALL_NAME} shellenv bash)"
