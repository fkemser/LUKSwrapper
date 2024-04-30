#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the LUKSwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /etc/luks.cfg.sh
#
#        USAGE:   ---
#                 (This is a configuration file, so please do NOT run it.)
#
#  DESCRIPTION:   Configuration File for </src/luks.sh>
#
#         BUGS:   ---
#
#        NOTES:   Please DO NOT DELETE this file, even when it is empty.
#
#         TODO:   See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#                  DONE: DEFINE YOUR VARIABLES/CONSTANTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
#===============================================================================
#  /src/luks.sh (CFG_LUKS_...)
#===============================================================================
# Encryption cipher depending whether CPU supports AES-NI or not
# run <cat /proc/crypto> or <cryptsetup benchmark> to get a full
# list of available ciphers
readonly CFG_LUKS_ARG_CIPHER_WITH_AESNI="aes-xts-plain64"
readonly CFG_LUKS_ARG_CIPHER_WITHOUT_AESNI="xchacha20,aes-adiantum-plain64"

# Encryption key size (in bits) depending on chosen cipher / operation mode
# Important if you use a cipher with XTS operation mode: XTS splits the
# supplied key in half, e.g. for AES-256 with XTS you need a key size of 512 bits.
readonly CFG_LUKS_ARG_KEY_SIZE_WITH_XTS="512"
readonly CFG_LUKS_ARG_KEY_SIZE_WITHOUT_XTS="256"

# File system to use when formatting a previously set up LUKS devices
readonly CFG_LUKS_ARG_FILESYSTEM_ENCRYPT="ext4"

# Hash algorithm
readonly CFG_LUKS_ARG_HASH="sha256"

# Number of milliseconds to spend with PBKDF2 password processing
readonly CFG_LUKS_ARG_ITER_TIME="2000"
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                  DONE: DEFINE YOUR VARIABLES/CONSTANTS HERE
#===============================================================================