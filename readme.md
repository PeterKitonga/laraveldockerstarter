## About Setup

### Brief
This setup builds on the knowledge learned in [this course](https://www.udemy.com/course/docker-kubernetes-the-practical-guide) to setup a laravel application using docker compose. The setup uses 'Utility' containers to run certain services that perform actions like running composer commands, artisan commands and even running php for the local server.

### Running setup

Before doing anything first copy the example mysql env into a new file named ```mysql.env``` like so ```cp env/mysql.env.example env/mysql.env```. Also copy the example laravel env into a file named ```.env``` like so ```cp src/.env.example src/.env```. Modify the mysql credentials/configs and other desired configs in the created env files. Thereafter, run ```docker-compose up -d --build server``` to run the application. The ```--build``` flag ensures that the images are always upto date in the case where the dockerfiles have been modified. For other setup commands check below.

### Running composer commands

Run desired composer command e.g. ```docker-compose run --rm composer install```

### Running artisan commands

You can run all artisan command using the artisan utility container like so: ```docker-compose run --rm artisan migrate```

### Destroying setup containers, networks and volumes

To stop all running services run ```docker-compose down```. This will stop all running containers of this setup and remove the network created by composer. Although not adviced, you can remove the volumes as well if you include the ```-v``` flag like so: ```docker-compose down -v```

### Creating laravel project using the composer 'utility' container

This setup uses utility containers for composer to run composer commands. For example if you desire to create a laravel app in this setup you first need to remove the contents of the ```src/``` folder and run ```docker-compose run --rm composer create-project --prefer-dist laravel/laravel:^7.0 .```

### Executing commands in a 'utility' container

One way to run commands in a utility container is to start it in attached mode with the ```-it``` flag. For example ```docker run -it node:14```. This will create the container and possible pull the node image if it doesn't exist before creating the container. Here we will get a shell in which we can interract with the container. The other way to run commands in this container would be to start it in detached mode like so: ```docker run -it -d node:14```. After that we can run the ```exec``` command and pass the name of the container. We can also add the ```-it``` flag together with this to keep the shell in interactive mode. e.g. ```docker exec -it youthful_wright node -v```(```docker exec -it [container name/id] [command to execute]```).

### Creating a 'utility' container

We can create utility containers by first creating an image using a docker file. With this in place we can build it as normal application containers .e.g. ```docker build -t nodeutil:latest .``` Now we can run a container based of the image and even append commands to execute immediately after the container is created .e.g. ```docker run -it --rm -v $(pwd):/var/opt/app nodeutil npm init``` This creates a bind mount with our project folder to be able to run commands in the container to apply changes to our project folder. In the example, we create a ```package.json``` file to initialize our nodejs project.

### Utilizing ENTRYPOINT

We use the ENTRYPOINT layer in a dockerfile(like in ```dockerfiles/composer.dockerfile```) to prepend a command that will be concatenated with whatever command we pass after the image name .e.g. ```docker run -it --rm -v $(pwd):/var/opt/app nodeutil init``` In this example we don't need to pass ```npm``` since it is already added in the ENTRYPOINT layer of our dockerfile.

### Using docker compose to run utility containers

When using docker compose, we first need to define our docker compose yaml file. Once setup, we can target a specific service which we will have defined as our utility container. We do this using the ```run``` command for docker compose .e.g. ```docker-compose run --rm npm init```(```docker-compose run --rm [service name] [executable command]```) The ```--rm``` flag here just makes sure the container is removed automatically once the command is executed.

### Online Course
Visit [Udemy](https://www.udemy.com/course/docker-kubernetes-the-practical-guide) for the course