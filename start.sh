echo "ejecutando webgoat"

cd WebGoat
mvn clean install
mvn -pl webgoat-server spring-boot:run &

echo "ejecutando dwva"
sudo docker run --rm -it -p 80:80 vulnerables/web-dvwa