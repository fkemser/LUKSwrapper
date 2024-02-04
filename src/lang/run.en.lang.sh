#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) <ABOUT_YEARS> <ABOUT_AUTHORS>
# SPDX-License-Identifier: <ABOUT_LICENSE>
#
#===============================================================================
#
#         FILE:   /src/lang/run.en.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   --English-- String Constants File for '/src/run.sh'
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
#  !!! IMPORTANT !!!
#===============================================================================
#  All constants (identifiers) must follow a certain naming convention,
#  see '/src/lang/run.0.lang.sh'

#===============================================================================
#  PARAMETER (TEMPLATE) - DO NOT EDIT
#===============================================================================
#  Script actions <ARG_ACTION_...>
readonly L_RUN_EN_HLP_DES_ARG_ACTION_HELP="${LIB_SHTPL_EN_HLP_DES_ARG_ACTION_HELP}"

#  Log destination <ARG_LOGDEST_...>
readonly L_RUN_EN_HLP_DES_ARG_LOGDEST="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST}"
readonly L_RUN_EN_HLP_DES_ARG_LOGDEST_BOTH="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_BOTH}"
readonly L_RUN_EN_HLP_DES_ARG_LOGDEST_SYSLOG="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_SYSLOG}"
readonly L_RUN_EN_HLP_DES_ARG_LOGDEST_TERMINAL="${LIB_SHTPL_EN_HLP_DES_ARG_LOGDEST_TERMINAL}"

#  Script operation modes <ARG_MODE_...>
readonly L_RUN_EN_HLP_DES_ARG_MODE_DAEMON="${LIB_SHTPL_EN_HLP_DES_ARG_MODE_DAEMON}"
readonly L_RUN_EN_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_EN_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#-------------------------------------------------------------------------------
#  arg_bool
#-------------------------------------------------------------------------------
readonly L_RUN_EN_DLG_TTL_ARG_BOOL="Dialogue Title <arg_bool>"
readonly L_RUN_EN_DLG_TXT_ARG_BOOL="Dialogue Text <arg_bool>"
readonly L_RUN_EN_HLP_DES_ARG_BOOL="Help <arg_bool>"
readonly L_RUN_EN_HLP_REF_ARG_BOOL="Use '${L_RUN_HLP_PAR_ARG_BOOL}' to enable <arg_bool>"

#-------------------------------------------------------------------------------
#  arg_dir
#-------------------------------------------------------------------------------
readonly L_RUN_EN_DLG_TTL_ARG_DIR="Dialogue Title <arg_dir>"
readonly L_RUN_EN_DLG_TXT_ARG_DIR_IN="Please select a source folder."
readonly L_RUN_EN_DLG_TXT_ARG_DIR_OUT="Please select a destination folder."
readonly L_RUN_EN_HLP_DES_ARG_DIR="Help <arg_dir>"
readonly L_RUN_EN_HLP_REF_ARG_DIR="Use '${L_RUN_HLP_PAR_ARG_DIR}' to specify the source/destination folder"

#-------------------------------------------------------------------------------
#  arg_file
#-------------------------------------------------------------------------------
readonly L_RUN_EN_DLG_TTL_ARG_FILE="Dialogue Title <arg_file>"
readonly L_RUN_EN_DLG_TXT_ARG_FILE_IN="Please select an existing file."
readonly L_RUN_EN_DLG_TXT_ARG_FILE_OUT="Please specify a path where the  file will be stored. Existing files will not(!) be overwritten."
readonly L_RUN_EN_HLP_DES_ARG_FILE="Help <arg_file>"
readonly L_RUN_EN_HLP_REF_ARG_FILE="Use '${L_RUN_HLP_PAR_ARG_FILE}' to specify the file to use/create"

#-------------------------------------------------------------------------------
#  arg_int
#-------------------------------------------------------------------------------
readonly L_RUN_EN_DLG_TTL_ARG_INT="Dialogue Title <arg_int>"
readonly L_RUN_EN_DLG_TXT_ARG_INT="Please specify a number for <arg_int>."
readonly L_RUN_EN_HLP_DES_ARG_INT="Help <arg_int>"
readonly L_RUN_EN_HLP_REF_ARG_INT="Use '${L_RUN_HLP_PAR_ARG_INT}' to specify <arg_int>'s value"

