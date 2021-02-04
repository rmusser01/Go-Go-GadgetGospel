#!/bin/bash
#

echo -en "Run one of these commands unless you know what you want to do:\n\n"
echo -en "Build the dockerfile:\n"
echo -en 'docker build -t jenkins:builder-1 . \n\n' 
echo -en 'Execute the Container with No Persistence:\n'
echo -en 'docker run --name jenkins-builder-1 --rm -p 8080:8080 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:jcasc\n\n'
echo -en 'Jenkins Persistence using Docker Volumes:\n'
echo -en 'docker run --name jenkins-builder-1 --rm -p 8080:8080 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:jcasc\n\n'
