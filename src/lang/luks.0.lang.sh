#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the LUKSwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/lang/luks.0.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   String Constants Files for '/src/luks.sh' - Used to generate
#                 <help()> texts, interactive dialogues, and other
#                 terminal/log messages.
#
#         BUGS:   ---
#
#        NOTES:   ---
#
#        TODO:    See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  NAMING CONVENTION
#===============================================================================
#  Please make sure that your constants follow the naming convention below.
#  This ensures that <help()> and 'dialog' menus can be created more or less
#  automatically.
#
#===============================================================================
#  Language-independent constants, to be stored within THIS file
#===============================================================================
#-------------------------------------------------------------------------------
#  Used in help, section "SYNOPSIS"
#-------------------------------------------------------------------------------
#  Constant                       Description             Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_HLP_PAR_<REF>            Parameter cmd switch    -i|--int <int>
#  (L_RUN_HLP_PAR_ARG_INT)
#
#-------------------------------------------------------------------------------
#  Used in help, sections "REFERENCES"
#-------------------------------------------------------------------------------
#  Constant                       Description         Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_HLP_TXT_REFERENCES_<I>   Reference           https://www.example.com
#  (L_RUN_HLP_TXT_REFERENCES_1)
#
#===============================================================================
#  Language-specific constants, to be stored within ANOTHER file,
#  e.g. within 'run.en.sh' for English, 'run.de.sh' for German, etc.
#===============================================================================
#-------------------------------------------------------------------------------
#  Used in interactive ('dialog') menus
#  (For more information on dialog please run 'dialog --help' or 'man dialog')
#-------------------------------------------------------------------------------
#  Constant                             Description       Parameter (dialog)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_<LL>_DLG_ITM_<REF>             List item         <item1>...
#  (L_RUN_EN_DLG_ITM_ARG_ITEM_ITEM1)
#
#  L_<S>_<LL>_DLG_TTL_<REF>             Title             [--title <title>]
#  (L_RUN_EN_DLG_TTL_ARG_ITEM)
#
#  L_<S>_<LL>_DLG_TXT_<REF>             Text              <text>
#  (L_RUN_EN_DLG_TXT_ARG_ITEM)
#
#-------------------------------------------------------------------------------
#  Used in help, section "SYNOPSIS"
#-------------------------------------------------------------------------------
#  Constant                   Description             Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_<LL>_HLP_DES_<REF>   Parameter description   Help <arg_int>
#  (L_RUN_EN_HLP_DES_ARG_INT)
#
#  L_<S>_<LL>_HLP_REF_<REF>   Reference description   Use '-i|--int <int>' to
#  (L_RUN_EN_HLP_REF_ARG_INT)                         specify <arg_int>'s value.
#
#-------------------------------------------------------------------------------
#  Used in help, sections "EXAMPLES" "NOTES" "REFERENCES" "REQUIREMENTS" "TLDR"
#-------------------------------------------------------------------------------
#  Constant                             Description       Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_<LL>_HLP_TTL_EXAMPLES_<I>      Example (Title)   Show Help
#  (L_RUN_EN_HLP_TTL_EXAMPLES_1)
#
#  L_<S>_<LL>_HLP_TXT_EXAMPLES_<I>      Example (Text)    ./run.sh --help
#  (L_RUN_EN_HLP_TXT_EXAMPLES_1)
#
#  L_<S>_<LL>_HLP_TXT_NOTES_<I>         Note (Text)       This is the first note.
#  (L_RUN_EN_HLP_TXT_NOTES_1)
#
#  L_<S>_<LL>_HLP_TTL_REQUIREMENTS_<I>  Requirements (Title)  General
#  (L_RUN_EN_HLP_TTL_REQUIREMENTS_1)
#
#  L_<S>_<LL>_HLP_TXT_REQUIREMENTS_<I>  Requirements (Text)   To run this ...
#  (L_RUN_EN_HLP_TXT_REQUIREMENTS_1)
#
#  L_<S>_<LL>_HLP_TTL_TLDR_<I>          TL;DR (Title)     Requirements
#  (L_RUN_EN_HLP_TTL_TLDR_1)
#
#  L_<S>_<LL>_HLP_TXT_TLDR_<I>          TL;DR (Text)      Please install ...
#  (L_RUN_EN_HLP_TXT_TLDR_1)
#
#-------------------------------------------------------------------------------
#  Used in terminal output (<stdout>/<stderr>)
#-------------------------------------------------------------------------------
#  Constant             Description                               Example (value)
#  (Example)
#  -----------------------------------------------------------------------------
#  L_<S>_<LL>_TXT_<T>   Custom language-specific text constants   Text 1 (English)
#  (L_RUN_EN_TXT_TEXT1)
#
#===============================================================================
#  Reference
#===============================================================================
#  <...>  Description                                           Example(s)
#  -----------------------------------------------------------------------------
#  <I>    Index/Counter, starting from 1                        1
#
#  <LL>   Language ID (ISO 639-1)                               EN
#
#  <REF>  Function, parameter, or parameter list value          HELP
#         this constant refers to                               ARG_ACTION
#                                                               ARG_ACTION_HELP
#
#  <S>    "Reverse" script name without '.sh'                   RUN
#
#  <T>    Identifier that describes what the string is about    ERR_NOT_FOUND
#===============================================================================

