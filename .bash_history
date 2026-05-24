sudo apt update
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc   https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]"   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins
sudo systemctl status
sudo systemctl status jenkins.service
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
sudo apt install openjdk-17-jdk -y
sudo systemctl status jenkins.service
java -version
sudo systemctl restart jenkins
sudo systemctl status jenkins.service
sudo journalctl -xeu jenkins.service
sudo systemctl restart jenkins
sudo systemctl status jenkins
sudo cat /var/log/jenkins/jenkins.log
sudo journalctl -u jenkins --no-pager -n 50
sudo apt update
sudo apt install openjdk-21-jdk -y
sudo systemctl status jenkins
sudo systemctl status jenkins.service
java --v
java -v
java -version
sudo systemctl restart jenkins
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
ls
mkdir petclinic
cd petclinic/
vi pom.xml
mkdir src/main/java/com/example/petclinic/
mkdir -p src/main/java/com/example/petclinic
ls
cd src/
cd main/
cd java/
cd com/
cd example/
cd petclinic/
ls
mkdir PetclinicApplication.java
vi PetclinicApplication.java/
ls
cdp
cd petclinic/
ls
cd src/
ls
cd main/
ls
cd java/
ls
cd com/
ls
cd example/
ls
cd petclinic/
ls
rm PetclinicApplication.java/
rm -rf PetclinicApplication.java/
ls
vi PetclinicApplication.java
mkdir controller
cd controller/
vi OwnerController.java
cd ..
mkdir service
cd service/
vi OwnerService.java
cd ..
mkdir repository
cd repository/
vi OwnerRepository.java
cd ..
mkdir model
cd model/
vi Owner.java
cd
cd petclinic/
cd src/
cd main/
mkdir resources
cd resources/
vi application.properties
mkdir templates
cd templates/
vi add-owner.html
vi owners.html
cd ..
mkdir static
cd static/
mkdir css
cd css/
vi style.css
cd ..
mkdir js
cd js/
vi app.js
cd
cd petclinic/
mvn spring-boot:run
sudo apt install maven -y
mvn spring-boot:run
sudo lsof -i :8080
sudo kill -9 2345
sudo kill -9 5385
mvn spring-boot:run
echo "server.port=9090" >> src/main/resources/application.properties
cat src/main/resources/application.properties
mvn spring-boot:run
