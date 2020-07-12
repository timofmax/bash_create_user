#!/bin/bash
#This script creates an account on local system
#Ask for username

if [[ "${UID}" -eq 0 ]]
then 
    echo "Script run as root"
else
    echo "please run script as root"
    exit 1
fi

USER_NAME="${1}"
shift
COMMENT_NAME="${*}"


PASSWORD=$(date +%s%N | sha256sum | head -c 16)
SPEC_CHARACTER=$(echo "!@#$%^&*()_+=" | fold -w 1 | shuf | head -c 1)

PASSWORD="${PASSWORD}${SPEC_CHARACTER}"

useradd -c "${COMMENT_NAME}" -m "${USER_NAME}"
echo "${PASSWORD}" | passwd --stdin "$USER_NAME"
passwd -e "${USER_NAME}"

echo "Successfully created ${USER_NAME} for ${COMMENT_NAME}"
echo "Password: ${PASSWORD}"

