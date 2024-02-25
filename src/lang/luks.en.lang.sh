#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the LUKSwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/lang/luks.en.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   --English-- String Constants File for '/src/luks.sh'
#                 Used to generate help texts, interactive dialogues,
#                 and other  terminal/log messages.
#
#         BUGS:   ---
#
#        NOTES:   ---
#
#        TODO:    See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  !!! IMPORTANT !!!
#===============================================================================
#  All constants (identifiers) must follow a certain naming convention,
#  see '/src/lang/run.0.lang.sh'.

#===============================================================================
#  PARAMETER (TEMPLATE) - DO NOT EDIT
#===============================================================================
#  Script actions <ARG_ACTION_...>
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_HELP="${LIB_SHTPL_EN_HLP_DES_ARG_ACTION_HELP}"

#  Log destination <ARG_LOGDEST_...>
readonly L_LUKS_EN_HLP_DES_ARG_LOGDEST="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST}"
readonly L_LUKS_EN_HLP_DES_ARG_LOGDEST_BOTH="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_BOTH}"
readonly L_LUKS_EN_HLP_DES_ARG_LOGDEST_SYSLOG="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_SYSLOG}"
readonly L_LUKS_EN_HLP_DES_ARG_LOGDEST_TERMINAL="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_TERMINAL}"

#  Script operation modes <ARG_MODE_...>
readonly L_LUKS_EN_HLP_DES_ARG_MODE_DAEMON="${LIB_SHTPL_EN_HLP_DES_ARG_MODE_DAEMON}"
readonly L_LUKS_EN_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_EN_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#-------------------------------------------------------------------------------
#  arg_auth
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_AUTH="Authentication Mechanism"
readonly L_LUKS_EN_DLG_TXT_ARG_AUTH="Please select one of the following methods.

${LIB_SHTPL_EN_DLG_TXT_ATTENTION}
Regarding FIDO2, PKCS11 and TPM2 your system (and your token) must meet some requirements. For more information please consider the script's help."

readonly L_LUKS_EN_DLG_ITM_ARG_AUTH_FIDO2="FIDO2 Security Token"
readonly L_LUKS_EN_DLG_ITM_ARG_AUTH_PASSPHRASE="Passphrase"
readonly L_LUKS_EN_DLG_ITM_ARG_AUTH_PKCS11="PKCS#11 Smartcards and Security Token"
readonly L_LUKS_EN_DLG_ITM_ARG_AUTH_RECOVERY="Recovery Key (automatically generated)"
readonly L_LUKS_EN_DLG_ITM_ARG_AUTH_TPM2="Trusted Platform Module 2 (TPM2)"

readonly L_LUKS_EN_HLP_DES_ARG_AUTH="Specify authentication method to use for accessing LUKS encryption key"
readonly L_LUKS_EN_HLP_DES_ARG_AUTH_FIDO2="${L_LUKS_EN_DLG_ITM_ARG_AUTH_FIDO2}"
readonly L_LUKS_EN_HLP_DES_ARG_AUTH_PASSPHRASE="${L_LUKS_EN_DLG_ITM_ARG_AUTH_PASSPHRASE}"
readonly L_LUKS_EN_HLP_DES_ARG_AUTH_PKCS11="${L_LUKS_EN_DLG_ITM_ARG_AUTH_PKCS11}"
readonly L_LUKS_EN_HLP_DES_ARG_AUTH_RECOVERY="${L_LUKS_EN_DLG_ITM_ARG_AUTH_RECOVERY}. Only if ACTION := { --enroll | --remove | --replace }. Mostly identical to 'passphrase', but this option randomly generates a passphrase which can be optionally scanned off screen via a QR code."
readonly L_LUKS_EN_HLP_DES_ARG_AUTH_TPM2="${L_LUKS_EN_DLG_ITM_ARG_AUTH_TPM2}"

