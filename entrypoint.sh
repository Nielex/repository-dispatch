#!/bin/sh -l

TOKEN=$1
USER=$2
REPO=$3
EVENT=$4
PAYLOAD=$5

if [ -z "${TOKEN}" ]; then
	echo "You must provide a GitHub authentication token"
	exit 1
fi
if [ -z "${USER}" ]; then
	echo "You must provide the GitHub user to which the authentication token belong"
	exit 1
fi
if [ -z "${REPO}" ]; then
	echo "You must provide a repository to dispatch event to (:owner/:repo)"
	exit 1
fi
if [ -z "${EVENT}" ]; then
	echo "You must provide an event name"
	exit 1
fi

curl -i -u "${USER}:${TOKEN}" -X POST https://api.github.com/repos/${REPO}/dispatches \
-H 'Accept: application/vnd.github.everest-preview+json' \
--data "{\"event_type\": \"${EVENT}\",\"client_payload\": ${PAYLOAD}}"