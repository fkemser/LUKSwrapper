#!/bin/sh
#
# SPDX-FileCopyrightText: Copyright (c) 2022-2024 Florian Kemser and the LUKSwrapper contributors
# SPDX-License-Identifier: GPL-3.0-or-later
#
#===============================================================================
#
#         FILE:   /src/lang/luks.de.lang.sh
#
#        USAGE:   ---
#                 (This is a constant file, so please do NOT run it.)
#
#  DESCRIPTION:   --German-- String Constants File for '/src/luks.sh'
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
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_HELP="${LIB_SHTPL_DE_HLP_DES_ARG_ACTION_HELP}"

#  Log destination <ARG_LOGDEST_...>
readonly L_LUKS_DE_HLP_DES_ARG_LOGDEST="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST}"
readonly L_LUKS_DE_HLP_DES_ARG_LOGDEST_BOTH="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_BOTH}"
readonly L_LUKS_DE_HLP_DES_ARG_LOGDEST_SYSLOG="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_SYSLOG}"
readonly L_LUKS_DE_HLP_DES_ARG_LOGDEST_TERMINAL="${LIB_SHTPL_DE_HLP_DES_ARG_LOGDEST_TERMINAL}"

#  Script operation modes <ARG_MODE_...>
readonly L_LUKS_DE_HLP_DES_ARG_MODE_DAEMON="${LIB_SHTPL_DE_HLP_DES_ARG_MODE_DAEMON}"
readonly L_LUKS_DE_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU="${LIB_SHTPL_DE_HLP_DES_ARG_MODE_INTERACTIVE_SUBMENU}"

#===============================================================================
#  PARAMETER (CUSTOM)
#===============================================================================
#-------------------------------------------------------------------------------
#  arg_auth
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_AUTH="Authentifizierung"
readonly L_LUKS_DE_DLG_TXT_ARG_AUTH="Bitte wählen Sie eine der nachfolgenden Methoden aus.

${LIB_SHTPL_DE_DLG_TXT_ATTENTION}
Für FIDO2, PKCS#11 und TPM2 gelten besondere Hardware- und Software-Anforderungen. Bitte beachten Sie hierzu die Hinweise in der Hilfe."

readonly L_LUKS_DE_DLG_ITM_ARG_AUTH_FIDO2="FIDO2 Security Token"
readonly L_LUKS_DE_DLG_ITM_ARG_AUTH_PASSPHRASE="Passwort"
readonly L_LUKS_DE_DLG_ITM_ARG_AUTH_PKCS11="PKCS#11 Smartcards und Security Token"
readonly L_LUKS_DE_DLG_ITM_ARG_AUTH_RECOVERY="Wiederherstellungsschlüssel (automatisch generiert)"
readonly L_LUKS_DE_DLG_ITM_ARG_AUTH_TPM2="Trusted Platform Module 2 (TPM2)"

readonly L_LUKS_DE_HLP_DES_ARG_AUTH="Legt die Authentifizierungsmethode fest, um auf den LUKS-Schlüssel zuzugreifen"
readonly L_LUKS_DE_HLP_DES_ARG_AUTH_FIDO2="${L_LUKS_DE_DLG_ITM_ARG_AUTH_FIDO2}"
readonly L_LUKS_DE_HLP_DES_ARG_AUTH_PASSPHRASE="${L_LUKS_DE_DLG_ITM_ARG_AUTH_PASSPHRASE}"
readonly L_LUKS_DE_HLP_DES_ARG_AUTH_PKCS11="${L_LUKS_DE_DLG_ITM_ARG_AUTH_PKCS11}"
readonly L_LUKS_DE_HLP_DES_ARG_AUTH_RECOVERY="${L_LUKS_DE_DLG_ITM_ARG_AUTH_RECOVERY}. Nur, falls ACTION := { --enroll | --remove | --replace }. Diese Option ist vergleichbar mit 'passphrase', erzeugt aber eine zufällig generierte Passphrase und bietet die Möglichkeit, diese via QR-Code abzuscannen."
readonly L_LUKS_DE_HLP_DES_ARG_AUTH_TPM2="${L_LUKS_DE_DLG_ITM_ARG_AUTH_TPM2}"

