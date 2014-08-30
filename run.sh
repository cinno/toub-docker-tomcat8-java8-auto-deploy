#!/bin/bash

set -e

WAR_BASENAME=ROOT

WAR_FILE=/docker/deploy/$WAR_BASENAME.war

TOMCAT_DEPLOYMENT_DIR=/opt/tomcat/webapps

if [[ -f $WAR_FILE ]]; then
    
    if [[ -d $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME ]]; then
		echo "Removing previous deployment dir $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME ..."
		rm -rf $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME
    fi
    
    if [[ -f $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME.war ]]; then
		echo "Removing previous deployment war $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME.war ..."
		rm $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME.war
    fi
    
    echo "Deploying war file $WAR_FILE to $TOMCAT_DEPLOYMENT_DIR ..."
    mv $WAR_FILE $TOMCAT_DEPLOYMENT_DIR
else
    echo "No war to deploy"
fi

KEYGEN=/usr/bin/ssh-keygen
KEYFILE=/root/.ssh/id_rsa

if [ ! -f $KEYFILE ]; then
	echo "Generating RSA keys"
	$KEYGEN -q -t rsa -N "" -f $KEYFILE
fi

echo "RSA public key"
cat $KEYFILE.pub

echo "Starting SSH server"
/etc/init.d/ssh start 

export MYSQL_ADDR=$MYSQL_PORT_3306_TCP_ADDR

export MYSQL_PORT=$MYSQL_PORT_3306_TCP_PORT

echo "Starting Tomcat"
service tomcat start

tail -50f /opt/tomcat/logs/catalina.out
