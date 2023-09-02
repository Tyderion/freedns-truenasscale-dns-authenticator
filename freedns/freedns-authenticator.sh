#!/bin/bash
### VARIABLES
# Logfile
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
LOGFILE="${SCRIPT_DIR}/freedns-authenticator.log"

export HOME="/mnt/Base/home/acmeScript" # Change this path to reflect yourf environment
# Source acmesh scripts
export ACME_FOLDER="/mnt/Base/acmeScript/freedns/acme.sh" # Change this path to reflect yourf environment
export ACME_DNSAPI="${ACME_FOLDER}/dnsapi"
export PROVIDER="dns_freedns" # Find provider script in 'dnsapi' folder
source "${ACME_FOLDER}/acme.sh" > /dev/null 2>&1
source "${ACME_DNSAPI}/${PROVIDER}.sh" > /dev/null 2>&1

# Dns API authentication. See details for your provider https://github.com/acmesh-official/acme.sh/wiki/dnsapi
source ./.env

# Somehow home and config are not initialized correctly
__initHome
_initconf
_inithttp


### FUNCTIONS
_log_output() {
        echo `date "+[%a %b %d %H:%M:%S %Z %Y]"`" $1" >> ${LOGFILE}
}

export DEBUG_LEVEL_1=1
export DEBUG_LEVEL_2=1
export DEBUG_LEVEL_3=1

### MAIN
_log_output "INFO Script started."

# File/folder validation
if [ ! -d "${ACME_FOLDER}" ]; then
        _log_output "ERROR Invalid acme folder: ${ACME_FOLDER}"
        return 1
fi
if [ ! -f "${LOGFILE}" ]; then
        touch "${LOGFILE}"
        chmod 500 "${LOGFILE}"
fi

# Main
if [ "${1}" == "set" ]; then
        ${PROVIDER}_add "${3}" "${4}" >> ${LOGFILE} 2>/dev/null
elif [ "${1}" == "unset" ]; then
        ${PROVIDER}_rm "${3}" "${4}" >> ${LOGFILE} 2>/dev/null
fi


_log_output "INFO Script finished."