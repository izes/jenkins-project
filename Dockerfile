FROM jenkins/jenkins:2.426.3-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release python3-pip
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
ENV JENKINS_UC_DOWNLOAD=https://updates.jenkins.io/download
ENV JENKINS_UC=https://updates.jenkins.io
RUN jenkins-plugin-cli --version
# Install plugins
RUN jenkins-plugin-cli --plugin-download-directory /var/jenkins_home/plugins --plugins "blueocean docker-workflow"
