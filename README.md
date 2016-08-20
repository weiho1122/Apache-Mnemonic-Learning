# This is topics to learn Apache-Mnemonic
* Item 1 build spark from source
* Item 2 docker build spark from source (clear cache/generic file location/behind proxy)
* Item 3 build and verify Apache Mnemonic, submit clean image to docker hub
  * Item 3a build from Dockerfile (see repo)
  * Item 3b build "docker build -t imagename ."
  * Item 3c. tag container "docker tag imageID accountname/imagename:latest"
  * Item 3d. push to dockerhub: "docker login --username=sername --email=youremail" "docker push accountname/imagename"
