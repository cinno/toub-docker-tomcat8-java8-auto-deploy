# Java8 / Tomcat8 Dockerfile with automated WAR deployment
===========

## Usage
        
Clone project & build image
    git clone https://github.com/Toub/toub-docker-tomcat8-java8-auto-deploy /opt/docker/build/toub-docker-tomcat8-java8-auto-deploy
    cd /opt/docker/build/toub-docker-tomcat8-java8-auto-deploy/   
    sudo docker build --tag="toub/tomcat8" .
    
Create volumes directories:

    # create volumes directories
    sudo mkdir -p /opt/my-app/deploy
    sudo mkdir -p /opt/my-app/logs

Copier le war à déployer :

    cp my-app.war /opt/my-app/deploy/ROOT.war

Création et démarrage du container
    
    # create and start a new container named "aireconsim-prod" from image
    sudo docker run --name=my-app -d --link mysql:mysql \
        -p 80:8080 \
        -v /opt/my-app/deploy/deploy/:/docker/deploy \
        -v /opt/my-app/logs:/opt/tomcat/logs \
        toub/tomcat8

Check the logs :

	docker logs -f my-app

or:

	tail -100f /opt/my-app/logs/catalina.out

Your app is now available by going to http://localhost:80


## Author

  * Nicolas Toublanc (n.toublanc@gmail.com)
  
Based on https://github.com/komu/dockerfiles

## LICENSE

* The MIT License (MIT) *

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
