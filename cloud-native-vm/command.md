curl -k "https://www.ocistarter.com/app/zip?prefix=api-java&group_name=api&group_common=apigw,compute&deploy=compute&ui=api&language=java&database=none" --output api.zip
curl -k "https://www.ocistarter.com/app/zip?prefix=api-node&group_common=apigw,compute&deploy=compute&ui=api&language=node&database=none" --output api-node.zip
curl -k "https://www.ocistarter.com/app/zip?prefix=api-go&group_common=apigw,compute&deploy=compute&ui=api&language=go&database=none" --output api-go.zip
curl -k "https://www.ocistarter.com/app/zip?prefix=api-python&group_common=apigw,compute&deploy=compute&ui=api&language=python&database=none" --output api-python.zip
curl -k "https://www.ocistarter.com/app/zip?prefix=api-dotnet&group_common=apigw,compute&deploy=compute&ui=api&language=dotnet&database=none" --output api-dotnet.zip
unzip api.zip
unzip api-node.zip
unzip api-go.zip
unzip api-python.zip
unzip api-dotnet.zip
mv api/* .
rm *.zip

mv api-dotnet/src/app api-dotnet/src/app-dotnet
mv api-go/src/app api-go/src/app-go
mv api-java/src/app api-java/src/app-java
mv api-node/src/app api-node/src/app-node
mv api-python/src/app api-python/src/app-python

cat > api-dotnet/src/compute/nginx_app.locations <<'EOT' 
  location /app-java/ { 
    proxy_pass http://localhost:8080/; 
  } 
  location /app-go/ { 
    proxy_pass http://localhost:8081/; 
  } 
  location /app-dotnet/ { 
    proxy_pass http://localhost:8082/; 
  } 
  location /app-node/ { 
    proxy_pass http://localhost:8083/; 
  } 
  location /app-python/ { 
    proxy_pass http://localhost:8084/; 
  } 
EOT

rm api-go/src/compute/nginx_app.locations
rm api-java/src/compute/nginx_app.locations
rm api-node/src/compute/nginx_app.locations
rm api-python/src/compute/nginx_app.locations

sed -i -e 's/8080/8082/g' api-dotnet/src/app-dotnet/src/appsettings.json
sed -i -e 's/8080/8081/g' api-go/src/app-go/src/rest.go
sed -i -e 's/8080/8083/g' api-node/src/app-node/src/rest.js
sed -i -e 's/8080/8084/g' api-python/src/app-python/src/rest.py

sed -i -e 's#/app/#/app-java/#g' api-java/src/app-java/openapi_spec.yaml
sed -i -e 's#/app/#/app-dotnet/#g' api-dotnet/src/app-dotnet/openapi_spec.yaml
sed -i -e 's#/app/#/app-go/#g' api-go/src/app-go/openapi_spec.yaml
sed -i -e 's#/app/#/app-node/#g' api-node/src/app-node/openapi_spec.yaml
sed -i -e 's#/app/#/app-python/#g' api-python/src/app-python/openapi_spec.yaml
