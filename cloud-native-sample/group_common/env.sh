#!/bin/bash
PROJECT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export BIN_DIR=$PROJECT_DIR/bin
export OCI_STARTER_CREATION_DATE=2023-09-08-11-26-45-566988
export OCI_STARTER_VERSION=1.5

# Env Variables
export TF_VAR_group_name="api"
export TF_VAR_prefix="api"

export TF_VAR_output_dir="output"
export TF_VAR_group_common="apigw"

if [ -f $PROJECT_DIR/../group_common_env.sh ]; then
  . $PROJECT_DIR/../group_common_env.sh
elif [ -f $PROJECT_DIR/../../group_common_env.sh ]; then
  . $PROJECT_DIR/../../group_common_env.sh
elif [ -f $HOME/.oci_starter_profile ]; then
  . $HOME/.oci_starter_profile
else
  # Ex: export TF_VAR_compartment_ocid=ocid1.compartment.xxxxx
  export TF_VAR_compartment_ocid=__TO_FILL__
  # Ex: export APIM_HOST=xxxx-xxx.adb.region.oraclecloudapps.com
  export APIM_HOST=__TO_FILL__

  # Landing Zone
  # export TF_VAR_lz_appdev_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_database_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_network_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_security_cmp_ocid=$TF_VAR_compartment_ocid
fi

# Get other env variables automatically (-silent flag can be passed)
. $BIN_DIR/auto_env.sh $1
