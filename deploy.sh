CONTAINER_NAME=$1
NEW_VERSION=$2

cat keyfile.json | docker login -u _json_key --password-stdin https://gcr.io

if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME) || $(docker ps -aq -f status=running -f name=$CONTAINER_NAME)" ]; then
        # cleanup
        echo "Stopping existing running container"
        docker stop $CONTAINER_NAME


        docker rm $CONTAINER_NAME
        echo "Delted the old container"
    fi
    # run your container
    echo "Deploying new Docker image"
    docker run -d -p 80:80 --name $CONTAINER_NAME gcr.io/closetpro/demo/dotnetapp:$NEW_VERSION
else 
        echo "No previous images are running"
        echo "Deploying new Docker image"
        docker run -d -p 80:80 --name $CONTAINER_NAME gcr.io/closetpro/demo/dotnetapp:$NEW_VERSION

fi