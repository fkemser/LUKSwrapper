#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) <ABOUT_YEARS> <ABOUT_AUTHORS>
# SPDX-License-Identifier: <ABOUT_SPDX_LICENSE_IDENTIFIER>
#
#===============================================================================
#
#         FILE:   /src/run.sh
#
#        USAGE:   Run <run.sh -h> for more information
#
#  DESCRIPTION:   Repository Run File
#
#      OPTIONS:   Run <run.sh -h> for more information
#
# REQUIREMENTS:   Run <run.sh -h> for more information
#
#         BUGS:   ---
#
#        NOTES:   Please edit the configuration file (/etc/run.cfg.sh)
#                 before you start.
#
#        TODO:    See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  CONFIG
#===============================================================================
#  TODO: Enable PID based locking? (true|false)
#  (If 'true' then parts of the script require root privileges.)
readonly PIDLOCK_ENABLED="false"

#===============================================================================
#  INIT - DO NOT EDIT
#===============================================================================
#  Run repository initialization script
. "$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )/init.sh"              || \
{ printf "%s\n\n"                                                           \
    "ERROR: Could not run the repository initialization script './init.sh'. Aborting..." >&2
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
#                        TODO: DEFINE YOUR ACTIONS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
readonly ARG_ACTION_CUSTOM1="custom1"   # Sample action 1
readonly ARG_ACTION_CUSTOM2="custom2"   # Sample action 2
readonly ARG_ACTION_CUSTOM3="custom3"   # Sample action 3
readonly ARG_ACTION_CUSTOM4="custom4"   # Sample action 4
readonly ARG_ACTION_CUSTOM5="custom5"   # Sample action 5
readonly ARG_ACTION_CUSTOM6="custom6"   # Sample action 6
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                        TODO: DEFINE YOUR ACTIONS HERE
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
#                       TODO: DEFINE YOUR PARAMETERS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
# Sample parameter that either takes an argument
# or, if not set, <stdin>'s content, see <args_read()>
arg_arg_or_stdin=""

arg_bool="false"                          # Sample boolean parameter
arg_dir="${I_DIR_TEST}"                   # Sample directory parameter (see <main_daemon()>)
arg_file=""                               # Sample file parameter

# Sample integer parameter with a range of allowed values
readonly ARG_INT_MIN="0"
readonly ARG_INT_MAX="10"
arg_int="1"

# Sample list item parameter
readonly ARG_ITEM_ITEM1="item1"
readonly ARG_ITEM_ITEM2="item2"
readonly ARG_ITEM_LIST="ITEM1 ITEM2"
arg_item="${ARG_ITEM_ITEM1}"

arg_password=""                           # Sample password parameter

# Sample string parameter
readonly ARG_STR_DEFAULT="abc123"
arg_str="${ARG_STR_DEFAULT}"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                       TODO: DEFINE YOUR PARAMETERS HERE
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
#                    TODO: DEFINE YOUR GLOBAL VARIABLES HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
var1=""
var2=""
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    TODO: DEFINE YOUR GLOBAL VARIABLES HERE
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
readonly ARG_ACTION_LIST_INTERACTIVE="CUSTOM2 CUSTOM3 CUSTOM4 CUSTOM5 CUSTOM6"
# Classic script mode
readonly ARG_ACTION_LIST_SCRIPT="HELP CUSTOM1 CUSTOM2 CUSTOM3 CUSTOM4 CUSTOM5"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                      DONE: DEFINE YOUR ACTION LISTS HERE
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#                    TODO: DEFINE YOUR PARAMETER LISTS HERE
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
readonly LIST_ARG="ARG_BOOL ARG_FILE ARG_INT ARG_ITEM ARG_LOGDEST ARG_PASSWORD ARG_STR"

#-------------------------------------------------------------------------------
#  Lists of parameters to clear/reset (interactive mode only)
#-------------------------------------------------------------------------------
#  List of arguments that have to be cleared or reset to their default values
#  after running <run()> function (interactive mode only).
#  To assign a default value to a parameter please define a constant (above)
#  with the suffix '_DEFAULT', e.g. <ARG_STR_DEFAULT> for <arg_str>.
#  !!! Use the variable's name as defined, so usually lowercase letters !!!
readonly LIST_ARG_CLEANUP_INTERACTIVE="arg_str"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    TODO: DEFINE YOUR PARAMETER LISTS HERE
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

# Daemon mode sleep interval (in s), see <main_daemon()>
readonly T_DAEMON_SLEEP="60"

#===============================================================================
#  GLOBAL CONSTANTS (CUSTOM)
#===============================================================================
#                    TODO: DEFINE YOUR GLOBAL CONSTANTS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#-------------------------------------------------------------------------------
# Test file extension for sample daemon, see also <main_daemon()>
readonly EXT_TEST="test"
#-------------------------------------------------------------------------------
#                                      /|\
#                                     /|||\
#                                      |||
#
#                    TODO: DEFINE YOUR GLOBAL CONSTANTS HERE
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
  #                        TODO: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  # # CODE SAMPLES
  # # For more available checks, please have a look at the functions
  # # <lib_core_is()> and <lib_core_regex()> in '/lib/SHlib/lib/core.lib.sh'
  # lib_core_is --bool "${arg_bool}"                                          && \
  # lib_core_is --dir "${arg_dir}"                                            && \
  # lib_core_is --file "${arg_file}"                                          && \
  # { lib_core_is --empty "${arg_int}"  \
  #   ||                                \
  #   lib_math_is_within_range          \
  #     "${ARG_INT_MIN}"                \
  #     "${arg_int}"                    \
  #     "${ARG_INT_MAX}"
  # }                                                                         && \
  # # Check if <ARG_ITEM_LIST> contains <arg_item> (indirectly, via pointers)
  # lib_core_list_contains_str_ptr "${arg_item}" "${ARG_ITEM_LIST}" " " "ARG_ITEM_" && \
  # # Check if <ARG_ITEM_LIST> contains <arg_item>
  # # lib_core_list_contains_str "${arg_item}" "${ARG_ITEM_LIST}" && \
  # lib_core_regex "[[:alnum:]]{10,20}" "${arg_password}"                     && \
  # lib_core_is --set "${arg_str}"                                            || \
  true                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        TODO: DEFINE YOUR CHECKS HERE
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
#      GLOBALS:  arg_action  arg_logdest  arg_mode
#
#                arg_arg_or_stdin  arg_bool  arg_dir  arg_file  arg_int
#                arg_item  arg_password  arg_str
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
      -D|--daemon) arg_mode="${ARG_MODE_DAEMON}";;
      --submenu)
        # Possibility to run a certain submenu interactively
        arg_mode="${ARG_MODE_INTERACTIVE_SUBMENU}"
        arg_action="$2"
        [ $# -ge 1 ] && { shift; }
        ;;

      #  Other parameters <arg_...>
      --log) arg_logdest="$2"; [ $# -ge 1 ] && { shift; };;

      #-------------------------------------------------------------------------
      #  PARAMETER (CUSTOM)
      #-------------------------------------------------------------------------
      #                 TODO: DEFINE YOUR ARGUMENT PARSING HERE
      #
      #                                   |||
      #                                  \|||/
      #                                   \|/
      #-------------------------------------------------------------------------
      #  Script actions <ARG_ACTION_...>
      #  (all actions that do not expect any arguments)
      --${ARG_ACTION_CUSTOM1}|--${ARG_ACTION_CUSTOM2})
        arg_action="${1#--}"
        ;;

      #  Script actions <ARG_ACTION_...>
      #  (all actions that expect one (1) argument)
      --${ARG_ACTION_CUSTOM3})
        arg_action="${1#--}"
        arg_dir="$2"
        [ $# -ge 1 ] && { shift; }
        ;;

      #  Script actions <ARG_ACTION_...>
      #  (all actions that expect two (2) arguments)
      --${ARG_ACTION_CUSTOM4})
        arg_action="${1#--}"
        arg_int="$2"
        arg_str="$3"
        [ $# -ge 2 ] && { shift; shift; }
        ;;

      #  Script actions <ARG_ACTION_...>
      #  Example for an action that expects either a string or a file.
      #  Both can be passed via an additional argument. In addition,
      #  a string can also be passed via <stdin> (pipe), e.g.
      #  'echo "string" | ./run.sh --custom5'
      #  (which can be either a string or a filepath)
      --${ARG_ACTION_CUSTOM5})
        if [ $# -gt 1 ]; then
          if lib_core_is --file "$(lib_core_expand_tilde "$2")"; then
            arg_file="$(lib_core_expand_tilde "$2")"
          else
            arg_arg_or_stdin="$2"
          fi
          shift
        else
          arg_arg_or_stdin="$(xargs)"
        fi
        ;;

      #  Script actions <ARG_ACTION_...>
      #  (all actions that automatically run in submenu mode)
      --${ARG_ACTION_CUSTOM6})
        arg_mode="${ARG_MODE_INTERACTIVE_SUBMENU}"
        arg_action="${1#--}"
        ;;

      #  Other parameters <arg_...>
      #  TODO: Please make sure that the command line options set here match
      #        the ones set in '/src/lang/run.0.lang.sh' (<L_RUN_HLP_PAR_ARG_...>).
      -b|--bool)      arg_bool="true";;
      -f|--file)      arg_file="$(lib_core_expand_tilde "$2")"; [ $# -ge 1 ] && { shift; };;
      -i|--int)       arg_int="$2"; [ $# -ge 1 ] && { shift; };;
      -j|--item)      arg_item="$2"; [ $# -ge 1 ] && { shift; };;
      -p|--password)  arg_password="$(lib_core_parse_credentials "$2")" && [ $# -ge 1 ] && { shift; };;
      -s|--str)       arg_str="$2"; [ $# -ge 1 ] && { shift; };;
      #-------------------------------------------------------------------------
      #                                   /|\
      #                                  /|||\
      #                                   |||
      #
      #                 TODO: DEFINE YOUR ARGUMENT PARSING HERE
      #-------------------------------------------------------------------------

      #-------------------------------------------------------------------------
      #  Last or undefined parameter
      #-------------------------------------------------------------------------
      *)
        #-----------------------------------------------------------------------
        #            TODO: DEFINE YOUR (LAST) ARGUMENT PARSING HERE
        #        PLEASE DO NOT FORGET TO DEFINE <L_RUN_HLP_PAR_LASTARG>
        #               IN '/src/lang/run.0.lang.sh' ACCORDINGLY.
        #
        #                                 |||
        #                                \|||/
        #                                 \|/
        #-----------------------------------------------------------------------
        #  Example: File/Directory parsing
        if [ $# -eq 1 ]; then
          #  Only one argument left
          local lastarg="$(lib_core_expand_tilde "$1")"

          #  Case 1: Check if file exists
          lib_core_is --file "${lastarg}" && \
          arg_file="${lastarg}"

          #  Case 2: Check if dir exists
          # lib_core_is --dir "${lastarg}" && \
          # arg_dir="${lastarg}"

          #  Case 3: Check if it can be a filepath
          # touch -c "${lastarg}" 2>/dev/null && \
          # arg_file="${lastarg}"
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
        #            TODO: DEFINE YOUR (LAST) ARGUMENT PARSING HERE
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
  #         TODO: DEFINE YOUR CLEANUP COMMANDS (INTERACTIVE MODE) HERE
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
  #         TODO: DEFINE YOUR CLEANUP COMMANDS (INTERACTIVE MODE) HERE
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
#         TODO:  Please do not hardcode any help texts here.
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
  #                TODO: DEFINE YOUR SYNOPSIS (INTRO) TEXT HERE
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
  #                TODO: DEFINE YOUR SYNOPSIS (INTRO) TEXT HERE
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
  #                TODO: DEFINE YOUR SYNOPSIS (ACTION) TEXT HERE
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
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                                                          \
    "$(lib_shtpl_arg --par "ARG_ACTION_HELP")"               "$(lib_shtpl_arg --des "ARG_ACTION_HELP")" " " ""  \
                                                                                                                \
    "$(lib_shtpl_arg --par "ARG_MODE_DAEMON")"               "$(lib_shtpl_arg --des "ARG_MODE_DAEMON")" " " ""  \
                                                                                                                \
    "$(lib_shtpl_arg --par "ARG_MODE_INTERACTIVE_SUBMENU")"  "$(lib_shtpl_arg --des "ARG_MODE_INTERACTIVE_SUBMENU")

<menu>$(lib_shtpl_arg --list-ptr "arg_action" "INTERACTIVE")" " " ""                                            \
                                                                                                                \
    "$(lib_shtpl_arg --par "ARG_ACTION_CUSTOM1")"         "$(lib_shtpl_arg --des "ARG_ACTION_CUSTOM1")" " " ""  \
                                                                                                                \
    "$(lib_shtpl_arg --par "ARG_ACTION_CUSTOM2")"         "$(lib_shtpl_arg --des "ARG_ACTION_CUSTOM2")" " " ""  \
                                                                                                                \
    "$(lib_shtpl_arg --par "ARG_ACTION_CUSTOM3")"         "$(lib_shtpl_arg --des "ARG_ACTION_CUSTOM3")" " " ""  \
                                                                                                                \
    "$(lib_shtpl_arg --par "ARG_ACTION_CUSTOM4")"         "$(lib_shtpl_arg --des "ARG_ACTION_CUSTOM4")" " " ""  \
                                                                                                                \
    "$(lib_shtpl_arg --par "ARG_ACTION_CUSTOM5")"         "$(lib_shtpl_arg --des "ARG_ACTION_CUSTOM5")" " " ""  \
                                                                                                                \
    "$(lib_shtpl_arg --par "ARG_ACTION_CUSTOM6")"         "$(lib_shtpl_arg --des "ARG_ACTION_CUSTOM6")"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                TODO: DEFINE YOUR SYNOPSIS (ACTION) TEXT HERE
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  SYNOPSIS (OPTION)
  #-----------------------------------------------------------------------------
  eval lib_msg_print_heading -211 \"\${LIB_SHTPL_${ID_LANG}_TXT_HELP_TTL_SYNOPSIS_OPTION}\"

  #-----------------------------------------------------------------------------
  #                TODO: DEFINE YOUR SYNOPSIS (OPTION) TEXT HERE
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
  lib_msg_print_propvalue "--left" "--left" "2" "" " "                              \
                                                                                    \
    "$(lib_shtpl_arg --par "arg_logdest")" "$(lib_shtpl_arg --des "arg_logdest")

$(lib_shtpl_arg --list-des-def "arg_logdest")" " " ""                                           \
                                                                                                \
    "$(lib_shtpl_arg --par "arg_bool")"       "$(lib_shtpl_arg --des "arg_bool")" " " ""        \
                                                                                                \
    "$(lib_shtpl_arg --par "arg_dir")"        "$(lib_shtpl_arg --des "arg_dir")" " " ""         \
                                                                                                \
    "$(lib_shtpl_arg --par "arg_file")"       "$(lib_shtpl_arg --des "arg_file")" " " ""        \
                                                                                                \
    "$(lib_shtpl_arg --par "arg_int")"        "$(lib_shtpl_arg --des "arg_int")

$(lib_shtpl_arg --minmax-def "arg_int")" " " ""                                                 \
                                                                                                \
    "$(lib_shtpl_arg --par "arg_item")"         "$(lib_shtpl_arg --list-des "arg_item")

$(lib_shtpl_arg --list-ptr-def "arg_item")" " " ""                                              \
                                                                                                \
    "$(lib_shtpl_arg --par "arg_password")"  "$(lib_shtpl_arg --des-def "arg_password")" " " "" \
                                                                                                \
    "$(lib_shtpl_arg --par "arg_str")" "$(lib_shtpl_arg --des-def "arg_str")"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                TODO: DEFINE YOUR SYNOPSIS (OPTION) TEXT HERE
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
  #                        TODO: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  # # CODE SAMPLES
  # # Check for commands
  # lib_core_is --cmd "echo" "printf"                                         && \
  # # Check for commands with "su" privileges
  # lib_core_is --cmd-su "chmod" "chown"                                      && \
  # # Check for group membership
  # lib_os_user_is_member_of "sudo"                                           && \
  # # Check for running service
  # if ! service cron status >/dev/null 2>&1; then
  #   lib_core_sudo service cron start
  # fi                                                                        && \
  # # Check for existing libraries
  # lib_os_lib --exists "lib.so"                                              && \
  # # Check if host is reachable
  # lib_net_host_is_up "www.example.com" "80"                                 || \

  true                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        TODO: DEFINE YOUR CHECKS HERE
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
  #                        TODO: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  true                                                                      || \
  optionalFulfilled="false"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        TODO: DEFINE YOUR CHECKS HERE
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
      lib_msg_message --terminal --error "${TXT_INVALID_ARG_1} <${arg_logdest}> ${TXT_INVALID_ARG_2} [${L_RUN_HLP_PAR_ARG_LOGDEST}]. ${LIB_SHTPL_EN_TPL_TXT_HELP} ${LIB_SHTPL_EN_TXT_ABORTING}"
      ;;
  esac                                                                      && \

  #-----------------------------------------------------------------------------
  #                        TODO: DEFINE YOUR CHECKS HERE
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
  #                        TODO: DEFINE YOUR CHECKS HERE
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
  #                        TODO: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  true                                                                      || \
  optionalFulfilled="false"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                        TODO: DEFINE YOUR CHECKS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------
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
    #       TODO: ADD FURTHER TRAP PARAMETERS HERE (and in <trap_main()>)
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
    #       TODO: ADD FURTHER TRAP PARAMETERS HERE (and in <trap_main()>)
    #---------------------------------------------------------------------------
  done                                                                      && \

  #  Get PID (if PID lock is disabled, then <lib_os_ps_pidlock()> will fail.)
  local pid                                                                 && \
  { pid="$(lib_os_ps_pidlock --getpid)" || \
    lib_os_ps_get_ownpid pid
  }                                                                         && \

  #-----------------------------------------------------------------------------
  #                       TODO: ADD FURTHER COMMANDS HERE
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
  #                       TODO: ADD FURTHER COMMANDS HERE
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
  #            TODO: ADD SUPPORTED LANGUAGES HERE (ISO 639-1 CODES)
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
  #            TODO: ADD SUPPORTED LANGUAGES HERE (ISO 639-1 CODES)
  #-----------------------------------------------------------------------------

  #=============================================================================
  #  CUSTOM
  #=============================================================================
  #-----------------------------------------------------------------------------
  #         TODO: PUBLISH YOUR CUSTOM LANGUAGE-SPECIFIC STRINGS <L_...>
  #               (DEFINED IN '/src/lang/run.<ll>.lang.sh') HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  eval "readonly TXT_DUMMY=\${L_RUN_${ID_LANG}_TXT_DUMMY}"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #         TODO: PUBLISH YOUR CUSTOM LANGUAGE-SPECIFIC STRINGS <L_...>
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
  eval "readonly TXT_TRAP_MAIN_TERMINATED=\${LIB_SHTPL_${ID_LANG}_TXT_TRAP_MAIN_TERMINATED}"
  eval "readonly TXT_TRAP_MAIN_TERMINATING=\${LIB_SHTPL_${ID_LANG}_TXT_TRAP_MAIN_TERMINATING}"
}