readonly L_LUKS_DE_HLP_REF_ARG_AUTH="Benutzen Sie '${L_LUKS_HLP_PAR_ARG_AUTH}', um die zu verwendende Authentifizierungsmethode festzulegen."
readonly L_LUKS_DE_HLP_REF_ARG_AUTH_FIDO2="Nur mit '--auth fido2'."
readonly L_LUKS_DE_HLP_REF_ARG_AUTH_FIDO2_OR_PKCS11_OR_TPM2="Nur mit '--auth <fido2|pkcs11|tpm2>'."
readonly L_LUKS_DE_HLP_REF_ARG_AUTH_FIDO2_OR_TPM2="Nur mit '--auth <fido2|tpm2>'."
readonly L_LUKS_DE_HLP_REF_ARG_AUTH_PKCS11="Nur mit '--auth pkcs11'."
readonly L_LUKS_DE_HLP_REF_ARG_AUTH_TPM2="Nur mit '--auth tpm2'."

#-------------------------------------------------------------------------------
#  arg_cipher
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_CIPHER="Verschlüsselungsalgorithmus"
readonly L_LUKS_DE_DLG_TXT_ARG_CIPHER="Bitte legen Sie den Algorithmus fest.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_DE_HLP_DES_ARG_CIPHER="Verschlüsselungsalgorithmus festlegen (1). Führen Sie 'cat /proc/crypto', 'cryptsetup benchmark' aus, um eine Liste verfügbare Algorithmen anzuzeigen."

#-------------------------------------------------------------------------------
#  arg_device_dst
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_DEVICE_DST_1="Zieldatenträger"
readonly L_LUKS_DE_DLG_TTL_ARG_DEVICE_DST_2="${LIB_SHTPL_DE_DLG_TTL_ERROR}"

readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_DST_CLONE="Bitte geben Sie an, auf welchen Datenträger geklont werden soll. Dieser muss sich vom zuvor ausgewählten Quelldatenträger unterscheiden.

${LIB_SHTPL_DE_DLG_TXT_WARNING}
Alle Daten auf dem Zieldatenträger werden ÜBERSCHRIEBEN und gehen UNWIEDERBRINGLICH VERLOREN."
readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_DST_2="Kein (LUKS-)Datenträger gefunden."

#-------------------------------------------------------------------------------
#  arg_device_src
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_DEVICE_SRC_1="Datenträger / Quelldatenträger"
readonly L_LUKS_DE_DLG_TTL_ARG_DEVICE_SRC_2="${L_LUKS_DE_DLG_TTL_ARG_DEVICE_DST_2}"

readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_SRC_CLONE="Bitte geben Sie den LUKS-Datenträger an, welcher geklont werden soll."
readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_SRC_CLOSE="Bitte geben Sie den LUKS-Datenträger an, welchen Sie schließen und auswerfen möchten."
readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_SRC_ENCRYPT="Bitte geben Sie den Datenträger an, welcher verschlüsselt werden soll.

${LIB_SHTPL_DE_DLG_TXT_WARNING}
Sollten Sie einen (neuen) Datenträger verschlüsseln, so gehen alle zuvor darauf gespeicherten Daten UNWIEDERBRINGLICH VERLOREN."
readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_SRC_HEADER_BACKUP="Bitte geben Sie den LUKS-Datenträger an, dessen Header Sie sichern bzw. anzeigen möchten."
readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_SRC_HEADER_MODIFY="Bitte geben Sie den LUKS-Datenträger an, dessen Header bearbeitet werden soll.

${LIB_SHTPL_DE_DLG_TXT_WARNING}
Erstellen Sie zuvor unbedingt eine Sicherung Ihres Headers. Sollte der Header beschädigt werden, so sind Ihre Daten ohne eine Sicherung UNWIEDERBRINGLICH VERLOREN."
readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_SRC_OPEN="Bitte geben Sie den LUKS-Datenträger an, welcher geöffnet (entschlüsselt) werden soll."
readonly L_LUKS_DE_DLG_TXT_ARG_DEVICE_SRC_2="${L_LUKS_DE_DLG_TXT_ARG_DEVICE_DST_2}"

#-------------------------------------------------------------------------------
#  arg_fido2_device
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_FIDO2_DEVICE_1="FIDO2 Security Token"
readonly L_LUKS_DE_DLG_TTL_ARG_FIDO2_DEVICE_3="${LIB_SHTPL_DE_DLG_TTL_ERROR}"

readonly L_LUKS_DE_DLG_TXT_ARG_FIDO2_DEVICE_1="Wie soll der zu verwendende FIDO2 Token ermittelt werden?"
readonly L_LUKS_DE_DLG_TXT_ARG_FIDO2_DEVICE_2="Bitte wählen Sie aus der nachfolgenden Geräteliste den gewünschten FIDO2 Token aus:"
readonly L_LUKS_DE_DLG_TXT_ARG_FIDO2_DEVICE_3="Kein FIDO2 Token gefunden."

