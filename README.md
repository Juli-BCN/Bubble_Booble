# Docker App for Bubble_Booble

Bubble Bobble Arcade Game on Docker with DosBox (2021)

## Install Docker on Amazon Linux 2
> sudo yum update -y

> sudo amazon-linux-extras install -y docker

> sudo service docker start

> sudo usermod -a -G docker ec2-user

> sudo systemctl enable docker

> docker info


## Download the code and Build the container
> sudo yum install -y git

> git clone https://github.com/Juli-BCN/Bubble_Booble.git

> cd Bubble_Booble

> docker build -t mybubble .

> docker images


## Run, Test & Stop the Docker container
> docker run -d -p 80:80 mybubble

> curl -L http://localhost/vnc.html

* Passwd: C0nn3ct!

> docker ps

> :eyeglasses: docker stop *CONTAINER_ID*


## Tag & Upload Container to DockerHub
Reference:
> :eyeglasses: docker image tag *SOURCE_IMAGE:SOURCE_TAG* *TARGET_IMAGE:TARGET_TAG*

> :eyeglasses: docker push *TARGET_IMAGE:TARGET_TAG*


Like:
> docker image tag mybubble:latest julibcn/bubbob:latest

> docker login

> docker push julibcn/bubbob:latest
