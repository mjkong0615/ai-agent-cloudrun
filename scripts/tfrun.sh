#!/bin/bash

source ./env

export TF_VAR_ORG_ID=$ORG_ID
export TF_VAR_BILLING_ACCOUNT=$BILLING_ACCOUNT
export TF_VAR_REGION=$REGION
export TF_VAR_MEMBER=$MEMBER

TERRAFORM_DIR="../terraform/$2"
echo $TERRAFORM_DIR
OPTIONS=""

if [ "apply" == $1 ]; then
    OPTIONS="-auto-approve"
fi

terraform -chdir=$TERRAFORM_DIR $1 $OPTIONS