curl -k "https://www.ocistarter.com/app/zip?prefix=api-java&group_name=api&group_common=apigw&deploy=compute&ui=api&language=java&database=none" --output api.zip
curl -k "https://www.ocistarter.com/app/zip?prefix=api-node&group_common=apigw&deploy=compute&ui=api&language=node&database=none" --output api-node.zip
curl -k "https://www.ocistarter.com/app/zip?prefix=api-go&group_common=apigw&deploy=compute&ui=api&language=go&database=none" --output api-go.zip
curl -k "https://www.ocistarter.com/app/zip?prefix=api-python&group_common=apigw&deploy=compute&ui=api&language=python&database=none" --output api-python.zip
curl -k "https://www.ocistarter.com/app/zip?prefix=api-dotnet&group_common=apigw&deploy=compute&ui=api&language=dotnet&database=none" --output api-dotnet.zip
unzip api.zip
unzip api-node.zip
unzip api-go.zip
unzip api-python.zip
unzip api-dotnet.zip
mv api/* .
rm *.zip
rmdir api
