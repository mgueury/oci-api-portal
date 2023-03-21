#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export OCI_STARTER_CREATION_DATE=2023-03-07-15-29-44-301665
export OCI_STARTER_VERSION=1.5

# Env Variables
export TF_VAR_prefix="api"

export TF_VAR_group_common="atp,apigw"

if [ -f $SCRIPT_DIR/../../group_common_env.sh ]; then
  . $SCRIPT_DIR/../../group_common_env.sh
else
  . $HOME/bin/env_oci_starter_testsuite.sh
  export TF_VAR_compartment_ocid=$EX_COMPARTMENT_OCID
  # TF_VAR_license_model : BRING_YOUR_OWN_LICENSE or LICENSE_INCLUDED
  export TF_VAR_license_model=BRING_YOUR_OWN_LICENSE

  export APIM_HOST=ohgfmjcmy0d6yut-mgatp.adb.eu-frankfurt-1.oraclecloudapps.com
  # Landing Zone
  # export TF_VAR_lz_appdev_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_database_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_network_cmp_ocid=$TF_VAR_compartment_ocid
  # export TF_VAR_lz_security_cmp_ocid=$TF_VAR_compartment_ocid
fi

# Get other env variables automatically (-silent flag can be passed)
. $SCRIPT_DIR/bin/auto_env.sh $1
