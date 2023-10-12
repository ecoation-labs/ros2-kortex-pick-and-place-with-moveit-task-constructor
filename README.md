# ros2-kortex-pick-and-place-with-moveit-task-constructor

## Prerequisits 

- Ubutun 22.04 x86_64
- Docker, docker-compose

Before running docker-compose up on Ubuntu 22.04, you'll need to ensure that both docker and docker-compose are installed.

- https://docs.docker.com/engine/install/ubuntu/

Try the convience script:

```bash
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
```

## Add xhost permissions so that you can use a GUI from within the container

```bash
xhost +local:docker
```

## Run docker container

```bash
docker compose up
```

## Start a bash terminal inside the container

```bash
docker exec -it ros2-kortex-pick-and-place-with-moveit-task-constructor bash
```

## Run the moveit demo

This will let you test planning motions in RViz.

```bash
ros2 launch kinova_gen3_6dof_robotiq_2f_85_description_moveit_config demo.launch.py
```

## Run the moveit task constructor demo (not working)

This demo is based on 
- https://moveit.picknik.ai/main/doc/tutorials/pick_and_place_with_moveit_task_constructor/pick_and_place_with_moveit_task_constructor.html
- https://github.com/ros-planning/moveit2_tutorials/tree/humble/doc/tutorials/pick_and_place_with_moveit_task_constructor

```bash

```