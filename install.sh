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

INSTALL_DIR="/usr/local/bin"
INSTALL_TAG="master"
INSTALL_WRAPPER_COMMANDS=(
ndw
nodew
npmw
npxw
yarnw
pnpm
pnpx
)
INSTALL_COMMANDS=(
node
npm
npx
yarn
pnpm
pnpx
)

while getopts hrl OPTION "$@"
do
  case ${OPTION} in
    d)
      INSTALL_DIR="${OPTARG}"
      ;;
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
curl -s "https://raw.githubusercontent.com/kkoudev/ndw/${INSTALL_TAG}/ndw-cli" -o ${INSTALL_DIR}/ndw-cli

# Set executing mode
chmod a+x ${INSTALL_DIR}/ndw-cli

# Creates symbolic links
for CMD_NAME in ${INSTALL_WRAPPER_COMMANDS[@]}
do
  ln -sf ${INSTALL_DIR}/ndw-cli ${INSTALL_DIR}/${CMD_NAME}
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
  ln -sf ${INSTALL_DIR}/ndw-cli ${INSTALL_DIR}/${CMD_NAME}

done
