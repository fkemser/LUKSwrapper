#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the LUKSwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/luks.sh
#
#        USAGE:   Run <luks.sh -h> for more information
#
#  DESCRIPTION:   LUKSwrapper Run File
#
#      OPTIONS:   Run <run.sh -h> for more information
#
# REQUIREMENTS:   Run <run.sh -h> for more information
#
#         BUGS:   ---
#
#        NOTES:   ---
#
#        TODO:    See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  CONFIG
#===============================================================================
#  DONE: Enable PID based locking? (true|false)
#  (If 'true' then parts of the script require root privileges.)
readonly PIDLOCK_ENABLED="false"

#===============================================================================
#  INIT - DO NOT EDIT
#===============================================================================
#  Run repository initialisation script
. "$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/init.sh"              || \
{ printf "%s\n\n"                                                           \
    "ERROR: Could not run the repository initialisation script './init.sh'. Aborting..." >&2
  return 1
}

#===============================================================================
#  PARAMETER (TEMPLATE) - DO NOT EDIT
#===============================================================================
#  Script actions <ARG_ACTION_...>
readonly ARG_ACTION_ABOUT="about"
readonly ARG_ACTION_EXIT="exit"
readonly ARG_ACTION_HELP="help"
arg_action=""

#  Log destination <ARG_LOGDEST_...>
readonly ARG_LOGDEST_BOTH="both"                  # Terminal window + System log
readonly ARG_LOGDEST_SYSLOG="syslog"              # System log
readonly ARG_LOGDEST_TERMINAL="terminal"          # Terminal window
readonly ARG_LOGDEST_LIST="BOTH SYSLOG TERMINAL"
arg_logdest=""

#  Script operation modes <ARG_MODE_...>
readonly ARG_MODE_DAEMON="daemon"                 # Daemon
readonly ARG_MODE_INTERACTIVE="interactive"       # Interactive
readonly ARG_MODE_INTERACTIVE_SUBMENU="submenu"   # Submenu
readonly ARG_MODE_SCRIPT="script"                 # Script
arg_mode="${ARG_MODE_SCRIPT}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#-------------------------------------------------------------------------------
#  Script actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
#                        DONE: DEFINE YOUR ACTIONS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
readonly ARG_ACTION_BENCHMARK="benchmark"
readonly ARG_ACTION_CLONE="clone"
readonly ARG_ACTION_CLOSE="close"
readonly ARG_ACTION_ENCRYPT="encrypt"
readonly ARG_ACTION_ENROLL="enroll"
readonly ARG_ACTION_HEADER_BACKUP="header-backup"
readonly ARG_ACTION_HEADER_INFO="header-info"
readonly ARG_ACTION_HEADER_RESTORE="header-restore"
readonly ARG_ACTION_IS_LUKS_DEVICE="is-luks-device"
readonly ARG_ACTION_LIST_TOKEN="list-token"
readonly ARG_ACTION_OPEN="open"
readonly ARG_ACTION_REMOVE="remove"
readonly ARG_ACTION_REPLACE="replace"
readonly ARG_ACTION_SHOW_DRIVES="show-drives"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                        DONE: DEFINE YOUR ACTIONS HERE
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Other parameters <arg_...>
#-------------------------------------------------------------------------------
#  In case you define any additional constants for your parameters please use
#  the following naming convention:
#
#  Name                 Description
#  -----------------------------------------------------------------------------
#  <ARG>_DEFAULT        Default value that <arg> will be reset to,
#                       see <LIST_ARG_CLEANUP_INTERACTIVE> below.
#
#  <ARG>_LIST[_...]     List of allowed values, either directly or
#                       indirectly via constant pointers.
#
#  <ARG>_MAX            Maximum value
#  <ARG>_MIN            Minimum value
#
#                       DONE: DEFINE YOUR PARAMETERS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
# Authentication mechanism
readonly ARG_AUTH_FIDO2="fido2"
readonly ARG_AUTH_PASSPHRASE="passphrase"
readonly ARG_AUTH_PKCS11="pkcs11"
readonly ARG_AUTH_RECOVERY="recovery"
readonly ARG_AUTH_TPM2="tpm2"

# List of allowed authentication mechanisms (updated in <init_check_pre()>)
ARG_AUTH_LIST="PASSPHRASE"
ARG_AUTH_LIST_LIST_TOKEN=""
ARG_AUTH_LIST_OPEN="PASSPHRASE"
arg_auth="${ARG_AUTH_PASSPHRASE}"

# Encryption cipher depending whether CPU supports AES-NI or not
readonly ARG_CIPHER_WITH_AESNI="${CFG_LUKS_ARG_CIPHER_WITH_AESNI:-aes-xts-plain64}"
readonly ARG_CIPHER_WITHOUT_AESNI="${CFG_LUKS_ARG_CIPHER_WITHOUT_AESNI:-xchacha20,aes-adiantum-plain64}"
arg_cipher=""

arg_device_dst="" # Destination device (only when <arg_action>=<ARG_ACTION_CLONE>)
arg_device_src="" # Source device to encrypt, open, ...

# (Only if <arg_auth>=<ARG_AUTH_FIDO2>) FIDO2 device node
# See also 'man systemd-cryptenroll'
readonly ARG_FIDO2_DEVICE_AUTO="auto"
readonly ARG_FIDO2_DEVICE_MANUAL="..."
readonly ARG_FIDO2_DEVICE_LIST="AUTO MANUAL"
arg_fido2_device="${ARG_FIDO2_DEVICE_AUTO}"

# File system to use when formatting a previously set up LUKS device
readonly ARG_FILESYSTEM_ENCRYPT="${CFG_LUKS_ARG_FILESYSTEM_ENCRYPT:-ext4}"
readonly ARG_FILESYSTEM_OPEN="auto"
arg_filesystem=""

arg_hash="${CFG_LUKS_ARG_HASH:-sha256}" # Hash algorithm
arg_headerfile="" # File(path) to use for LUKS header backup/restore

# Number of milliseconds to spend with PBKDF2 password processing
readonly ARG_ITER_TIME_MIN="1000"
readonly ARG_ITER_TIME_MAX="60000"
arg_iter_time="${CFG_LUKS_ARG_ITER_TIME:-2000}"

# Encryption key size depending on chosen cipher
readonly ARG_KEY_SIZE_MIN="128"
readonly ARG_KEY_SIZE_MAX="512"
readonly ARG_KEY_SIZE_WITH_XTS="${CFG_LUKS_ARG_KEY_SIZE_WITH_XTS:-512}"
readonly ARG_KEY_SIZE_WITHOUT_XTS="${CFG_LUKS_ARG_KEY_SIZE_WITHOUT_XTS:-256}"
arg_key_size=""

# Map open LUKS to '/dev/mapper/${arg_mapper}'
arg_mapper=""

# Mountpoint where (mapped/opened) LUKS device will be mounted
# See also global variable <mount>
arg_mount=""

# (Only if <arg_auth>=<ARG_AUTH_PKCS11>) PKCS11# URI
# See also 'man systemd-cryptenroll'
readonly ARG_PKCS11_TOKEN_URI_AUTO="auto"
readonly ARG_PKCS11_TOKEN_URI_MANUAL="..."
readonly ARG_PKCS11_TOKEN_URI_LIST="AUTO MANUAL"
arg_pkcs11_token_uri="${ARG_PKCS11_TOKEN_URI_AUTO}"

# (Only if <arg_auth>=<ARG_AUTH_TPM2>) TPM2 device node
# See also 'man systemd-cryptenroll'
readonly ARG_TPM2_DEVICE_AUTO="auto"
readonly ARG_TPM2_DEVICE_MANUAL="..."
readonly ARG_TPM2_DEVICE_LIST="AUTO MANUAL"
arg_tpm2_device="${ARG_TPM2_DEVICE_AUTO}"

# (Only if <arg_auth>=<ARG_AUTH_TPM2>)
# TPM2 PCRs (Platform Configuration Registers)
# See also: https://man7.org/linux/man-pages/man1/systemd-cryptenroll.1.html
arg_tpm2_pcrs="7"

# (Only if <arg_auth>=(<ARG_AUTH_FIDO2>|<ARG_AUTH_TPM2>))
# Request additional FIDO2/TPM2 PIN before unlocking? (true|false)
arg_with_pin="true"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                       DONE: DEFINE YOUR PARAMETERS HERE
#-------------------------------------------------------------------------------

#===============================================================================
#  GLOBAL VARIABLES (TEMPLATE) - DO NOT EDIT
#===============================================================================
# Trap handling
trap_blocked="false"        # Prevent trap execution? (true|false)
trap_triggered="false"      # <trap_...()> function was called? (true|false)

#===============================================================================
#  GLOBAL VARIABLES (CUSTOM)
#===============================================================================
#                    DONE: DEFINE YOUR GLOBAL VARIABLES HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
#-------------------------------------------------------------------------------
#  Other
#-------------------------------------------------------------------------------
# systemd-cryptenroll
readonly CMD_SYSTEMD_CRYPTENROLL_CMD="systemd-cryptenroll"
cmd_systemd_cryptenroll=""

# systemd-cryptsetup
readonly CMD_SYSTEMD_CRYPTSETUP_BIN="/usr/lib/systemd/systemd-cryptsetup"
readonly CMD_SYSTEMD_CRYPTSETUP_CMD="systemd-cryptsetup"
cmd_systemd_cryptsetup=""

# Mount (mapped/opened) LUKS device? (true|false)
readonly MOUNT_DEFAULT="true"
mount="${MOUNT_DEFAULT}"
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    DONE: DEFINE YOUR GLOBAL VARIABLES HERE
#===============================================================================

#===============================================================================
#  GLOBAL CONSTANTS (TEMPLATE)
#===============================================================================
#-------------------------------------------------------------------------------
#  Lists of allowed actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
#  Used for auto-generating help's SYNOPSIS section and the main menu in
#  interactive mode. Please define a list of actions (separated by space) that
#  are allowed in interactive (also submenu) and/or script mode.
#  Use the variable's name but WITHOUT the <ARG_ACTION_> prefix,
#  e.g. for <ARG_ACTION_CUSTOM1> just use <CUSTOM1> in the list.
#-------------------------------------------------------------------------------
#                      DONE: DEFINE YOUR ACTION LISTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
# Interactive mode / Submenu mode
readonly ARG_ACTION_LIST_INTERACTIVE="SHOW_DRIVES BENCHMARK ENCRYPT OPEN CLOSE ENROLL REMOVE REPLACE HEADER_BACKUP HEADER_RESTORE HEADER_INFO CLONE"
# Classic script mode
readonly ARG_ACTION_LIST_SCRIPT="HELP BENCHMARK CLONE CLOSE ENCRYPT ENROLL HEADER_BACKUP HEADER_INFO HEADER_RESTORE IS_LUKS_DEVICE LIST_TOKEN OPEN REMOVE REPLACE SHOW_DRIVES"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                      DONE: DEFINE YOUR ACTION LISTS HERE
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#                    DONE: DEFINE YOUR PARAMETER LISTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
#  Lists of compatible parameters (script mode only)
#-------------------------------------------------------------------------------
#  Used for auto-generating help's SYNOPSIS section. Please define a list of
#  parameters (separated by space) that are allowed in script mode.
#  !!! Use the variable's name in capital letters,
#      e.g. for <arg_int> use <ARG_INT> !!!
readonly LIST_ARG="ARG_AUTH ARG_CIPHER ARG_FIDO2_DEVICE ARG_FILESYSTEM ARG_HASH ARG_ITER_TIME ARG_KEY_SIZE ARG_MAPPER ARG_MOUNT ARG_WITH_PIN ARG_PKCS11_TOKEN_URI ARG_TPM2_DEVICE ARG_TPM2_PCRS"

#-------------------------------------------------------------------------------
#  Lists of parameters to clear/reset (interactive mode only)
#-------------------------------------------------------------------------------
#  List of arguments that have to be cleared or reset to their default values
#  after running <run()> function (interactive mode only).
#  To assign a default value to a parameter please define a constant (above)
#  with the suffix '_DEFAULT', e.g. <ARG_STR_DEFAULT> for <arg_str>.
#  !!! Use the variable's name as defined, so usually lowercase letters !!!
readonly LIST_ARG_CLEANUP_INTERACTIVE="arg_cipher arg_device_dst arg_device_src arg_filesystem arg_headerfile arg_key_size arg_mapper arg_mount mount"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    DONE: DEFINE YOUR PARAMETER LISTS HERE
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Custom language-specific strings <TXT_...>
#-------------------------------------------------------------------------------
#  Please do not set anything here, use '/src/lang/run.<ll>.lang.sh'
#  and <init_lang()> function (see below) instead.

#-------------------------------------------------------------------------------
#  OTHER
#-------------------------------------------------------------------------------
# Current language ID (ISO 639-1), see <init_lang()>
ID_LANG=""

# Number of running instances,
# used to check if this script was called recursively
INSTANCES=""

#===============================================================================
#  GLOBAL CONSTANTS (CUSTOM)
#===============================================================================
#                    DONE: DEFINE YOUR GLOBAL CONSTANTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
# libccid (PC/SC driver for USB CCID smart card readers)
readonly FILE_SO_LIBCCIDTWIN="libccidtwin.so"

# FIDO2 library used by systemd (otherwise "FIDO2 support is not installed")
readonly FILE_SO_LIBFIDO2="libfido2.so.1"

# PKCS#11 library
readonly FILE_SO_PKCS11_OPENSC="opensc-pkcs11.so" # OpenSC, see https://github.com/OpenSC/libp11

# TPM2 libraries used by systemd (otherwise "TPM2 support is not installed")
readonly FILE_SO_LIBTSS2_ESYS="libtss2-esys.so.0"
readonly FILE_SO_LIBTSS2_RC="libtss2-rc.so.0"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    DONE: DEFINE YOUR GLOBAL CONSTANTS HERE
#-------------------------------------------------------------------------------

