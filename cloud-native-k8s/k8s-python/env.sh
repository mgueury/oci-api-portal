#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export OCI_STARTER_CREATION_DATE=2023-06-05-06-57-50-038637
export OCI_STARTER_VERSION=1.5

# Env Variables
export TF_VAR_prefix="k8s-python"

export TF_VAR_ui_strategy="html"
export TF_VAR_db_strategy="none"
export TF_VAR_deploy_strategy="kubernetes"
export TF_VAR_language="python"
export TF_VAR_db_user=""

if [ -f $SCRIPT_DIR/../group_common_env.sh ]; then
  . $SCRIPT_DIR/../group_common_env.sh
else
  # export TF_VAR_compartment_ocid=ocid1.compartment.xxxxx
  # TF_VAR_license_model : BRING_YOUR_OWN_LICENSE or LICENSE_INCLUDED
  export TF_VAR_license_model="LICENSE_INCLUDED"
  # TF_VAR_auth_token : See doc: https://docs.oracle.com/en-us/iaas/Content/Registry/Tasks/registrygettingauthtoken.htm
  export TF_VAR_auth_token="__TO_FILL__"
  export TF_VAR_vcn_ocid="__TO_FILL__"
  export TF_VAR_public_subnet_ocid="__TO_FILL__"
  export TF_VAR_private_subnet_ocid="__TO_FILL__"
  export TF_VAR_oke_ocid="__TO_FILL__"

  # API Management
  # export APIM_HOST=xxxx-xxx.adb.region.oraclecloudapps.com

  # Landing Zone
  # export TF_VAR_lz_appdev_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_database_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_network_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_security_cmp_ocid=$TF_VAR_compartment_ocid
fi

# Get other env variables automatically (-silent flag can be passed)
. $SCRIPT_DIR/bin/auto_env.sh $1
