#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) <ABOUT_YEARS> <ABOUT_AUTHORS>
# SPDX-License-Identifier: <ABOUT_LICENSE>
#
#===============================================================================
#
#         FILE:   /src/lang/run.0.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   String Constants Files for '/src/run.sh'
#                 Used to generate help texts, interactive dialogues,
#                 and other terminal/log messages.
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
readonly L_RUN_HLP_PAR_ARG_ACTION_HELP="${LIB_SHTPL_HLP_PAR_ARG_ACTION_HELP}"

#  Script operation modes <ARG_MODE_...>
readonly L_RUN_HLP_PAR_ARG_MODE_DAEMON="${LIB_SHTPL_HLP_PAR_ARG_MODE_DAEMON}"
readonly L_RUN_HLP_PAR_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_HLP_PAR_ARG_MODE_INTERACTIVE_SUBMENU}"

#  Log destination <ARG_LOGDEST_...>
readonly L_RUN_HLP_PAR_ARG_LOGDEST="${LIB_SHTPL_HLP_PAR_ARG_LOGDEST}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#-------------------------------------------------------------------------------
#  Script actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
readonly L_RUN_HLP_PAR_ARG_ACTION_CUSTOM1="--custom1"
readonly L_RUN_HLP_PAR_ARG_ACTION_CUSTOM2="--custom2"
readonly L_RUN_HLP_PAR_ARG_ACTION_CUSTOM3="--custom3 <dir>"
readonly L_RUN_HLP_PAR_ARG_ACTION_CUSTOM4="--custom4 <int> <str>"
readonly L_RUN_HLP_PAR_ARG_ACTION_CUSTOM5="--custom5 [<file>]"
readonly L_RUN_HLP_PAR_ARG_ACTION_CUSTOM6="--custom6"

#-------------------------------------------------------------------------------
#  Other parameters <arg_...>
#-------------------------------------------------------------------------------
readonly L_RUN_HLP_PAR_ARG_BOOL="-b|--bool"
readonly L_RUN_HLP_PAR_ARG_DIR="-d|--dir <dir>"
readonly L_RUN_HLP_PAR_ARG_FILE="-f|--file <file>"
readonly L_RUN_HLP_PAR_ARG_INT="-i|--int <int>"
readonly L_RUN_HLP_PAR_ARG_ITEM="-j|--item <item>"
readonly L_RUN_HLP_PAR_ARG_PASSWORD="-p|--password <pwd>"
readonly L_RUN_HLP_PAR_ARG_STR="-s|--str <string>"

#-------------------------------------------------------------------------------
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#-------------------------------------------------------------------------------
readonly L_RUN_HLP_PAR_LASTARG="[<file>]"

#===============================================================================
#  HELP
#===============================================================================
#-------------------------------------------------------------------------------
#  EXAMPLES
#-------------------------------------------------------------------------------
readonly L_RUN_HLP_TXT_EXAMPLES_1="\
> ${L_ABOUT_RUN} --custom1"
readonly L_RUN_HLP_TXT_EXAMPLES_2="\
> ${L_ABOUT_RUN} --custom2 --item item2"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  REFERENCES
#-------------------------------------------------------------------------------
readonly L_RUN_HLP_TXT_REFERENCES_1="https://www.example.com"
readonly L_RUN_HLP_TXT_REFERENCES_2="https://www.example.org"

#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
readonly L_RUN_HLP_TXT_REQUIREMENTS_1_REQUIRED="\
  General: (...)
  Debian:  > sudo apt install (...)"
readonly L_RUN_HLP_TXT_REQUIREMENTS_1_OPTIONAL="\
  General: (...)
  Debian:  > sudo apt install (...)"

#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_RUN_HLP_TXT_TLDR_1_INSTALL="\
Debian
> sudo apt install dialog (...)"
readonly L_RUN_HLP_TXT_TLDR_1_KERNEL="... (Run 'uname -r')"
readonly L_RUN_HLP_TXT_TLDR_1_OS="... (Run 'cat /etc/*release')"
readonly L_RUN_HLP_TXT_TLDR_1_PACKAGES="Dialog (...), (...)"