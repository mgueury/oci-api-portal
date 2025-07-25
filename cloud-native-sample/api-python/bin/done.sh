#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

if [ -z "$TF_VAR_deploy_strategy" ]; then
  . ./env.sh -silent
else
  . bin/shared_bash_function.sh
fi 

get_ui_url

echo 
echo "Build done"
if [ ! -z "$UI_URL" ]; then
  # Check the URL if running in the test_suite
  if [ ! -z "$TEST_NAME" ]; then
    echo $UI_URL > /tmp/ui_url.txt
    
    if [ "$TF_VAR_deploy_strategy" == "kubernetes" ]; then
      kubectl wait --for=condition=ready pod ${TF_VAR_prefix}-app
      kubectl wait --for=condition=ready pod ${TF_VAR_prefix}-ui
      kubectl get all
      sleep 5
    fi

    # Retry several time. Needed for ORDS or Go or Tomcat that takes more time to start
    x=1
    while [ $x -le 5 ]
    do
      rm /tmp/cookie.txt
      curl $UI_URL/app/dept -b /tmp/cookie.txt -c /tmp/cookie.txt -L --retry 5 --retry-max-time 20 -D /tmp/result_json.log > /tmp/result.json
      if grep -q -i "deptno" /tmp/result.json; then
        echo "OK"
       	break
      fi
      echo "WARNING: /app/dept does not contain 'deptno'. Retrying in 10 secs"
      sleep 10  
      x=$(( $x + 1 ))
    done
    if [ "$TF_VAR_ui_strategy" != "api" ]; then
      rm /tmp/cookie.txt
      curl $UI_URL/ -b /tmp/cookie.txt -c /tmp/cookie.txt -L --retry 5 --retry-max-time 20 -D /tmp/result_html.log > /tmp/result.html
    else 
      echo "OCI Starter" > /tmp/result.html
    fi  
    rm /tmp/cookie.txt
    curl $UI_URL/app/info -b /tmp/cookie.txt -c /tmp/cookie.txt -L --retry 5 --retry-max-time 20 -D /tmp/result_info.log > /tmp/result.info
  fi
  if [ "$TF_VAR_ui_strategy" != "api" ]; then
    echo - User Interface: $UI_URL/
  fi  
  for APP_DIR in `app_dir_list`; do
    if [ -f  $PROJECT_DIR/src/$APP_DIR/openapi_spec.yaml ]; then
            grep "^[[:space:]]*/.*:" $PROJECT_DIR/src/$APP_DIR/openapi_spec.yaml | sed "s#[[:space:]]*##" | sed "s/://" | sed  "s#^#- $UI_URL#"
    fi  
    # echo - Rest DB API     : $UI_URL/$APP_DIR/dept
    # echo - Rest Info API   : $UI_URL/$APP_DIR/info
  done
  if [ "$TF_VAR_deploy_strategy" == "compute" ] && [ "$TF_VAR_ui_strategy" == "api" ]; then   
    export APIGW_URL=https://${APIGW_HOSTNAME}/${TF_VAR_prefix}  
    echo - API Gateway URL : $APIGW_URL/app/dept 
  fi
  if [ "$TF_VAR_language" == "java" ] && [ "$TF_VAR_java_framework" == "springboot" ] && [ "$TF_VAR_ui_strategy" == "html" ] && [ "$TF_VAR_db_node_count" == "2" ]; then
    echo - RAC Page        : $UI_URL/rac.html
  fi
fi

if [ -f $PROJECT_DIR/src/after_done.sh ]; then
  $PROJECT_DIR/src/after_done.sh
fi
