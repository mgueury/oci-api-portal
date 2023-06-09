#!/bin/bash
if [[ -z "${ROOT_DIR}" ]]; then
  echo "Error: ROOT_DIR not set"
  exit
fi
cd $ROOT_DIR
SECONDS=0

# Call the script with --auto-approve to destroy without prompt

. $ROOT_DIR/bin/shared_bash_function.sh
title "OCI Starter - Destroy"
echo 
echo "Warning: This will destroy all the resources created by Terraform."
echo 
if [ "$1" != "--auto-approve" ]; then
  read -p "Do you want to proceed? (yes/no) " yn

  case $yn in 
  	yes ) echo Deleting;;
	no ) echo Exiting...;
		exit;;
	* ) echo Invalid response;
		exit 1;;
  esac
fi

. env.sh
if [ -f $ROOT_DIR/src/terraform/oke.tf ]; then
  title "OKE Destroy"
  bin/oke_destroy.sh --auto-approve
elif [ "$TF_VAR_deploy_strategy" == "function" ]; then
  title "Delete Object Storage files"
  oci os object bulk-delete -bn ${TF_VAR_prefix}-public-bucket --force
fi

title "Terraform Destroy"
src/terraform/destroy.sh --auto-approve -no-color
echo "Destroy time: ${SECONDS} secs"