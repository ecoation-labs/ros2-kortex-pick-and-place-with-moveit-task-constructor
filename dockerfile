FROM osrf/ros:humble-desktop-full

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --yes \
    git \
    build-essential \
    cmake \
    wget \
    python3 \
    python3-pip \
    python3-colcon-common-extensions \
    python3-vcstool \
    python3-rosdep \
    bash-completion \
    apt-utils \
    ros-$ROS_DISTRO-rviz2 \
    ros-$ROS_DISTRO-rviz-common \
    ros-$ROS_DISTRO-rviz-rendering \
    ros-$ROS_DISTRO-rviz-default-plugins \
    ros-$ROS_DISTRO-rviz-ogre-vendor \
    ros-$ROS_DISTRO-rviz-visual-tools \
    ros-$ROS_DISTRO-moveit \
    ros-$ROS_DISTRO-moveit-servo \
    ros-$ROS_DISTRO-moveit-ros-perception \
    ros-$ROS_DISTRO-moveit-ros-control-interface \
    ros-$ROS_DISTRO-moveit-visual-tools \
    ros-$ROS_DISTRO-moveit-resources \
    ros-$ROS_DISTRO-cv-bridge \
    ros-$ROS_DISTRO-kortex-bringup \
    ros-$ROS_DISTRO-kinova-gen3-6dof-robotiq-2f-85-moveit-config \
    ros-$ROS_DISTRO-rmw-cyclonedds-cpp \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# add bash autocompletion
RUN echo 'source /usr/share/bash-completion/bash_completion' >> ~/.bashrc

# add apt autocompletion
RUN echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean && \
    echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean

# ignore setuptools deprecation warnings when building with colcon
ENV PYTHONWARNINGS="ignore:setup.py install is deprecated::setuptools.command.install"
ENV PYTHONWARNINGS="ignore:::setuptools.command.install,ignore:::setuptools.command.easy_install,ignore:::pkg_resources"

# create workspace
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws

# install extra packages from github
RUN cd /ros2_ws/src \
    && git clone -b humble --single-branch https://github.com/ros-planning/moveit_task_constructor.git

# copy ROS packages into container
# COPY mtc_kinova_demo /ros2_ws/src/mtc_kinova_demo
# COPY kinova_gen3_6dof_robotiq_2f_85_description /ros2_ws/src/kinova_gen3_6dof_robotiq_2f_85_description
# COPY kinova_gen3_6dof_robotiq_2f_85_description_moveit_config /ros2_ws/src/kinova_gen3_6dof_robotiq_2f_85_description_moveit_config

RUN source /opt/ros/$ROS_DISTRO/setup.bash && colcon build --symlink-install

# add sourcing ros2_ws to entrypoint
RUN sed --in-place --expression \
    '$isource "/ros2_ws/install/setup.bash"' \
    /ros_entrypoint.sh

# add packages to path
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc