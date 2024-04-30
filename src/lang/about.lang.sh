#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the LUKSwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/lang/about.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   Repository About File - Contains string constants with
#                 information about this repository (author, license, etc.)
#
#         BUGS:   ---
#
#        NOTES:   ---
#
#         TODO:   See 'TODO:'-tagged lines below.
#===============================================================================

#===============================================================================
#  ABOUT THIS REPOSITORY
#===============================================================================
#  Author name and mail address (multiple authors separated by newline)
readonly L_ABOUT_AUTHORS="Florian Kemser and the LUKSwrapper contributors"

#  (Optional) Project description, should be a oneliner describing what the
#  project does. Please start with a low letter and leave the terminating
#  '.' out.
readonly L_ABOUT_DESCRIPTION="a collection of shell scripts to setup and manage LUKS2-encrypted drives, either interactively or via command line"

#  (Optional) Institution (multiple lines allowed)
readonly L_ABOUT_INSTITUTION=""

#  (Optional) Project license (SPDX-License-Identifier)
#
#  For the full SPDX license list please have a look at
#  'https://spdx.org/licenses/'. However, only some licenses
#  are supported, see </lib/SHtemplateLIB/lib/licenses> folder.
#
#  If you are not sure which license to choose
#  just have a look at e.g. 'https://choosealicense.com'.
readonly L_ABOUT_LICENSE="GPL-3.0-or-later"

#  (Optional) ASCII logo to display when running the script in interactive ('dialog') mode
readonly L_ABOUT_LOGO=""

#  Project title, e.g. 'My Project'
readonly L_ABOUT_PROJECT="LUKSwrapper"

#  DO NOT EDIT
readonly L_ABOUT_RUN="./$(basename "$0")"

#  (Optional) Release/Version number, e.g. '1.1.0'
readonly L_ABOUT_VERSION="1.0.0"

#  (Optional) Project year(s), e.g. '2023', '2023-2024'
readonly L_ABOUT_YEARS="2022-2024"