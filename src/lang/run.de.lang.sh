#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) <ABOUT_YEARS> <ABOUT_AUTHORS>
# SPDX-License-Identifier: <ABOUT_LICENSE>
#
#===============================================================================
#
#         FILE:   /src/lang/run.de.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   --German-- String Constants File for '/src/run.sh'
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
#  see '/src/lang/run.0.lang.sh'.

#===============================================================================
#  PARAMETER (TEMPLATE) - DO NOT EDIT
#===============================================================================
#  Script actions <ARG_ACTION_...>
readonly L_RUN_DE_HLP_DES_ARG_ACTION_HELP="${LIB_SHTPL_DE_HLP_DES_ARG_ACTION_HELP}"

#  Log destination <ARG_LOGDEST_...>
readonly L_RUN_DE_HLP_DES_ARG_LOGDEST="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST}"
readonly L_RUN_DE_HLP_DES_ARG_LOGDEST_BOTH="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_BOTH}"
readonly L_RUN_DE_HLP_DES_ARG_LOGDEST_SYSLOG="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_SYSLOG}"
readonly L_RUN_DE_HLP_DES_ARG_LOGDEST_TERMINAL="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_TERMINAL}"

#  Script operation modes <ARG_MODE_...>
readonly L_RUN_DE_HLP_DES_ARG_MODE_DAEMON="${LIB_SHTPL_DE_HLP_DES_ARG_MODE_DAEMON}"
readonly L_RUN_DE_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_DE_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#-------------------------------------------------------------------------------
#  arg_bool
#-------------------------------------------------------------------------------
readonly L_RUN_DE_DLG_TTL_ARG_BOOL="Dialog-Titel <arg_bool>"
readonly L_RUN_DE_DLG_TXT_ARG_BOOL="Dialog-Text <arg_bool>"
readonly L_RUN_DE_HLP_DES_ARG_BOOL="Hilfe <arg_bool>"
readonly L_RUN_DE_HLP_REF_ARG_BOOL="Verwenden Sie ${L_RUN_HLP_PAR_ARG_BOOL}, um <arg_bool> zu aktivieren"

#-------------------------------------------------------------------------------
#  arg_dir
#-------------------------------------------------------------------------------
readonly L_RUN_DE_DLG_TTL_ARG_DIR="Dialog-Titel <arg_dir>"
readonly L_RUN_DE_DLG_TXT_ARG_DIR_IN="Bitte wählen Sie einen Quellordner aus."
readonly L_RUN_DE_DLG_TXT_ARG_DIR_OUT="Bitte geben Sie einen Zielordner an."
readonly L_RUN_DE_HLP_DES_ARG_DIR="Hilfe <arg_dir>"
readonly L_RUN_DE_HLP_REF_ARG_DIR="Legen Sie den Quell- bzw. Zielordner mit '${L_RUN_HLP_PAR_ARG_DIR}' fest"

#-------------------------------------------------------------------------------
#  arg_file
#-------------------------------------------------------------------------------
readonly L_RUN_DE_DLG_TTL_ARG_FILE="Dialog-Titel <arg_file>"
readonly L_RUN_DE_DLG_TXT_ARG_FILE_IN="Bitte wählen Sie eine bestehende Datei aus."
readonly L_RUN_DE_DLG_TXT_ARG_FILE_OUT="Bitte geben Sie einen Dateipfad an, an dem die Datei gespeichert werden soll. Bestehende Dateien werden ignoriert und nicht(!) überschrieben."
readonly L_RUN_DE_HLP_DES_ARG_FILE="Hilfe <arg_file>"
readonly L_RUN_DE_HLP_REF_ARG_FILE="Legen Sie die zu verwendende/erstellende Datei mit '${L_RUN_HLP_PAR_ARG_FILE}' fest"

#-------------------------------------------------------------------------------
#  arg_int
#-------------------------------------------------------------------------------
readonly L_RUN_DE_DLG_TTL_ARG_INT="Dialog-Titel <arg_int>"
readonly L_RUN_DE_DLG_TXT_ARG_INT="Bitte legen Sie eine Zahl für <arg_int> fest."
readonly L_RUN_DE_HLP_DES_ARG_INT="Hilfe <arg_int>"
readonly L_RUN_DE_HLP_REF_ARG_INT="Verwenden Sie '${L_RUN_HLP_PAR_ARG_INT}', um den Wert von <arg_int> festzulegen"