readonly L_LUKS_EN_HLP_REF_ARG_AUTH="Use it with '${L_LUKS_HLP_PAR_ARG_AUTH}' to set the authentication method to use."
readonly L_LUKS_EN_HLP_REF_ARG_AUTH_FIDO2="Only with '--auth fido2'."
readonly L_LUKS_EN_HLP_REF_ARG_AUTH_FIDO2_OR_PKCS11_OR_TPM2="Only with '--auth <fido2|pkcs11|tpm2>'."
readonly L_LUKS_EN_HLP_REF_ARG_AUTH_FIDO2_OR_TPM2="Only with '--auth <fido2|tpm2>'."
readonly L_LUKS_EN_HLP_REF_ARG_AUTH_PKCS11="Only with '--auth pkcs11'."
readonly L_LUKS_EN_HLP_REF_ARG_AUTH_TPM2="Only with '--auth tpm2'."

#-------------------------------------------------------------------------------
#  arg_cipher
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_CIPHER="Cipher"
readonly L_LUKS_EN_DLG_TXT_ARG_CIPHER="Please define an algorithm to use.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_EN_HLP_DES_ARG_CIPHER="Specify cipher (1). Run 'cat /proc/crypto', 'cryptsetup benchmark' to get a list of available ciphers."

#-------------------------------------------------------------------------------
#  arg_device_dst
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_DEVICE_DST_1="Destination Device"
readonly L_LUKS_EN_DLG_TTL_ARG_DEVICE_DST_2="${LIB_SHTPL_EN_DLG_TTL_ERROR}"

readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_DST_CLONE="Please specify the destination device which the source will be cloned to. This must be different from the previously selected source device.

${LIB_SHTPL_EN_DLG_TXT_WARNING}
All data on this device will be FULLY AND IRREVERSIBLY DELETED."
readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_DST_2="No (LUKS) device found."

#-------------------------------------------------------------------------------
#  arg_device_src
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_DEVICE_SRC_1="(Source) Device"
readonly L_LUKS_EN_DLG_TTL_ARG_DEVICE_SRC_2="${L_LUKS_EN_DLG_TTL_ARG_DEVICE_DST_2}"

readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_SRC_CLONE="Please specify the LUKS device which you would like to clone."
readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_SRC_CLOSE="Please specify the LUKS device which you would like to close and unmount."
readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_SRC_ENCRYPT="Please specify the the device that shall be encrypted.

${LIB_SHTPL_EN_DLG_TXT_WARNING}
All data previously stored on this device will be FULLY AND IRREVERSIBLY DELETED."
readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_SRC_HEADER_BACKUP="Please specify the LUKS device whose header you would like to backup/display."
readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_SRC_HEADER_MODIFY="Please specify the LUKS device whose header shall be modified.

${LIB_SHTPL_EN_DLG_TXT_WARNING}
Please backup your header before continuing. In case the header gets corrupted, ALL YOUR DATA WILL BE PROBABLY LOST."
readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_SRC_OPEN="Please specify the LUKS device that shall be opened (decrypted)."
readonly L_LUKS_EN_DLG_TXT_ARG_DEVICE_SRC_2="${L_LUKS_EN_DLG_TXT_ARG_DEVICE_DST_2}"

#-------------------------------------------------------------------------------
#  arg_fido2_device
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_FIDO2_DEVICE_1="FIDO2 Security Token"
readonly L_LUKS_EN_DLG_TTL_ARG_FIDO2_DEVICE_3="${LIB_SHTPL_EN_DLG_TTL_ERROR}"

readonly L_LUKS_EN_DLG_TXT_ARG_FIDO2_DEVICE_1="How shall the FIDO2 token be chosen?"
readonly L_LUKS_EN_DLG_TXT_ARG_FIDO2_DEVICE_2="Please select a FIDO2 token from the following device list:"
readonly L_LUKS_EN_DLG_TXT_ARG_FIDO2_DEVICE_3="No FIDO2 token found."

readonly L_LUKS_EN_DLG_ITM_ARG_FIDO2_DEVICE_AUTO="Automatically (exactly one (1) token, no other token must be connected)"
readonly L_LUKS_EN_DLG_ITM_ARG_FIDO2_DEVICE_MANUAL="Manually (from a list of all currently connected Token)"

readonly L_LUKS_EN_HLP_DES_ARG_FIDO2_DEVICE="${L_LUKS_EN_HLP_REF_ARG_AUTH_FIDO2} Specify FIDO2 (hidraw) device to use, possible values are:"
readonly L_LUKS_EN_HLP_DES_ARG_FIDO2_DEVICE_AUTO="${L_LUKS_EN_DLG_ITM_ARG_FIDO2_DEVICE_AUTO}"
readonly L_LUKS_EN_HLP_DES_ARG_FIDO2_DEVICE_MANUAL="Manually, by specifying its devnode name (<dev> = /dev/hidraw...). To list all currently connected hidraw devices, just run '${L_ABOUT_RUN} --list-token fido2'."

