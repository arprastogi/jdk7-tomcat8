#!/bin/bash

if [ ! -f ${CATALINA_HOME}/scripts/.tomcat_admin_created ]; then
	${CATALINA_HOME}/scripts/create_admin_user.sh
fi
		
exec ${CATALINA_HOME}/bin/catalina.sh run
