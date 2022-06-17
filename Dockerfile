FROM fithwum/debian-base:bullseye
LABEL maintainer "fithwum"

# URL's for files
ARG INSTALL_SCRIPT=https://raw.githubusercontent.com/fithwum/docker-registry/master/files/Install_Script.sh

# Install main app and dependencies
RUN apt-get -y update && apt-get clean \
	&& apt-get install -y docker-registry \
	&& rm -rf /var/lib/apt/lists/* 

# Make directories and set permissions
RUN mkdir -p /docker-registry /docker-registry-temp
ADD "${INSTALL_SCRIPT}" /docker-registry-temp
RUN chmod 777 -R /docker-registry /docker-registry-temp \
	&& chown 99:100 -R /docker-registry /docker-registry-temp \
	&& chmod +x /docker-registry-temp/Install_Script.sh

# Directory where data is stored
VOLUME [ "/docker-registry", "/docker-registry-temp" ]

# Run command
CMD [ "/bin/bash", "./docker-registry-temp/Install_Script.sh" ]
