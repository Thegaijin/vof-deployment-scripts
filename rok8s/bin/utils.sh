#!/usr/bin/env bash

DIR=$(pwd)

BOLD='\e[1m'
BLUE='\e[34m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[92m'
NC='\e[0m'


info() {
    printf "\n${BOLD}${BLUE}====> $(echo $@ ) ${NC}\n"
}

warning () {
    printf "\n${BOLD}${YELLOW}====> $(echo $@ )  ${NC}\n"
}

error() {
    printf "\n${BOLD}${RED}====> $(echo $@ )  ${NC}\n"; exit 1
}

success () {
    printf "\n${BOLD}${GREEN}====> $(echo $@ ) ${NC}\n"
}

is_success_or_fail() {
    if [ "$?" == "0" ]; then success $@; else error $@; fi
}

is_success() {
    if [ "$?" == "0" ]; then success $@; fi
}

# require "variable name" "value"
require () {
    if [ -z ${2+x} ]; then error "Required variable ${1} has not been set"; fi
}

if [ -f $DIR/bin/sample.envs ]; then
  source $DIR/bin/sample.envs
fi


SERVICE_KEY_PATH=$HOME/service-account-key.json
IMAGE_TAG=$(git rev-parse --short HEAD)
PROJECT_ID=apprenticeship-projects
# assert required variables

# require INGRESS_STATIC_IP_NAME $INGRESS_STATIC_IP_NAMEE
require PRODUCTION_COMPUTE_ZONE $COMPUTE_ZONE
require CLUSTER_NAME $CLUSTER_NAME
require FLASK_CONFIG=$FLASK_CONFIG
require REDIS_IP=$REDIS_IP


if [ "$CIRCLE_BRANCH" =~ 'sandbox' ]; then
    export COMPUTE_ZONE=$COMPUTE_ZONE
    export CLUSTER_NAME=$CLUSTER_NAME
    export REDIS_IP=$REDIS_IP
fi

# export NAMESPACE=$ENVIRONMENT
