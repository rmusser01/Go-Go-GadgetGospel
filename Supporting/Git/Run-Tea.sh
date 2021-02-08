#!/bin/bash
#

echo -en "Downloading and setting up Gitea Docker Image:\n\n"
sleep 1
git clone https://github.com/go-gitea/gitea
cd ./gitea/

echo -en "Building the dockerfile: 'docker build -t'\n"
sleep 1
docker build -t gitea:latest .

echo -en 'Executing the built Container with Persistence:\n'
sleep 1
docker run --name Git-Tea -p 11001:3000 -p 11002:22 -v gitea:/data -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro --env USER_UID=1000 --env USER_GID=1000 gitea:latest
