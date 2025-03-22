#build the docker image

docker build -t jenkins-with-docker2 .

#run this command with your host (docker host) machine (hone inside the container)
sudo chmod 666 /var/run/docker.sock


#Run the custom Jenkins image with Docker socket mounted:

docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --restart unless-stopped \
  jenkins-with-docker2



# Check the logs to get the initial admin password:

docker logs jenkins


# install the following plugins as your requirements

Essential Plugins

Git - For source code management
Pipeline - For creating pipeline jobs
Docker - For Docker integration
Docker Commons - Shared functionality for Docker-related plugins

Build and Deployment

Maven Integration - For Maven integration
Gradle (optional) - If you also use Gradle builds
Config File Provider - For managing configuration files like Maven settings
Credentials Binding - For secure credential handling
SSH Agent - For SSH connections

Testing and Quality

JUnit - For test result publishing
JaCoCo - For code coverage reports
SonarQube Scanner - For SonarQube integration
Warnings Next Generation - For displaying compiler warnings
HTML Publisher - For publishing HTML reports

Utilities

Timestamper - For adding timestamps to console output
AnsiColor - For colored console output
Build Timeout - For setting timeouts on builds
Workspace Cleanup - For cleaning up workspaces

Docker-specific

Docker Pipeline (if available) or Docker Workflow - For Docker operations in Pipeline
Docker Compose Build Step - For Docker Compose operations

UI Improvements (Optional)

Blue Ocean - Modern UI for Jenkins
Dashboard View - For customizable dashboard views
Build Monitor View - For large displays showing build status

