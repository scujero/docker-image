#!/bin/sh
#
# Login into DockerHub
#
docker login -u $DOCKER_NAME -p $DOCKER_PASSWORD
#
# it get all not hidden directory
#
for directory in $(find . -maxdepth 1 -mindepth 1 -type d -regex '\./[^\.].*'); do
  #
  # Detect if I have made some changes in this directory in the last commit
  #
	if printf '%s\n' "$(git log -1 --pretty="" --name-only)" | grep -Fqe "$(basename "${directory}")"; then
	  #
    # Go into that directory
    #
    cd $(basename "${directory}")
      #
      # Build and push the new docker image
      #
  		export REPO=$DOCKER_NAME/$(basename "${directory}")
  		export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`
  		docker build -f Dockerfile -t $REPO:$COMMIT .
  		docker tag $REPO:$COMMIT $REPO:$TAG
  		docker tag $REPO:$COMMIT $REPO:travis-$TRAVIS_BUILD_NUMBER
  		docker push $REPO

      echo "pushed: " + $REPO
    #
    # Return to the root
    #
		cd ..
	fi
done