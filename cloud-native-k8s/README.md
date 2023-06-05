## OCI-Starter - Common Resources
### Usage 

### Commands
- build_group.sh   : Build first the Common Resources (group_common), then other directories
- destroy_group.sh : Destroy other directories, then the Common Resources

- group_common
    - build.sh     : Create the Common Resources using Terraform
    - destroy.sh   : Destroy the objects created by Terraform
    - env.sh       : Contains the settings of the project

### Directories
- group_common/src : Sources files
    - terraform    : Terraform scripts (Command: plan.sh / apply.sh)

### After Build
- group_common_env.sh : File created during the build.sh and imported in each application
- app1                : Directory with an application using "group_common_env.sh" 
- app2                : ...
...
    

Help (Tutorial + How to customize): https://www.ocistarter.com/help

### Next Steps:
- Edit the file group_common/env.sh. Some variables need to be filled:
```
export TF_VAR_auth_token="__TO_FILL__"
```

- Run:
  # Build first the group common resources (group_common), then other directories
  cd k8s
  ./build_group.sh