#===============================================================================
#  PARAMETER (TEMPLATE) - DO NOT EDIT
#===============================================================================
#  Script actions <ARG_ACTION_...>
readonly L_LUKS_HLP_PAR_ARG_ACTION_HELP="${LIB_SHTPL_HLP_PAR_ARG_ACTION_HELP}"

#  Log destination <ARG_LOGDEST_...>
readonly L_LUKS_HLP_PAR_ARG_LOGDEST="${LIB_SHTPL_HLP_PAR_ARG_LOGDEST}"

#  Script operation modes <ARG_MODE_...>
readonly L_LUKS_HLP_PAR_ARG_MODE_DAEMON="${LIB_SHTPL_HLP_PAR_ARG_MODE_DAEMON}"
readonly L_LUKS_HLP_PAR_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_HLP_PAR_ARG_MODE_INTERACTIVE_SUBMENU}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#-------------------------------------------------------------------------------
#  Script actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
readonly L_LUKS_HLP_PAR_ARG_ACTION_BENCHMARK="--benchmark"
readonly L_LUKS_HLP_PAR_ARG_ACTION_CLONE="--clone <src dev> <dst dev>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_CLOSE="--close <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_ENCRYPT="--encrypt <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_ENROLL="--enroll <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_HEADER_BACKUP="--header-backup <device> <file>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_HEADER_INFO="--header-info <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_HEADER_RESTORE="--header-restore <file> <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_IS_LUKS_DEVICE="--is-luks-device <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_LIST_TOKEN="--list-token <type>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_OPEN="--open <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_REMOVE="--remove <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_REPLACE="--replace <device>"
readonly L_LUKS_HLP_PAR_ARG_ACTION_SHOW_DRIVES="--show-drives"

#-------------------------------------------------------------------------------
#  Other parameters <arg_...>
#-------------------------------------------------------------------------------
readonly L_LUKS_HLP_PAR_ARG_AUTH="--auth <type>"
readonly L_LUKS_HLP_PAR_ARG_CIPHER="-c|--cipher <cipher>"
readonly L_LUKS_HLP_PAR_ARG_FIDO2_DEVICE="--fido2-device <dev>"
readonly L_LUKS_HLP_PAR_ARG_FILESYSTEM="--filesystem <fs>"
readonly L_LUKS_HLP_PAR_ARG_HASH="--hash <algorithm>"
readonly L_LUKS_HLP_PAR_ARG_KEY_SIZE="-s|--key-size <bits>"
readonly L_LUKS_HLP_PAR_ARG_ITER_TIME="-i|--iter-time <t>"
readonly L_LUKS_HLP_PAR_ARG_MAPPER="--mapper <name>"
readonly L_LUKS_HLP_PAR_ARG_MOUNT="--mount <mountpoint>"
readonly L_LUKS_HLP_PAR_ARG_PKCS11_TOKEN_URI="--pkcs11-token-uri <uri>"
readonly L_LUKS_HLP_PAR_ARG_TPM2_DEVICE="--tpm2-device <dev>"
readonly L_LUKS_HLP_PAR_ARG_TPM2_PCRS="--tpm2-pcrs <pcrs>"
readonly L_LUKS_HLP_PAR_ARG_WITH_PIN="--no-pin"

