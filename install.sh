#!/bin/bash

INSTALL_PREFIX=${1:-/usr/local/bin}

# Download cli script
curl -s https://raw.githubusercontent.com/kkoudev/ndw/master/ndw-cli -o ${INSTALL_PREFIX}/ndw-cli

# Set executing mode
chmod a+x ${INSTALL_PREFIX}/ndw-cli

# Creates symbolic links
ln -sf ${INSTALL_PREFIX}/ndw-cli ${INSTALL_PREFIX}/ndw
ln -sf ${INSTALL_PREFIX}/ndw-cli ${INSTALL_PREFIX}/nodew
ln -sf ${INSTALL_PREFIX}/ndw-cli ${INSTALL_PREFIX}/npmw
ln -sf ${INSTALL_PREFIX}/ndw-cli ${INSTALL_PREFIX}/npxw
ln -sf ${INSTALL_PREFIX}/ndw-cli ${INSTALL_PREFIX}/yarnw
