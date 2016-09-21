#!/bin/bash
>&2 echo "-------------------Loading Initial Data-------------------"

set -e

>&2 echo "DEBUG: curl elastic at http://$USER:$PASS@$HOST:9200"

until $(curl --output /dev/null --silent --head --fail http://$USER:$PASS@$HOST:9200); do
    >&2 echo '.'
    sleep 5
done

>&2 echo "elasticsearch is up - executing command"

>&2 echo "-------------------Loading Dashboard Data-------------------"
sh /tmp/scripts/import_dashboards.sh -url http://$USER:$PASS@$HOST:9200 -d kibana

>&2 echo "-------------------Loading Initial Data-------------------"
sh /tmp/scripts/import_kibana_data.sh http://$USER:$PASS@$HOST:9200 /tmp/scripts

>&2 echo "-------------------Loading Watch Data-------------------"
sh /tmp/scripts/import_watch_data.sh http://$USER:$PASS@$HOST:9200 cpu_watch /tmp/scripts