#-------------------------------------------------------------------------------
#  arg_item
#-------------------------------------------------------------------------------
readonly L_RUN_EN_DLG_TTL_ARG_ITEM="Dialogue Title <arg_item>"
readonly L_RUN_EN_DLG_TXT_ARG_ITEM="Dialogue Text <arg_item>"
readonly L_RUN_EN_DLG_ITM_ARG_ITEM_ITEM1="Dialogue List Item <ARG_ITEM_ITEM1>"
readonly L_RUN_EN_DLG_ITM_ARG_ITEM_ITEM2="Dialogue List Item <ARG_ITEM_ITEM2>"
readonly L_RUN_EN_HLP_DES_ARG_ITEM="Help <arg_item>"
readonly L_RUN_EN_HLP_DES_ARG_ITEM_ITEM1="Help <ARG_ITEM_ITEM1>"
readonly L_RUN_EN_HLP_DES_ARG_ITEM_ITEM2="Help <ARG_ITEM_ITEM2>"
readonly L_RUN_EN_HLP_REF_ARG_ITEM="Use '${L_RUN_HLP_PAR_ARG_ITEM}' to specify <arg_item>'s value"

#-------------------------------------------------------------------------------
#  arg_password
#-------------------------------------------------------------------------------
readonly L_RUN_EN_DLG_TTL_ARG_PASSWORD="Dialogue Title <arg_password>"
readonly L_RUN_EN_DLG_TXT_ARG_PASSWORD="Dialogue Text <arg_password>"
readonly L_RUN_EN_HLP_DES_ARG_PASSWORD="Help <arg_password>. See also (1)."

#-------------------------------------------------------------------------------
#  arg_str
#-------------------------------------------------------------------------------
readonly L_RUN_EN_DLG_TTL_ARG_STR="Dialogue Title <arg_str>"
readonly L_RUN_EN_DLG_TXT_ARG_STR_1="Dialogue Text <arg_str> Part 1, extended by some command's output, e.g. 'date':"
readonly L_RUN_EN_DLG_TXT_ARG_STR_2="\
Dialogue Text <arg_str> Part 2

In this case only alphanumeric characters [A-Za-z0-9] are allowed. Select <OK> to continue or <${LIB_SHTPL_EN_TXT_GOBACK}> to get to the previous menu."
readonly L_RUN_EN_HLP_DES_ARG_STR="Help <arg_str>"
readonly L_RUN_EN_HLP_REF_ARG_STR="Use '${L_RUN_HLP_PAR_ARG_STR}' to specify <arg_str>'s value"

#-------------------------------------------------------------------------------
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#-------------------------------------------------------------------------------
readonly L_RUN_EN_HLP_DES_LASTARG="File to use"

#-------------------------------------------------------------------------------
#  Script actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
#  Main Menu Title/Text
readonly L_RUN_EN_DLG_TTL_ARG_ACTION="SHtemplate"
readonly L_RUN_EN_DLG_TXT_ARG_ACTION="What would you like to do?"

#  ARG_ACTION_CUSTOM1
readonly L_RUN_EN_DLG_ITM_ARG_ACTION_CUSTOM1="Dialogue List Item <ARG_ACTION_CUSTOM1>"
readonly L_RUN_EN_HLP_DES_ARG_ACTION_CUSTOM1="Help <ARG_ACTION_CUSTOM1>"

#  ARG_ACTION_CUSTOM2
readonly L_RUN_EN_DLG_ITM_ARG_ACTION_CUSTOM2="Dialogue List Item <ARG_ACTION_CUSTOM2>"
readonly L_RUN_EN_HLP_DES_ARG_ACTION_CUSTOM2="Help <ARG_ACTION_CUSTOM2> ${L_RUN_EN_HLP_REF_ARG_BOOL}. ${L_RUN_EN_HLP_REF_ARG_ITEM}."

#  ARG_ACTION_CUSTOM3
readonly L_RUN_EN_DLG_ITM_ARG_ACTION_CUSTOM3="Dialogue List Item <ARG_ACTION_CUSTOM3>"
readonly L_RUN_EN_HLP_DES_ARG_ACTION_CUSTOM3="Help <ARG_ACTION_CUSTOM3>. Regarding <dir> please have a look at '${L_RUN_HLP_PAR_ARG_DIR}'."

