#!/bin/bash

WAR_BASENAME=ROOT

WAR_FILE=/docker/deploy/$WAR_BASENAME.war

TOMCAT_DEPLOYMENT_DIR=/opt/tomcat/webapps

if [[ -f $WAR_FILE ]]; then
    
    if [[ -d $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME ]]; then
		echo "=> Removing previous deployment dir $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME ..."
		rm -rf $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME
    fi
    
    if [[ -f $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME.war ]]; then
		echo "=> Removing previous deployment war $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME.war ..."
		rm $TOMCAT_DEPLOYMENT_DIR/$WAR_BASENAME.war
    fi
    
    echo "=> Deploying war file $WAR_FILE to $TOMCAT_DEPLOYMENT_DIR ..."
    cp $WAR_FILE $TOMCAT_DEPLOYMENT_DIR
else
    echo "=> No war to deploy"
fi

echo "=> Starting Tomcat"
service tomcat start

tail -50f /opt/tomcat/logs/catalina.out