readonly L_LUKS_DE_DLG_ITM_ARG_FIDO2_DEVICE_AUTO="Automatisch (genau ein (1) Token, es darf kein weiterer angeschlossen sein)"
readonly L_LUKS_DE_DLG_ITM_ARG_FIDO2_DEVICE_MANUAL="Manuell (aus einer Liste aller angeschlossenen Token)"

readonly L_LUKS_DE_HLP_DES_ARG_FIDO2_DEVICE="${L_LUKS_DE_HLP_REF_ARG_AUTH_FIDO2} Legt das zu verwendende FIDO2(hidraw)-Gerät fest, zulässige Werte:"
readonly L_LUKS_DE_HLP_DES_ARG_FIDO2_DEVICE_AUTO="${L_LUKS_DE_DLG_ITM_ARG_FIDO2_DEVICE_AUTO}"
readonly L_LUKS_DE_HLP_DES_ARG_FIDO2_DEVICE_MANUAL="Manuell, durch Angabe des devnode-Namens (<dev> = /dev/hidraw...). Führen Sie '${L_ABOUT_RUN} --list-token fido2' aus, um alle derzeit verbundenen hidraw-Geräte anzuzeigen."

#-------------------------------------------------------------------------------
#  arg_filesystem
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_FILESYSTEM="Dateisystem"
readonly L_LUKS_DE_DLG_TXT_ARG_FILESYSTEM="Bitte legen Sie das Dateisystem fest, mit dem das geöffnete LUKS-Gerät eingehängt bzw. formatiert (nur im Verschlüsselungsmodus) werden soll.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_DE_HLP_DES_ARG_FILESYSTEM="Legt das Dateisystem fest, das beim Einhängen bzw. Formatieren verwendet wird."

#-------------------------------------------------------------------------------
#  arg_hash
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_HASH="Hash Algorithmus (Passwort-Hashing)"
readonly L_LUKS_DE_DLG_TXT_ARG_HASH="Bitte legen Sie einen Algorithmus für das Passwort-Hashing fest.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_DE_HLP_DES_ARG_HASH="Legt den Algorithmus für das Passwort-Hashing fest (1). Für eine Liste verfügbarer Algorithmen führen Sie bitte 'cryptsetup benchmark' aus."

#-------------------------------------------------------------------------------
#  arg_headerfile
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_HEADERFILE="Headerdatei"
readonly L_LUKS_DE_DLG_TXT_ARG_HEADERFILE_BACKUP="${LIB_SHTPL_DE_DLG_TXT_FILE_OUT_NOOVERRIDE}"
readonly L_LUKS_DE_DLG_TXT_ARG_HEADERFILE_RESTORE="Bitte wählen Sie die Datei aus, aus der der Header wiederhergestellt werden soll."

#-------------------------------------------------------------------------------
#  arg_key_size
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_KEY_SIZE="Schlüssellänge"
readonly L_LUKS_DE_DLG_TXT_ARG_KEY_SIZE="Bitte legen Sie die Schlüssellänge in Bits fest. Sollten Sie einen Algorithmus im XTS-Modus benutzen, so beachten Sie bitte, dass XTS den Schlüssel in zwei Teile gleicher Länge halbiert, d.h. für XTS-AES-256 benötigen Sie eine Schlüssellänge von 512 Bit.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_DE_HLP_DES_ARG_KEY_SIZE="Legt die Schlüssellänge in Bits fest (1) (2)"

#-------------------------------------------------------------------------------
#  arg_iter_time
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_ITER_TIME="Iterationszeit (PBKDF2)"
readonly L_LUKS_DE_DLG_TXT_ARG_ITER_TIME="Bitte geben Sie die Wartezeit in Millisekunden an, die nach der Passwort-Eingabe gewartet werden soll. Dies ist eine Maßnahme gegen Brute-Force-Angriffe.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_DE_HLP_DES_ARG_ITER_TIME="Legt die Wartezeit in Millisekunden für die PBKDF2-Passwortverarbeitung fest."

