# The Quick Start Stack!  Metricbeat - Elasticsearch - Kibana
	This is a docker-compose based deployment for the three products for the 5.0 release.  
	There are some cool features like Metricbeat product, kibana dashboards, security, 
	and watches that a user can experiment with.

# Git Submodules
This project uses submodules; use **git clone --recursive**
		
# Usage

	make initial-run
		Wait for about one minute, looking for a log like: quickstartstack_dashboard_1 exited with code 0
		Then Ctrl-C to stop in the terminal, or docker-compose stop
	make quick-start-stack

	Log into Kibana at Docker default IP:9200 with elastic and changeme
