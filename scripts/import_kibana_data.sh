es_response=$(curl -s --w "%{http_code}" -o /dev/null -X POST $1/_bulk -u elastic:changeme --data-binary "@$2/kibana.json" -H "Expect:")
if [ 0 -eq $? ] && [ $es_response = "200" ]; then
echo "------------ Loaded default indexes...OK"
fi

es_resp_user=$(curl -s --w "%{http_code}" -o /dev/null -X POST $1/_xpack/security/user/donottrust -u elastic:changeme --data-binary "@$2/add_user.json" "Expect:")
if [ 0 -eq $? ] && [ $es_resp_user = "200" ]; then
echo "------------ Added User...OK"
fi

es_resp_role=$(curl -s --w "%{http_code}" -o /dev/null -X POST $1/_xpack/security/role/limit -u elastic:changeme --data-binary "@$2/add_role.json" "Expect:")
if [ 0 -eq $? ] && [ $es_resp_role = "200" ]; then
echo "------------ Added Limit Role...OK"
fi

es_resp_kb_role=$(curl -s --w "%{http_code}" -o /dev/null -X POST $1/_xpack/security/role/limit -u elastic:changeme --data-binary "@$2/add_kb_role.json" "Expect:")
if [ 0 -eq $? ] && [ $es_resp_kb_role = "200" ]; then
echo "------------ Added Kibana UI Role...OK"
fi
