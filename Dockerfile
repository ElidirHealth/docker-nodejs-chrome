FROM openjdk:8u121-jdk

RUN apt-get update; \
    curl -sL https://deb.nodesource.com/setup_9.x | bash -; \
    curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - ; \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list';  \
    apt-get update && apt-get install -y google-chrome-stable nodejs build-essential tzdata ruby ruby-dev rubygems; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; 

#RUN apk add --no-cache tzdata
RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime
ENV TZ=Europe/London
     
# other useful things for testing
RUN npm install -g grunt bower
RUN gem install sass

ADD entrypoint.sh /entrypoint.sh

# bower cannot run as root user
RUN useradd -ms /bin/bash test
USER test

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/google-chrome
ENV PATH "/usr/bin:${PATH}"

ENTRYPOINT ["/entrypoint.sh"]
