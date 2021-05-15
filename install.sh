#!/bin/bash

#===========================================
# Usages.
#===========================================

#-------------------------------------------
# View usage install options.
#-------------------------------------------
usage() {

  cat << EOF
Usage: ${0##*/} [<args>]

    -h            Show this message.
    -d <dir>      Set install directory.
    -v <version>  Set install version.
EOF

}


#===========================================
# Entry point of install script.
#===========================================

readonly INSTALL_DIR="/usr/local/bin"
INSTALL_TAG="master"
INSTALL_NDW_COMMANDS=(
ndw
)
INSTALL_COMMANDS=(
node
npm
npx
yarn
pnpm
pnpx
)
SUDO_ACCESS=""

# Apple Silicon?
if [[ $(uname -s) == "Darwin" && $(uname -m) == "arm64" ]]; then
  SUDO_ACCESS="sudo"
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
for CMD_NAME in ${INSTALL_COMMANDS[@]}
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