#===============================================================================
#  FUNCTIONS (TEMPLATE)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  args_check
#  DESCRIPTION:  Check if passed arguments are valid
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  All arguments are valid
#            1:  At least one argument is not valid
#===============================================================================
args_check() {
  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  # # For more available checks, please have a look at the functions
  # # <lib_core_is()> and <lib_core_regex()> in '/lib/shlib/lib/core.lib.sh'

  #-----------------------------------------------------------------------------
  #  arg_auth
  #-----------------------------------------------------------------------------
  #  Get list of allowed authentication mechanisms
  local arg_auth_list
  arg_auth_list="$(lib_core_str_to --const "ARG_AUTH_LIST_${arg_action}")"
  eval "arg_auth_list=\${${arg_auth_list}}"

  #  In case action-specific list does not exist
  arg_auth_list="${arg_auth_list:-${ARG_AUTH_LIST}}"

  #  Check if select mechanism <arg_auth> is part of allowed list <arg_auth_list>
  { lib_core_list_contains_str_ptr                      \
      "${arg_auth}" "${arg_auth_list}" " " "ARG_AUTH_"  || \
    error "${TXT_ARG_AUTH_NOT_SUPPORTED}"
  }                                                                         && \

  #-----------------------------------------------------------------------------
  #  arg_cipher
  #-----------------------------------------------------------------------------
  true && \

  #-----------------------------------------------------------------------------
  #  arg_device_src
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_CLONE}|${ARG_ACTION_CLOSE}|${ARG_ACTION_ENCRYPT}|\
    ${ARG_ACTION_ENROLL}|${ARG_ACTION_HEADER_BACKUP}|${ARG_ACTION_HEADER_INFO}|\
    ${ARG_ACTION_HEADER_RESTORE}|${ARG_ACTION_OPEN}|${ARG_ACTION_REMOVE}|\
    ${ARG_ACTION_REPLACE})
      lib_core_is --blockdevice "${arg_device_src}"
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_device_dst
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_CLONE})
      lib_core_is --blockdevice "${arg_device_dst}" && \

      #  Ensure that <arg_device_src> and <arg_device_dst> are not identical
      if [ "${arg_device_src}" = "${arg_device_dst}" ]; then
        lib_msg_echo --error "${TXT_ERROR_IDENTICAL_DEVS}" "false" "" \
          "device_src" "${arg_device_src}"                            \
          "device_dst" "${arg_device_dst}"
      fi
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_fido2_device
  #-----------------------------------------------------------------------------
  case "${arg_fido2_device}" in
    ${ARG_FIDO2_DEVICE_AUTO}) ;;
    /dev/hidraw*) lib_core_is --exists "${arg_fido2_device}";;
    *) false;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_filesystem
  #-----------------------------------------------------------------------------
  true && \

  #-----------------------------------------------------------------------------
  #  arg_hash
  #-----------------------------------------------------------------------------
  true && \

  #-----------------------------------------------------------------------------
  #  arg_headerfile
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_HEADER_BACKUP})
      touch -c "${arg_headerfile}" 2>/dev/null && \
      ! lib_core_is --file "${arg_headerfile}"
      ;;
    ${ARG_ACTION_HEADER_RESTORE})
      lib_core_is --file "${arg_headerfile}"
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_iter_time
  #-----------------------------------------------------------------------------
  if lib_core_is --set "${arg_iter_time}"; then
    lib_math_is_within_range \
      "${ARG_ITER_TIME_MIN}" "${arg_iter_time}" "${ARG_ITER_TIME_MAX}"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_key_size
  #-----------------------------------------------------------------------------
  if lib_core_is --set "${arg_key_size}"; then
    lib_math_is_within_range \
      "${ARG_KEY_SIZE_MIN}" "${arg_key_size}" "${ARG_KEY_SIZE_MAX}"
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #  arg_mapper
  #-----------------------------------------------------------------------------
  true && \

  #-----------------------------------------------------------------------------
  #  arg_mount
  #-----------------------------------------------------------------------------
  true && \

  #-----------------------------------------------------------------------------
  #  arg_pkcs11_token_uri
  #-----------------------------------------------------------------------------
  true && \

  #-----------------------------------------------------------------------------
  #  arg_tpm2_device
  #-----------------------------------------------------------------------------
  case "${arg_tpm2_device}" in
    ${ARG_TPM2_DEVICE_AUTO}) ;;
    /dev/tpmrm*) lib_core_is --exists "${arg_tpm2_device}";;
    *) false;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  arg_tpm2_pcrs
  #-----------------------------------------------------------------------------
  if lib_core_is --set "${arg_tpm2_pcrs}"; then
    lib_core_regex --luks2-tpm2-pcrs "${arg_tpm2_pcrs}"
  fi                                                                        || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  { error "${TXT_ARGS_CHECK_ERR}"
    return 1
  }
}

#===  FUNCTION  ================================================================
#         NAME:  args_read
#  DESCRIPTION:  Read passed arguments into global parameters/variables
#
#      GLOBALS:  arg_action  arg_mode
#
#                arg_auth  arg_cipher  arg_device_dst  arg_device_src
#                arg_fido2_device  arg_filesystem  arg_hash  arg_headerfile
#                arg_iter_time  arg_key_size  arg_mapper  arg_mount
#                arg_pkcs11_token_uri  arg_with_pin  arg_tpm2_device
#                arg_tpm2_pcrs
#
#                mount
#
# PARAMETER  1:  Should be "$@" to get all arguments passed
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  All arguments were successfully parsed
#            1:  At least one argument could not be parsed
#===============================================================================
args_read() {
  #-----------------------------------------------------------------------------
  #  No arguments => Run script interactively
  #-----------------------------------------------------------------------------
  if [ $# -eq 0 ]; then
    arg_mode="${ARG_MODE_INTERACTIVE}"
    return
  fi

  #-----------------------------------------------------------------------------
  #  Arguments defined => Run script in script mode
  #-----------------------------------------------------------------------------
  local arg_current
  while [ $# -gt 0 ]; do
    arg_current="$1"
    case "$1" in
      #-------------------------------------------------------------------------
      #  PARAMETER (TEMPLATE)
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      -h|--help) arg_action="${ARG_ACTION_HELP}"; break;;

      #  Script operation modes <ARG_MODE_...>
      --submenu)
        # Possibility to run a certain submenu interactively
        arg_mode="${ARG_MODE_INTERACTIVE_SUBMENU}"
        arg_action="$2"; [ $# -ge 1 ] && { shift; }
        ;;

      #-------------------------------------------------------------------------
      #  PARAMETER (CUSTOM)
      #-------------------------------------------------------------------------
      #                 DONE: DEFINE YOUR ARGUMENT PARSING HERE
      #
      #                                   |||
      #                                  \|||/
      #                                   \|/
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      #  (all actions that do not expect any arguments)
      --${ARG_ACTION_BENCHMARK}|--${ARG_ACTION_ENROLL}|\
      --${ARG_ACTION_IS_LUKS_DEVICE}|--${ARG_ACTION_SHOW_DRIVES})
        arg_action="${1#--}"
        ;;

      #  Script actions <ARG_ACTION_...>
      #  (all actions that expect one (1) argument)
      --${ARG_ACTION_CLOSE}|--${ARG_ACTION_ENCRYPT}|\
      --${ARG_ACTION_HEADER_INFO}|--${ARG_ACTION_OPEN}|\
      --${ARG_ACTION_REMOVE}|--${ARG_ACTION_REPLACE})
        arg_action="${1#--}"
        arg_device_src="$2"
        [ $# -ge 1 ] && { shift; }
        ;;

      --${ARG_ACTION_LIST_TOKEN})
        arg_action="${1#--}"
        arg_auth="$2"
        [ $# -ge 1 ] && { shift; }
        ;;

      #  Script actions <ARG_ACTION_...>
      #  (all actions that expect two (2) arguments)
      --${ARG_ACTION_CLONE})
        arg_action="${1#--}"
        arg_device_src="$2"
        arg_device_dst="$3"
        [ $# -gt 1 ] && { shift; shift; }
        ;;

      --${ARG_ACTION_HEADER_BACKUP})
        arg_action="${1#--}"
        arg_device_src="$2"
        arg_headerfile="$(lib_core_expand_tilde "$3")"
        [ $# -gt 1 ] && { shift; shift; }
        ;;

      --${ARG_ACTION_HEADER_RESTORE})
        arg_action="${1#--}"
        arg_headerfile="$(lib_core_expand_tilde "$2")"
        arg_device_src="$3"
        [ $# -gt 1 ] && { shift; shift; }
        ;;

      #  Other parameters <arg_...>
      #  DONE: Please make sure that the command line options set here match
      #        the ones set in '/src/lang/run.0.lang.sh' (<L_RUN_HLP_PAR_ARG_...>).
      #  See 'man cryptsetup'
      -c|--cipher)        arg_cipher="$2"; [ $# -ge 1 ] && { shift; };;
      --hash)             arg_hash="$2"; [ $# -ge 1 ] && { shift; };;
      -i|--iter-time)     arg_iter_time="$2"; [ $# -ge 1 ] && { shift; };;
      -s|--key-size)      arg_key_size="$2"; [ $# -ge 1 ] && { shift; };;
      #  Other
      --auth)             arg_auth="$2"; [ $# -ge 1 ] && { shift; };;
      --fido2-device)     arg_fido2_device="$2"; [ $# -ge 1 ] && { shift; };;
      --filesystem)       arg_filesystem="$2"; [ $# -ge 1 ] && { shift; };;
      --mapper)           arg_mapper="$2"; [ $# -ge 1 ] && { shift; };;
      --mount)
        if [ -n "$2" ]; then arg_mount="$2"; mount="true"; else mount="false"; fi
        [ $# -ge 1 ] && { shift; }
        ;;
      --no-pin|--nopin)   arg_with_pin="false";;
      --pkcs11-token-uri) arg_pkcs11_token_uri="$2"; [ $# -ge 1 ] && { shift; };;
      --tpm2-device)      arg_tpm2_device="$2"; [ $# -ge 1 ] && { shift; };;
      --tpm2-pcrs)        arg_tpm2_pcrs="$2"; [ $# -ge 1 ] && { shift; };;
      #-------------------------------------------------------------------------
      #                                   /|\
      #                                  /|||\
      #                                   |||
      #
      #                 DONE: DEFINE YOUR ARGUMENT PARSING HERE
      #-------------------------------------------------------------------------

      #-------------------------------------------------------------------------
      #  Last or undefined parameter
      #-------------------------------------------------------------------------
      *)
        #-----------------------------------------------------------------------
        #            DONE: DEFINE YOUR (LAST) ARGUMENT PARSING HERE
        #        PLEASE DO NOT FORGET TO DEFINE <L_RUN_HLP_PAR_LASTARG>
        #               IN '/src/lang/run.0.lang.sh' ACCORDINGLY.
        #
        #                                 |||
        #                                \|||/
        #                                 \|/
        #-----------------------------------------------------------------------
        # Last argument can only be a (source) block device
        if [ $# -eq 1 ]; then
          #  Only one argument left
          arg_device_src="$1"
          lib_core_is --blockdevice "${arg_device_src}"
        else
          #  More than one argument left
          #
          #  Ignore wrong argument and continue with next one ('true')
          #  or exit program ('false')?
          false
        fi
        #-----------------------------------------------------------------------
        #                                 /|\
        #                                /|||\
        #                                 |||
        #
        #            DONE: DEFINE YOUR (LAST) ARGUMENT PARSING HERE
        #        PLEASE DO NOT FORGET TO DEFINE <L_RUN_HLP_PAR_LASTARG>
        #               IN '/src/lang/run.0.lang.sh' ACCORDINGLY.
        #-----------------------------------------------------------------------
        ;;
    esac                                                  && \
    [ $# -gt 0 ]                                          && \
    shift                                                 || \
    { error "<${arg_current}> ${TXT_ARGS_READ_ERR}"
      return 1
    }
  done
}

#===  FUNCTION  ================================================================
#         NAME:  cleanup_interactive
#  DESCRIPTION:  Cleanup, executed each cycle after <run()>
#                (interactive mode only)
#===============================================================================
cleanup_interactive() {
  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  #  Reset arguments to their default values
  local list
  list="${LIST_ARG_CLEANUP_INTERACTIVE}"

  local arg
  local val
  for arg in ${list}; do
    val="$(lib_core_str_to --const "${arg}_DEFAULT")"
    eval "val=\${${val}}"
    eval "${arg}=\${val}"
  done

  #  Further cleanup steps
  arg_action=""

  #-----------------------------------------------------------------------------
  #         DONE: DEFINE YOUR CLEANUP COMMANDS (INTERACTIVE MODE) HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #         DONE: DEFINE YOUR CLEANUP COMMANDS (INTERACTIVE MODE) HERE
  #-----------------------------------------------------------------------------
}

#===  FUNCTION  ================================================================
#         NAME:  error
#  DESCRIPTION:  Log/Print error message and optionally exit
#          ...:  See <msg()>
#===============================================================================
error() {
  msg --error "$@"
}

#===  FUNCTION  ================================================================
#         NAME:  help
#  DESCRIPTION:  Print help message using 'less' utility
#         DONE:  Please do not hardcode any help texts here.
#                Edit '/src/lang/run.<...>.lang.sh' to define your help texts
#                and edit <help_synopsis()> below to modify the SYNOPSIS
#                section of your help.
#===============================================================================
help() {
  lib_shtpl_help
}

#===  FUNCTION  ================================================================
#         NAME:  help_synopsis
#  DESCRIPTION:  Create help's <SYNOPSIS> section
#      OUTPUTS:  Write SYNOPSIS text to <stdout>
#===============================================================================
help_synopsis() {
  local ARG_SECTION_SYNOPSIS="--synopsis"
  local ARG_SECTION_TLDR="--tldr"
  local arg_section="${1:-${ARG_SECTION_SYNOPSIS}}"

  #  Get language-dependent text strings
  local ttl_action
  local ttl_option
  local txt_interactive
  local txt_intro
  local txt_script
  eval "ttl_action=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_ACTION}"
  eval "ttl_option=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_OPTION}"
  eval "txt_interactive=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TXT_SYNOPSIS_INTERACTIVE}"
  eval "txt_script=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TXT_SYNOPSIS_SCRIPT}"
  case "${arg_section}" in
    ${ARG_SECTION_SYNOPSIS})
      eval "txt_intro=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TXT_SYNOPSIS_INTRO}"
      ;;
    ${ARG_SECTION_TLDR})
      eval "txt_intro=\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TXT_TLDR_SYNOPSIS}"
      ;;
    *)
      return 1
      ;;
  esac

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (INTRO)
  #-----------------------------------------------------------------------------
  #  Pointer prefix used for actions and options
  local ptr_prefix
  ptr_prefix="L_$(lib_core_file_get --name "$0")"
  ptr_prefix="$(lib_core_str_to --const "${ptr_prefix}")"

  #  Last argument, see  <args_read()>, <L_RUN_HLP_PAR_LASTARG> in
  #  '/src/lang/run.0.lang.sh', and <L_RUN_<DE|EN|..>_HLP_DES_LASTARG> in
  #  '/src/lang/run.<de|en|...>.lang.sh'.
  local par_lastarg # Parameter, e.g. '<file>'
  local txt_lastarg # Parameter description, e.g. '<file> is optional'
  eval "par_lastarg=\${${ptr_prefix}_HLP_PAR_LASTARG}"
  eval "txt_lastarg=\${${ptr_prefix}_${ID_LANG}_HLP_DES_LASTARG}"

  #  SYNOPSIS strings
  local synopsis_tldr   # TL;DR (short) version
  local synopsis        # SYNOPSIS (long) version

  #-----------------------------------------------------------------------------
  #                DONE: DEFINE YOUR SYNOPSIS (INTRO) TEXT HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  TL;DR (short) version
  synopsis_tldr="\
${txt_intro}

${txt_interactive}:
> ${L_ABOUT_RUN}

${txt_script}:
> ${L_ABOUT_RUN} [ ${ttl_option} ]... ${ttl_action}${par_lastarg:+ ${par_lastarg}}"

  #  SYNOPSIS (long) version
  synopsis="\
${synopsis_tldr}

${ttl_action} := $(lib_msg_print_list_ptr "${ARG_ACTION_LIST_SCRIPT}" "${ptr_prefix}_HLP_PAR_ARG_ACTION_")

${ttl_option} := $(lib_msg_print_list_ptr "${LIST_ARG}" "${ptr_prefix}_HLP_PAR_" "" "true")"

  if lib_core_is --set "${txt_lastarg}"; then
    synopsis="\
${synopsis}

${par_lastarg} : ${txt_lastarg}"
  fi
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                DONE: DEFINE YOUR SYNOPSIS (INTRO) TEXT HERE
  #-----------------------------------------------------------------------------

  #  Print
  case "${arg_section}" in
    ${ARG_SECTION_SYNOPSIS})
      eval lib_msg_print_heading -111 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS}\"
      printf "%s\n" "${synopsis}"
      ;;

    ${ARG_SECTION_TLDR})
      eval lib_msg_print_heading -311 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_TLDR_SYNOPSIS}\"
      printf "%s\n" "${synopsis_tldr}"
      return
      ;;
  esac

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (ACTION)
  #-----------------------------------------------------------------------------
  eval lib_msg_print_heading -211 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_ACTION}\"

  #-----------------------------------------------------------------------------
  #                DONE: DEFINE YOUR SYNOPSIS (ACTION) TEXT HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  NOTE:
  #    Please define your help texts in '/src/lang/run.<...>.lang.sh' before
  #    continuing here. To create/format the texts automatically, please use the
  #    the <lib_shtpl_arg()> function. You can find its documentation in
  #    '/lib/SHtemplateLIB/lib/shtpl.0.lib.sh'.
  #-----------------------------------------------------------------------------
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                                \
    "$(lib_shtpl_arg --par "ARG_ACTION_HELP")"               "$(lib_shtpl_arg --des "ARG_ACTION_HELP")" " " ""        \
    "$(lib_shtpl_arg --par "ARG_MODE_INTERACTIVE_SUBMENU")"  "$(lib_shtpl_arg --des "ARG_MODE_INTERACTIVE_SUBMENU")

