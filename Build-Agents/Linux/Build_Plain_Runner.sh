#!/bin/bash
#

echo -en "Run one of these commands unless you know what you want to do:\n\n"
echo -en "Build the dockerfile:\n"
echo -en 'docker build -t jenkins:U18LTS -f ./U18LTS.Dockerfile .\n\n' 
echo -en 'Execute the Container with No Persistence:\n'
echo -en 'docker run --name jenkins-Slave-1 --rm -p 8081:8080 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:U18LTS\n\n'
echo -en 'Jenkins Persistence using Docker Volumes:\n'
echo -en 'docker run --name jenkins-Slave-1 -p 8081:8080 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:U18LTS\n\n'
