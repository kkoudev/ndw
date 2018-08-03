#!/bin/bash

INSTALL_PREFIX=${1:-/usr/local/bin}

# Remove all commands
rm -f ${INSTALL_PREFIX}/ndw-cli
rm -f ${INSTALL_PREFIX}/ndw
rm -f ${INSTALL_PREFIX}/nodew
rm -f ${INSTALL_PREFIX}/npmw
rm -f ${INSTALL_PREFIX}/npxw
rm -f ${INSTALL_PREFIX}/yarnw
