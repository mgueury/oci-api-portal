#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export OCI_STARTER_CREATION_DATE=2023-06-02-14-37-41-134874
export OCI_STARTER_VERSION=1.5

# Env Variables
export TF_VAR_prefix="k8s"

export TF_VAR_group_common="atp,oke"

if [ -f $SCRIPT_DIR/../../group_common_env.sh ]; then
  . $SCRIPT_DIR/../../group_common_env.sh
else
  export TF_VAR_compartment_ocid=ocid1.compartment.xxxxx
  # TF_VAR_license_model : BRING_YOUR_OWN_LICENSE or LICENSE_INCLUDED
  export TF_VAR_license_model="LICENSE_INCLUDED"
  # TF_VAR_auth_token : See doc: https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm
  export TF_VAR_auth_token="__TO_FILL__"

  # API Management
  export APIM_HOST="__TO_FILL__"

  # Landing Zone
  # export TF_VAR_lz_appdev_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_database_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_network_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_security_cmp_ocid=$TF_VAR_compartment_ocid
fi

# Get other env variables automatically (-silent flag can be passed)
. $SCRIPT_DIR/bin/auto_env.sh $1