<menu>$(lib_shtpl_arg --list-ptr "arg_action" "INTERACTIVE")" " " ""                                                  \
    "$(lib_shtpl_arg --par "ARG_ACTION_BENCHMARK")"       "$(lib_shtpl_arg --des "ARG_ACTION_BENCHMARK")" " " ""      \
    "$(lib_shtpl_arg --par "ARG_ACTION_CLONE")"           "$(lib_shtpl_arg --des "ARG_ACTION_CLONE")" " " ""          \
    "$(lib_shtpl_arg --par "ARG_ACTION_CLOSE")"           "$(lib_shtpl_arg --des "ARG_ACTION_CLOSE")" " " ""          \
    "$(lib_shtpl_arg --par "ARG_ACTION_ENCRYPT")"         "$(lib_shtpl_arg --des "ARG_ACTION_ENCRYPT")" " " ""        \
    "$(lib_shtpl_arg --par "ARG_ACTION_ENROLL")"          "$(lib_shtpl_arg --des "ARG_ACTION_ENROLL")" " " ""         \
    "$(lib_shtpl_arg --par "ARG_ACTION_HEADER_BACKUP")"   "$(lib_shtpl_arg --des "ARG_ACTION_HEADER_BACKUP")" " " ""  \
    "$(lib_shtpl_arg --par "ARG_ACTION_HEADER_INFO")"     "$(lib_shtpl_arg --des "ARG_ACTION_HEADER_INFO")" " " ""    \
    "$(lib_shtpl_arg --par "ARG_ACTION_HEADER_RESTORE")"  "$(lib_shtpl_arg --des "ARG_ACTION_HEADER_RESTORE")" " " "" \
    "$(lib_shtpl_arg --par "ARG_ACTION_IS_LUKS_DEVICE")"  "$(lib_shtpl_arg --des "ARG_ACTION_IS_LUKS_DEVICE")" " " "" \
    "$(lib_shtpl_arg --par "ARG_ACTION_LIST_TOKEN")"      "$(lib_shtpl_arg --des "ARG_ACTION_LIST_TOKEN")

$(lib_shtpl_arg --list-des "arg_auth" "LIST_TOKEN")" " " ""                                                           \
    "$(lib_shtpl_arg --par "ARG_ACTION_OPEN")"            "$(lib_shtpl_arg --des "ARG_ACTION_OPEN")" " " ""           \
    "$(lib_shtpl_arg --par "ARG_ACTION_REMOVE")"          "$(lib_shtpl_arg --des "ARG_ACTION_REMOVE")" " " ""         \
    "$(lib_shtpl_arg --par "ARG_ACTION_REPLACE")"         "$(lib_shtpl_arg --des "ARG_ACTION_REPLACE")" " " ""        \
    "$(lib_shtpl_arg --par "ARG_ACTION_SHOW_DRIVES")"     "$(lib_shtpl_arg --des "ARG_ACTION_SHOW_DRIVES")"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                DONE: DEFINE YOUR SYNOPSIS (ACTION) TEXT HERE
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (OPTION)
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #                DONE: DEFINE YOUR SYNOPSIS (OPTION) TEXT HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  NOTE:
  #    Please define your help texts in '/src/lang/run.<...>.lang.sh' before
  #    continuing here. To create/format the texts automatically, please use the
  #    the <lib_shtpl_arg()> function. You can find its documentation in
  #    '/lib/SHtemplateLIB/lib/shtpl.0.lib.sh'.
  #-----------------------------------------------------------------------------
  eval lib_msg_print_heading -211 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_OPTION}\"

  #  ACTION := { --enroll | --open | --remove | --replace }
  lib_msg_print_heading -301 "ACTION := { --enroll | --open | --remove | --replace }"
  lib_msg_print_propvalue "--left" "--left" "2" "" " " \
    "$(lib_shtpl_arg --par "arg_auth")"       "$(lib_shtpl_arg --list-des-def "arg_auth")"

  #  ACTION := { --enroll | --open | --replace }
  lib_msg_print_heading -311 "ACTION := { --enroll | --open | --replace }"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                              \
    "$(lib_shtpl_arg --par "arg_fido2_device")"     "$(lib_shtpl_arg --list-des-def "arg_fido2_device")" " " ""     \
    "$(lib_shtpl_arg --par "arg_pkcs11_token_uri")" "$(lib_shtpl_arg --list-des-def "arg_pkcs11_token_uri")" " " "" \
    "$(lib_shtpl_arg --par "arg_tpm2_device")"      "$(lib_shtpl_arg --list-des-def "arg_tpm2_device")"

  #  ACTION := { --enroll | --replace }
  lib_msg_print_heading -311 "ACTION := { --enroll | --replace }"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                              \
    "$(lib_shtpl_arg --par "arg_with_pin")"     "$(lib_shtpl_arg --list-des "arg_with_pin")" " " "" \
    "$(lib_shtpl_arg --par "arg_tpm2_pcrs")"    "$(lib_shtpl_arg --des-def "arg_tpm2_pcrs")"

  #  ACTION := { --encrypt | --open }
  lib_msg_print_heading -311 "ACTION := { --encrypt | --open }"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                        \
    "$(lib_shtpl_arg --par "arg_filesystem")"       "$(lib_shtpl_arg --des "arg_filesystem")

(default '$(lib_shtpl_arg --par "ARG_ACTION_ENCRYPT")': ${ARG_FILESYSTEM_ENCRYPT})
(default '$(lib_shtpl_arg --par "ARG_ACTION_OPEN")': ${ARG_FILESYSTEM_OPEN})" " " ""          \
    "$(lib_shtpl_arg --par "arg_mapper")"           "$(lib_shtpl_arg --des "arg_mapper")

(default: '<device>_crypt', e.g. 'sdz_crypt')"

  #  ACTION := --encrypt
  lib_msg_print_heading -311 "ACTION := --encrypt"
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                            \
    "$(lib_shtpl_arg --par "arg_cipher")"     "$(lib_shtpl_arg --des-def "arg_cipher")" " " ""    \
    "$(lib_shtpl_arg --par "arg_hash")"       "$(lib_shtpl_arg --des-def "arg_hash")" " " ""      \
    "$(lib_shtpl_arg --par "arg_iter_time")"  "$(lib_shtpl_arg --des-def "arg_iter_time")" " " "" \
    "$(lib_shtpl_arg --par "arg_key_size")"   "$(lib_shtpl_arg --des-def "arg_key_size")"

  #  ACTION := --open
  lib_msg_print_heading -311 "ACTION := --open"
  lib_msg_print_propvalue "--left" "--left" "2" "" " " \
    "$(lib_shtpl_arg --par "arg_mount")"      "$(lib_shtpl_arg --des "arg_mount")

(default: '/mnt/mapper/($(lib_shtpl_arg --par "arg_mapper"))')"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                DONE: DEFINE YOUR SYNOPSIS (OPTION) TEXT HERE
  #-----------------------------------------------------------------------------
}

#===  FUNCTION  ================================================================
#         NAME:  info
#  DESCRIPTION:  Log/Print info message and optionally exit
#          ...:  See <msg()>
#===============================================================================
info() {
  msg --info "$@"
}

#===  FUNCTION  ================================================================
#         NAME:  init_check_pre
#  DESCRIPTION:  Check script requirements (before argument parsing)
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  All mandatory requirements are fulfilled
#            1:  At least one mandatory requirement is not fulfilled
#===============================================================================
init_check_pre() {
  #=============================================================================
  #  Mandatory (= script will break on error)
  #=============================================================================
  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  lib_core_is --cmd-su "cryptsetup" "mkfs"                                  && \
  lib_core_is --cmd "dd" "lsblk" "pv" "sha1sum" "sudo"                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  { error "${TXT_INIT_CHECK_ERR}"
    return 1
  }

  #=============================================================================
  #  Optional (= script will continue on error)
  #=============================================================================
  local optionalFulfilled="true"
  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  Check for and get 'systemd-cryptsetup' command
  { lib_core_is --cmd-su "${CMD_SYSTEMD_CRYPTSETUP_CMD}" 2>/dev/null  && \
    cmd_systemd_cryptsetup="${CMD_SYSTEMD_CRYPTSETUP_CMD}"
  }                                                                         || \
  { lib_core_is --file "${CMD_SYSTEMD_CRYPTSETUP_BIN}"                && \
    cmd_systemd_cryptsetup="${CMD_SYSTEMD_CRYPTSETUP_BIN}"
  }                                                                         || \
  optionalFulfilled="false"

  #  Check for and get 'systemd-cryptenroll' command
  lib_core_is --cmd-su "${CMD_SYSTEMD_CRYPTENROLL_CMD}" 2>/dev/null         && \
  cmd_systemd_cryptenroll="${CMD_SYSTEMD_CRYPTENROLL_CMD}"                  || \
  optionalFulfilled="false"

  #  Check FIDO2 support
  local systemd_fido2_supported="false"
  lib_os_lib --exists "${FILE_SO_LIBFIDO2}"                                 && \
  systemd_fido2_supported="true"                                            || \
  optionalFulfilled="false"

  #  Check PKCS#11 support
  local pkcs11_supported="false"
  lib_os_lib --exists "${FILE_SO_LIBCCIDTWIN}" "${FILE_SO_PKCS11_OPENSC}"   && \
  if ! service pcscd status >/dev/null 2>&1; then
    lib_core_sudo service pcscd start
  fi                                                                        && \
  pkcs11_supported="true"                                                   || \
  optionalFulfilled="false"

  #  Check TPM2 support
  local systemd_tpm2_supported="false"
  lib_os_lib --exists "${FILE_SO_LIBTSS2_ESYS}"                             && \
  lib_os_lib --exists "${FILE_SO_LIBTSS2_RC}"                               && \
  systemd_tpm2_supported="true"                                             || \
  optionalFulfilled="false"

  #  Update list of allowed authentication mechanisms
  if lib_core_is --set "${cmd_systemd_cryptenroll}"; then
    ARG_AUTH_LIST="${ARG_AUTH_LIST} RECOVERY"
    if ${systemd_fido2_supported}; then
      ARG_AUTH_LIST="${ARG_AUTH_LIST} FIDO2"
      ARG_AUTH_LIST_LIST_TOKEN="${ARG_AUTH_LIST_LIST_TOKEN}${ARG_AUTH_LIST_LIST_TOKEN:+ }FIDO2"
    fi
    if ${pkcs11_supported}; then
      ARG_AUTH_LIST="${ARG_AUTH_LIST} PKCS11"
      ARG_AUTH_LIST_LIST_TOKEN="${ARG_AUTH_LIST_LIST_TOKEN}${ARG_AUTH_LIST_LIST_TOKEN:+ }PKCS11"
    fi
    if ${systemd_tpm2_supported}; then
      ARG_AUTH_LIST="${ARG_AUTH_LIST} TPM2"
      ARG_AUTH_LIST_LIST_TOKEN="${ARG_AUTH_LIST_LIST_TOKEN}${ARG_AUTH_LIST_LIST_TOKEN:+ }TPM2"
    fi
  fi
  readonly ARG_AUTH_LIST="${ARG_AUTH_LIST}"
  readonly ARG_AUTH_LIST_LIST_TOKEN="${ARG_AUTH_LIST_LIST_TOKEN}"

  #  Update list of allowed authentication mechanisms
  if lib_core_is --set "${cmd_systemd_cryptsetup}"; then
    if ${systemd_fido2_supported}; then
      ARG_AUTH_LIST_OPEN="${ARG_AUTH_LIST_OPEN} FIDO2"
    fi
    if ${pkcs11_supported}; then
      ARG_AUTH_LIST_OPEN="${ARG_AUTH_LIST_OPEN} PKCS11"
    fi
    if ${systemd_tpm2_supported}; then
      ARG_AUTH_LIST_OPEN="${ARG_AUTH_LIST_OPEN} TPM2"
    fi
  fi
  readonly ARG_AUTH_LIST_OPEN="${ARG_AUTH_LIST_OPEN}"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  if ! ${optionalFulfilled}; then
    warning "${TXT_INIT_CHECK_WARN}"
    sleep 3
  fi
}

#===  FUNCTION  ================================================================
#         NAME:  init_check_post
#  DESCRIPTION:  Check script requirements (after argument parsing)
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  All mandatory requirements are fulfilled
#            1:  At least one mandatory requirement is not fulfilled
#===============================================================================
init_check_post() {
  #=============================================================================
  #  Mandatory (= script will break on error)
  #=============================================================================
  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  # Check for running log service (except when terminal is the only destination)
  case "${arg_logdest}" in
    ${ARG_LOGDEST_BOTH}|${ARG_LOGDEST_SYSLOG})
      service log status >/dev/null 2>&1        || \
      service rsyslog status >/dev/null 2>&1    || \
      service syslog-ng status >/dev/null 2>&1  || \
      lib_msg_message --terminal --error "${TXT_INIT_CHECK_ERR_LOGSERVICE}"
      ;;
    ${ARG_LOGDEST_TERMINAL})
      ;;
    *)
      lib_msg_message --terminal --error "${TXT_INVALID_ARG_1} <${arg_logdest}> ${TXT_INVALID_ARG_2} [${L_LUKS_HLP_PAR_ARG_LOGDEST}]. ${LIB_SHTPL_EN_TXT_HELP} ${LIB_SHTPL_EN_TXT_ABORTING}"
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  true                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  { error "${TXT_INIT_CHECK_ERR}"
    return 1
  }

  #=============================================================================
  #  Optional (= script will continue on error)
  #=============================================================================
  local optionalFulfilled="true"
  #-----------------------------------------------------------------------------
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  true                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        DONE: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
  optionalFulfilled="false"
  if ! ${optionalFulfilled}; then
    warning "${TXT_INIT_CHECK_WARN}"
    sleep 3
  fi
}

#===  FUNCTION  ================================================================
#         NAME:  init_first
#  DESCRIPTION:  Lock the script (PID file) or initialize instance counter,
#                set default log destination, and install trap handler
#      OUTPUTS:  In case of ...
#                  success : An info message with the script's PID to <syslog>
#                            (only if script is NOT run within a terminal)
#                    error : An error message to either <stderr> or <syslog>
#   RETURNS  0:  Success
#            1:  Error
#===============================================================================
init_first() {
  if ${PIDLOCK_ENABLED}; then
    #  PID lock (to prevent further instances) or ...
    lib_os_ps_pidlock --lock
  else
    # ... instance counter (used to check if this script was called recursively)
    readonly INSTANCES="$(lib_core_file_get --name "$0")_instances" && \
    eval "export ${INSTANCES}=$(( ${INSTANCES} + 1 ))"
  fi                                                                        && \

  #  Set default log destination (can be overwritten in <args_read()>)
  if lib_core_is --terminal-stdin || lib_core_is --terminal-stdout; then
    arg_logdest="${ARG_LOGDEST_TERMINAL}"
  else
    arg_logdest="${ARG_LOGDEST_SYSLOG}"
  fi                                                                        && \

  #  Install trap handlers
  local sig                                                                 && \
  for sig in EXIT HUP INT QUIT TERM; do
    #---------------------------------------------------------------------------
    #       DONE: ADD FURTHER TRAP PARAMETERS HERE (and in <trap_main()>)
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    #  Please make sure to escape your variable and put it in escaped quotes,
    #  e.g. for variable <var> use: \"\${var}\"
    trap "{
      trap_main                                                     \
        \"${sig}\"          \"true\"            \"\${I_DIR_PID}\"   \
        \"\${I_EXT_PID}\"   \"\${arg_mode}\"
    }" ${sig}
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #       DONE: ADD FURTHER TRAP PARAMETERS HERE (and in <trap_main()>)
    #---------------------------------------------------------------------------
  done                                                                      && \

  #  Get PID (if PID lock is disabled, then <lib_os_ps_pidlock()> will fail.)
  local pid                                                                 && \
  { pid="$(lib_os_ps_pidlock --getpid)" || \
    lib_os_ps_get_ownpid pid
  }                                                                         && \

  #-----------------------------------------------------------------------------
  #                       DONE: ADD FURTHER COMMANDS HERE
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                       DONE: ADD FURTHER COMMANDS HERE
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #-----------------------------------------------------------------------------

  #  Print/Log
  info --syslog "${TXT_INIT_FIRST_INFO} (PID <${pid}>)."
}

