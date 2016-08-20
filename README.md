# This is topics to learn Apache-Mnemonic
1.  build spark from source
2.  docker build spark from source (clear cache/generic file location/behind proxy)
3.  build and verify Apache Mnemonic, submit clean image to docker hub
  *  build from Dockerfile (see repo)
  *  build "docker build -t imagename ."
  *  tag container "docker tag imageID accountname/imagename:latest"
  *  push to dockerhub: "docker login --username=sername --email=youremail" "docker push accountname/imagename"
