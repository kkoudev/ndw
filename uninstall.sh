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
EOF

}


#===========================================
# Entry point of install script.
#===========================================

readonly INSTALL_DIR="$HOME/.ndw"
readonly CLI_INSTALL_DIR="/usr/local/bin"
readonly CLI_INSTALL_NAME="ndw"
SUDO_ACCESS=""

while getopts h OPTION "$@"
do
  case ${OPTION} in
    *)
      usage
      exit 0
      ;;
  esac
done

# Prompt confirmation message
read -p "Really uninstall ndw? (y/N) : " CONTINUE_UNINSTALL

# Require sudo access?
test -w "${CLI_INSTALL_DIR}" || SUDO_ACCESS="sudo"
if [[ -n ${SUDO_ACCESS} ]]; then
  echo "Please input your sudo password."
fi

# Continue uninstall?
if [[ $(printf "${CONTINUE_UNINSTALL}" | tr '[:upper:]' '[:lower:]') = "y" ]]; then

  ${SUDO_ACCESS} rm -f "${CLI_INSTALL_DIR}/${CLI_INSTALL_NAME}"
  rm -rf "${INSTALL_DIR}"
  echo "Complete uninstallation."

fi
