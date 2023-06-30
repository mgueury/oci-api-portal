#!/bin/bash
if [[ -z "${ROOT_DIR}" ]]; then
  echo "Error: ROOT_DIR not set"
  exit
fi
cd $ROOT_DIR
SECONDS=0

# Build all
# Generate sshkeys if not part of a Common Resources project 
if [ "$TF_VAR_ssh_private_path" == "" ]; then
  . bin/sshkey_generate.sh
fi
. env.sh
# Run Terraform
src/terraform/apply.sh --auto-approve -no-color
exit_on_error

. env.sh
# Run config command on the DB directly (ex RAC)
if [ -f bin/deploy_db_node.sh ]; then
  bin/deploy_db_node.sh
fi 

# Build the DB tables (via Bastion)
if [ -d src/db ]; then
  bin/deploy_bastion.sh
fi  

# Init target/compute
if [ "$TF_VAR_deploy_strategy" == "compute" ]; then
    mkdir -p target/compute
    cp src/compute/* target/compute/.
fi

# Build all app* directories
for d in `ls -d src/app* | sort -g`; do
    ${d}/build_app.sh
    exit_on_error
done

if [ -f src/app/build_app.sh ]; then
    src/app/build_app.sh 
    exit_on_error
fi

if [ -f src/ui/build_ui.sh ]; then
    src/ui/build_ui.sh 
    exit_on_error
fi

# Deploy
if [ "$TF_VAR_deploy_strategy" == "compute" ]; then
    bin/deploy_compute.sh
elif [ "$TF_VAR_deploy_strategy" == "kubernetes" ]; then
    bin/oke_deploy.sh
elif [ "$TF_VAR_deploy_strategy" == "container_instance" ]; then
    bin/ci_deploy.sh
fi

bin/add_api.sh

bin/done.sh
echo "Build time: ${SECONDS} secs"

