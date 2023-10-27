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
readonly SHELL_NAME="${SHELL##*/}"
INSTALL_TAG="master"
INSTALL_NDW_COMMANDS=(
ndw
)
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
INSTALL_SHELL_CONFIG_BEGIN="## ndw BEGIN"
INSTALL_SHELL_CONFIG_END="## ndw END"
INSTALL_SHELL_CONFIG_BODY=""
SUDO_ACCESS=""

# Not exists install directory
if [[ ! -e ${INSTALL_DIR} ]]; then
  # create install directory
  mkdir -p "${INSTALL_DIR}"
fi

# Require sudo access?
test -w "${INSTALL_DIR}" || SUDO_ACCESS="sudo"

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

# Download cli script
${SUDO_ACCESS} curl -s "https://raw.githubusercontent.com/kkoudev/ndw/${INSTALL_TAG}/ndw-cli" -o ${INSTALL_DIR}/ndw-cli

# Set executing mode
${SUDO_ACCESS} chmod a+x ${INSTALL_DIR}/ndw-cli

# Creates symbolic links
for CMD_NAME in ${INSTALL_NDW_COMMANDS[@]}
do
  ${SUDO_ACCESS} ln -sf ${INSTALL_DIR}/ndw-cli ${INSTALL_DIR}/${CMD_NAME}
done

# Creates symbolic links for general commands
for CMD_NAME in ${INSTALL_ALIAS_COMMANDS[@]}
do

  if [[ -e ${INSTALL_DIR}/${CMD_NAME} ]]; then

    # Not ndw-cli command?
    if [[ ! -L ${INSTALL_DIR}/${CMD_NAME} \
         || (-L ${INSTALL_DIR}/${CMD_NAME} && $(readlink ${INSTALL_DIR}/${CMD_NAME} | tr -d '\n') != ${INSTALL_DIR}/ndw-cli) ]]; then

      read -p "Overwrite already installed \"${CMD_NAME}\" command? (y/N) : " CONTINUE_INSTALL
      [[ $(printf "${CONTINUE_INSTALL}" | tr '[:upper:]' '[:lower:]') != "y" ]] && continue

    fi

  fi

  # Creates symbolic link for general command
  ${SUDO_ACCESS} ln -sf ${INSTALL_DIR}/ndw-cli ${INSTALL_DIR}/${CMD_NAME}

done

# Install shellenv
case "${SHELL_NAME}" in
bash)
  INSTALL_SHELL_CONFIG_PATH="$HOME/.bash_profile"
  INSTALL_SHELL_CONFIG_BODY=$(cat << EOF
eval "$(\$HOME/.ndw/bin/ndw shellenv)"
EOF
)
  ;;

zsh)
  INSTALL_SHELL_CONFIG_PATH="$HOME/.zshrc"
  INSTALL_SHELL_CONFIG_BODY=$(cat << EOF
eval "$(\$HOME/.ndw/bin/ndw shellenv)"
EOF
)
  ;;

fish)
  INSTALL_SHELL_CONFIG_PATH="$HOME/.config/fish/config.fish"
  INSTALL_SHELL_CONFIG_BODY=$(cat << EOF
\$HOME/.ndw/bin/ndw shellenv | source
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
  exec ${SHELL_NAME} -l
fi
