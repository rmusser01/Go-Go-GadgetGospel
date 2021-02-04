FROM jenkins/jenkins:lts
#
# ---- Install via APT ----
USER root
RUN apt-get update && apt-get install -y ruby make #nuget mono-devel mono-xbuild
USER jenkins
# 
# ---- Establish Volumes ----
#
VOLUME /var/jenkins_home
#
# ---- Setup Jenkins ----
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY casc.yaml /var/jenkins_home/casc.yaml
#
# ----Further Customize Jenkins through custom groovy scripts:----
# COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
#
# ------------------Install Extra Software & Tools------------------
#
# ----Env Setup----
# RUN mkdir /Tools
# CHMOD 777 /Tools
# 
# ----.NET Stuff----
# Install .NET Supporting tooling - Make sure you also setup the .NET framework & MSBuild apps/extensions in Jenkins.
USER root
RUN apt-get install -y nuget mono-devel mono-xbuild
USER jenkins
#
#

