
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
junit, coverage, git, maven, pipeline
(After selecting all the required plugins click on install)

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

# Now create a Jenkins Build (Pipeline)

 New Item -> Give a Name -> Pipeline ->  Pipeline Script (Copy the Content of the Jenkins file stored in the root of the project)

 # Build Now
