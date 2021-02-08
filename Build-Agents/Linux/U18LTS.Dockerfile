# Dockerfile for creating a Jenkins Build Agent.
# Not configured for anything particular.
# Does require the following files:
#
#
# ----Import base image----
FROM ubuntu:18.04
#
#
# ----Update Repos----
RUN apt update -y
RUN apt install git -y
#
#
# ----Setup SSH Server----
RUN apt-get install -y openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd
#
#
# ----Install JDK----
RUN apt-get install -qy openjdk-8-jdk
#----
#
#
# ----Install maven----
#RUN apt-get install -qy maven
#----
#
#
# ----Cleanup old packages----
RUN apt-get -qy autoremove
#
#
# ----Setup 'jenkins' User----
RUN adduser --quiet jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2
#
#
# ----Change 'root' User----
RUN echo root:password123 |chpasswd
#
#
# ----Copy SSH Authorized Keys----
#COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys
#
#
# ----Expose SSH Port----
#EXPOSE 22
#
#
# ----Start the SSHD Server----
CMD ["/usr/sbin/sshd", "-D"]