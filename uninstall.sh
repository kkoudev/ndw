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
    -d <dir>      Set uninstall directory.
EOF

}


#===========================================
# Entry point of install script.
#===========================================

INSTALL_DIR="/usr/local/bin"

while getopts hrl OPTION "$@"
do
  case ${OPTION} in
    d)
      INSTALL_DIR="${OPTARG}"
      ;;
    *)
      usage
      exit 0
      ;;
  esac
done

# Prompt confirmation message
read -p "Really uninstall ndw? (y/N) : " CONTINUE_UNINSTALL

# Continue uninstall?
if [[ $(printf "${CONTINUE_UNINSTALL}" | tr '[:upper:]' '[:lower:]') = "y" ]]; then

  # Remove all commands
  rm -f ${INSTALL_DIR}/ndw-cli
  rm -f ${INSTALL_DIR}/ndw
  rm -f ${INSTALL_DIR}/nodew
  rm -f ${INSTALL_DIR}/npmw
  rm -f ${INSTALL_DIR}/npxw
  rm -f ${INSTALL_DIR}/yarnw

  echo "Complete uninstallation."

fi