#  ARG_ACTION_CUSTOM4
readonly L_RUN_EN_DLG_ITM_ARG_ACTION_CUSTOM4="Dialogue List Item <ARG_ACTION_CUSTOM4>"
readonly L_RUN_EN_HLP_DES_ARG_ACTION_CUSTOM4="Help <ARG_ACTION_CUSTOM4>. Regarding <int> and <str> please have a look at '${L_RUN_HLP_PAR_ARG_INT}' and '${L_RUN_HLP_PAR_ARG_STR}'."

#  ARG_ACTION_CUSTOM5
readonly L_RUN_EN_DLG_ITM_ARG_ACTION_CUSTOM5="Dialogue List Item <ARG_ACTION_CUSTOM5>"
readonly L_RUN_EN_HLP_DES_ARG_ACTION_CUSTOM5="Help <ARG_ACTION_CUSTOM5>. Either use a given <file> or <stdin>'s (pipe) content ('echo \"string\" | ${L_ABOUT_RUN} --custom5')."

#  ARG_ACTION_CUSTOM6
readonly L_RUN_EN_DLG_ITM_ARG_ACTION_CUSTOM6="Dialogue List Item <ARG_ACTION_CUSTOM6>"
readonly L_RUN_EN_HLP_DES_ARG_ACTION_CUSTOM6="Help <ARG_ACTION_CUSTOM6>"

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
#  Example 1
readonly L_RUN_EN_HLP_TTL_EXAMPLES_1="Example 1"
readonly L_RUN_EN_HLP_TXT_EXAMPLES_1="${L_RUN_HLP_TXT_EXAMPLES_1}"

#  Example 2
readonly L_RUN_EN_HLP_TTL_EXAMPLES_2="Example 2"
readonly L_RUN_EN_HLP_TXT_EXAMPLES_2="${L_RUN_HLP_TXT_EXAMPLES_2}"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------
#  Note 1
readonly L_RUN_EN_HLP_TXT_NOTES_1="${LIB_SHTPL_EN_TXT_HELP_TXT_NOTES_CREDENTIALS_ENV}"

#  Note 2
readonly L_RUN_EN_HLP_TXT_NOTES_2="This is the text of note 2."

#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
#  Requirements 1
readonly L_RUN_EN_HLP_TTL_REQUIREMENTS_1="General"
readonly L_RUN_EN_HLP_TXT_REQUIREMENTS_1="\
Required Packages:
${L_RUN_HLP_TXT_REQUIREMENTS_1_REQUIRED}

Optional Packages:
${L_RUN_HLP_TXT_REQUIREMENTS_1_OPTIONAL}

(...)"

#  Requirements 2
readonly L_RUN_EN_HLP_TTL_REQUIREMENTS_2="${LIB_SHTPL_EN_TXT_HELP_TTL_REQUIREMENTS_INTERACTIVE}"
readonly L_RUN_EN_HLP_TXT_REQUIREMENTS_2="${LIB_SHTPL_EN_TXT_HELP_TXT_REQUIREMENTS_INTERACTIVE}"

#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------
#  Intro Description
readonly L_RUN_EN_HLP_TXT_INTRO="A template repository for Bourne-Shell (sh) projects."

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_RUN_EN_HLP_TTL_TLDR_1="Requirements"
readonly L_RUN_EN_HLP_TXT_TLDR_1="\
To install the necessary packages on your system, simply run:

${L_RUN_HLP_TXT_TLDR_1_INSTALL}

(...further requirements...)

The script has been developed and tested on the following system:

OS:         ${L_RUN_HLP_TXT_TLDR_1_OS}
Kernel:     ${L_RUN_HLP_TXT_TLDR_1_KERNEL}
Packages:   ${L_RUN_HLP_TXT_TLDR_1_PACKAGES}"

#===============================================================================
#  CUSTOM STRINGS (used in terminal output <stdout>/<stderr>)
#===============================================================================
#  TODO: Here you can define custom language-specific strings.
#        Do not forget to "publish" them within the <init_lang()> function of
#        your destination script, e.g. 'run.sh'.
#===============================================================================
readonly L_RUN_EN_TXT_DUMMY="This is a dummy output to show you how this script works."