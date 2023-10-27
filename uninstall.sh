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

# Continue uninstall?
if [[ $(printf "${CONTINUE_UNINSTALL}" | tr '[:upper:]' '[:lower:]') = "y" ]]; then

  rm -rf "${INSTALL_DIR}"
  echo "Complete uninstallation."

fi
