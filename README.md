The project is dockerising my son's personal website that I created some time ago which was hosted on a S3 bucket.

The git repository is part of a CI/CD Jenkins project, running the app on a docker container using apache2. The container image is build and pushed to the Docker public repository from where it is pulled and run in an AWS instance. The container exposes port 80 on the docker agent running the container.

Any committed changes to the code will trigger a GitHub hook and will pull the code automatically in Jenkins to integrate the changes into a new image and deploy the new version to production.

GitHub: https://github.com/mmark0v/markov-app

DockerHub: https://hub.docker.com/repository/docker/mmark0v/markov-app

Product: https://martin-markov.com

This web app is a single page personal website using frontend template from "iPortfolio Designed by BootstrapMade". This website was created to present Martin Markov's experience and achievements.