#-------------------------------------------------------------------------------
#  arg_mapper
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_MAPPER="Device Mapper (/dev/mapper/...)"
readonly L_LUKS_DE_DLG_TXT_ARG_MAPPER="Bitte geben Sie einen eindeutigen Gerätenamen an unter dem der geöffnete LUKS-Datenträger erreichbar sein soll.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_DE_HLP_DES_ARG_MAPPER="Mappt einen geöffneten LUKS-Datenträger nach '/dev/mapper/<name>'"

#-------------------------------------------------------------------------------
#  arg_mount
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_MOUNT="Einhängepunkt"
readonly L_LUKS_DE_DLG_TXT_ARG_MOUNT="Bitte geben Sie einen Pfad an, unter dem der geöffnete LUKS-Datenträger eingehängt werden soll. Lassen Sie dieses Feld leer, wenn der Datenträger nicht eingehängt werden soll.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_DE_HLP_DES_ARG_MOUNT="Einhängepunkt festlegen. Lassen Sie <mountpoint> leer (\"\"), um das Einhängen zu verhindern."

#-------------------------------------------------------------------------------
#  arg_pkcs11_token_uri
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_PKCS11_TOKEN_URI_1="PKCS#11 Security Token URI"
readonly L_LUKS_DE_DLG_TTL_ARG_PKCS11_TOKEN_URI_3="${LIB_SHTPL_DE_DLG_TTL_ERROR}"

readonly L_LUKS_DE_DLG_TXT_ARG_PKCS11_TOKEN_URI_1="Wie soll der PKCS#11-kompatible Token hinzugefügt bzw. entfernt werden?"
readonly L_LUKS_DE_DLG_TXT_ARG_PKCS11_TOKEN_URI_2="Bitte wählen Sie aus der nachfolgenden Geräteliste den gewünschten PKCS#11-kompatiblen Token aus:"
readonly L_LUKS_DE_DLG_TXT_ARG_PKCS11_TOKEN_URI_3="Kein PKCS#11-kompatibler Token gefunden."

readonly L_LUKS_DE_DLG_ITM_ARG_PKCS11_TOKEN_URI_AUTO="${L_LUKS_DE_DLG_ITM_ARG_FIDO2_DEVICE_AUTO}"
readonly L_LUKS_DE_DLG_ITM_ARG_PKCS11_TOKEN_URI_MANUAL="${L_LUKS_DE_DLG_ITM_ARG_FIDO2_DEVICE_MANUAL}"

readonly L_LUKS_DE_HLP_DES_ARG_PKCS11_TOKEN_URI="${L_LUKS_DE_HLP_REF_ARG_AUTH_PKCS11} PKCS#11-URI des zu verwendenden Token-Objekts festlegen, zulässige Werte:"
readonly L_LUKS_DE_HLP_DES_ARG_PKCS11_TOKEN_URI_AUTO="${L_LUKS_DE_DLG_ITM_ARG_PKCS11_TOKEN_URI_AUTO}"
readonly L_LUKS_DE_HLP_DES_ARG_PKCS11_TOKEN_URI_MANUAL="Manuell, durch Angabe der URI (<uri> = pkcs11:...). Führen Sie '${L_ABOUT_RUN} --list-token pkcs11' aus, um alle derzeit verbundenen PKCS#11-Token anzuzeigen."

#-------------------------------------------------------------------------------
#  arg_tpm2_device
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_TPM2_DEVICE_1="TPM2 Security Chip"
readonly L_LUKS_DE_DLG_TTL_ARG_TPM2_DEVICE_3="${LIB_SHTPL_DE_DLG_TTL_ERROR}"

readonly L_LUKS_DE_DLG_TXT_ARG_TPM2_DEVICE_1="Wie soll der TPM2 Chip hinzugefügt bzw. entfernt werden?"
readonly L_LUKS_DE_DLG_TXT_ARG_TPM2_DEVICE_2="Bitte wählen Sie aus der nachfolgenden Geräteliste den gewünschten TMP2 Chip aus:"
readonly L_LUKS_DE_DLG_TXT_ARG_TPM2_DEVICE_3="Kein TPM2 Chip gefunden."

readonly L_LUKS_DE_DLG_ITM_ARG_TPM2_DEVICE_AUTO="Automatisch (genau ein (1) Chip, es darf kein weiterer existieren)"
readonly L_LUKS_DE_DLG_ITM_ARG_TPM2_DEVICE_MANUAL="Manuell (aus einer Liste aller erkannten Chips)"

readonly L_LUKS_DE_HLP_DES_ARG_TPM2_DEVICE="${L_LUKS_DE_HLP_REF_ARG_AUTH_TPM2} Zu verwendenden TPM2-Chip festlegen, zulässige Werte:"
readonly L_LUKS_DE_HLP_DES_ARG_TPM2_DEVICE_AUTO="${L_LUKS_DE_DLG_ITM_ARG_TPM2_DEVICE_AUTO}"
readonly L_LUKS_DE_HLP_DES_ARG_TPM2_DEVICE_MANUAL="Manuell, durch Angabe des devnode-Namens (<dev> = /dev/tpmrm...). Führen Sie '${L_ABOUT_RUN} --list-token tpm2' aus, um alle erkannten TPM2-Chips anzuzeigen."

#-------------------------------------------------------------------------------
#  arg_tpm2_pcrs
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_TPM2_PCRS="TPM2 PCRs (Platform Configuration Registers)"
readonly L_LUKS_DE_DLG_TXT_ARG_TPM2_PCRS="Bitte bestimmen Sie ein oder mehrere TMP2 PCRs (Plattform-Konfigurationsregister), an die die gewünschte Registrierung gebunden werden soll. Das nachfolgende Feld erwartet eine '+' getrennte Liste von PCR-Indizes im Bereich 0...23. Für mehr Informationen siehe 'man systemd-cryptenroll', Abschnitt '--tpm2-pcrs= [PCR...]'.

${LIB_SHTPL_DE_DLG_TXT_LEAVEDEFAULT}"
readonly L_LUKS_DE_HLP_DES_ARG_TPM2_PCRS="${L_LUKS_DE_HLP_REF_ARG_AUTH_TPM2} Ein oder mehrere TMP2 PCRs (Plattform-Konfigurationsregister) festlegen, an die die gewünschte Registrierung gebunden werden soll. <pcrs> muss eine '+' getrennte Liste von PCR-Indizes im Bereich 0...23 sein. Für mehr Informationen siehe 'man systemd-cryptenroll', Abschnitt '--tpm2-pcrs= [PCR...]'."

#-------------------------------------------------------------------------------
#  arg_with_pin
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_DLG_TTL_ARG_WITH_PIN="Zusätzliche PIN-Abfrage zum Entsperren?"
readonly L_LUKS_DE_DLG_TXT_ARG_WITH_PIN_FIDO2="Soll zum Entsperren zusätzlich die PIN des FIDO2-Tokens abgefragt werden?

${LIB_SHTPL_DE_DLG_TXT_ATTENTION}
Dies funktioniert nur, wenn Ihr Token das FIDO2-Feature 'clientPIN' unterstützt."
readonly L_LUKS_DE_DLG_TXT_ARG_WITH_PIN_TPM2="Soll zum Entsperren zusätzlich die TPM2-PIN abgefragt werden?"
readonly L_LUKS_DE_HLP_DES_ARG_WITH_PIN="${L_LUKS_DE_HLP_REF_ARG_AUTH_FIDO2_OR_TPM2} Beim Öffnen wird keine(!) zusätzliche PIN angefordert. Nicht empfohlen."

#-------------------------------------------------------------------------------
#  Last argument (parameter), see also <args_read()> in '/src/run.sh'
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_HLP_DES_LASTARG="Zu verwendender Datenträger (Blockgerät), z.B. '/dev/sda'"

#-------------------------------------------------------------------------------
#  Script actions <ARG_ACTION_...>
#-------------------------------------------------------------------------------
#  Main Menu Title/Text
readonly L_LUKS_DE_DLG_TTL_ARG_ACTION="${L_ABOUT_PROJECT}"
readonly L_LUKS_DE_DLG_TXT_ARG_ACTION="Was möchten Sie tun?"

#  ARG_ACTION_BENCHMARK
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_BENCHMARK="Benchmark durchführen"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_BENCHMARK="${L_LUKS_DE_DLG_ITM_ARG_ACTION_BENCHMARK}"

#  ARG_ACTION_CLONE
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_CLONE="LUKS-Datenträger klonen"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_CLONE="Quelldatenträger <src dev> nach Zieldatenträger <dst dev> klonen"

#  ARG_ACTION_CLOSE
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_CLOSE="Geöffneten LUKS-Datenträger schließen/sperren"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_CLOSE="<device> schließen und aushängen"

#  ARG_ACTION_ENCRYPT
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_ENCRYPT="Neuen Datenträger verschlüsseln"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_ENCRYPT="<device> verschlüsseln"

#  ARG_ACTION_ENROLL
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_ENROLL="LUKS-Header | Passwort oder Security Token hinzufügen"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_ENROLL="Ein Passwort ein Passwort oder Security Token (FIDO2/PKCS#11/TPM2) zum LUKS-Header von <device> hinzufügen. ${L_LUKS_DE_HLP_REF_ARG_AUTH}"

#  ARG_ACTION_HEADER_BACKUP
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_HEADER_BACKUP="LUKS-Header | Header sichern"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_HEADER_BACKUP="LUKS-Header von <device> in die Datei <file> sichern (4)"

#  ARG_ACTION_HEADER_INFO
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_HEADER_INFO="LUKS-Header | Info"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_HEADER_INFO="Informationen über den LUKS-Header von <device> anzeigen"

#  ARG_ACTION_HEADER_RESTORE
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_HEADER_RESTORE="LUKS-Header | Header wiederherstellen"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_HEADER_RESTORE="LUKS-Header aus der Datei <file> nach <device> wiederherstellen"

#  ARG_ACTION_IS_LUKS_DEVICE
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_IS_LUKS_DEVICE="Prüfen, ob <device> ein LUKS-Datenträger ist. Rückgabewert: 0 = ja, 1 = nein."

#  ARG_ACTION_LIST_TOKEN
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_LIST_TOKEN="Verfügbare Token eines bestimmten Typs anzeigen"

#  ARG_ACTION_OPEN
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_OPEN="Einen verfügbaren LUKS-Datenträger öffnen/entsperren"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_OPEN="Datenträger <device> öffnen und einhängen. ${L_LUKS_DE_HLP_REF_ARG_AUTH}"

#  ARG_ACTION_REMOVE
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_REMOVE="LUKS-Header | Einzelnes Passwort oder alle Security Token entfernen"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_REMOVE="Entweder ein einzelnes Passwort oder alle Security Token aus dem LUKS-Header von <device> entfernen (3)"

#  ARG_ACTION_REPLACE
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_REPLACE="LUKS-Header | Vorhandenen FIDO2/PKCS#11/TPM2 Security Token Slot ersetzen"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_REPLACE="${L_LUKS_DE_HLP_REF_ARG_AUTH_FIDO2_OR_PKCS11_OR_TPM2} Vorhandenen FIDO2/PKCS#11/TPM2 Security Token Slot durch alle (derzeit angeschlossenen) Security Token ersetzen"

#  ARG_ACTION_SHOW_DRIVES
readonly L_LUKS_DE_DLG_ITM_ARG_ACTION_SHOW_DRIVES="Alle verfügbaren internen und externen Datenträger anzeigen"
readonly L_LUKS_DE_HLP_DES_ARG_ACTION_SHOW_DRIVES="Verfügbare Datenträger anzeigen"

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
readonly L_LUKS_DE_HLP_TTL_EXAMPLES_1="Datenträger verschlüsseln"
readonly L_LUKS_DE_HLP_TXT_EXAMPLES_1="${L_LUKS_HLP_TXT_EXAMPLES_1}"

# Example 2
readonly L_LUKS_DE_HLP_TTL_EXAMPLES_2="Datenträger öffnen und schließen"
readonly L_LUKS_DE_HLP_TXT_EXAMPLES_2="${L_LUKS_HLP_TXT_EXAMPLES_2}"

# Example 3
readonly L_LUKS_DE_HLP_TTL_EXAMPLES_3="FIDO2-Token hinzufügen"
readonly L_LUKS_DE_HLP_TXT_EXAMPLES_3="${L_LUKS_HLP_TXT_EXAMPLES_3}"

# Example 4
readonly L_LUKS_DE_HLP_TTL_EXAMPLES_4="Header sichern und wiederherstellen"
readonly L_LUKS_DE_HLP_TXT_EXAMPLES_4="${L_LUKS_HLP_TXT_EXAMPLES_4}"

#-------------------------------------------------------------------------------
#  NOTES
#-------------------------------------------------------------------------------
# Note 1
readonly L_LUKS_DE_HLP_TXT_NOTES_1="\
Führen Sie 'cryptsetup --help' aus, um die Standardwerte anzuzeigen."

# Note 2
readonly L_LUKS_DE_HLP_TXT_NOTES_2="\
Wichtig, falls Sie einen Algorithmus im XTS-Modus benutzen:
XTS teilt den Schlüssel in zwei Hälften auf, z.B. benötigen Sie
für AES-256 im XTS-Modus eine Schlüssellänge von 512 Bits."

# Note 3
readonly L_LUKS_DE_HLP_TXT_NOTES_3="\
Verwenden Sie '--auth <type>', um die Authentifizierungsmethode festzulegen,
welche aus dem LUKS-Header entfernt werden Soll. Wenn <type> gleich ...

          'passphrase' : Nur die Passphrase, die während der Eingabeaufforderung
                         eingegeben wird, wird aus dem LUKS-Header entfernt.

      'fido2'|'pkcs11' : ALLE Token dieses Typs werden aus dem
     'recovery'|'tpm2'   LUKS-Header entfernt."

# Note 4
readonly L_LUKS_DE_HLP_TXT_NOTES_4="\
ES WIRD DRINGEND EMPFOHLEN, IHRE HEADER-SICHERUNG AUF EINEM SEPARATEN EXTERNEN
DATENTRÄGER AUFZUBEWAHREN. Denken Sie bitte daran, Ihre Header-Sicherung zu
erneuern, wenn Sie Passphrasen/Token aus Ihrem Header entfernen.
Andernfalls kann der alte Header wiederhergestellt werden und so der Zugriff
auch mit bereits entfernten Passphrasen/Token möglich sein."

#-------------------------------------------------------------------------------
#  REQUIREMENTS
#-------------------------------------------------------------------------------
#  Requirements 1
readonly L_LUKS_DE_HLP_TTL_REQUIREMENTS_1="Allgemein"
readonly L_LUKS_DE_HLP_TXT_REQUIREMENTS_1="\
Benötigte Pakete:
${L_LUKS_HLP_TXT_REQUIREMENTS_1}"

#  Requirements 2
readonly L_LUKS_DE_HLP_TTL_REQUIREMENTS_2="${LIB_SHTPL_DE_TXT_HELP_TTL_REQUIREMENTS_INTERACTIVE}"
readonly L_LUKS_DE_HLP_TXT_REQUIREMENTS_2="${LIB_SHTPL_DE_TXT_HELP_TXT_REQUIREMENTS_INTERACTIVE}"

#  Requirements 3
readonly L_LUKS_DE_HLP_TTL_REQUIREMENTS_3="FIDO2/PKCS#11/TMP2 Security Token/Chip (optional)"
readonly L_LUKS_DE_HLP_TXT_REQUIREMENTS_3="\
Bitte stellen Sie sicher, dass die <systemd>-Version Ihres Betriebssystems '251.3-1'
oder höher ist. Um Ihre aktuelle Version zu prüfen, führen Sie folgenden Befehl aus:
${L_LUKS_HLP_TXT_REQUIREMENTS_3_SYSTEMCTL}

FIDO2
  Ihr Token muss die Erweiterung \"HMAC Secret Extension\" (hmac-secret) unterstützen.
  Außerdem müssen folgende zusätzliche Pakete installiert sein:

${L_LUKS_HLP_TXT_REQUIREMENTS_3_FIDO2}

PKCS#11
  Ihr Token muss initialisiert sein und ein gültiges öffentlich-privates Schlüsselpaar
  besitzen. Außerdem müssen folgende zusätzliche Pakete installiert sein:

${L_LUKS_HLP_TXT_REQUIREMENTS_3_PKCS11_1}

  Siehe auch: ${L_LUKS_HLP_TXT_REQUIREMENTS_3_PKCS11_2}

TPM2
  Benötigte Pakete:

${L_LUKS_HLP_TXT_REQUIREMENTS_3_TPM2}

Siehe auch: ${L_LUKS_HLP_TXT_REQUIREMENTS_3_SEEALSO}"

#-------------------------------------------------------------------------------
#  TEXTS
#-------------------------------------------------------------------------------
# Intro Description
readonly L_LUKS_DE_HLP_TXT_INTRO="Eine Sammlung von Shellskripts, um LUKS2-verschlüsselte Laufwerke einzurichten und zu verwalten."

#-------------------------------------------------------------------------------
#  TL;DR
#-------------------------------------------------------------------------------
readonly L_LUKS_DE_HLP_TTL_TLDR_1="Anforderungen"
readonly L_LUKS_DE_HLP_TXT_TLDR_1="\
Um die benötigten Pakete zu installieren, führen Sie bitte folgenden Befehl aus:

${L_LUKS_HLP_TXT_TLDR_1_INSTALL}

Das Skript wurde in folgender Umgebung entwickelt und getestet:

OS:         ${L_LUKS_HLP_TXT_TLDR_1_OS}
Kernel:     ${L_LUKS_HLP_TXT_TLDR_1_KERNEL}
Pakete:     ${L_LUKS_HLP_TXT_TLDR_1_PACKAGES}"

#===============================================================================
#  CUSTOM STRINGS (used in terminal output <stdout>/<stderr>)
#===============================================================================
#  DONE: Here you can define custom language-specific strings.
#        Do not forget to "publish" them within the <init_lang()> function of
#        your destination script, e.g. 'run.sh'.
#===============================================================================
readonly L_LUKS_DE_TXT_ARG_AUTH_NOT_SUPPORTED="Die gewählte Authentifizierungsmethode wird nicht unterstützt, möglicherweise sind einige Voraussetzungen nicht erfüllt."
readonly L_LUKS_DE_TXT_CLONE_ERROR="Klonvorgang konnte nicht abgeschlossen werden"
readonly L_LUKS_DE_TXT_CLONE_INFO_CHECKSUM="Berechne Prüfsumme..."
readonly L_LUKS_DE_TXT_CLONE_INFO_CLONED="Datenträger erfolgreich geklont."
readonly L_LUKS_DE_TXT_CLONE_INFO_CLONING="Klone ..."
readonly L_LUKS_DE_TXT_ENCRYPT_INFO="erfolgreich verschlüsselt."
readonly L_LUKS_DE_TXT_ENROLL_INFO="Passphrase/Token erfolgreich hinzugefügt."
readonly L_LUKS_DE_TXT_ERROR_DEFAULT="Vorgang konnte nicht abgeschlossen werden."
readonly L_LUKS_DE_TXT_ERROR_IDENTICAL_DEVS="Quell- und Zieldatenträger identisch. ${LIB_SHTPL_DE_TXT_ABORTING}"
readonly L_LUKS_DE_TXT_HEADER_BACKUP_INFO="Header erfolgreich gesichert nach"
readonly L_LUKS_DE_TXT_HEADER_RESTORE_INFO="LUKS Header erfolgreich wiederhergestellt."
readonly L_LUKS_DE_TXT_MSG_INFO_HEADER_INFO_BACKUP="Es wird dringend empfohlen, den LUKS-Datenträger jetzt zu testen und, falls alles funktioniert, die Sicherung Ihres Datenträgers sowie die des Headers zu aktualisieren."
readonly L_LUKS_DE_TXT_MSG_INFO_HEADER_INFO_CHANGED="INFO: LUKS Header geändert ..."
readonly L_LUKS_DE_TXT_MSG_WARN_HEADER_INFO="Es wird dringend empfohlen, den Header zu sichern, bevor Sie fortfahren"
readonly L_LUKS_DE_TXT_MSG_WARN_HEADER_WARN="Ändere LUKS Header ..."
readonly L_LUKS_DE_TXT_MSG_WARN_LSBLK_INFO_ENCRYPTING="Verschlüssele ..."
readonly L_LUKS_DE_TXT_MSG_WARN_LSBLK_WARN="Alle Daten auf dem folgenden Datenträger gehen unwiederbringlich verloren:"
readonly L_LUKS_DE_TXT_OPEN_INFO_OPENED="Datenträger erfolgreich geöffnet unter"
readonly L_LUKS_DE_TXT_OPEN_INFO_OPENING="Öffne LUKS-Datenträger ..."
readonly L_LUKS_DE_TXT_OPEN_INFO_MOUNTED="Datenträger erfolgreich eingehangen unter"
readonly L_LUKS_DE_TXT_OPEN_INFO_MOUNTING="Mounte ..."
readonly L_LUKS_DE_TXT_REMOVE_INFO="Passphrase/Token erfolgreich entfernt."
readonly L_LUKS_DE_TXT_REPLACE_INFO="Token erfolgreich ersetzt."
readonly L_LUKS_DE_TXT_UNMOUNT_ERROR="Aushängen konnte nicht abgeschlossen werden"
readonly L_LUKS_DE_TXT_UNMOUNT_INFO_CLOSED="erfolgreich geschlossen."
readonly L_LUKS_DE_TXT_UNMOUNT_INFO_CLOSING="Schließe LUKS-Datenträger"
readonly L_LUKS_DE_TXT_UNMOUNT_INFO_UNMOUNTED="erfolgreich ausgehangen."
readonly L_LUKS_DE_TXT_UNMOUNT_INFO_UNMOUNTING="Hänge aus"