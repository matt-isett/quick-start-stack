echo "Loading $2 watch..."
curl -s -o /dev/null -X DELETE $1/_xpack/watcher/watch/$2 -u elastic:changeme
es_response=$(curl --w "%{http_code}" -s -o /dev/null -X PUT $1/_xpack/watcher/watch/$2 -u elastic:changeme -d @$3/$2.json -H "Expect:")
if [ 0 -eq $? ] && [ $es_response = "201" ]; then
echo "Successfully loaded watch $2"
else
echo "Unable to load watch $2"
fi