#-------------------------------------------------------------------------------
#  arg_item
#-------------------------------------------------------------------------------
readonly L_RUN_DE_DLG_TTL_ARG_ITEM="Dialog-Titel <arg_item>"
readonly L_RUN_DE_DLG_TXT_ARG_ITEM="Dialog-Text <arg_item>"
readonly L_RUN_DE_DLG_ITM_ARG_ITEM_ITEM1="Dialog-Listenelement <ARG_ITEM_ITEM1>"
readonly L_RUN_DE_DLG_ITM_ARG_ITEM_ITEM2="Dialog-Listenelement <ARG_ITEM_ITEM2>"
readonly L_RUN_DE_HLP_DES_ARG_ITEM="Hilfe <arg_item>"
readonly L_RUN_DE_HLP_DES_ARG_ITEM_ITEM1="Hilfe <ARG_ITEM_ITEM1>"
readonly L_RUN_DE_HLP_DES_ARG_ITEM_ITEM2="Hilfe <ARG_ITEM_ITEM2>"
readonly L_RUN_DE_HLP_REF_ARG_ITEM="Verwenden Sie '${L_RUN_HLP_PAR_ARG_ITEM}', um den Wert von <arg_item> festzulegen"

#-------------------------------------------------------------------------------
#  arg_password
#-------------------------------------------------------------------------------
readonly L_RUN_DE_DLG_TTL_ARG_PASSWORD="Dialog-Titel <arg_password>"
readonly L_RUN_DE_DLG_TXT_ARG_PASSWORD="Dialog-Text <arg_password>"
readonly L_RUN_DE_HLP_DES_ARG_PASSWORD="Hilfe <arg_password>. Siehe auch (1)."

#-------------------------------------------------------------------------------
#  arg_str
#-------------------------------------------------------------------------------
readonly L_RUN_DE_DLG_TTL_ARG_STR="Dialog-Titel <arg_str>"
readonly L_RUN_DE_DLG_TXT_ARG_STR_1="Dialog-Text <arg_str> Teil 1, erweitert um die Ausgabe eines Befehls, z.B. 'date':"
readonly L_RUN_DE_DLG_TXT_ARG_STR_2="\
Dialog-Text <arg_str> Teil 2

In diesem Beispiel sind nur alphanumerische Zeichen [A-Za-z0-9] erlaubt. Wählen Sie <OK>, um fortzufahren, oder drücken Sie <${LIB_SHTPL_DE_TXT_GOBACK}>, um zum vorherigen Menü zu gelangen. "
readonly L_RUN_DE_HLP_DES_ARG_STR="Hilfe <arg_str>"
readonly L_RUN_DE_HLP_REF_ARG_STR="Verwenden Sie '${L_RUN_HLP_PAR_ARG_STR}', um den Wert von <arg_str> festzulegen"

#-------------------------------------------------------------------------------
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#-------------------------------------------------------------------------------
readonly L_RUN_DE_HLP_DES_LASTARG="Zu verwendende Datei"

#-------------------------------------------------------------------------------
#  Script actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
#  Main Menu Title/Text
readonly L_RUN_DE_DLG_TTL_ARG_ACTION="SHtemplate"
readonly L_RUN_DE_DLG_TXT_ARG_ACTION="Was möchten Sie tun?"

#  ARG_ACTION_CUSTOM1
readonly L_RUN_DE_DLG_ITM_ARG_ACTION_CUSTOM1="Dialog-Listenelement <ARG_ACTION_CUSTOM1>"
readonly L_RUN_DE_HLP_DES_ARG_ACTION_CUSTOM1="Hilfe <ARG_ACTION_CUSTOM1>"

#  ARG_ACTION_CUSTOM2
readonly L_RUN_DE_DLG_ITM_ARG_ACTION_CUSTOM2="Dialog-Listenelement <ARG_ACTION_CUSTOM2>"
readonly L_RUN_DE_HLP_DES_ARG_ACTION_CUSTOM2="Hilfe <ARG_ACTION_CUSTOM2>. ${L_RUN_HLP_REF_ARG_BOOL_DE}. ${L_RUN_HLP_REF_ARG_ITEM_DE}."

#  ARG_ACTION_CUSTOM3
readonly L_RUN_DE_DLG_ITM_ARG_ACTION_CUSTOM3="Dialog-Listenelement <ARG_ACTION_CUSTOM3>"
readonly L_RUN_DE_HLP_DES_ARG_ACTION_CUSTOM3="Hilfe <ARG_ACTION_CUSTOM3>. Bezüglich <dir> siehe '${L_RUN_HLP_PAR_ARG_DIR}'."

