#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) <ABOUT_YEARS> <ABOUT_AUTHORS>
# SPDX-License-Identifier: <ABOUT_LICENSE>
#
#===============================================================================
#
#         FILE:   /src/init.sh
#
#        USAGE:   ---
#                 (This is a configuration script, so please do NOT run it.)
#
#  DESCRIPTION:   Repository Initialisation Script - Used to
#                  - set file/folder structure,
#                  - load libraries from </lib/*.lib.sh>, </lib/*/*.lib.sh>,
#                    and </lib/*/lib/*.lib.sh>,
#                  - load configuration files from </etc/*.cfg.sh>, and
#                  - load string constants files from </src/lang/*.lang.sh>.
#
#         BUGS:   ---
#
#        NOTES:   ---
#
#        TODO:    See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  CHECK IF SCRIPT WAS PREVIOUSLY RUN
#===============================================================================
if ${I_INITIALISED:-false} 2>/dev/null; then return; fi

#===============================================================================
#  FILE / FOLDER STRUCTURE (TEMPLATE) - DO NOT EDIT
#===============================================================================
readonly I_DIR_CWD="$(pwd -P)"                  # Current working directory

# PID directory for subshell PID files,
# e.g. see <func1()>/<main()> in '/src/run.sh'
readonly I_DIR_PID="/var/run/$(basename "$0")"
readonly I_EXT_PID="pid"                        # PID File Extension

readonly I_DIR_ROOT="$( cd "$(dirname "$0")/.." >/dev/null 2>&1 ; pwd -P )"
readonly I_DIR_ETC="${I_DIR_ROOT:-.}/etc"       # Configuration
readonly I_DIR_LIB="${I_DIR_ROOT:-.}/lib"       # Library / Submodule
readonly I_DIR_SRC="${I_DIR_ROOT:-.}/src"       # Source
readonly I_DIR_SRC_LANG="${I_DIR_SRC}/lang"     # Source (String Constants Files)
readonly I_DIR_TEST="${I_DIR_ROOT:-.}/test"     # Test

readonly I_EXT_CFG="cfg.sh"                     # Configuration File Extension
readonly I_EXT_LANG="lang.sh"                   # String Constants File Extension
readonly I_EXT_LIB="lib.sh"                     # Library File Extension

readonly I_FILE_SH_INIT="${I_DIR_SRC}/init.sh"  # Initialisation Script

#===============================================================================
#  FILE / FOLDER STRUCTURE (CUSTOM)
#===============================================================================
#                     TODO: DEFINE YOUR FILES/FOLDERS HERE
#
#                                      |||
#                                     \|||/
#                                      \|/
#===============================================================================
readonly I_FILE_SH_RUN="${I_DIR_SRC}/run.sh"
#===============================================================================
#                                      /|\
#                                     /|||\
#                                      |||
#
#                     TODO: DEFINE YOUR FILES/FOLDERS HERE
#===============================================================================

#===============================================================================
#  IMPORT - DO NOT EDIT
#===============================================================================
# Load libraries (/lib/[*[/lib]/]*.lib.sh)
for dir in "${I_DIR_LIB}" "${I_DIR_LIB}"/* "${I_DIR_LIB}"/*/lib ; do
  [ -d "${dir}" ] || continue
  cd "${dir}"
  for lib in ./*.${I_EXT_LIB}; do
    [ -f "${lib}" ] || continue

    . "${lib}" || \
    {
      printf "%s\n\n"                                                     \
        "ERROR: Library '${dir}/${lib}' could not be loaded. Aborting..." >&2
      cd "${I_DIR_CWD}"
      return 1
    }
  done
done

cd "${I_DIR_CWD}"

# Load configuration files (/etc/*.cfg.sh)
# and string constants files (/src/lang/*.lang.sh)
for file in "${I_DIR_ETC}"/*.${I_EXT_CFG} "${I_DIR_SRC_LANG}"/*.${I_EXT_LANG}; do
  [ -f "${file}" ] || continue

  . "${file}" || \
  {
    printf "%s\n\n"                                                     \
      "ERROR: File '${file}' could not be loaded. Aborting..." >&2
    return 1
  }
done

# Extend PATH variable (temporarily) otherwise some commands may not be found
lib_core_env_append "PATH" "/sbin" "/usr/sbin"                              && \

# Initialisation completed
readonly I_INITIALISED="true"                                               || \

# Break if an error occurs
return