#!/bin/bash
# Add the API to the API Management Portal
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..
. env.sh -silent

add_api_portal() {
  PARAM=$1
  if [ "$APIGW_DEPLOYMENT_OCID" != "" ]; then
    PARAM="${PARAM}&runtime_console=https://cloud.oracle.com/api-gateway/gateways/$TF_VAR_apigw_ocid/deployments/$APIGW_DEPLOYMENT_OCID"
  fi
  echo "Add to API Portal: ${PARAM}"
  URL_PARAM="https://${APIM_HOST}/ords/apim/rest/add_api?git_repo_url=${TF_VAR_git_url}&impl_name=${FIRST_LETTER_UPPERCASE}&icon_url=${TF_VAR_language}&version=${GIT_BRANCH}&spec_type=OpenAPI&${PARAM}" 
  curl -k $URL_PARAM
}

if [ "$APIM_HOST" != "" ]; then
  FIRST_LETTER_UPPERCASE=`echo $TF_VAR_prefix | sed -e "s/\b\(.\)/\u\1/g"`
  if [ "$TF_VAR_ui_strategy" == "api" ]; then
    APIGW_URL=https://${APIGW_HOSTNAME}/${TF_VAR_prefix}  
    for APP_DIR in `app_dir_list`; do
      if [ -f src/${APP_DIR}/openapi_spec.yaml ]; then
         add_api_portal "endpoint_url=${APIGW_URL}/${APP_DIR}/dept&endpoint_git_path=src/terraform/apigw_existing.tf&spec_git_path=src/${APP_DIR}/openapi_spec.yaml"
      fi  
    done
  else
    get_ui_url
    if [ -f src/oke/ingress-app.yaml ]; then
      ENDPOINT_GIT=src/oke/ingress-app.yaml
      add_api_portal "endpoint_url=${UI_URL}/app/dept&endpoint_git_path=${ENDPOINT_GIT}&spec_git_path=src/app/openapi_spec.yaml"
    fi 
  fi
fi