#  ARG_ACTION_CUSTOM4
readonly L_RUN_DE_DLG_ITM_ARG_ACTION_CUSTOM4="Dialog-Listenelement <ARG_ACTION_CUSTOM4>"
readonly L_RUN_DE_HLP_DES_ARG_ACTION_CUSTOM4="Hilfe <ARG_ACTION_CUSTOM4>. Bezüglich <int> und <str> siehe '${L_RUN_HLP_PAR_ARG_INT}' und '${L_RUN_HLP_PAR_ARG_STR}'."

#  ARG_ACTION_CUSTOM5
readonly L_RUN_DE_DLG_ITM_ARG_ACTION_CUSTOM5="Dialog-Listenelement <ARG_ACTION_CUSTOM5>"
readonly L_RUN_DE_HLP_DES_ARG_ACTION_CUSTOM5="Hilfe <ARG_ACTION_CUSTOM5>. Verwendet entweder eine Datei (<file>) oder alternativ den Inhalt der Pipe <stdin> ('echo \"string\" | ${L_ABOUT_RUN} --custom5')."

#  ARG_ACTION_CUSTOM6
readonly L_RUN_DE_DLG_ITM_ARG_ACTION_CUSTOM6="Dialog-Listenelement <ARG_ACTION_CUSTOM6>"
readonly L_RUN_DE_HLP_DES_ARG_ACTION_CUSTOM6="Hilfe <ARG_ACTION_CUSTOM6>"

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
readonly L_RUN_DE_HLP_TTL_EXAMPLES_1="Beispiel 1"
readonly L_RUN_DE_HLP_TXT_EXAMPLES_1="${L_RUN_HLP_TXT_EXAMPLES_1}"

#  Example 2
readonly L_RUN_DE_HLP_TTL_EXAMPLES_2="Beispiel 2"
readonly L_RUN_DE_HLP_TXT_EXAMPLES_2="${L_RUN_HLP_TXT_EXAMPLES_2}"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------
# Note 1
readonly L_RUN_DE_HLP_TXT_NOTES_1="${LIB_SHTPL_DE_TXT_HELP_TXT_NOTES_CREDENTIALS_ENV}"

# Note 2
readonly L_RUN_DE_HLP_TXT_NOTES_2="Dies ist der Text zu Notiz 2."

#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
#  Requirements 1
readonly L_RUN_DE_HLP_TTL_REQUIREMENTS_1="Allgemein"
readonly L_RUN_DE_HLP_TXT_REQUIREMENTS_1="\
Benötigte Pakete:
${L_RUN_HLP_TXT_REQUIREMENTS_1_REQUIRED}

Optionale Pakete:
${L_RUN_HLP_TXT_REQUIREMENTS_1_OPTIONAL}

(...)"

#  Requirements 2
readonly L_RUN_DE_HLP_TTL_REQUIREMENTS_2="${LIB_SHTPL_DE_TXT_HELP_TTL_REQUIREMENTS_INTERACTIVE}"
readonly L_RUN_DE_HLP_TXT_REQUIREMENTS_2="${LIB_SHTPL_DE_TXT_HELP_TXT_REQUIREMENTS_INTERACTIVE}"

#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------
#  Intro Description
readonly L_RUN_DE_HLP_TXT_INTRO="Eine Repository-Vorlage für Bourne-Shell (sh) Projekte."

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_RUN_DE_HLP_TTL_TLDR_1="Anforderungen"
readonly L_RUN_DE_HLP_TXT_TLDR_1="\
Um die benötigten Pakete zu installieren, führen Sie bitte folgenden Befehl aus:

${L_RUN_HLP_TXT_TLDR_1_INSTALL}

(...weitere Anforderungen...)

Das Skript wurde in folgender Umgebung entwickelt und getestet:

OS:         ${L_RUN_HLP_TXT_TLDR_1_OS}
Kernel:     ${L_RUN_HLP_TXT_TLDR_1_KERNEL}
Pakete:     ${L_RUN_HLP_TXT_TLDR_1_PACKAGES}"

#===============================================================================
#  CUSTOM STRINGS (used in terminal output <stdout>/<stderr>)
#===============================================================================
#  TODO: Here you can define custom language-specific strings.
#        Do not forget to "publish" them within the <init_lang()> function of
#        your destination script, e.g. 'run.sh'.
#===============================================================================
readonly L_RUN_DE_TXT_DUMMY="Das ist eine Beispiel-Ausgabe, um zu zeigen, wie dieses Skript funktioniert."