#-------------------------------------------------------------------------------
#  arg_filesystem
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_FILESYSTEM="File System"
readonly L_LUKS_EN_DLG_TXT_ARG_FILESYSTEM="Please set the file system to use for mounting the opened LUKS device. In case you are in encryption mode this file system will be used for formatting the recently created LUKS device.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_EN_HLP_DES_ARG_FILESYSTEM="Filesystem to use for mounting or formatting"

#-------------------------------------------------------------------------------
#  arg_hash
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_HASH="Hash Algorithm (Password Hashing)"
readonly L_LUKS_EN_DLG_TXT_ARG_HASH="Please specify the algorithm that will be used for password hashing.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_EN_HLP_DES_ARG_HASH="Specify the passphrase hash (1). Run 'cryptsetup benchmark' to get a list of available algorithms."

#-------------------------------------------------------------------------------
#  arg_headerfile
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_HEADERFILE="Header File"
readonly L_LUKS_EN_DLG_TXT_ARG_HEADERFILE_BACKUP="${LIB_SHTPL_EN_DLG_TXT_FILE_OUT_NOOVERRIDE}"
readonly L_LUKS_EN_DLG_TXT_ARG_HEADERFILE_RESTORE="Please select the file to restore the header from."

#-------------------------------------------------------------------------------
#  arg_key_size
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_KEY_SIZE="Key Length"
readonly L_LUKS_EN_DLG_TXT_ARG_KEY_SIZE="Please set the key length (in bits). Important if you use a cipher with XTS operation mode: XTS splits the supplied key in half, e.g. for XTS-AES-256 you need a key size of 512 bits.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_EN_HLP_DES_ARG_KEY_SIZE="Specify key size in bits (1) (2)"

#-------------------------------------------------------------------------------
#  arg_iter_time
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_ITER_TIME="Iteration Time (PBKDF2 Password Processing)"
readonly L_LUKS_EN_DLG_TXT_ARG_ITER_TIME="Please specify a number of milliseconds to wait after user input. This is a mechanism against Brute Force Attacks.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_EN_HLP_DES_ARG_ITER_TIME="Specify number of milliseconds to spend with PBKDF2 passphrase processing"

#-------------------------------------------------------------------------------
#  arg_mapper
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_MAPPER="Device Mapper (/dev/mapper/...)"
readonly L_LUKS_EN_DLG_TXT_ARG_MAPPER="Please specify a unique device name to use for mapping the opened LUKS device.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_EN_HLP_DES_ARG_MAPPER="Map open LUKS device to '/dev/mapper/<name>'"

