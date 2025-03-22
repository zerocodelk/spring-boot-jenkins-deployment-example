
#remove volumes data jenkins
docker volume rm $(docker volume ls -q | grep jenkins)


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



# Check the logs to get the initial admin password:
docker logs jenkins


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