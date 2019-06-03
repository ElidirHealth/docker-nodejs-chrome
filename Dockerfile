FROM openjdk:8u121-jdk

RUN apt-get update; \
    curl -sL https://deb.nodesource.com/setup_9.x | bash -; \
    curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - ; \
    sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list';  \
    apt-get update && apt-get install -y google-chrome-stable nodejs build-essential tzdata gnupg2; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; 

RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s
RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && rvm install 2.3.3 && rvm --default use 2.3.3"

#RUN apk add --no-cache tzdata
RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime
ENV TZ=Europe/London
     
# other useful things for testing
RUN npm install -g grunt bower
RUN  /bin/bash -l -c ". /etc/profile.d/rvm.sh && gem install sass"

ADD entrypoint.sh /entrypoint.sh

# bower cannot run as root user
RUN useradd -ms /bin/bash test
USER test

ENV DISPLAY :99.0
ENV CHROME_BIN /usr/bin/google-chrome
ENV PATH "/usr/bin:${PATH}"

ENTRYPOINT ["/entrypoint.sh"]
