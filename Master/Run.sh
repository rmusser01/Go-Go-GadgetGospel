#!/bin/bash
#
# Original URLs
# 	https://github.com/rmusser01/docker-jenkins
# 	https://www.digitalocean.com/community/tutorials/how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code

echo -en "Run these commands unless you know what you want to do:\n\n"
echo -en "Build the dockerfile:\n"
echo -en 'docker build -t jenkins:Master -f ./J-LTS.Dockerfile .\n\n' 
echo -en 'Execute the Container with No Persistence:\n'
echo -en 'docker run --name Jenkins-Master-1-NP --rm -p 8080:8080 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:Master\n\n'
echo -en 'Jenkins Persistence using Docker Volumes:\n'
echo -en 'docker run --name Jenkins-Master-1-P -p 8080:8080 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:master-1\n\n'
echo -en 'Run the container saving to raw disk\n'
echo -en '"docker run -u <username_to_run_container_as> --name Jenkins-Master-1-R -p 8080:8080 -v /home/<USERNAME_HERE>:/var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:master-1"\n\n'
echo -en 'Increase the amount of RAM available to the JVM:\n --env JAVA_OPTS="-Xmx4096m"'
#sleep 30
exit

# Define globals
export JENKINS_KEYSTORE_FILE=jenkins_keystore.jks
export JENKINS_KEYSTORE_PASS_FILE=jenkins_keystore.jks.password

echo -en "This script is meant to be ran on Linux.\nIt requires gpg, keytool, openssl, and obviously Docker\n\nWe're now going to wait a few seconds to flip some bits.\n\n"
sleep 5



# Create password to be used for SSL cert gen
#psswrd=`gpg --quiet --gen-random --armor 0 24 |& tail -1`

psswrd='failboats'
echo $psswrd | tee $JENKINS_KEYSTORE_PASS_FILE

psswrd=`cat ${JENKINS_KEYSTORE_PASS_FILE}`

# Create > certificate + key
openssl req -x509 -days 365 -passout pass:"$psswrd" -newkey rsa:4096 -subj "/CN=Jenkins Self Signed" -keyout jenkins_selfsigned.key -out jenkins_selfsigned.crt

# Convert tp pkcs12 which can be imported as keystore file
openssl pkcs12 -export -in jenkins_selfsigned.crt -inkey jenkins_selfsigned.key -passin pass:"$psswrd" -out jenkins_selfsigned.p12 -passout pass:"$psswrd"

# Import to jenkins keystore
keytool -importkeystore -srckeystore jenkins_selfsigned.p12 -srcstoretype PKCS12 -srcstorepass "$psswrd" -deststoretype PKCS12 -destkeystore $JENKINS_KEYSTORE_FILE -deststorepass "$storepsswrd"



# Deliver message - Eventually put at end of script
echo -en "Starting Gospel Delivery System.\nPlease wait to commit any heresy until process is complete: \n\n"
sleep 5
# Define User/Pass
export JENKINS_INITIAL_ADMIN_NAME=admin
psswrd='ilikecake'
#psswrd=`gpg --quiet --gen-random --armor 0 24 |& tail -1`

echo -e '\n\nusername is ...?'
sleep 2
echo -e '....oh yea: admin'
echo -e '\n\npassword is ...?'
sleep 2
echo -e '.....oh yea:' $psswrd '\n\n'
sleep 2

keystore_pass=storepsswrd
rm -f $JENKINS_KEYSTORE_FILE


# Keep this directory for persistence
volume_base=`dirname $(pwd)`/run/jenkins_home



#
# Locally Hosted Version
#
# docker build -t jenkins:jcasc .
# docker run --name jenkins --rm -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:jcasc



#
# Fancy Version with Certs
docker build -t jenkins:Master -f ./J-LTS.Dockerfile .
docker run --name GDS --rm  -p 443:8443 -v $volume_base:/var/jenkins_home --env JENKINS_ADMIN_ID=$JENKINS_INITIAL_ADMIN_NAME --env JENKINS_ADMIN_PASSWORD="$psswrd" jenkins:jcasc --httpPort=-1 --httpsPort=8443 --httpsKeyStore=/usr/share/jenkins/ref/jenkins_keystore.jks --httpsKeyStorePassword="$keystore_pass"


# Extra Space
#
#
#