#===  FUNCTION  ================================================================
#         NAME:  init_lang
#  DESCRIPTION:  Set language-specific text constants
#      GLOBALS:  ID_LANG  ... (see 'eval ...' commands below)
#===============================================================================
init_lang() {
  ID_LANG="$(lib_os_get --lang)"

  #=============================================================================
  #  Supported Languages
  #=============================================================================
  #-----------------------------------------------------------------------------
  #            DONE: ADD SUPPORTED LANGUAGES HERE (ISO 639-1 CODES)
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  case "${ID_LANG}" in
    ${LIB_C_ID_LANG_EN}) readonly ID_LANG="${LIB_C_ID_L_EN}";;
    ${LIB_C_ID_LANG_DE}) readonly ID_LANG="${LIB_C_ID_L_DE}";;
    *) readonly ID_LANG="${LIB_C_ID_L_EN}";;
  esac
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #            DONE: ADD SUPPORTED LANGUAGES HERE (ISO 639-1 CODES)
  #-----------------------------------------------------------------------------

  #=============================================================================
  #  CUSTOM
  #=============================================================================
  #-----------------------------------------------------------------------------
  #         DONE: PUBLISH YOUR CUSTOM LANGUAGE-SPECIFIC STRINGS <L_...>
  #               (DEFINED IN '/src/lang/run.<ll>.lang.sh') HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  eval "readonly TXT_ABORTING=\${LIB_SHTPL_${ID_LANG}_TXT_ABORTING}"

  eval "readonly TXT_ARG_AUTH_NOT_SUPPORTED=\${L_LUKS_${ID_LANG}_TXT_ARG_AUTH_NOT_SUPPORTED}"
  eval "readonly TXT_CLONE_ERROR=\${L_LUKS_${ID_LANG}_TXT_CLONE_ERROR}"
  eval "readonly TXT_CLONE_INFO_CHECKSUM=\${L_LUKS_${ID_LANG}_TXT_CLONE_INFO_CHECKSUM}"
  eval "readonly TXT_CLONE_INFO_CLONED=\${L_LUKS_${ID_LANG}_TXT_CLONE_INFO_CLONED}"
  eval "readonly TXT_CLONE_INFO_CLONING=\${L_LUKS_${ID_LANG}_TXT_CLONE_INFO_CLONING}"
  eval "readonly TXT_ENCRYPT_INFO=\${L_LUKS_${ID_LANG}_TXT_ENCRYPT_INFO}"
  eval "readonly TXT_ENROLL_INFO=\${L_LUKS_${ID_LANG}_TXT_ENROLL_INFO}"
  eval "readonly TXT_ERROR_DEFAULT=\${L_LUKS_${ID_LANG}_TXT_ERROR_DEFAULT}"
  eval "readonly TXT_ERROR_IDENTICAL_DEVS=\${L_LUKS_${ID_LANG}_TXT_ERROR_IDENTICAL_DEVS}"
  eval "readonly TXT_HEADER_BACKUP_INFO=\${L_LUKS_${ID_LANG}_TXT_HEADER_BACKUP_INFO}"
  eval "readonly TXT_MSG_INFO_HEADER_INFO_CHANGED=\${L_LUKS_${ID_LANG}_TXT_MSG_INFO_HEADER_INFO_CHANGED}"
  eval "readonly TXT_HEADER_RESTORE_INFO=\${L_LUKS_${ID_LANG}_TXT_HEADER_RESTORE_INFO}"
  eval "readonly TXT_MSG_INFO_HEADER_INFO_BACKUP=\${L_LUKS_${ID_LANG}_TXT_MSG_INFO_HEADER_INFO_BACKUP}"
  eval "readonly TXT_MSG_WARN_HEADER_INFO=\${L_LUKS_${ID_LANG}_TXT_MSG_WARN_HEADER_INFO}"
  eval "readonly TXT_MSG_WARN_HEADER_WARN=\${L_LUKS_${ID_LANG}_TXT_MSG_WARN_HEADER_WARN}"
  eval "readonly TXT_MSG_WARN_LSBLK_INFO_ENCRYPTING=\${L_LUKS_${ID_LANG}_TXT_MSG_WARN_LSBLK_INFO_ENCRYPTING}"
  eval "readonly TXT_MSG_WARN_LSBLK_WARN=\${L_LUKS_${ID_LANG}_TXT_MSG_WARN_LSBLK_WARN}"
  eval "readonly TXT_OPEN_INFO_MOUNTED=\${L_LUKS_${ID_LANG}_TXT_OPEN_INFO_MOUNTED}"
  eval "readonly TXT_OPEN_INFO_MOUNTING=\${L_LUKS_${ID_LANG}_TXT_OPEN_INFO_MOUNTING}"
  eval "readonly TXT_OPEN_INFO_OPENED=\${L_LUKS_${ID_LANG}_TXT_OPEN_INFO_OPENED}"
  eval "readonly TXT_OPEN_INFO_OPENING=\${L_LUKS_${ID_LANG}_TXT_OPEN_INFO_OPENING}"
  eval "readonly TXT_REMOVE_INFO=\${L_LUKS_${ID_LANG}_TXT_REMOVE_INFO}"
  eval "readonly TXT_REPLACE_INFO=\${L_LUKS_${ID_LANG}_TXT_REPLACE_INFO}"
  eval "readonly TXT_UNMOUNT_ERROR=\${L_LUKS_${ID_LANG}_TXT_UNMOUNT_ERROR}"
  eval "readonly TXT_UNMOUNT_INFO_CLOSED=\${L_LUKS_${ID_LANG}_TXT_UNMOUNT_INFO_CLOSED}"
  eval "readonly TXT_UNMOUNT_INFO_CLOSING=\${L_LUKS_${ID_LANG}_TXT_UNMOUNT_INFO_CLOSING}"
  eval "readonly TXT_UNMOUNT_INFO_UNMOUNTED=\${L_LUKS_${ID_LANG}_TXT_UNMOUNT_INFO_UNMOUNTED}"
  eval "readonly TXT_UNMOUNT_INFO_UNMOUNTING=\${L_LUKS_${ID_LANG}_TXT_UNMOUNT_INFO_UNMOUNTING}"
  #-----------------------------------------------------------------------------
  #                                    /|\
  #                                   /|||\
  #                                    |||
  #
  #         DONE: PUBLISH YOUR CUSTOM LANGUAGE-SPECIFIC STRINGS <L_...>
  #               (DEFINED IN '/src/lang/run.<ll>.lang.sh') HERE
  #-----------------------------------------------------------------------------

  #=============================================================================
  #  TEMPLATE - DO NOT EDIT
  #=============================================================================
  eval "readonly TXT_ARGS_CHECK_ERR=\${LIB_SHTPL_${ID_LANG}_TXT_ARGS_CHECK_ERR}"
  eval "readonly TXT_ARGS_READ_ERR=\${LIB_SHTPL_${ID_LANG}_TXT_ARGS_READ_ERR}"
  eval "readonly TXT_CONTINUE_ENTER=\${LIB_SHTPL_${ID_LANG}_TXT_CONTINUE_ENTER}"
  eval "readonly TXT_CONTINUE_YESNO=\${LIB_SHTPL_${ID_LANG}_TXT_CONTINUE_YESNO}"
  eval "readonly TXT_INIT_CHECK_ERR=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_CHECK_ERR}"
  eval "readonly TXT_INIT_CHECK_ERR_LOGSERVICE=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_CHECK_ERR_LOGSERVICE}"
  eval "readonly TXT_INIT_CHECK_WARN=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_CHECK_WARN}"
  eval "readonly TXT_INIT_FIRST_INFO=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_FIRST_INFO}"
  eval "readonly TXT_INIT_UPDATE_ERR=\${LIB_SHTPL_${ID_LANG}_TXT_INIT_UPDATE_ERR}"
  eval "readonly TXT_INVALID_ARG_1=\${LIB_SHTPL_${ID_LANG}_TXT_INVALID_ARG_1}"
  eval "readonly TXT_INVALID_ARG_2=\${LIB_SHTPL_${ID_LANG}_TXT_INVALID_ARG_2}"
  eval "readonly TXT_PROCESSING=\${LIB_SHTPL_${ID_LANG}_TXT_PROCESSING}"
}

#===  FUNCTION  ================================================================
#         NAME:  init_update
#  DESCRIPTION:  Update global variables/constants and perform initialisation
#                commands that should be executed after argument parsing
#      GLOBALS:  arg_cipher  arg_filesystem  arg_key_size  arg_mapper  arg_mount
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  Success
#            1:  Error
#===============================================================================
init_update() {
  #-----------------------------------------------------------------------------
  #                   DONE: DEFINE YOUR UPDATE COMMANDS HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  #  Set default cipher depending on if CPU supports AES-NI
  #-----------------------------------------------------------------------------
  if lib_os_cpu_has_feature "aes"; then
    arg_cipher="${arg_cipher:-${ARG_CIPHER_WITH_AESNI}}"
  else
    arg_cipher="${arg_cipher:-${ARG_CIPHER_WITHOUT_AESNI}}"
  fi                                                                        && \

  case "${arg_cipher}" in
    *xts*) arg_key_size="${arg_key_size:-${ARG_KEY_SIZE_WITH_XTS}}" ;;
    *) arg_key_size="${arg_key_size:-${ARG_KEY_SIZE_WITHOUT_XTS}}" ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Set default device mapper, filesystem, and mountpoint
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ENCRYPT}|${ARG_ACTION_OPEN})
      arg_mapper="${arg_mapper:-$(basename "${arg_device_src}")_crypt}"
      ;;
  esac                                                                      && \

  case "${arg_action}" in
    ${ARG_ACTION_ENCRYPT})
      arg_filesystem="${arg_filesystem:-${ARG_FILESYSTEM_ENCRYPT}}"
      ;;
    ${ARG_ACTION_OPEN})
      arg_filesystem="${arg_filesystem:-${ARG_FILESYSTEM_OPEN}}"
      if ${mount}; then arg_mount="${arg_mount:-/mnt/mapper/${arg_mapper}}"; fi
      ;;
  esac                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                   DONE: DEFINE YOUR UPDATE COMMANDS HERE
  #-----------------------------------------------------------------------------
  { error "${TXT_INIT_UPDATE_ERR}"
    return 1
  }
}

#===  FUNCTION  ================================================================
#         NAME:  main
#  DESCRIPTION:  Main function
#      OUTPUTS:  (See functions listed below)

#                In case an error occurs during <init_...()> or <args_...()>:
#                  An error message will be printed to <stderr> and/or <syslog>,
#                  the script's help will be automatically shown, and the script
#                  exits with '1'.
#
#      RETURNS:  (See functions listed below)
#===============================================================================
main() {
  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  #   init_lang         Set language-specific text constants
  #
  #   init_first        Set default log destination, lock the script (PID file)
  #                     install trap handler and run other commands that need
  #                     to be executed right at the beginning
  #
  #   init_check_pre    Check script requirements (before argument parsing)
  #
  #   args_read         Read/Parse arguments
  #
  #   args_check        Check if passed arguments are valid
  #
  #   init_update       Update global variables/constants and perform
  #                     initialisation commands that should be executed after
  #                     argument parsing
  #
  #   init_check_post   Check script requirements (after argument parsing)
  #
  #   main_daemon       Main subfunction (daemon mode)
  #   main_interactive  Main subfunction (interactive / submenu mode)
  #   main_script       Main subfunction (script mode)
  #-----------------------------------------------------------------------------
  init_lang                                                                 && \
  init_first                                                                && \
  init_check_pre                                                            && \
  args_read "$@"                                                            && \
  case "${arg_mode}" in
    ${ARG_MODE_DAEMON}|${ARG_MODE_INTERACTIVE_SUBMENU}|${ARG_MODE_SCRIPT})
      args_check      && \
      init_update     && \
      init_check_post
      ;;
    ${ARG_MODE_INTERACTIVE})
      # For further init functions see <main_interactive()>
      lib_core_is --cmd dialog || \
      error "${TXT_INIT_CHECK_ERR}"
      ;;
  esac                                                                      || \

  # If any error occurred show help but wait some seconds before
  # (to allow the user to read error/warning messages)
  { lib_core_is --terminal-stdout && { sleep 3; help; }; return 1; }

  # Run mode-specific subfunctions
  case "${arg_mode}" in
    ${ARG_MODE_DAEMON}) main_daemon;;
    ${ARG_MODE_INTERACTIVE}|${ARG_MODE_INTERACTIVE_SUBMENU}) main_interactive || return $?;;
    ${ARG_MODE_SCRIPT}) main_script;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  main_daemon
#  DESCRIPTION:  Main subfunction (daemon mode)
#===============================================================================
main_daemon() {
  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  # Create subshell PID directory (removed in <trap_main()>)
  lib_core_sudo mkdir -p "${I_DIR_PID}"                                     || \
  { error "Could not create subshell PID directory at <${I_DIR_PID}>. Aborting..."
    return 1
  }

  #-----------------------------------------------------------------------------
  #             DONE: DEFINE YOUR MAIN FUNCTION (DAEMON MODE) HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  return
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #             DONE: DEFINE YOUR MAIN FUNCTION (DAEMON MODE) HERE
  #-----------------------------------------------------------------------------
}

#===  FUNCTION  ================================================================
#         NAME:  main_interactive
#  DESCRIPTION:  Main subfunction (interactive / submenu mode)
#===============================================================================
main_interactive() {
  # Check for minimum terminal size (otherwise some dialogues would fail)
  lib_msg_dialog_autosize >/dev/null                                        && \

  # Show welcome message (but not in submenu mode)
  if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
    lib_shtpl_about --dialog
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #          DONE: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  true                                                                      && \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #          DONE: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #-----------------------------------------------------------------------------

  if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
    #---------------------------------------------------------------------------
    #         DONE: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
    #                     EXCEPT WHEN BEING IN SUBMENU MODE
    #                  (DO NOT FORGET THE TERMINATING '&& \')
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    true && \
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #         DONE: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
    #                     EXCEPT WHEN BEING IN SUBMENU MODE
    #                  (DO NOT FORGET THE TERMINATING '&& \')
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    #  DO NOT EDIT
    #---------------------------------------------------------------------------
    args_check          && \
    init_update         && \
    init_check_post
  fi                                                                        && \

  # Endless loop until user exits
  local exitcode                                                            && \
  while menu_main || { clear; false; }; do
    exitcode="0"
    case "${arg_action}" in
      "")
        # See comment at the end of menu_main() function
        if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE_SUBMENU}" ]; then
          # 'submenu' mode: user has cancelled 'dialog' so exit with error
          return 2
        else
          # other modes: run cleanup procedure and get back to main menu
          cleanup_interactive
          continue
        fi
        ;;

      #-------------------------------------------------------------------------
      #    DONE: ADD <ARG_ACTION_...> WHERE PROMPT TO CONTINUE IS NOT NEEDED
      #
      #                                   |||
      #                                  \|||/
      #                                   \|/
      #-------------------------------------------------------------------------
      ${ARG_ACTION_ABOUT}|${ARG_ACTION_HELP}|${ARG_ACTION_EXIT})
        run || exitcode="$?"
        ;;
      #-------------------------------------------------------------------------
      #                                   /|\
      #                                  /|||\
      #                                   |||
      #
      #    DONE: ADD <ARG_ACTION_...> WHERE PROMPT TO CONTINUE IS NOT NEEDED
      #-------------------------------------------------------------------------

      *)
        # Run a certain command and prompt the user to continue
        clear
        lib_msg_print_heading -201 "${TXT_PROCESSING}"
        run || exitcode="$?"
        # No prompt in submenu mode
        if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
          lib_msg_print_heading -2 "${TXT_CONTINUE_ENTER}"
          read -r dummy
        fi
        ;;
    esac

    # Submenu mode means "run a certain sub-menu and exit"
    [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE_SUBMENU}" ] && return ${exitcode}

    # Run cleanup procedure
    cleanup_interactive
  done
}

