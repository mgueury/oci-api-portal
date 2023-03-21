## OCI-Starter
### Usage 

### Commands
- build.sh      : Build the whole program: Run Terraform, Configure the DB, Build the App, Build the UI
- destroy.sh    : Destroy the objects created by Terraform
- env.sh        : Contains the settings of your project

### Directories
- src           : Sources files
    - app       : Source of the Backend Application (Command: build_app.sh)
    - ui        : Source of the User Interface (Command: build_ui.sh)
    - db        : SQL files of the database
    - terraform : Terraform scripts (Command: plan.sh / apply.sh)
  - compute     : Contains the deployment files to Compute

Help (Tutorial + How to customize): https://starter.wedoteam.io/help

### Next Steps:
- Edit the file env.sh. Some variables need to be filled:
```
export TF_VAR_vcn_ocid="__TO_FILL__"
export TF_VAR_public_subnet_ocid="__TO_FILL__"
export TF_VAR_private_subnet_ocid="__TO_FILL__"
export TF_VAR_bastion_ocid="__TO_FILL__"
```

- Run:
  cd api-dotnet
  ./build.sh