#-------------------------------------------------------------------------------
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#-------------------------------------------------------------------------------
readonly L_LUKS_HLP_PAR_LASTARG="[<device>]"

#===============================================================================
#  HELP
#===============================================================================
#-------------------------------------------------------------------------------
#  EXAMPLES
#-------------------------------------------------------------------------------
# Example 1
readonly L_LUKS_HLP_TXT_EXAMPLES_1="\
${L_ABOUT_RUN} --show-drives
${L_ABOUT_RUN} --cipher aes-xts-plain64 --hash sha256 --iter-time 2000 --key-size 512 --filesystem ext4 --encrypt /dev/sdz"

# Example 2
readonly L_LUKS_HLP_TXT_EXAMPLES_2="\
${L_ABOUT_RUN} --show-drives
${L_ABOUT_RUN} --mapper mymapper --filesystem auto --open /dev/sdz
${L_ABOUT_RUN} --close /dev/sdz"

# Example 3
readonly L_LUKS_HLP_TXT_EXAMPLES_3="\
${L_ABOUT_RUN} --auth fido2 --fido2-device auto --enroll /dev/sdz
${L_ABOUT_RUN} --auth fido2 --fido2-device auto --mapper mymapper --open /dev/sdz
${L_ABOUT_RUN} --close /dev/sdz"

# Example 4
readonly L_LUKS_HLP_TXT_EXAMPLES_4="\
${L_ABOUT_RUN} --header-info /dev/sdz
${L_ABOUT_RUN} --header-backup /dev/sdz /tmp/luks.header
${L_ABOUT_RUN} --header-restore /tmp/luks.header /dev/sdz"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  REFERENCES
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
readonly L_LUKS_HLP_TXT_REQUIREMENTS_1="\
  General: Cryptsetup, PipeViewer
   Debian: > sudo apt install cryptsetup pv"
readonly L_LUKS_HLP_TXT_REQUIREMENTS_3_SYSTEMCTL="\
  > systemctl --version"
readonly L_LUKS_HLP_TXT_REQUIREMENTS_3_FIDO2="\
  General: libfido2.so.1
   Debian: > sudo apt install libfido2-1"
readonly L_LUKS_HLP_TXT_REQUIREMENTS_3_PKCS11_1="\
  General: OpenSC (PKCS#11 module), PCSClite, USB PC/SC CCID driver
   Debian: > sudo apt install opensc-pkcs11 pcscd libccid"
readonly L_LUKS_HLP_TXT_REQUIREMENTS_3_PKCS11_2="\
https://github.com/shimunn/fido2luks/tree/master#theory-of-operation"
readonly L_LUKS_HLP_TXT_REQUIREMENTS_3_SEEALSO="\
https://manpages.debian.org/experimental/systemd/systemd-cryptenroll.1.en.html"
readonly L_LUKS_HLP_TXT_REQUIREMENTS_3_TPM2="\
  General: TPM2 Software stack library - TSS and TCTI libraries
   Debian: > sudo apt install libtss2-esys-3.0.2-0 libtss2-rc0"

#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_LUKS_HLP_TXT_TLDR_1_INSTALL="\
Debian
> sudo apt install dialog cryptsetup pv libfido2-1 opensc-pkcs11 pcscd libccid \\
                   libtss2-esys-3.0.2-0 libtss2-rc0"
readonly L_LUKS_HLP_TXT_TLDR_1_KERNEL="6.1.0-17-amd64"
readonly L_LUKS_HLP_TXT_TLDR_1_OS="Debian GNU/Linux 12 (bookworm)"
readonly L_LUKS_HLP_TXT_TLDR_1_PACKAGES="\
Dialog (1.3-20230209-1), Cryptsetup (2:2.6.1-4~deb12u1), PipeViewer (1.6.20-1),
            libfido2-1 (1.12.0-2+b1), OpenSC (PKCS#11 module) (0.23.0-0.3+deb12u1),
            PCSClite (1.9.9-2), USB PC/SC CCID driver (1.5.2-1),
            libtss2-esys-3.0.2-0 (3.2.1-3), libtss2-rc0 (3.2.1-3)"