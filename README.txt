
#remove volumes data jenkins
docker volume rm $(docker volume ls -q | grep jenkins)

# run the docker container as root
docker run -d --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  --user root \
  jenkins/jenkins:jdk17

# Check the logs to get the initial admin password:
docker logs jenkins

# then installed the required plugins (manually)
junit, coverage, git, maven


#login to the container as root
docker exec -it --user root jenkins /bin/bash


# install maven
apt-get update && apt-get install -y maven


#install docker
apt-get update && \
    apt-get install -y apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release


curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null


apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

#installing the docker compose

curl -L "https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version


docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/usr/bin/docker \
  -v /usr/lib/jvm:/usr/lib/jvm \
  -v /usr/share/maven:/usr/share/maven \
  -v /usr/bin/mvn:/usr/bin/mvn \
  jenkins/jenkins:jdk17

docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(which docker):/usr/bin/docker \
  -v /usr/lib/jvm:/usr/lib/jvm \
  -v /usr/share/maven:/usr/share/maven \
  -v /etc/maven:/etc/maven \
  -v /usr/bin/mvn:/usr/bin/mvn \
  -e MAVEN_HOME=/usr/share/maven \
  -e M2_HOME=/usr/share/maven \
  -e PATH="/usr/share/maven/bin:${PATH}" \
  jenkins/jenkins:jdk17






Following plugins should be installed

* Maven
* Git
* Docker Pipeline
* Docker
* Docker Compose


# Configure Jenkins to Use Host's Java and Maven

# Configure JDK in Jenkins:

  Go to "Manage Jenkins" > "Global Tool Configuration"
  Under JDK section, click "Add JDK"
  Uncheck "Install automatically"
  Name it (e.g., "HostJDK")
  Set JAVA_HOME to match your host's Java path (e.g., /usr/lib/jvm/java-11-openjdk-amd64)


 # Configure Maven in Jenkins:

  In the same screen, scroll to Maven section
  Click "Add Maven"
  Uncheck "Install automatically"
  Name it (e.g., "HostMaven")
  Set MAVEN_HOME to match your host's Maven path (e.g., /usr/share/maven)
  Save the configuration