#===  FUNCTION  ================================================================
#         NAME:  init_update
#  DESCRIPTION:  Update global variables/constants and perform initialization
#                commands that should be executed after argument parsing
#      OUTPUTS:  An error message to <stderr> and/or <syslog>
#                in case an error occurs
#   RETURNS  0:  Success
#            1:  Error
#===============================================================================
init_update() {
  #-----------------------------------------------------------------------------
  #                   TODO: DEFINE YOUR UPDATE COMMANDS HERE
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
  #                   TODO: DEFINE YOUR UPDATE COMMANDS HERE
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
  #                     initialization commands that should be executed after
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
  #             TODO: DEFINE YOUR MAIN FUNCTION (DAEMON MODE) HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  SAMPLE CODE - CAN BE SAFELY DELETED
  #  Example for a daemon that parses files infinitely
  #  by running <func1()>  in a subshell (&) for each file in folder <arg_dir>
  #  having the extension <EXT_TEST>.
  while true; do
    for file in "${arg_dir}"/*."${EXT_TEST}"; do
      func1 "${file}" &
    done
    # Run sleep in the background to allow it getting interrupted
    sleep "${T_DAEMON_SLEEP}" &
    wait $!
  done
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #             TODO: DEFINE YOUR MAIN FUNCTION (DAEMON MODE) HERE
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
  #          TODO: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
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
  #          TODO: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
  #                   (DO NOT FORGET THE TERMINATING '&& \')
  #-----------------------------------------------------------------------------

  if [ "${arg_mode}" = "${ARG_MODE_INTERACTIVE}" ]; then
    #---------------------------------------------------------------------------
    #         TODO: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
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
    #         TODO: INSERT COMMANDS HERE THAT RUN ONCE AT THE BEGINNING
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
      #    TODO: ADD <ARG_ACTION_...> WHERE PROMPT TO CONTINUE IS NOT NEEDED
      #
      #                                   |||
      #                                  \|||/
      #                                   \|/
      #-------------------------------------------------------------------------
      ${ARG_ACTION_ABOUT}|${ARG_ACTION_EXIT}|${ARG_ACTION_HELP})
        run || exitcode="$?"
        ;;
      #-------------------------------------------------------------------------
      #                                   /|\
      #                                  /|||\
      #                                   |||
      #
      #    TODO: ADD <ARG_ACTION_...> WHERE PROMPT TO CONTINUE IS NOT NEEDED
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
    #               TODO: ADD YOUR ACTION-SPECIFIC COMMANDS HERE
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    # ${ARG_ACTION_CUSTOM1}) ;;
    # ${ARG_ACTION_CUSTOM2}) ;;
    *)
      case "${arg_logdest}" in
        ${ARG_LOGDEST_TERMINAL})
          lib_msg_echo --info "${TXT_DUMMY}" "" ""                            \
            "arg_arg_or_stdin" "${arg_arg_or_stdin}" "arg_bool" "${arg_bool}" \
            "arg_dir" "${arg_dir}" "arg_file" "${arg_file}"                   \
            "arg_int" "${arg_int}" "arg_item" "${arg_item}"                   \
            "arg_password" "${arg_password}" "arg_str" "${arg_str}"           \
            " " ""                                                            \
            "arg_action" "${arg_action}" "arg_logdest" "${arg_logdest}"       \
            "arg_mode" "${arg_mode}"                                          \
            " " ""                                                            \
            "ARG_ACTION_LIST_INTERACTIVE" "${ARG_ACTION_LIST_INTERACTIVE}"    \
            "ARG_ACTION_LIST_SCRIPT" "${ARG_ACTION_LIST_SCRIPT}"              \
            "ID_LANG" "${ID_LANG}" "INSTANCES" "${INSTANCES}"                 \
            "LIST_ARG" "${LIST_ARG}"                                          \
            "LIST_ARG_CLEANUP_INTERACTIVE" "${LIST_ARG_CLEANUP_INTERACTIVE}"  \
            "PIDLOCK_ENABLED" "${PIDLOCK_ENABLED}"                            \
            "T_DAEMON_SLEEP" "${T_DAEMON_SLEEP}"
          ;;
        *)
          info "${TXT_DUMMY} arg_action = <${arg_action}> | arg_arg_or_stdin = <${arg_arg_or_stdin}> | arg_bool = <${arg_bool}> | arg_dir = <${arg_dir}> | arg_file = <${arg_file}> | arg_int = <${arg_int}> | arg_item = <${arg_item}> | arg_password = <${arg_password}> | arg_str = <${arg_str}>"
          ;;
      esac
      ;;
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #               TODO: ADD YOUR ACTION-SPECIFIC COMMANDS HERE
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
  #       TODO: ADD FURTHER TRAP PARAMETERS HERE (AND IN <init_first()>)
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
  #       TODO: ADD FURTHER TRAP PARAMETERS HERE (AND IN <init_first()>)
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
    #          TODO: FOR EACH ADDITIONAL TRAP PARAMETER DEFINED ABOVE
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
    #          TODO: FOR EACH ADDITIONAL TRAP PARAMETER DEFINED ABOVE
    #                    ADD ANOTHER TEMPORARY VARIABLE HERE
    #---------------------------------------------------------------------------

    return
  fi

  #  Get PID (if PID lock is disabled ("PIDLOCK_ENABLED"="false"), then
  #  <lib_os_ps_pidlock()> will fail.)
  local pid
  pid="$(lib_os_ps_pidlock --getpid)" || \
  lib_os_ps_get_ownpid pid
  eval info --syslog \"${TXT_TRAP_MAIN_TERMINATING}\"

  # Special Trap Handling
  case "${arg_mode}" in
    #---------------------------------------------------------------------------
    #          TODO: DEFINE MODE(S) THAT HAVE NO SPECIAL TRAP HANDLING
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
    #          TODO: DEFINE MODE(S) THAT HAVE NO SPECIAL TRAP HANDLING
    #---------------------------------------------------------------------------
      ;;

    *)
      # Modes with special trap handling
      case "${arg_signal}" in
        EXIT)
          #---------------------------------------------------------------------
          #          TODO: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
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
          #          TODO: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
          #             IN CASE OF A NORMAL EXIT (NO OTHER SIGNAL)
          #---------------------------------------------------------------------
          ;;

        *)
          #---------------------------------------------------------------------
          #          TODO: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
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
          #          TODO: PUT ANY COMMANDS HERE THAT WILL BE EXECUTED
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
  eval info --syslog \"${TXT_TRAP_MAIN_TERMINATED}\"

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
  eval "title=\${L_RUN_${ID_LANG}_DLG_TTL_ARG_ACTION}"
  eval "text=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_ACTION}"
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
        eval "item=\${L_RUN_${ID_LANG}_DLG_ITM_ARG_ACTION_${a}}"
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
  #                    TODO: DEFINE YOUR MENU HANDLING HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  # All modes that require <arg_bool>
  case "${arg_action}" in
    ${ARG_ACTION_CUSTOM2}) menu_arg_bool;;
  esac                                                                      && \

  # All modes that require <arg_dir>
  case "${arg_action}" in
    ${ARG_ACTION_CUSTOM3}) menu_arg_dir;;
  esac                                                                      && \

  # All modes that require <arg_file>
  case "${arg_action}" in
    ${ARG_ACTION_CUSTOM5}|${ARG_ACTION_CUSTOM6}) menu_arg_file;;
  esac                                                                      && \

  # All modes that require <arg_int>
  case "${arg_action}" in
    ${ARG_ACTION_CUSTOM4}) menu_arg_int;;
  esac                                                                      && \

  # All modes that require <arg_item>
  case "${arg_action}" in
    ${ARG_ACTION_CUSTOM2}) menu_arg_item;;
  esac                                                                      && \

  # All modes that require <arg_str>
  case "${arg_action}" in
    ${ARG_ACTION_CUSTOM4}) menu_arg_str;;
  esac                                                                      || \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                   TODO: DEFINE YOUR UPDATE COMMANDS HERE
  #                   (DO NOT FORGET THE TERMINATING '|| \')
  #-----------------------------------------------------------------------------

  # Make sure that <main()> loop does not break if one of the menus above
  # throws an error but also do not perform any action in <run()> function.
  arg_action=""
}

#===============================================================================
#  FUNCTIONS (CUSTOM)
#===============================================================================
#                     TODO: DEFINE YOUR OWN FUNCTIONS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  func1
#
#  DESCRIPTION:  Sample function that can be run either in script mode (once)
#                or in daemon mode (infinite loop)
#
#                It simply processes a file by printing its name and some
#                message, either to the terminal (script mode) or to 'syslog'
#                (daemon mode), see <info ...> commands within the function.
#
# PARAMETER  1:  File to process
#
#   RETURNS  0:  OK
#            1:  Error
#===============================================================================
func1() {
  local arg_file="$1"

  local pid_file  # PID file of this (sub)shell

  # Function is running in a subshell (daemon mode)? (true|false)
  local is_subshell
  if lib_os_is_subshell; then is_subshell="true"; else is_subshell="false"; fi

  #-----------------------------------------------------------------------------
  #                          TODO: PUT YOUR CODE HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  local filename
  filename="$(lib_core_file_get --file "${arg_file}")"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                          TODO: PUT YOUR CODE HERE
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  Check/Create PID file and install trap handlers (subshell / daemon mode)
  #-----------------------------------------------------------------------------
  if ${is_subshell}; then
    # TODO: Replace <filename> by your own (PID filename) variable
    pid_file="${I_DIR_PID}/${filename}.${I_EXT_PID}"                        && \

    # PID lock needs to be reset because parent shell may have already locked
    lib_os_ps_pidlock --reset                                               && \
    lib_os_ps_pidlock --lock "${pid_file}" "false" "false"                  && \

    local sig                                                               && \
    for sig in EXIT HUP INT QUIT TERM; do
      # TODO: Replace <trap_func1> by your trap handler's function name.
      # TODO: Replace/Add arguments. Make sure to escape your variable and
      #       put it in escaped quotes, e.g. for variable <var> use
      #         \"\${var}\"
      trap "{
        trap_func1 \
          \"${sig}\" \"\${pid_file}\"
      }" ${sig}
    done
  fi                                                                        && \

  #-----------------------------------------------------------------------------
  #       TODO: PUT CODE HERE THAT WILL BE EXECUTED ONCE BEFORE THE LOOP
  #           (DO NOT FORGET THE TERMINATING '&& \' AFTER EACH LINE)
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  # Sample Code
  info "[${filename}] Running code before loop ..."                         && \
  local t_sleep                                                             && \
  t_sleep="3"                                                               && \
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #       TODO: PUT CODE HERE THAT WILL BE EXECUTED ONCE BEFORE THE LOOP
  #           (DO NOT FORGET THE TERMINATING '&& \' AFTER EACH LINE)
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  Loop (will be executed infinitely in daemon mode, otherwise just once)
  #-----------------------------------------------------------------------------
  while true; do
    #---------------------------------------------------------------------------
    #                       TODO: PUT YOUR LOOP CODE HERE
    #
    #                                    |||
    #                                   \|||/
    #                                    \|/
    #---------------------------------------------------------------------------
    # Sample Code (prints some messages while temporarily disables trap handling)
    trap_blocked="true"
    info "[${filename}] Starting loop cycle (3s) ..."
    sleep 3
    info "[${filename}] Terminating loop cycle (3s) ..."
    trap_blocked="false"
    if ${trap_triggered}; then
      if ${is_subshell}; then trap_func1; else trap_main; fi
    fi
    #---------------------------------------------------------------------------
    #                                    /|\
    #                                   /|||\
    #                                    |||
    #
    #                       TODO: PUT YOUR LOOP CODE HERE
    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    #  DO NOT EDIT
    #---------------------------------------------------------------------------
    if ${is_subshell}; then
      # Daemon mode (subshell)
      # Run sleep in the background to allow it getting interrupted
      sleep "${t_sleep}" &
      wait $!
    else
      # No subshell (script mode)
      break
    fi
  done
}

#===  FUNCTION  ================================================================
#         NAME:  trap_func1
#  DESCRIPTION:  Trap (cleanup and exit) function for <func1>
#                (subshell / daemon mode only)
#      GLOBALS:  trap_triggered
# PARAMETER  1:  Signal (EXIT|HUP|INT|QUIT|TERM|...)
#            2:  Subshell PID file
#===============================================================================
trap_func1() {
  local arg_signal="${1:-${trap_func1_arg_signal}}"
  local arg_pidfile="${2:-${trap_func1_arg_pidfile}}"
  #-----------------------------------------------------------------------------
  #                   TODO: ADD FURTHER TRAP PARAMETERS HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  #  IMPORTANT: For each parameter please set its temporary variable (see below,
  #             in the next 'TODO' section) as the default value, e.g.
  #               local arg_myparam="${3:-${trap_func1_arg_myparam}}"
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                   TODO: ADD FURTHER TRAP PARAMETERS HERE
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
    trap_func1_arg_signal="${arg_signal}"
    trap_func1_arg_pidfile="${arg_pidfile}"

    #---------------------------------------------------------------------------
    #          TODO: FOR EACH ADDITIONAL TRAP PARAMETER DEFINED ABOVE
    #                    ADD ANOTHER TEMPORARY VARIABLE HERE
    #
    #                                     |||
    #                                    \|||/
    #                                     \|/
    #---------------------------------------------------------------------------
    #  Example: For <arg_myparam> add the following line:
    #             trap_func1_arg_myparam="${arg_myparam}"
    #---------------------------------------------------------------------------
    #                                     /|\
    #                                    /|||\
    #                                     |||
    #
    #          TODO: FOR EACH ADDITIONAL TRAP PARAMETER DEFINED ABOVE
    #                    ADD ANOTHER TEMPORARY VARIABLE HERE
    #---------------------------------------------------------------------------

    return
  fi

  #  Get PID
  local pid="$(cat "${arg_pidfile}")"

  #-----------------------------------------------------------------------------
  #                    TODO: DEFINE YOUR TRAP HANDLING HERE
  #
  #                                     |||
  #                                    \|||/
  #                                     \|/
  #-----------------------------------------------------------------------------
  info "Signal <${arg_signal}> received. Terminating subshell (PID <${pid}>) ..."
  #-----------------------------------------------------------------------------
  #                                     /|\
  #                                    /|||\
  #                                     |||
  #
  #                   TODO: ADD FURTHER TRAP PARAMETERS HERE
  #-----------------------------------------------------------------------------

  #-----------------------------------------------------------------------------
  #  DO NOT EDIT
  #-----------------------------------------------------------------------------
  # Kill subshells / child processes + remove PID file
  local subpids
  lib_os_ps_get_descendants subpids "${pid}"
  lib_os_ps_kill_by_pid "${subpids}" "${arg_signal}" "true" "true" "true"
  lib_core_sudo rm -f "${arg_pidfile}"

  # Exit
  case "${arg_signal}" in
    EXIT) exit;;
    *) trap - EXIT; exit 1;;
  esac
}
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                     TODO: DEFINE YOUR OWN FUNCTIONS HERE
#===============================================================================

#===============================================================================
#  FUNCTIONS (CUSTOM) (MENUS)
#===============================================================================
#                    TODO: DEFINE YOUR OWN DIALOG MENUS HERE
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
#                    TODO: DEFINE YOUR OWN DIALOG MENUS HERE
#===============================================================================

#===============================================================================
#  FUNCTIONS (CUSTOM) (MENUS) (PARAMETERS/VARIABLES)
#===============================================================================
#               TODO: DEFINE PARAMETER/VARIABLE DIALOG MENUS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
#===  FUNCTION  ================================================================
#         NAME:  menu_arg_bool
#  DESCRIPTION:  Interactive menu for setting <arg_bool> parameter
#      GLOBALS:  arg_bool
#===============================================================================
menu_arg_bool() {
  local title
  local text1
  eval "title=\${L_RUN_${ID_LANG}_DLG_TTL_ARG_BOOL}"
  eval "text1=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_BOOL}"

  exec 3>&1
    dialog --title "${title}" --yesno "${text1}" 0 0                        && \
    arg_bool="true"                                                         || \
    arg_bool="false"
  exec 3>&-
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_dir
#  DESCRIPTION:  Interactive menu for setting <arg_dir> parameter
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_dir() {
  local title
  local text1
  eval "title=\${L_RUN_${ID_LANG}_DLG_TTL_ARG_DIR}"

  # Example: Action-dependent 'dialog' texts
  case "${arg_action}" in
    ${ARG_ACTION_CUSTOM3})
      eval "text1=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_DIR_OUT}"
      ;;
    *)
      eval "text1=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_DIR_IN}"
      ;;
  esac

  local result
  local exitcode="0"
  exec 3>&1
    dialog --title "${title}" --msgbox "${text1}" 0 0                       && \
    result="$(dialog --title "${title}"                                     \
      --dselect "${arg_dir}" 0 0 2>&1 1>&3)"                                || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_dir="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_file
#  DESCRIPTION:  Interactive menu for setting <arg_file> parameter
#      GLOBALS:  arg_file
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_file() {
  local title
  local text1
  eval "title=\${L_RUN_${ID_LANG}_DLG_TTL_ARG_FILE}"

  # Example: Action-dependent 'dialog' texts
  case "${arg_action}" in
    ${ARG_ACTION_CUSTOM5})
      eval "text1=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_FILE_OUT}"
      ;;
    ${ARG_ACTION_CUSTOM6})
      eval "text1=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_FILE_IN}"
      ;;
  esac

  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      dialog --title "${title}" --msgbox "${text1}" 0 0                     && \
      result="$(dialog --title "${title}"                                   \
        --fselect "${result:-${arg_file:-~/}}" 0 0 2>&1 1>&3)"              && \
      result="$(lib_core_expand_tilde "${result}")"                         || \
      exitcode="$?"

      #  Show prompt again if <result>
      #    - is not a valid filepath (<ARG_ACTION_CUSTOM5>)
      #    - is already existing (<ARG_ACTION_CUSTOM5>)
      #    - does not exist  (<ARG_ACTION_CUSTOM6>)
      #  unless the user has pressed the 'Cancel' button
      case "${exitcode}" in
        0)
          { case "${arg_action}" in
              ${ARG_ACTION_CUSTOM5})
                touch -c "${result}" 2>/dev/null && \
                ! lib_core_is --file "${result}"
                ;;
              ${ARG_ACTION_CUSTOM6})
                lib_core_is --file "${result}"
                ;;
            esac
          } && \
          break
          ;;
        *)
          break
          ;;
      esac
    done
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_file="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_int
#  DESCRIPTION:  Interactive menu for setting <arg_int> parameter
#      GLOBALS:  arg_int
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_int() {
  local title
  local text1
  eval "title=\${L_RUN_${ID_LANG}_DLG_TTL_ARG_INT}"
  eval "text1=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_INT}"

  local result
  local exitcode="0"
  exec 3>&1
    result="$(dialog --title "${title}" --rangebox "${text1}" 0 0         \
      ${ARG_INT_MIN} ${ARG_INT_MAX}                                       \
      ${arg_int}                                                          \
      2>&1 1>&3)"                                                         || \
    exitcode="$?"
  exec 3>&-

  if [ "${exitcode}" -eq "0" ]; then arg_int="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_item
#  DESCRIPTION:  Interactive menu for setting <arg_item> parameter
#      GLOBALS:  arg_item
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_item() {
  local title
  local text1
  eval "title=\${L_RUN_${ID_LANG}_DLG_TTL_ARG_ITEM}"
  eval "text1=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_ITEM}"

  local OLDIFS="$IFS"
  local IFS="$IFS"

  local dlgpairs
  local result
  local exitcode="0"
  exec 3>&1
    dlgpairs="$(for a in ${ARG_ITEM_LIST}; do
        eval "tag=\${ARG_ITEM_${a}}"
        eval "item=\${L_RUN_${ID_LANG}_DLG_ITM_ARG_ITEM_${a}}"
        printf "%s\n%s\n" "${tag}" "${item}"
      done)"                                                                && \
    IFS="${LIB_C_STR_NEWLINE}"                                              && \
    result="$(dialog --title "${title}" --menu "${text1}" 0 0 0  \
      ${dlgpairs} 2>&1 1>&3)"                                               || \
    exitcode="$?"
  exec 3>&-

  IFS="$OLDIFS"

  if [ "${exitcode}" -eq "0" ]; then arg_item="${result}"; fi
  return ${exitcode}
}

#===  FUNCTION  ================================================================
#         NAME:  menu_arg_str
#  DESCRIPTION:  Interactive menu for setting <arg_str> parameter
#      GLOBALS:  arg_str
#   RETURNS  0:  Parameter successfully changed
#            1:  Error or user interrupt
#===============================================================================
menu_arg_str() {
  local title
  local extra
  local text1
  local text2
  eval "title=\${L_RUN_${ID_LANG}_DLG_TTL_ARG_STR}"
  eval "extra=\${LIB_SHTPL_${ID_LANG}_TXT_GOBACK}"
  eval "text1=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_STR_1}"
  eval "text2=\${L_RUN_${ID_LANG}_DLG_TXT_ARG_STR_2}"

  local msg1
  local result
  local exitcode
  exec 3>&1
    while true; do
      exitcode="0"
      # Example: Insert a command's output in the dialog message, e.g. 'date'
      msg1="$(printf "%s\n\n%s" "${text1}" "$(date)")"          && \
      dialog --title "${title}" --msgbox "${msg1}" 0 0          && \
      result="$(dialog --extra-button --extra-label "${extra}"  \
        --title "${title}" --inputbox "${text2}" 0 0            \
        "${arg_str}" 2>&1 1>&3)"                                || \
      exitcode="$?"

      case "${exitcode}" in
        0)
          # 'dialog' completed => If value is valid then break, otherwise go on
          lib_core_regex "[[:alnum:]]+" "${result}" && break
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

  if [ "${exitcode}" -eq "0" ]; then arg_str="${result}"; fi
  return ${exitcode}
}
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#               TODO: DEFINE PARAMETER/VARIABLE DIALOG MENUS HERE
#===============================================================================

#===============================================================================
#  MAIN
#===============================================================================
main "$@"

#===============================================================================
#  CODE TEMPLATES
#===============================================================================
#-------------------------------------------------------------------------------
#  Run a certain command (<cmd>) and in case of any error do not only log a
#  pre-defined error message (<msg>) but also the command's previous output
#  (<result>).
#-------------------------------------------------------------------------------
# exec 3>&1
#   result="$(<cmd> 2>&1 1>&3; exit $?)" # TODO: Replace <cmd> by your own value.
#   exitcode="$?"
# exec 3>&-
# if [ ${exitcode} -ne 0 ]; then
#   # ...                             # TODO: Put your error handling here.
#   msg="<msg>"                       # TODO: Replace <msg> by your own value.
#   error "${msg}" "${result}"
# fi

#-------------------------------------------------------------------------------
#  Temporarily disable trap handling
#-------------------------------------------------------------------------------
# trap_blocked="true"   # Disable trap handling
# # ...
# # TODO: Put commands here that should not(!) be interrupted
# # ...
# trap_blocked="false"  # Re-enable trap handling

# # Run trap handling (manually) if trap was previously triggered
# if ${trap_triggered}; then
#   if ${is_subshell}; then trap_func1; else trap_main; fi
# fi

#-------------------------------------------------------------------------------
#  Check whether the script was called recursively
#-------------------------------------------------------------------------------
# if eval [ \${${INSTANCES}} -gt 1 ]; then echo "Script recursively called"; fi