#-------------------------------------------------------------------------------
#  arg_mount
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_MOUNT="Mount Point"
readonly L_LUKS_EN_DLG_TXT_ARG_MOUNT="Please specify a path where the opened LUKS device will be mounted. In case you do not want to mount the device just leave this field empty.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_EN_HLP_DES_ARG_MOUNT="Specify mount point. Leave <mountpoint> empty (\"\") to prevent mounting."

#-------------------------------------------------------------------------------
#  arg_pkcs11_token_uri
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_PKCS11_TOKEN_URI_1="PKCS#11 Security Token URI"
readonly L_LUKS_EN_DLG_TTL_ARG_PKCS11_TOKEN_URI_3="${LIB_SHTPL_EN_DLG_TTL_ERROR}"

readonly L_LUKS_EN_DLG_TXT_ARG_PKCS11_TOKEN_URI_1="How shall the PKCS#11-compatible token be enrolled/removed?"
readonly L_LUKS_EN_DLG_TXT_ARG_PKCS11_TOKEN_URI_2="Please select a PKCS#11-compatible token from the following device list:"
readonly L_LUKS_EN_DLG_TXT_ARG_PKCS11_TOKEN_URI_3="No PKCS#11-compatible token found."

readonly L_LUKS_EN_DLG_ITM_ARG_PKCS11_TOKEN_URI_AUTO="${L_LUKS_EN_DLG_ITM_ARG_FIDO2_DEVICE_AUTO}"
readonly L_LUKS_EN_DLG_ITM_ARG_PKCS11_TOKEN_URI_MANUAL="${L_LUKS_EN_DLG_ITM_ARG_FIDO2_DEVICE_MANUAL}"

readonly L_LUKS_EN_HLP_DES_ARG_PKCS11_TOKEN_URI="${L_LUKS_EN_HLP_REF_ARG_AUTH_PKCS11} Specify PKCS#11 URI of the token object to use, possible values are:"
readonly L_LUKS_EN_HLP_DES_ARG_PKCS11_TOKEN_URI_AUTO="${L_LUKS_EN_DLG_ITM_ARG_PKCS11_TOKEN_URI_AUTO}"
readonly L_LUKS_EN_HLP_DES_ARG_PKCS11_TOKEN_URI_MANUAL="Manually, by specifying the URI (<uri> =  pkcs11:...). To list all currently discovered PKCS#11 token, just run '${L_ABOUT_RUN} --list-token pkcs11'."

#-------------------------------------------------------------------------------
#  arg_tpm2_device
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_TPM2_DEVICE_1="TPM2 Security Chip (Device)"
readonly L_LUKS_EN_DLG_TTL_ARG_TPM2_DEVICE_3="${LIB_SHTPL_EN_DLG_TTL_ERROR}"

readonly L_LUKS_EN_DLG_TXT_ARG_TPM2_DEVICE_1="How shall the TMP2 chip be added/removed?"
readonly L_LUKS_EN_DLG_TXT_ARG_TPM2_DEVICE_2="Please select a TPM2 chip from the following device list:"
readonly L_LUKS_EN_DLG_TXT_ARG_TPM2_DEVICE_3="No TPM2 chip found."

readonly L_LUKS_EN_DLG_ITM_ARG_TPM2_DEVICE_AUTO="Automatically (there must be exactly one (1) chip existing)"
readonly L_LUKS_EN_DLG_ITM_ARG_TPM2_DEVICE_MANUAL="Manually (from a list of all discovered chips)"

readonly L_LUKS_EN_HLP_DES_ARG_TPM2_DEVICE="${L_LUKS_EN_HLP_REF_ARG_AUTH_TPM2} Specify TPM2 security chip (device) to use, possible values are:"
readonly L_LUKS_EN_HLP_DES_ARG_TPM2_DEVICE_AUTO="${L_LUKS_EN_DLG_ITM_ARG_TPM2_DEVICE_AUTO}"
readonly L_LUKS_EN_HLP_DES_ARG_TPM2_DEVICE_MANUAL="Manually, by specifying its devnode name (<dev> = /dev/tpmrm...). To list all currently discovered TPM2 chips, just run '${L_ABOUT_RUN} --list-token tpm2'."

#-------------------------------------------------------------------------------
#  arg_tpm2_pcrs
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_TPM2_PCRS="TPM2 PCRs (Platform Configuration Registers)"
readonly L_LUKS_EN_DLG_TXT_ARG_TPM2_PCRS="Please specify one or more TPM2 PCRs (Platform Configuration Registers) to bind the requested enrollment to. This field requires a '+' separated list of PCR indexes in the range of 0...23. For more information please have a look at 'man systemd-cryptenroll', section '--tpm2-pcrs= [PCR...]'.

${LIB_SHTPL_EN_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_EN_HLP_DES_ARG_TPM2_PCRS="${L_LUKS_EN_HLP_REF_ARG_AUTH_TPM2} Specify one or more TPM2 PCRs (Platform Configuration Registers) to bind the requested enrollment to. <pcrs> must be a '+' separated list of PCR indexes in the range of 0...23. For more information please have a look at 'man systemd-cryptenroll', section '--tpm2-pcrs= [PCR...]'."

#-------------------------------------------------------------------------------
#  arg_with_pin
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_DLG_TTL_ARG_WITH_PIN="Request PIN to unlock?"
readonly L_LUKS_EN_DLG_TXT_ARG_WITH_PIN_FIDO2="Does the user have to enter the token's PIN before unlocking the LUKS device?

${LIB_SHTPL_EN_DLG_TXT_ATTENTION}
Your token must support FIDO2's 'clientPIN' feature."
readonly L_LUKS_EN_DLG_TXT_ARG_WITH_PIN_TPM2="Does the user have to enter the TPM2 PIN before unlocking the LUKS device?"
readonly L_LUKS_EN_HLP_DES_ARG_WITH_PIN="${L_LUKS_EN_HLP_REF_ARG_AUTH_FIDO2_OR_TPM2} Disable any PIN request during unlock. Not recommended."

#-------------------------------------------------------------------------------
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_HLP_DES_LASTARG="Block device to use, e.g. '/dev/sda'"

#-------------------------------------------------------------------------------
#  Script actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
#  Main Menu Title/Text
readonly L_LUKS_EN_DLG_TTL_ARG_ACTION="${L_ABOUT_PROJECT}"
readonly L_LUKS_EN_DLG_TXT_ARG_ACTION="What would you like to do?"

#  ARG_ACTION_BENCHMARK
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_BENCHMARK="Run a benchmark"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_BENCHMARK="${L_LUKS_EN_DLG_ITM_ARG_ACTION_BENCHMARK}"

#  ARG_ACTION_CLONE
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_CLONE="Clone a LUKS device"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_CLONE="Clone <src dev> to <dst dev>"

#  ARG_ACTION_CLOSE
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_CLOSE="Close/Lock an opened LUKS device"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_CLOSE="Close and unmount <device>"

#  ARG_ACTION_ENCRYPT
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_ENCRYPT="Encrypt a new device"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_ENCRYPT="Encrypt <device>"

#  ARG_ACTION_ENROLL
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_ENROLL="LUKS Header | Enroll a passphrase or a security token"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_ENROLL="Enroll a passphrase or a security token (FIDO2/PKCS#11/TPM2) to <device>'s LUKS header. ${L_LUKS_EN_HLP_REF_ARG_AUTH}"

#  ARG_ACTION_HEADER_BACKUP
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_HEADER_BACKUP="LUKS Header | Backup header"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_HEADER_BACKUP="Backup <device>'s LUKS header to <file> (4)"

#  ARG_ACTION_HEADER_INFO
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_HEADER_INFO="LUKS Header | Info"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_HEADER_INFO="Show information about <device>'s LUKS header"

#  ARG_ACTION_HEADER_RESTORE
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_HEADER_RESTORE="LUKS Header | Restore header"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_HEADER_RESTORE="Restore <device>'s LUKS header from <file>"

#  ARG_ACTION_IS_LUKS_DEVICE
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_IS_LUKS_DEVICE="Check whether <device> is a LUKS device. Return value: 0 = yes, 1 = no."

#  ARG_ACTION_LIST_TOKEN
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_LIST_TOKEN="List connected tokens of a certain type"

#  ARG_ACTION_OPEN
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_OPEN="Open/Unlock a LUKS device"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_OPEN="Open <device> and mount it. ${L_LUKS_EN_HLP_REF_ARG_AUTH}"

#  ARG_ACTION_REMOVE
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_REMOVE="LUKS Header | Remove a single passphrase or wipe an entire (security) token slot"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_REMOVE="Either remove a passphrase from <device>'s LUKS header or wipe an entire token slot (3)"

#  ARG_ACTION_REPLACE
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_REPLACE="LUKS Header | Replace entire FIDO2/PKCS#11/TPM2 security token slot"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_REPLACE="${L_LUKS_EN_HLP_REF_ARG_AUTH_FIDO2_OR_PKCS11_OR_TPM2} Replace an entire token slot by all (currently connected) security token"

#  ARG_ACTION_SHOW_DRIVES
readonly L_LUKS_EN_DLG_ITM_ARG_ACTION_SHOW_DRIVES="List all available internal and external storage devices"
readonly L_LUKS_EN_HLP_DES_ARG_ACTION_SHOW_DRIVES="Show available drives"

#===============================================================================
#  GLOBAL VARIABLES (CUSTOM)
#===============================================================================

#===============================================================================
#  FUNCTIONS (CUSTOM) (MENUS)
#===============================================================================

#===============================================================================
#  HELP
#===============================================================================
#-------------------------------------------------------------------------------
#  EXAMPLES
#-------------------------------------------------------------------------------
# Example 1
readonly L_LUKS_EN_HLP_TTL_EXAMPLES_1="Encrypt device"
readonly L_LUKS_EN_HLP_TXT_EXAMPLES_1="${L_LUKS_HLP_TXT_EXAMPLES_1}"

# Example 2
readonly L_LUKS_EN_HLP_TTL_EXAMPLES_2="Open and close device"
readonly L_LUKS_EN_HLP_TXT_EXAMPLES_2="${L_LUKS_HLP_TXT_EXAMPLES_2}"

# Example 3
readonly L_LUKS_EN_HLP_TTL_EXAMPLES_3="Enroll FIDO2 token"
readonly L_LUKS_EN_HLP_TXT_EXAMPLES_3="${L_LUKS_HLP_TXT_EXAMPLES_3}"

# Example 4
readonly L_LUKS_EN_HLP_TTL_EXAMPLES_4="Backup and recover header"
readonly L_LUKS_EN_HLP_TXT_EXAMPLES_4="${L_LUKS_HLP_TXT_EXAMPLES_4}"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------
# Note 1
readonly L_LUKS_EN_HLP_TXT_NOTES_1="\
Run 'cryptsetup --help' to show the defaults."

# Note 2
readonly L_LUKS_EN_HLP_TXT_NOTES_2="\
Important if you use a cipher with XTS operation mode:
XTS splits the supplied key in half, e.g. for AES-256 with
XTS mode you need a key size of 512 bits."

# Note 3
readonly L_LUKS_EN_HLP_TXT_NOTES_3="\
Use '--auth <type>' to define the authentication method that
should be removed from the LUKS header. If <type> is ...

          'passphrase' : Only the passphrase entered during prompt
                         will be removed from LUKS header

      'fido2'|'pkcs11' : ALL tokens of this type
     'recovery'|'tpm2'   will be removed from LUKS header"

# Note 4
readonly L_LUKS_EN_HLP_TXT_NOTES_4="\
IT IS HIGHLY RECOMMENDED TO STORE YOUR HEADER BACKUP ON A SEPARATE EXTERNAL
FLASH DRIVE. In case you delete passphrases/tokens from your header you must
also update your header backup files. Otherwise one could restore your old
header and use deprecated passphrases/tokens."

#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
#  Requirements 1
readonly L_LUKS_EN_HLP_TTL_REQUIREMENTS_1="General"
readonly L_LUKS_EN_HLP_TXT_REQUIREMENTS_1="\
Required Packages:
${L_LUKS_HLP_TXT_REQUIREMENTS_1}"

#  Requirements 2
readonly L_LUKS_EN_HLP_TTL_REQUIREMENTS_2="${LIB_SHTPL_EN_TXT_HELP_TTL_REQUIREMENTS_INTERACTIVE}"
readonly L_LUKS_EN_HLP_TXT_REQUIREMENTS_2="${LIB_SHTPL_EN_TXT_HELP_TXT_REQUIREMENTS_INTERACTIVE}"

#  Requirements 3
readonly L_LUKS_EN_HLP_TTL_REQUIREMENTS_3="FIDO2/PKCS#11/TMP2 Security Token/Chip (optional)"
readonly L_LUKS_EN_HLP_TXT_REQUIREMENTS_3="\
Please make sure that your OS is shipped with <systemd> version '251.3-1' or
higher. To check your current systemd version simply run
${L_LUKS_HLP_TXT_REQUIREMENTS_3_SYSTEMCTL}

FIDO2
  Your token must support the \"HMAC Secret Extension (hmac-secret)\".
  Additionally, the following packages must be installed:

${L_LUKS_HLP_TXT_REQUIREMENTS_3_FIDO2}

PKCS#11
  Your token must be initialized and contain a valid public/private key pair.
  Additionally, the following packages must be installed:

${L_LUKS_HLP_TXT_REQUIREMENTS_3_PKCS11_1}

  See also: ${L_LUKS_HLP_TXT_REQUIREMENTS_3_PKCS11_2}

TPM2
  Required Packages:

${L_LUKS_HLP_TXT_REQUIREMENTS_3_TPM2}

See also: ${L_LUKS_HLP_TXT_REQUIREMENTS_3_SEEALSO}"

#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------
# Intro Description
readonly L_LUKS_EN_HLP_TXT_INTRO="A collection of shell scripts to setup and manage LUKS2-encrypted drives."

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_LUKS_EN_HLP_TTL_TLDR_1="Requirements"
readonly L_LUKS_EN_HLP_TXT_TLDR_1="\
To install the neccessary packages on your system, simply run:

${L_LUKS_HLP_TXT_TLDR_1_INSTALL}

The script has been developed and tested on the following system:

OS:         ${L_LUKS_HLP_TXT_TLDR_1_OS}
Kernel:     ${L_LUKS_HLP_TXT_TLDR_1_KERNEL}
Packages:   ${L_LUKS_HLP_TXT_TLDR_1_PACKAGES}"

#===============================================================================
#  CUSTOM STRINGS (used in terminal output <stdout>/<stderr>)
#===============================================================================
#  DONE: Here you can define custom language-specific strings.
#        Do not forget to "publish" them within the <init_lang()> function of
#        your destination script, e.g. 'run.sh'.
#===============================================================================
readonly L_LUKS_EN_TXT_ARG_AUTH_NOT_SUPPORTED="Then selected authentication mechanism is not supported, some system requirements may not be met."
readonly L_LUKS_EN_TXT_CLONE_ERROR="Cloning process could not be completed"
readonly L_LUKS_EN_TXT_CLONE_INFO_CHECKSUM="Calculating checksum..."
readonly L_LUKS_EN_TXT_CLONE_INFO_CLONED="Drive successfully cloned."
readonly L_LUKS_EN_TXT_CLONE_INFO_CLONING="Cloning ..."
readonly L_LUKS_EN_TXT_ENCRYPT_INFO="successfully encrypted."
readonly L_LUKS_EN_TXT_ENROLL_INFO="Passphrase/Token successfully enrolled."
readonly L_LUKS_EN_TXT_ERROR_DEFAULT="Operation could not be completed."
readonly L_LUKS_EN_TXT_ERROR_IDENTICAL_DEVS="Identical source and destination device. ${LIB_SHTPL_EN_TXT_ABORTING}"
readonly L_LUKS_EN_TXT_HEADER_BACKUP_INFO="Header successfully backed up to"
readonly L_LUKS_EN_TXT_HEADER_RESTORE_INFO="LUKS header successfully restored."
readonly L_LUKS_EN_TXT_MSG_INFO_HEADER_INFO_BACKUP="It is highly recommended to test your LUKS device NOW and, in case everything works, update your backup drives as well as your header backup files."
readonly L_LUKS_EN_TXT_MSG_INFO_HEADER_INFO_CHANGED="INFO: LUKS header has changed ..."
readonly L_LUKS_EN_TXT_MSG_WARN_HEADER_INFO="It is highly recommended to backup the header before continuing"
readonly L_LUKS_EN_TXT_MSG_WARN_HEADER_WARN="Changing LUKS header ..."
readonly L_LUKS_EN_TXT_MSG_WARN_LSBLK_INFO_ENCRYPTING="Encrypting ..."
readonly L_LUKS_EN_TXT_MSG_WARN_LSBLK_WARN="All data on the following device will be lost:"
readonly L_LUKS_EN_TXT_OPEN_INFO_MOUNTED="Device successfully mounted at"
readonly L_LUKS_EN_TXT_OPEN_INFO_MOUNTING="Mounting ..."
readonly L_LUKS_EN_TXT_OPEN_INFO_OPENED="Device successfully opened and mapped to"
readonly L_LUKS_EN_TXT_OPEN_INFO_OPENING="Opening LUKS device ..."
readonly L_LUKS_EN_TXT_REMOVE_INFO="Passphrase/Token successfully removed."
readonly L_LUKS_EN_TXT_REPLACE_INFO="Token successfully replaced."
readonly L_LUKS_EN_TXT_UNMOUNT_ERROR="Could not unmount/close"
readonly L_LUKS_EN_TXT_UNMOUNT_INFO_CLOSED="successfully closed."
readonly L_LUKS_EN_TXT_UNMOUNT_INFO_CLOSING="Closing LUKS device"
readonly L_LUKS_EN_TXT_UNMOUNT_INFO_UNMOUNTED="successfully unmounted."
readonly L_LUKS_EN_TXT_UNMOUNT_INFO_UNMOUNTING="Unmounting"