#===  FUNCTION  ================================================================
#         NAME:  main_script
#  DESCRIPTION:  Main subfunction (script mode)
#===============================================================================
main_script() {
  run
}

#===  FUNCTION  ================================================================
#         NAME:  msg
#  DESCRIPTION:  Log/Print error/info/warning message and optionally exit
#          ...:  See <lib_shtpl_message()> in
#                '/lib/SHtemplateLIB/lib/shtpl.0.lib.sh'
#===============================================================================
msg() {
  lib_shtpl_message "$@"
}

#===  FUNCTION  ================================================================
#         NAME:  run
#  DESCRIPTION:  Perform one certain action (cycle)
#      OUTPUTS:  Depends on <arg_action>
#      RETURNS:  Depends on <arg_action>
#===============================================================================
run() {
  case "${arg_action}" in
    #---------------------------------------------------------------------------
    #  TEMPLATE - DO NOT EDIT
    #---------------------------------------------------------------------------
    ${ARG_ACTION_ABOUT})        lib_shtpl_about --dialog;;
    ${ARG_ACTION_EXIT})         clear; exit;;
    ${ARG_ACTION_HELP})         help;;

    #---------------------------------------------------------------------------
    #  CUSTOM
    #---------------------------------------------------------------------------
    #---------------------------------------------------------------------------
    #               DONE: ADD YOUR ACTION-SPECIFIC COMMANDS HERE
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    *)
      #  Close/Unmount <arg_device_src> in case it it still open/mounted
      case "${arg_action}" in
        ${ARG_ACTION_CLONE}|${ARG_ACTION_CLOSE}|${ARG_ACTION_ENCRYPT}|\
        ${ARG_ACTION_ENROLL}|${ARG_ACTION_HEADER_RESTORE}|${ARG_ACTION_OPEN}|\
        ${ARG_ACTION_REMOVE}|${ARG_ACTION_REPLACE})
          lib_core_is --blockdevice "${arg_device_src}" && \
          unmount "${arg_device_src}"
          ;;
      esac                                                                  && \

      #  Call action-dependent function
      case "${arg_action}" in
        ${ARG_ACTION_BENCHMARK})      benchmark ;;
        ${ARG_ACTION_CLONE})          clone ;;
        ${ARG_ACTION_CLOSE})          ;; # no function needed as closing is done above
        ${ARG_ACTION_ENCRYPT})        encrypt ;;
        ${ARG_ACTION_ENROLL})         enroll ;;
        ${ARG_ACTION_HEADER_BACKUP})  header_backup ;;
        ${ARG_ACTION_HEADER_INFO})    header_info ;;
        ${ARG_ACTION_HEADER_RESTORE}) header_restore ;;
        ${ARG_ACTION_IS_LUKS_DEVICE}) is_luks_device ;;
        ${ARG_ACTION_LIST_TOKEN})     list_token ;;
        ${ARG_ACTION_OPEN})           open ;;
        ${ARG_ACTION_REMOVE})         remove ;;
        ${ARG_ACTION_REPLACE})        replace ;;
        ${ARG_ACTION_SHOW_DRIVES})    show_drives ;;
      esac                                                                  || \

      { msg_error_with_params
        return 1
      }
      ;;
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #               DONE: ADD YOUR ACTION-SPECIFIC COMMANDS HERE
    #---------------------------------------------------------------------------
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  trap_main
#  DESCRIPTION:  Trap (cleanup and exit) function for this script
#      GLOBALS:  trap_triggered
# PARAMETER  1:  Signal (EXIT|HUP|INT|QUIT|TERM|...)
#            2:  Kill subshells / child processes? (true|false)
#                (default: 'true')
#            3:  Subshell(s) PID directory
#                (default: '/var/run/$(basename "$0")')
#            4:  Subshell(s) PID file extension (default: 'pid')
#            5:  Operation mode (see <arg_mode> above)
#===============================================================================
trap_main() {
  local arg_signal="${1:-${trap_main_arg_signal}}"
  local arg_sub_kill="${2:-${trap_main_arg_sub_kill:-true}}"
  local arg_sub_pid_dir="${3:-${trap_main_arg_sub_pid_dir:-/var/run/$(basename "$0")}}"
  local arg_sub_pid_ext="${4:-${trap_main_arg_sub_pid_ext:-pid}}"
  local arg_mode="${5:-${trap_main_arg_mode}}"

  #-----------------------------------------------------------------------------
  #       DONE: ADD FURTHER TRAP PARAMETERS HERE (AND IN <init_first()>)
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  IMPORTANT: For each parameter please set its temporary variable (see below,
  #             in the next 'TODO' section) as the default value, e.g.
  #               local arg_myparam="${3:-${trap_main_arg_myparam}}"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #       DONE: ADD FURTHER TRAP PARAMETERS HERE (AND IN <init_first()>)
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  #  Do not run trap handling immediately if it was previously blocked
  trap_triggered="true"
  if ${trap_blocked}; then
    #  Do not continue trap function but save the trap arguments for the next
    #  run (then the trap is manually triggered so probably no arguments will
    #  be passed and therefore need to be restored from the temporary variables)
    trap_main_arg_signal="${arg_signal}"
    trap_main_arg_sub_kill="${arg_sub_kill}"
    trap_main_arg_sub_pid_dir="${arg_sub_pid_dir}"
    trap_main_arg_sub_pid_ext="${arg_sub_pid_ext}"
    trap_main_arg_mode="${arg_mode}"

    #---------------------------------------------------------------------------
    #          DONE: FOR EACH ADDITIONAL TRAP PARAMETER DEFINED ABOVE
    #                    ADD ANOTHER TEMPORARY VARIABLE HERE
    #
    #                                     |||
    #                                    \|||/
    #                                     \|/
    #---------------------------------------------------------------------------
    #  Example: For <arg_myparam> add the following line:
    #             trap_main_arg_myparam="${arg_myparam}"
    #---------------------------------------------------------------------------
    #                                     /|\
    #                                    /|||\
    #                                     |||
    #
    #          DONE: FOR EACH ADDITIONAL TRAP PARAMETER DEFINED ABOVE
    #                    ADD ANOTHER TEMPORARY VARIABLE HERE
    #---------------------------------------------------------------------------

    return
  fi

  #  Get PID (if PID lock is disabled ("PIDLOCK_ENABLED"="false"), then
  #  <lib_os_ps_pidlock()> will fail.)
  local pid
  pid="$(lib_os_ps_pidlock --getpid)" || \
  lib_os_ps_get_ownpid pid
  info --syslog "Signal <${arg_signal}> received. Terminating (PID <${pid}>) ..."

  # Special Trap Handling
  case "${arg_mode}" in
    #---------------------------------------------------------------------------
    #          DONE: DEFINE MODE(S) THAT HAVE NO SPECIAL TRAP HANDLING
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    ${ARG_MODE_DAEMON})
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #          DONE: DEFINE MODE(S) THAT HAVE NO SPECIAL TRAP HANDLING
    #---------------------------------------------------------------------------
      ;;

    *)
      # Modes with special trap handling
      case "${arg_signal}" in
        EXIT)
          #---------------------------------------------------------------------
          #          DONE: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #             IN CASE OF A NORMAL EXIT (NO OTHER SIGNAL)
          #
          #                                 |||
          #                                \|||/
          #                                 \|/
          #---------------------------------------------------------------------
          #---------------------------------------------------------------------
          #                                 /|\
          #                                /|||\
          #                                 |||
          #
          #          DONE: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #             IN CASE OF A NORMAL EXIT (NO OTHER SIGNAL)
          #---------------------------------------------------------------------
          ;;

        *)
          #---------------------------------------------------------------------
          #          DONE: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #              IN CASE OF ANY INTERRUPT/TERM/... SIGNAL
          #
          #                                 |||
          #                                \|||/
          #                                 \|/
          #---------------------------------------------------------------------
          #---------------------------------------------------------------------
          #                                 /|\
          #                                /|||\
          #                                 |||
          #
          #          DONE: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #              IN CASE OF ANY INTERRUPT/TERM/... SIGNAL
          #---------------------------------------------------------------------
          ;;
      esac
      ;;
  esac

  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  if ${arg_sub_kill}; then
    # SIGINT and SIGQUIT cannot be forwarded to subshells / child processes
    # as they may run in background (asynchronously).
    local sub_signal
    case "${arg_signal}" in
      INT|QUIT) sub_signal="TERM";;
      *)        sub_signal="${arg_signal}";;
    esac

    # Kill subshells / child processes
    local file
    for file in "${arg_sub_pid_dir}"/*."${arg_sub_pid_ext}"; do
      [ -f "${file}" ] || break
      lib_os_ps_kill_by_pidfile \
        "${file}" "${sub_signal}" "false" "true" "true" "false"
    done

    # Kill (other) subshells / child processes
    local subpids
    lib_os_ps_get_descendants subpids "${pid}"
    lib_os_ps_kill_by_pid "${subpids}" "${sub_signal}" "false" "true" "true"

    # Remove subshell PID directory
    if lib_core_is --dir "${arg_sub_pid_dir}"; then
      lib_core_sudo rm -rf "${arg_sub_pid_dir}"
    fi
  fi

  #  Remove (parent) PID file
  #  If PID lock is disabled ("PIDLOCK_ENABLED"="false"), then
  #  <lib_os_ps_pidlock()> will fail but without any consequences.
  lib_os_ps_pidlock --unlock
  info --syslog "Script terminated (PID <${pid}>)."

  #  Exit - Depends on signal ...
  case "${arg_signal}" in
    EXIT)
      # ... EXIT
      exit;;
    *)
      # ... other signals:
      # Clear EXIT trap handling, otherwise <trap_main()> would run again.
      trap - EXIT; exit 1;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  warning
#  DESCRIPTION:  Log/Print warning message and optionally exit
#          ...:  See <msg()>
#===============================================================================
warning() {
  msg --warning "$@"
}

#===============================================================================
#  FUNCTIONS (TEMPLATE) (MENUS)
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_action
#  DESCRIPTION:  Interactive menu for setting <arg_action> parameter
#      GLOBALS:  arg_action
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_action() {
  local tag1="${ARG_ACTION_ABOUT}"
  local tag2="${ARG_ACTION_HELP}"
  local tag3="${ARG_ACTION_EXIT}"

  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_ACTION}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_ACTION}"
  eval "item1=\${LIB_SHTPL_${ID_LANG}_DLG_ITM_ABOUT}"
  eval "item2=\${LIB_SHTPL_${ID_LANG}_DLG_ITM_HELP}"
  eval "item3=\${LIB_SHTPL_${ID_LANG}_DLG_ITM_EXIT}"

  local list
  list="${ARG_ACTION_LIST_INTERACTIVE}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${list}; do
        eval "tag=\${ARG_ACTION_${a}}"
        eval "item=\${L_LUKS_${ID_LANG}_DLG_ITM_ARG_ACTION_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title}" --menu "${text}" 0 0 0  \
      ${dlgpairs}                                               \
      "${tag1}"  "${item1}"                                     \
      "${tag2}"  "${item2}"                                     \
      "${tag3}"  "${item3}" 2>&1 1>&3)"                                     || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_action="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_main
#  DESCRIPTION:  Main menu (interactive mode)
#===============================================================================
menu_main() {
  # Check for minimum terminal size (otherwise some dialogues would fail)
  lib_msg_dialog_autosize >/dev/null                                        || \
  { sleep 3; return 1; }

  # <arg_action> can be already set if script is called with <--submenu ...>
  if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
    menu_arg_action || return
  fi                                                                        && \

  #  Default actions do not depend on any further parameter
  case "${arg_action}" in
    ${ARG_ACTION_ABOUT}|${ARG_ACTION_EXIT}|${ARG_ACTION_HELP}) return;;
  esac                                                                      && \
  #-----------------------------------------------------------------------------
  #                    DONE: DEFINE YOUR MENU HANDLING HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  Only modes that need a <device> parameter
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_CLONE}|${ARG_ACTION_CLOSE}|${ARG_ACTION_ENCRYPT}|\
    ${ARG_ACTION_ENROLL}|${ARG_ACTION_HEADER_BACKUP}|${ARG_ACTION_HEADER_INFO}|\
    ${ARG_ACTION_HEADER_RESTORE}|${ARG_ACTION_OPEN}|${ARG_ACTION_REMOVE}|\
    ${ARG_ACTION_REPLACE})
      menu_arg_device_src
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Set mode-dependent default values
  #-----------------------------------------------------------------------------
  init_update                                                               && \

  #-----------------------------------------------------------------------------
  #  Modes that need a second argument
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_CLONE}) menu_arg_device_dst ;;
    ${ARG_ACTION_HEADER_BACKUP}|${ARG_ACTION_HEADER_RESTORE})
      menu_arg_headerfile
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Only with '--enroll', '--open', '--remove', and '--replace'
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ENROLL}|${ARG_ACTION_OPEN}|${ARG_ACTION_REMOVE}|${ARG_ACTION_REPLACE})
      menu_arg_auth
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Only with '--enroll', '--open', and '--replace'
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ENROLL}|${ARG_ACTION_OPEN}|${ARG_ACTION_REPLACE})
      case "${arg_auth}" in
        ${ARG_AUTH_FIDO2})  menu_arg_fido2_device;;
        ${ARG_AUTH_PKCS11}) menu_arg_pkcs11_token_uri;;
        ${ARG_AUTH_TPM2})   menu_arg_tpm2_device;;
      esac
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Only with '--enroll' or '--replace'
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ENROLL}|${ARG_ACTION_REPLACE})
      case "${arg_auth}" in
        ${ARG_AUTH_FIDO2})  menu_arg_with_pin;;
        ${ARG_AUTH_TPM2})   menu_arg_tpm2_pcrs && menu_arg_with_pin;;
      esac
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Only with '--encrypt' or '--open'
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ENCRYPT}|${ARG_ACTION_OPEN})
      menu_arg_mapper && \
      menu_arg_filesystem
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #  Mode-specific
  #-----------------------------------------------------------------------------
  case "${arg_action}" in
    ${ARG_ACTION_ENCRYPT})
      local cipher_old="${arg_cipher}"                                  && \
      menu_arg_cipher                                                   && \

      # In case cipher was changed reset the default key size value
      if ! [ "${arg_cipher}" = "${cipher_old}" ]; then
        case "${arg_cipher}" in
          *xts*) arg_key_size="${ARG_KEY_SIZE_WITH_XTS}" ;;
          *) arg_key_size="${ARG_KEY_SIZE_WITHOUT_XTS}" ;;
        esac
      fi                                                                && \

      menu_arg_key_size                                                 && \
      menu_arg_hash                                                     && \
      menu_arg_iter_time
      ;;

    ${ARG_ACTION_OPEN})
      menu_arg_mount
      ;;
  esac                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                   DONE: DEFINE YOUR UPDATE COMMANDS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------

  # Make sure that <main()> loop does not break if one of the menus above
  # throws an error but also do not perform any action in <run()> function.
  arg_action=""
}

#===============================================================================
#  FUNCTIONS (CUSTOM)
#===============================================================================
#                     DONE: DEFINE YOUR OWN FUNCTIONS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  benchmark
#  DESCRIPTION:  Run <cryptsetup> benchmark
#todo: verschieben
#===============================================================================
benchmark() {
  # || true as the command always returns 1
  lib_core_sudo cryptsetup benchmark || true
}

#===  FUNCTION  ================================================================
#         NAME:  is_luks_device
#  DESCRIPTION:  Check if <arg_device_src> is a LUKS device (0) or not (1)
#todo: verschieben
#===============================================================================
is_luks_device() {
  lib_core_sudo cryptsetup isLuks "${arg_device_src}"
}

#===  FUNCTION  ================================================================
#         NAME:  show_drives
#  DESCRIPTION:  List block devices
#todo: verschieben
#===============================================================================
show_drives() {
  lib_msg_print_heading -301 "lsblk (/dev/...)"
  list_blk "all" "dialog-msgbox" "all"
  printf "\n"
}

#===  FUNCTION  ================================================================
#         NAME:  clone
#  DESCRIPTION:  Clone LUKS device from <arg_device_src> to <arg_device_dst>
#todo: evtl überarbeiten
#===============================================================================
clone() {
  local exitcode="0"

  # Close/unmount <arg_device_dst> in case it is still open/mounted
  unmount "${arg_device_dst}"                                               && \

  #  Warn user and ask to continue (Y/N)
  msg_warn_lsblk                                                            && \

  while read -r REPLY; do
    clear
    msg_warn_lsblk

    if lib_core_is "--Yy-${ID_LANG}" "${REPLY}"; then
      local checksum_src=""
      local checksum_dst=""

      # Calculate checksum (src)
      lib_core_echo "true" "true" "${TXT_CLONE_INFO_CHECKSUM}"              \
        "device" "${arg_device_src}"                                        && \
      checksum_src="$(lib_core_sudo pv "${arg_device_src}" | sha1sum)"      && \

      # Msg
      lib_core_echo "true" "true" "${TXT_CLONE_INFO_CLONING}"               \
        "device_src" "${arg_device_src}" "device_dst" "${arg_device_dst}"   && \

      # Clone
      lib_core_sudo dd                                                      \
        if="${arg_device_src}"                                              \
        of="${arg_device_dst}"                                              \
        bs=64K status=progress                                              && \

      # Calculate checksum (dst)
      lib_core_echo "true" "true" "${TXT_CLONE_INFO_CHECKSUM}"              \
        "device" "${arg_device_dst}"                                        && \
      checksum_dst="$(lib_core_sudo pv "${arg_device_dst}" | sha1sum)"      && \

      # Cloning considered to be successful if checksums are identical
      [ "${checksum_src}" = "${checksum_dst}" ]                             && \

      # Msg (success)
      lib_core_echo "true" "true" "${TXT_CLONE_INFO_CLONED}"                \
        "device_src" "${arg_device_src}" "device_dst" "${arg_device_dst}"   || \

      # Msg (error)
      { exitcode="$?"
        lib_core_echo                                                 \
          "true" "true" "${TXT_CLONE_ERROR}"                          \
          "device_src <${arg_device_src}> (SHA1)"  "${checksum_src}"  \
          "device_dst <${arg_device_dst}> (SHA1)"  "${checksum_dst}"
      } 1>&2

      break

    elif lib_core_is "--Nn-${ID_LANG}" "${REPLY}"; then
      break
    fi
  done                                                                      || \
  exitcode="$?"

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  encrypt
#  DESCRIPTION:  Encrypt a new device
#===============================================================================
encrypt() {
  #  Warn user and ask to continue (Y/N)
  msg_warn_lsblk

  local exitcode="0"
  while read -r REPLY; do
    clear
    msg_warn_lsblk

    if lib_core_is "--Yy-${ID_LANG}" "${REPLY}"; then
      # Format as LUKS device
      lib_core_sudo cryptsetup                                              \
        --type luks2 --cipher "${arg_cipher}" --hash "${arg_hash}"          \
        --key-size "${arg_key_size}" --iter-time "${arg_iter_time}"         \
        --verify-passphrase luksFormat "${arg_device_src}"                  && \

      # Open device, create filesystem, close device
      { lib_core_sudo cryptsetup open                                       \
          "${arg_device_src}" --type luks "${arg_mapper}"                   && \
        { lib_core_sudo mkfs -t "${arg_filesystem}" "/dev/mapper/${arg_mapper}"
          lib_core_sudo cryptsetup close "${arg_mapper}"
        }
      }                                                                     && \

      # Msg
      lib_core_echo                                                         \
        "true" "false" "<${arg_device_src}> ${TXT_ENCRYPT_INFO}"            || \

      exitcode="$?"
      break

    elif lib_core_is "--Nn-${ID_LANG}" "${REPLY}"; then
      break
    fi
  done

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  enroll
#  DESCRIPTION:  Enroll a passphrase or security token (FIDO2/PKCS#11/TPM2)
#                to LUKS header
#===============================================================================
enroll() {
  #  Warn user and ask to continue (Y/N)
  msg_warn_header

  local exitcode="0"
  while read -r REPLY; do
    clear
    msg_warn_header

    if lib_core_is "--Yy-${ID_LANG}" "${REPLY}"; then
      case "${arg_auth}" in
        ${ARG_AUTH_FIDO2})
          lib_core_sudo "${cmd_systemd_cryptenroll}"  \
            --fido2-device="${arg_fido2_device}"      \
            --fido2-with-client-pin="${arg_with_pin}" \
            "${arg_device_src}"
          ;;

        ${ARG_AUTH_PASSPHRASE})
          lib_core_sudo cryptsetup luksAddKey "${arg_device_src}"
          ;;

        ${ARG_AUTH_PKCS11})
          lib_core_sudo "${cmd_systemd_cryptenroll}"      \
            --pkcs11-token-uri="${arg_pkcs11_token_uri}"  \
            "${arg_device_src}"
          ;;

        ${ARG_AUTH_RECOVERY})
          lib_core_sudo "${cmd_systemd_cryptenroll}"  \
            --recovery-key                            \
            "${arg_device_src}"
          ;;

        ${ARG_AUTH_TPM2})
          lib_core_sudo "${cmd_systemd_cryptenroll}"  \
            --tpm2-device="${arg_tpm2_device}"        \
            --tpm2-pcrs="${arg_tpm2_pcrs}"            \
            --tpm2-with-pin="${arg_with_pin}"         \
            "${arg_device_src}"
          ;;
      esac                                                                  && \

      lib_core_echo                                                         \
        "true" "false" "<${arg_device_src}> ${TXT_ENROLL_INFO}"             && \
      msg_info_header                                                       || \
      exitcode="$?"
      break

    elif lib_core_is "--Nn-${ID_LANG}" "${REPLY}"; then
      break
    fi
  done

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  header_backup
#  DESCRIPTION:  Backup LUKS header to backup file
#===============================================================================
header_backup() {
  lib_core_sudo cryptsetup luksHeaderBackup "${arg_device_src}" \
    --header-backup-file "${arg_headerfile}"                    && \

  lib_core_echo "true" "false" "${TXT_HEADER_BACKUP_INFO} <${arg_headerfile}>."
}

#===  FUNCTION  ================================================================
#         NAME:  header_info
#  DESCRIPTION:  Dump LUKS header to <stdout>
#===============================================================================
header_info() {
  lib_core_sudo cryptsetup luksDump "${arg_device_src}"
}

#===  FUNCTION  ================================================================
#         NAME:  header_restore
#  DESCRIPTION:  Restore LUKS header from backup file
#===============================================================================
header_restore() {
  #  Warn user and ask to continue (Y/N)
  msg_warn_header

  local exitcode="0"
  while read -r REPLY; do
    clear
    msg_warn_header

    if lib_core_is "--Yy-${ID_LANG}" "${REPLY}"; then
      lib_core_sudo cryptsetup luksHeaderRestore "${arg_device_src}"      \
        --header-backup-file "${arg_headerfile}"                          && \
      lib_core_echo                                                       \
        "true" "false" "<${arg_device_src}> ${TXT_HEADER_RESTORE_INFO}"   && \
      msg_info_header                                                     || \
      exitcode="$?"
      break

    elif lib_core_is "--Nn-${ID_LANG}" "${REPLY}"; then
      break
    fi
  done

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  list_blk
#  DESCRIPTION:  List available block devices
# PARAMETER  1:  File system type, can be one of the following
#                  all            List all block devices (default)
#                  crypto_LUKS    List only LUKS devices
#            2:  Output format, can be one of the following
#                  dialog-menu    'dialog --menu' format
#                  dialog-msgbox  'dialog --msgbox' format
#      OUTPUTS:  Write block device list to <stdout>
#===============================================================================
list_blk() {
  local ARG_FSTYPE_ALL="all"
  local ARG_FSTYPE_CRYPTO_LUKS="crypto_LUKS"
  local arg_fstype="${1:-${ARG_FSTYPE_ALL}}"

  local ARG_OUT_DLG_MENU="dialog-menu"
  local ARG_OUT_DLG_MSGBOX="dialog-msgbox"
  local arg_out="$2"

  local ARG_FILTER_ALL="all"
  local ARG_FILTER_NOT_MOUNTED="not-mounted"
  local ARG_FILTER_MOUNTED="mounted"
  local arg_filter="${3:-${ARG_FILTER_ALL}}"

  local in_lsblk
  case "${arg_fstype}" in
    ${ARG_FSTYPE_ALL})
      case "${arg_out}" in
        ${ARG_OUT_DLG_MENU})
          in_lsblk="$(\
            lib_os_dev_lsblk "FSTYPE,NAME,SIZE,SERIAL" "false" "false")"
          ;;

        ${ARG_OUT_DLG_MSGBOX})
          in_lsblk="$(lib_os_dev_lsblk                        \
            "NAME,TYPE,FSTYPE,SIZE,LABEL,SERIAL,VENDOR,MODEL" \
            "false" "true")"
          ;;
      esac
      ;;

    ${ARG_FSTYPE_CRYPTO_LUKS})
      case "${arg_out}" in
        ${ARG_OUT_DLG_MENU})
          in_lsblk="$(lib_os_dev_lsblk                \
            "FSTYPE,NAME,SIZE,SERIAL" "false" "false" \
              | grep -E "${arg_fstype}\s+")"
          ;;

        ${ARG_OUT_DLG_MSGBOX})
          in_lsblk="$(lib_os_dev_lsblk                        \
            "NAME,TYPE,FSTYPE,SIZE,LABEL,SERIAL,VENDOR,MODEL" \
            "false" "true")"                                            && \

          in_lsblk="$(printf "%s\n%s"                                   \
            "$(printf "%s" "${in_lsblk}" | head -n 1)"                  \
            "$(printf "%s" "${in_lsblk}"                                \
              | grep -E "^([^[:blank:]]+[[:blank:]]+){2}${arg_fstype}"  \
            )"                                                          \
          )"
          ;;
      esac
      ;;

    *) return 1;;
  esac                                                                      && \

  case "${arg_filter}" in
    ${ARG_FILTER_ALL})
      printf "%s" "${in_lsblk}"
      ;;

    ${ARG_FILTER_NOT_MOUNTED}|${ARG_FILTER_MOUNTED})
      local column_dev
      local filter_mounted
      local out_header
      local out_devs

      case "${arg_out}" in
        ${ARG_OUT_DLG_MENU}) column_dev="2";;
        ${ARG_OUT_DLG_MSGBOX})
          column_dev="1"
          out_header="$(printf "%s" "${in_lsblk}" | head -n 1)"
          in_lsblk="$(printf "%s" "${in_lsblk}" | tail -n +2)"
          ;;
      esac

      case "${arg_filter}" in
        ${ARG_FILTER_NOT_MOUNTED}) filter_mounted="false";;
        ${ARG_FILTER_MOUNTED})     filter_mounted="true";;
      esac

      local OLDIFS="$IFS"
      local IFS="${LIB_C_STR_NEWLINE}"
      local line
      local dev
      for line in ${in_lsblk}; do
        IFS="$OLDIFS"
        dev="/dev/$(printf "%s" "${line}" | cut -d' ' -f${column_dev})"
        if __lib_os_dev_is_mounted "true" "${dev}"; then
          if ${filter_mounted}; then
            out_devs="$(printf "%s${out_devs:+\n}%s" "${out_devs}" "${line}")"
          fi
        elif ! ${filter_mounted}; then
          out_devs="$(printf "%s${out_devs:+\n}%s" "${out_devs}" "${line}")"
        fi
      done
      IFS="$OLDIFS"

      lib_core_is --notempty "${out_devs}" && \
      printf "%s${out_header:+\n}%s" "${out_header}" "${out_devs}"
      ;;

    *) return 1;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  list_token
#  DESCRIPTION:  List security token devices
#      OUTPUTS:  Write device list to <stdout>
#===============================================================================
list_token() {
  case "${arg_auth}" in
    ${ARG_AUTH_FIDO2})
      # lib_os_dev_class_list "hidraw" "   "
      "${cmd_systemd_cryptenroll}" --fido2-device=list | tail +2
      ;;

    ${ARG_AUTH_PKCS11})
      "${cmd_systemd_cryptenroll}" --pkcs11-token-uri=list | tail +2
      ;;

    ${ARG_AUTH_TPM2})
      # lib_os_dev_class_list "tpmrm" "   "
      "${cmd_systemd_cryptenroll}" --tpm2-device=list | tail +2
      ;;
  esac
}

#===  FUNCTION  ================================================================
#         NAME:  msg_error_with_params
#  DESCRIPTION:  Print error message (with parameters)
# PARAMETER  1:  Message to print
#                (Optional, default "Operation could not be completed.")
#      OUTPUTS:  Write message to <stderr>
#===============================================================================
msg_error_with_params() {
  local arg_msg="${1:-${TXT_ERROR_DEFAULT}}"

  lib_msg_echo --error "${arg_msg}" "false" ""                                 \
    "${arg_action:+action}" "${arg_action}"                                    \
                                                                               \
    "${arg_device_src:+device (full path)}" "${arg_device_src}"                \
    "${arg_mapper:+mapper}" "/dev/mapper/${arg_mapper}"                        \
    "${arg_mount:+mount point}" "${arg_mount}"                                 \
    "${arg_filesystem:+filesystem}" "${arg_filesystem}"                        \
                                                                               \
    "${arg_device_dst:+backup/clone device}" "${arg_device_dst}"               \
    "${arg_headerfile:+backup header file}" "${arg_headerfile}"                \
                                                                               \
    "${arg_auth:+auth}" "${arg_auth}"                                          \
    "${arg_with_pin:+pin (FIDO2/TPM2)}" "${arg_with_pin}"                      \
    "${arg_cipher:+cipher}" "${arg_cipher}"                                    \
    "${arg_key_size:+key size}" "${arg_key_size:+${arg_key_size} bits}"        \
    "${arg_hash:+hash}" "${arg_hash}"                                          \
    "${arg_iter_time:+iteration time}" "${arg_iter_time:+${arg_iter_time} ms}" \
  1>&2
}

#===  FUNCTION  ================================================================
#         NAME:  msg_error_without_params
#  DESCRIPTION:  Print error message (without parameters)
# PARAMETER  1:  Message to print
#                (Optional, default "Operation could not be completed.")
#      OUTPUTS:  Write message to <stderr>
#===============================================================================
msg_error_without_params() {
  local arg_msg="${1:-${TXT_ERROR_DEFAULT}}"
  lib_msg_echo --error "${arg_msg}" 1>&2
}

#===  FUNCTION  ================================================================
#         NAME:  msg_info_header
#  DESCRIPTION:  Print info message after changing header
#      OUTPUTS:  Write message to <stdout>
#===============================================================================
msg_info_header() {
  lib_msg_print_heading -2 "${TXT_CONTINUE_ENTER}"
  read -r dummy
  clear
  lib_msg_print_heading -201 "${TXT_MSG_INFO_HEADER_INFO_CHANGED}"
  lib_msg_print_heading -301 "LUKS header (${arg_device_src})"
  lib_core_sudo cryptsetup luksDump "${arg_device_src}"
  lib_msg_print_heading -301
  lib_core_echo "true" "false" "${TXT_MSG_INFO_HEADER_INFO_BACKUP}"
}

#===  FUNCTION  ================================================================
#         NAME:  msg_warn_header
#  DESCRIPTION:  Print warning message before changing header
#      OUTPUTS:  Write message to <stdout>
#===============================================================================
msg_warn_header() {
  lib_msg_echo --warning "${TXT_MSG_WARN_HEADER_WARN}"
  lib_msg_print_heading -301 "LUKS header (${arg_device_src})"
  lib_core_sudo cryptsetup luksDump "${arg_device_src}"
  lib_msg_print_heading -301
  lib_core_echo "true" "false"                                  \
    "${TXT_MSG_WARN_HEADER_INFO}"                               \
    "device" "${arg_device_src}"                                \
    ${arg_headerfile:+"backup header file" "${arg_headerfile}"} \
    "action" "${arg_action}"                                    \
    "auth" "${arg_auth}"                                        \
    "pin (FIDO2/TPM2)" "${arg_with_pin}"
  lib_msg_print_heading -211 "${TXT_CONTINUE_YESNO}"
}

#===  FUNCTION  ================================================================
#         NAME:  msg_warn_lsblk
#  DESCRIPTION:  Print warning message before overwriting device
#      OUTPUTS:  Write message to <stdout>
#===============================================================================
msg_warn_lsblk() {
  lib_msg_print_heading -301 "lsblk (/dev/...)"
  lsblk -o NAME,TYPE,FSTYPE,SIZE,LABEL,SERIAL,VENDOR,MODEL
  lib_msg_print_heading -301

  local dev
  case "${arg_action}" in
    ${ARG_ACTION_CLONE})
      dev="${arg_device_dst}"
      lib_core_echo "true" "false" "${TXT_CLONE_INFO_CLONING}"  \
        "device_src" "${arg_device_src}"                        \
        "device_dst" "${arg_device_dst}"
      ;;

    ${ARG_ACTION_ENCRYPT})
      dev="${arg_device_src}"
      lib_core_echo "true" "false" "${TXT_MSG_WARN_LSBLK_INFO_ENCRYPTING}"  \
        "device" "${arg_device_src}"                                        \
        "auth" "${arg_auth}"                                                \
        "cipher" "${arg_cipher}"                                            \
        "key size" "${arg_key_size} bits"                                   \
        "hash" "${arg_hash}"                                                \
        "iteration time" "${arg_iter_time} ms"
      ;;
  esac

  lib_msg_echo --warning \
    "${TXT_MSG_WARN_LSBLK_WARN} <${dev}>. ${TXT_CONTINUE_YESNO}"
}

#===  FUNCTION  ================================================================
#         NAME:  open
#  DESCRIPTION:  Open a LUKS device
#===============================================================================
open() {
  lib_core_echo "true" "true" "${TXT_OPEN_INFO_OPENING}"  \
    "auth"    "${arg_auth}"                               \
    "device"  "${arg_device_src}"                         \
    "mapper"  "/dev/mapper/${arg_mapper}"                 && \

  # Open LUKS device
  case "${arg_auth}" in
    ${ARG_AUTH_FIDO2})
      lib_core_sudo "${cmd_systemd_cryptsetup}" attach    \
        "${arg_mapper}" "${arg_device_src}"               \
        - fido2-device="${arg_fido2_device}"
      ;;

    ${ARG_AUTH_PKCS11})
      lib_core_sudo "${cmd_systemd_cryptsetup}" attach    \
        "${arg_mapper}" "${arg_device_src}"               \
        - pkcs11-token-uri="${arg_pkcs11_token_uri}"
      ;;

    ${ARG_AUTH_PASSPHRASE})
      lib_core_sudo cryptsetup open                       \
        "${arg_device_src}" --type luks "${arg_mapper}"
      ;;

    ${ARG_AUTH_TPM2})
      lib_core_sudo "${cmd_systemd_cryptsetup}" attach    \
        "${arg_mapper}" "${arg_device_src}"               \
        - tpm2-device="${arg_tpm2_device}"
      ;;
  esac                                                                    && \
  lib_core_echo                                                           \
    "true" "true" "${TXT_OPEN_INFO_OPENED} </dev/mapper/${arg_mapper}>."  && \

  # Optionally mount opened LUKS device
  if ${mount}; then
    lib_core_echo "true" "true" "${TXT_OPEN_INFO_MOUNTING}"           \
      "device" "/dev/mapper/${arg_mapper}"                            \
      "mount point" "${arg_mount}"                                    \
      "filesystem" "${arg_filesystem}"                                && \
    lib_core_sudo mkdir --parents "${arg_mount}"                      && \
    lib_core_sudo mount -t "${arg_filesystem}"                        \
      "/dev/mapper/${arg_mapper}" "${arg_mount}"                      && \
    lib_core_echo                                                     \
      "true" "false" "${TXT_OPEN_INFO_MOUNTED} <${arg_mount}>."       && \

    # If there is a graphical environment open the file explorer
    if lib_core_is --set "${DISPLAY}"; then
      xdg-open "${arg_mount}"
    fi
  fi
}

#===  FUNCTION  ================================================================
#         NAME:  remove
#  DESCRIPTION:  Remove passphrase or security token from LUKS header
#===============================================================================
remove() {
  #  Warn user and ask to continue (Y/N)
  msg_warn_header

  local exitcode="0"
  while read -r REPLY; do
    clear
    msg_warn_header

    if lib_core_is "--Yy-${ID_LANG}" "${REPLY}"; then
      case "${arg_auth}" in
        ${ARG_AUTH_FIDO2}|${ARG_AUTH_PKCS11}|${ARG_AUTH_RECOVERY}|${ARG_AUTH_TPM2})
          lib_core_sudo "${cmd_systemd_cryptenroll}"  \
            --wipe-slot=${arg_auth}                   \
            "${arg_device_src}"
          ;;

        ${ARG_AUTH_PASSPHRASE})
          lib_core_sudo cryptsetup luksRemoveKey "${arg_device_src}"
          ;;
      esac                                                                  && \
      lib_core_echo                                                         \
        "true" "false" "<${arg_device_src}> ${TXT_REMOVE_INFO}"             && \
      msg_info_header                                                       || \
      exitcode="$?"
      break

    elif lib_core_is "--Nn-${ID_LANG}" "${REPLY}"; then
      break
    fi
  done

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  replace
#  DESCRIPTION:  Replace all security token of a certain type in LUKS header
#===============================================================================
replace() {
  #  Warn user and ask to continue (Y/N)
  msg_warn_header

  local exitcode="0"
  while read -r REPLY; do
    clear
    msg_warn_header

    if lib_core_is "--Yy-${ID_LANG}" "${REPLY}"; then
      case "${arg_auth}" in
        ${ARG_AUTH_FIDO2})
          lib_core_sudo "${cmd_systemd_cryptenroll}"  \
            --wipe-slot=fido2                         \
            --fido2-device="${arg_fido2_device}"      \
            --fido2-with-client-pin="${arg_with_pin}" \
            "${arg_device_src}"
          ;;

        ${ARG_AUTH_PKCS11})
          lib_core_sudo "${cmd_systemd_cryptenroll}"      \
            --wipe-slot=pkcs11                            \
            --pkcs11-token-uri="${arg_pkcs11_token_uri}"  \
            "${arg_device_src}"
          ;;

        ${ARG_AUTH_RECOVERY})
          lib_core_sudo "${cmd_systemd_cryptenroll}"  \
            --wipe-slot=recovery                      \
            --recovery-key                            \
            "${arg_device_src}"
          ;;

        ${ARG_AUTH_TPM2})
          lib_core_sudo "${cmd_systemd_cryptenroll}"  \
            --wipe-slot=tpm2                          \
            --tpm2-device="${arg_tpm2_device}"        \
            --tpm2-pcrs="${arg_tpm2_pcrs}"            \
            --tpm2-with-pin="${arg_with_pin}"         \
            "${arg_device_src}"
          ;;
      esac                                                                  && \
      lib_core_echo                                                         \
        "true" "false" "<${arg_device_src}> ${TXT_REPLACE_INFO}"            && \
      msg_info_header                                                       || \
      exitcode="$?"
      break

    elif lib_core_is "--Nn-${ID_LANG}" "${REPLY}"; then
      break
    fi
  done

  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  unmount
#  DESCRIPTION:  Unmount a device and close it before in case it is a LUKS dev
# PARAMETER  1:  Device to unmount/close
#===============================================================================
unmount() {
  local arg_device="$1"

  if lib_core_sudo cryptsetup isLuks "${arg_device}"; then
    # Device is a LUKS device
    local mapper
    local mountpoint

    # Get LUKS partitions
    lib_os_dev_lsblk "TYPE,NAME,MOUNTPOINT" "true" "false" "${arg_device}"  \
      | grep -E "^crypt\s+"                                                 \
      | while IFS= read -r line || [ -n "${line}" ]; do
          mapper="$(printf "%s" "${line}" | cut -d' ' -f2)"
          mountpoint="$(printf "%s" "${line}" | cut -d' ' -f3-)"

          if lib_core_is --notempty "${mountpoint}"; then
            lib_core_echo "true" "true"                             \
              "${TXT_UNMOUNT_INFO_UNMOUNTING} <${mountpoint}> ..."  && \
            lib_core_sudo umount "${mountpoint}"                    && \
            lib_core_echo "true" "true"                             \
              "<${mountpoint}> ${TXT_UNMOUNT_INFO_UNMOUNTED}"
          fi                                                            && \
          lib_core_echo "true" "true"                                   \
            "${TXT_UNMOUNT_INFO_CLOSING} </dev/mapper/${mapper}> ..."   && \
          lib_core_sudo cryptsetup close "${mapper}"                    && \
          lib_core_echo "true" "false"                                  \
            "</dev/mapper/${mapper}> ${TXT_UNMOUNT_INFO_CLOSED}"
        done
  fi                                                                        && \

  lib_os_dev_umount "${arg_device}"                                         || \

  { msg_error_without_params \
      "${TXT_UNMOUNT_ERROR} <${arg_device}>. ${TXT_ABORTING}"
    return 1
  }
}
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                     DONE: DEFINE YOUR OWN FUNCTIONS HERE
#===============================================================================

#===============================================================================
#  FUNCTIONS (CUSTOM) (MENUS)
#===============================================================================
#                    DONE: DEFINE YOUR OWN DIALOG MENUS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    DONE: DEFINE YOUR OWN DIALOG MENUS HERE
#===============================================================================

#===============================================================================
#  FUNCTIONS (CUSTOM) (MENUS) (PARAMETERS/VARIABLES)
#===============================================================================
#               DONE: DEFINE PARAMETER/VARIABLE DIALOG MENUS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_auth
#  DESCRIPTION:  Interactive menu for setting <arg_auth> parameter
#      GLOBALS:  arg_auth
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_auth() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_AUTH}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_AUTH}"

  local list
  list="$(lib_core_str_to --const "ARG_AUTH_LIST_${arg_action}")"
  eval "list=\${${list}}"

  # In case specific list does not exist
  list="${list:-${ARG_AUTH_LIST}}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${list}; do
        eval "tag=\${ARG_AUTH_${a}}"
        eval "item=\${L_LUKS_${ID_LANG}_DLG_ITM_ARG_AUTH_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    lib_core_is --notempty "${dlgpairs}"                                    && \
    result="$(dialog --title "${title}" --menu "${text}" 0 0 0  \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_auth="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_cipher
#  DESCRIPTION:  Interactive menu for setting <arg_cipher> parameter
#      GLOBALS:  arg_cipher
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_cipher() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_CIPHER}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_CIPHER}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --inputbox "${text}" 0 0  \
      "${arg_cipher}" 2>&1 1>&3)"                                           || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_cipher="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_device_dst
#  DESCRIPTION:  Interactive menu for setting <arg_device_dst> parameter
#      GLOBALS:  arg_device_dst
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_device_dst() {
  local title1
  local title2
  local extra
  local text1
  local text2
  eval "title1=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_DEVICE_DST_1}"
  eval "title2=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_DEVICE_DST_2}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_CLONE})
      eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_DST_CLONE}"
      ;;
  esac
  eval "text2=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_DST_2}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local msg
  local lsblk_msgbox
  local lsblk_menu
  local result
  local exitcode
  exec 3>&1
    exitcode="0"
    while true; do
      # Get a filtered list of block devices depending on <arg_action>
      { case "${arg_action}" in
          ${ARG_ACTION_CLONE})
            lsblk_msgbox="$(list_blk "all" "dialog-msgbox" "all")" && \
            lsblk_menu="$(list_blk "all" "dialog-menu" "all")"
            ;;
        esac || \

        { dialog  --no-collapse --title "${title2}" --msgbox "${text2}" 0 0
          false
        }
      }                                                                     && \

      # Dialogue 1: Show message box with detailed information about the block
      #             devices
      msg="$(printf "%s\n\n%s\n%s\n%s\n%s"  \
                    "${text1}"              \
                    "=========="            \
                    " /dev/..."             \
                    "=========="            \
                    "${lsblk_msgbox}"       \
            )"                                                              && \

      dialog --no-collapse --title "${title1}" --msgbox "${msg}" 0 0        && \

      # Dialogue 2: Request user to select one of the block devices
      IFS="${LIB_C_STR_NEWLINE}"                                            && \
      lsblk_menu="$(for a in ${lsblk_menu}; do
          name="$(printf "%s" "$a" | cut -d' ' -f2)"
          size="$(printf "%s" "$a" | cut -d' ' -f3)"
          serial="$(printf "%s" "$a" | cut -d' ' -f4-)"

          tag="/dev/${name}"
          item="${name} (${size})${serial:+ (${serial})}"
          printf "%s\n%s\n" "${tag}" "${item}"
        done)"                                                              && \
      lib_core_is --notempty "${lsblk_menu}"                                && \
      result="$(dialog --extra-button --extra-label "${extra}"  \
        --title "${title1}" --menu "${text1}" 0 0 0             \
        ${lsblk_menu} 2>&1 1>&3)"                                           || \

      exitcode="$?"
      IFS="$OLDIFS"

      case "${exitcode}" in
        0)
          # 'dialog' completed => If value is valid then break, otherwise go on
          lib_core_is --blockdevice "${result}"   && \
          ! [ "${arg_device_src}" = "${result}" ] && \
          break
          ;;
        3)
          # Extra button (go back) pressed => Stay in loop
          ;;
        *)
          # 'dialog' interrupted => Break
          break;;
      esac
    done
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_device_dst="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_device_src
#  DESCRIPTION:  Interactive menu for setting <arg_device_src> parameter
#      GLOBALS:  arg_device_src
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_device_src() {
  local title1
  local title2
  local extra
  local text1
  local text2
  eval "title1=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_DEVICE_SRC_1}"
  eval "title2=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_DEVICE_SRC_2}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  case "${arg_action}" in
    ${ARG_ACTION_CLONE})
      eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_SRC_CLONE}"
      ;;

    ${ARG_ACTION_CLOSE})
      eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_SRC_CLOSE}"
      ;;

    ${ARG_ACTION_ENCRYPT})
      eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_SRC_ENCRYPT}"
      ;;

    ${ARG_ACTION_ENROLL}|${ARG_ACTION_HEADER_RESTORE}|${ARG_ACTION_REMOVE}|${ARG_ACTION_REPLACE})
      eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_SRC_HEADER_MODIFY}"
      ;;

    ${ARG_ACTION_HEADER_BACKUP}|${ARG_ACTION_HEADER_INFO})
      eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_SRC_HEADER_BACKUP}"
      ;;

    ${ARG_ACTION_OPEN})
      eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_SRC_OPEN}"
      ;;
  esac
  eval "text2=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_DEVICE_SRC_2}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local msg
  local lsblk_msgbox
  local lsblk_menu
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      # Get a filtered list of block devices depending on <arg_action>
      { case "${arg_action}" in
          ${ARG_ACTION_CLOSE})
            lsblk_msgbox="$(\
              list_blk "crypto_LUKS" "dialog-msgbox" "mounted")" && \
            lsblk_menu="$(\
              list_blk "crypto_LUKS" "dialog-menu" "mounted")"
            ;;

          ${ARG_ACTION_ENCRYPT})
            lsblk_msgbox="$(list_blk "all" "dialog-msgbox" "all")" && \
            lsblk_menu="$(list_blk "all" "dialog-menu" "all")"
            ;;

          ${ARG_ACTION_OPEN})
            lsblk_msgbox="$(\
              list_blk "crypto_LUKS" "dialog-msgbox" "not-mounted")" && \
            lsblk_menu="$(\
              list_blk "crypto_LUKS" "dialog-menu" "not-mounted")"
            ;;

          *)
            lsblk_msgbox="$(list_blk "crypto_LUKS" "dialog-msgbox" "all")" && \
            lsblk_menu="$(list_blk "crypto_LUKS" "dialog-menu" "all")"
            ;;
        esac || \

        { dialog  --no-collapse --title "${title2}" --msgbox "${text2}" 0 0
          false
        }
      }                                                                     && \

      # Dialogue 1: Show message box with detailed information about the block
      #             devices
      msg="$(printf "%s\n\n%s\n%s\n%s\n%s"  \
                    "${text1}"              \
                    "=========="            \
                    " /dev/..."             \
                    "=========="            \
                    "${lsblk_msgbox}"       \
            )"                                                              && \

      dialog --no-collapse --title "${title1}" --msgbox "${msg}" 0 0        && \

      # Dialogue 2: Request user to select one of the block devices
      IFS="${LIB_C_STR_NEWLINE}"                                            && \
      lsblk_menu="$(for a in ${lsblk_menu}; do
          name="$(printf "%s" "$a" | cut -d' ' -f2)"
          size="$(printf "%s" "$a" | cut -d' ' -f3)"
          serial="$(printf "%s" "$a" | cut -d' ' -f4-)"

          tag="/dev/${name}"
          item="${name} (${size})${serial:+ (${serial})}"
          printf "%s\n%s\n" "${tag}" "${item}"
        done)"                                                              && \
      lib_core_is --notempty "${lsblk_menu}"                                && \
      result="$(dialog --extra-button --extra-label "${extra}"  \
        --title "${title1}" --menu "${text1}" 0 0 0             \
        ${lsblk_menu} 2>&1 1>&3)"                                           || \

      exitcode="$?"
      IFS="$OLDIFS"

      case "${exitcode}" in
        0)
          # 'dialog' completed => If value is valid then break, otherwise go on
          lib_core_is --blockdevice "${result}" && break
          ;;
        3)
          # Extra button (go back) pressed => Stay in loop
          ;;
        *)
          # 'dialog' interrupted => Break
          break;;
      esac
    done
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_device_src="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_fido2_device
#  DESCRIPTION:  Interactive menu for setting <arg_fido2_device> parameter
#      GLOBALS:  arg_fido2_device
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_fido2_device() {
  local tag1="${ARG_FIDO2_DEVICE_AUTO}"
  local tag2="${ARG_FIDO2_DEVICE_MANUAL}"

  local title1
  local title3
  local text1
  local text2
  local text3
  local item1
  local item2
  eval "title1=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_FIDO2_DEVICE_1}"
  eval "title3=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_FIDO2_DEVICE_3}"
  eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_FIDO2_DEVICE_1}"
  eval "text2=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_FIDO2_DEVICE_2}"
  eval "text3=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_FIDO2_DEVICE_3}"
  eval "item1=\${L_LUKS_${ID_LANG}_DLG_ITM_ARG_FIDO2_DEVICE_AUTO}"
  eval "item2=\${L_LUKS_${ID_LANG}_DLG_ITM_ARG_FIDO2_DEVICE_MANUAL}"

  local OLDIFS="$IFS"
  local IFS="${LIB_C_STR_NEWLINE}"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title1}" --menu "${text1}" 0 0 0  \
      "${tag1}" "${item1}"                                        \
      "${tag2}" "${item2}" 2>&1 1>&3)"                                      && \

    case "${result}" in
      ${ARG_FIDO2_DEVICE_MANUAL})
        # dlgpairs="$(for a in $(lib_os_dev_class_list "hidraw" ";"); do
        #     tag="$(printf "%s" "$a" | cut -d';' -f1)"
        #     item="$(printf "%s" "$a" | cut -d';' -f2-)"
        #     printf "%s\n%s\n" "${tag}" "${item}"
        #   done)"                                                      && \

        dlgpairs="$(for a in \
          $("${cmd_systemd_cryptenroll}" --fido2-device=list 2>/dev/null | tail +2); do
            tag="$(printf "%s" "$a" | cut -d' ' -f1)"
            item="$(printf "%s" "$a" | cut -d' ' -f2- | tr -s ' ')"
            printf "%s\n%s\n" "${tag}" "${item}"
          done)"                                                      && \
        ( lib_core_is --notempty "${dlgpairs}" || exit 2 )            && \
        result="$(dialog --title "${title1}" --menu "${text2}" 0 0 0  \
          ${dlgpairs} 2>&1 1>&3)"
        ;;
    esac                                                                    || \
    exitcode="$?"

    case "${exitcode}" in
      0|1) ;; # '1' = cancel button
      *) dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0 ;;
    esac
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_fido2_device="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_filesystem
#  DESCRIPTION:  Interactive menu for setting <arg_filesystem> parameter
#      GLOBALS:  arg_filesystem
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_filesystem() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_FILESYSTEM}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_FILESYSTEM}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --inputbox "${text}" 0 0  \
      "${arg_filesystem}" 2>&1 1>&3)"                                       || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_filesystem="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_hash
#  DESCRIPTION:  Interactive menu for setting <arg_hash> parameter
#      GLOBALS:  arg_hash
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_hash() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_HASH}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_HASH}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --inputbox "${text}" 0 0  \
      "${arg_hash}" 2>&1 1>&3)"                                             || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_hash="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_headerfile
#  DESCRIPTION:  Interactive menu for setting <arg_headerfile> parameter
#      GLOBALS:  arg_headerfile
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_headerfile() {
  local title
  local text
  case "${arg_action}" in
    ${ARG_ACTION_HEADER_BACKUP})
      eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_HEADERFILE}"
      eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_HEADERFILE_BACKUP}"
      ;;
    ${ARG_ACTION_HEADER_RESTORE})
      eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_HEADERFILE}"
      eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_HEADERFILE_RESTORE}"
      ;;
  esac

  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      dialog --title "${title}" --msgbox "${text}" 0 0                      && \
      result="$(dialog --title "${title}"                                   \
        --fselect "${result:-${arg_headerfile:-~/}}" 0 0 2>&1 1>&3)"        && \
      result="$(lib_core_expand_tilde "${result}")"                         || \
      exitcode="$?"

      #  Show prompt again if <result>
      #    - is not a valid filepath (<ARG_ACTION_HEADER_BACKUP>)
      #    - is already existing (<ARG_ACTION_HEADER_BACKUP>)
      #    - does not exist  (<ARG_ACTION_HEADER_RESTORE>)
      #  unless the user has pressed the 'Cancel' button
      case "${exitcode}" in
        0)
          case "${arg_action}" in
            ${ARG_ACTION_HEADER_BACKUP})
              touch -c "${result}" 2>/dev/null && \
              ! lib_core_is --file "${result}"
              ;;
            ${ARG_ACTION_HEADER_RESTORE})
              lib_core_is --file "${result}"
              ;;
          esac && \
          break
          ;;
        *)
          break
          ;;
      esac
    done
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_headerfile="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_iter_time
#  DESCRIPTION:  Interactive menu for setting <arg_iter_time> parameter
#      GLOBALS:  arg_iter_time
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_iter_time() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_ITER_TIME}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_ITER_TIME}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --rangebox "${text}" 0 0  \
      ${ARG_ITER_TIME_MIN} ${ARG_ITER_TIME_MAX} ${arg_iter_time}  \
      2>&1 1>&3; exit $?)"                                                  && \
    result="$(printf "%s" "${result}" | rev | cut -d" " -f2- | rev)"        || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_iter_time="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_key_size
#  DESCRIPTION:  Interactive menu for setting <arg_key_size> parameter
#      GLOBALS:  arg_key_size
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_key_size() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_KEY_SIZE}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_KEY_SIZE}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --rangebox "${text}" 0 0  \
      ${ARG_KEY_SIZE_MIN} ${ARG_KEY_SIZE_MAX} ${arg_key_size}     \
      2>&1 1>&3; exit $?)"                                                  && \
    result="$(printf "%s" "${result}" | rev | cut -d" " -f2- | rev)"        || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_key_size="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_mapper
#  DESCRIPTION:  Interactive menu for setting <arg_mapper> parameter
#      GLOBALS:  arg_mapper
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_mapper() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_MAPPER}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_MAPPER}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --inputbox "${text}" 0 0  \
      "${arg_mapper}" 2>&1 1>&3)"                                           || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_mapper="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_mount
#  DESCRIPTION:  Interactive menu for setting <arg_mount> parameter
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_mount() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_MOUNT}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_MOUNT}"

  local result
  local exitcode="0"
  exec 3>&1
    dialog --title "${title}" --msgbox "${text}" 0 0                        && \
    result="$(dialog --title "${title}"                                     \
      --dselect "${arg_mount}" 0 0 2>&1 1>&3)"                              || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then
    if [ -n "${result}" ]; then mount="true"; else mount="false"; fi
    arg_mount="${result}"
  fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_pkcs11_token_uri
#  DESCRIPTION:  Interactive menu for setting <arg_pkcs11_token_uri> parameter
#      GLOBALS:  arg_pkcs11_token_uri
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_pkcs11_token_uri() {
  local tag1="${ARG_PKCS11_TOKEN_URI_AUTO}"
  local tag2="${ARG_PKCS11_TOKEN_URI_MANUAL}"

  local title1
  local text1
  local text2
  local text3
  local item1
  local item2
  eval "title1=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_PKCS11_TOKEN_URI_1}"
  eval "title3=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_PKCS11_TOKEN_URI_3}"
  eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_PKCS11_TOKEN_URI_1}"
  eval "text2=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_PKCS11_TOKEN_URI_2}"
  eval "text3=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_PKCS11_TOKEN_URI_3}"
  eval "item1=\${L_LUKS_${ID_LANG}_DLG_ITM_ARG_PKCS11_TOKEN_URI_AUTO}"
  eval "item2=\${L_LUKS_${ID_LANG}_DLG_ITM_ARG_PKCS11_TOKEN_URI_MANUAL}"

  local OLDIFS="$IFS"
  local IFS="${LIB_C_STR_NEWLINE}"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title1}" --menu "${text1}" 0 0 0  \
      "${tag1}" "${item1}"                                        \
      "${tag2}" "${item2}" 2>&1 1>&3)"                                      && \

    case "${result}" in
      ${ARG_PKCS11_TOKEN_URI_MANUAL})
        dlgpairs="$(for a in \
          $("${cmd_systemd_cryptenroll}" --pkcs11-token-uri=list 2>/dev/null | tail +2); do
            tag="$(printf "%s" "$a" | cut -d' ' -f1)"
            item="$(printf "%s" "$a" | cut -d' ' -f2- | tr -s ' ')"
            printf "%s\n%s\n" "${tag}" "${item}"
          done)"                                                      && \
        ( lib_core_is --notempty "${dlgpairs}" || exit 2 )            && \
        result="$(dialog --title "${title1}" --menu "${text2}" 0 0 0  \
          ${dlgpairs} 2>&1 1>&3)"
        ;;
    esac                                                                    || \
    exitcode="$?"

    case "${exitcode}" in
      0|1) ;; # '1' = cancel button
      *) dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0 ;;
    esac
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_pkcs11_token_uri="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_tpm2_device
#  DESCRIPTION:  Interactive menu for setting <arg_tpm2_device> parameter
#      GLOBALS:  arg_tpm2_device
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_tpm2_device() {
  local tag1="${ARG_TPM2_DEVICE_AUTO}"
  local tag2="${ARG_TPM2_DEVICE_MANUAL}"

  local title1
  local title3
  local text1
  local text2
  local text3
  local item1
  local item2
  eval "title1=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_TPM2_DEVICE_1}"
  eval "title3=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_TPM2_DEVICE_3}"
  eval "text1=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_TPM2_DEVICE_1}"
  eval "text2=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_TPM2_DEVICE_2}"
  eval "text3=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_TPM2_DEVICE_3}"
  eval "item1=\${L_LUKS_${ID_LANG}_DLG_ITM_ARG_TPM2_DEVICE_AUTO}"
  eval "item2=\${L_LUKS_${ID_LANG}_DLG_ITM_ARG_TPM2_DEVICE_MANUAL}"

  local OLDIFS="$IFS"
  local IFS="${LIB_C_STR_NEWLINE}"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title1}" --menu "${text1}" 0 0 0  \
      "${tag1}" "${item1}"                                        \
      "${tag2}" "${item2}" 2>&1 1>&3)"                                      && \

    case "${result}" in
      ${ARG_TPM2_DEVICE_MANUAL})
        # dlgpairs="$(for a in $(lib_os_dev_class_list "tpmrm" ";"); do
        #     tag="$(printf "%s" "$a" | cut -d';' -f1)"
        #     item="$(printf "%s" "$a" | cut -d';' -f2-)"
        #     printf "%s\n%s\n" "${tag}" "${item}"
        #   done)"                                                      && \

        dlgpairs="$(for a in \
          $("${cmd_systemd_cryptenroll}"  --tpm2-device=list 2>/dev/null | tail +2); do
            tag="$(printf "%s" "$a" | cut -d' ' -f1)"
            item="$(printf "%s" "$a" | cut -d' ' -f2- | tr -s ' ')"
            printf "%s\n%s\n" "${tag}" "${item}"
          done)"                                                      && \
        ( lib_core_is --notempty "${dlgpairs}" || exit 2 )            && \
        result="$(dialog --title "${title1}" --menu "${text2}" 0 0 0  \
          ${dlgpairs} 2>&1 1>&3)"
        ;;
    esac                                                                    || \
    exitcode="$?"

    case "${exitcode}" in
      0|1) ;; # '1' = cancel button
      *) dialog  --no-collapse --title "${title3}" --msgbox "${text3}" 0 0 ;;
    esac
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_tpm2_device="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_tpm2_pcrs
#  DESCRIPTION:  Interactive menu for setting <arg_tpm2_pcrs> parameter
#      GLOBALS:  arg_tpm2_pcrs
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_tpm2_pcrs() {
  local title
  local text
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_TPM2_PCRS}"
  eval "text=\${L_LUKS_${ID_LANG}_DLG_TXT_ARG_TPM2_PCRS}"

  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      result="$(dialog --title "${title}" --inputbox "${text}" 0 0 \
        "${arg_tpm2_pcrs}" 2>&1 1>&3)"                                      || \
      exitcode="$?"

      # Continue loop in case a wrong value was entered
      if  lib_core_regex --luks2-tpm2-pcrs "${result}" || \
          [ "${exitcode}" -ne 0 ]; then
            break
      fi
    done
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_tpm2_pcrs="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_with_pin
#  DESCRIPTION:  Interactive menu for setting <arg_with_pin> parameter
#      GLOBALS:  arg_with_pin
#===============================================================================
menu_arg_with_pin() {
  local title
  local text1
  eval "title=\${L_LUKS_${ID_LANG}_DLG_TTL_ARG_WITH_PIN}"
  text1="$(lib_core_str_to --const "L_LUKS_${ID_LANG}_DLG_TXT_ARG_WITH_PIN_${arg_auth}")"
  eval "text1=\${${text1}}"

  exec 3>&1
    dialog --title "${title}" --yesno "${text1}" 0 0                        && \
    arg_with_pin="true"                                                     || \
    arg_with_pin="false"
  exec 3>&-
}
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#               DONE: DEFINE PARAMETER/VARIABLE DIALOG MENUS HERE
#===============================================================================

#===============================================================================
#  MAIN
#===============================================================================
main "$@"