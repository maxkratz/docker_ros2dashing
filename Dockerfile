# Use ubuntu 18.04
FROM ubuntu:18.04
LABEL maintainer="Max Kratz <account@maxkratz.com>"
ENV DEBIAN_FRONTEND=noninteractive

# Update and install various packages
RUN apt-get update -q && \
    apt-get upgrade -yq && \
    apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata

# Create a user and give it sudo permissions
RUN useradd -m -d /home/ubuntu ubuntu -p $(perl -e 'print crypt("ubuntu", "salt"),"\n"') && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Use en utf8 locales
RUN locale-gen en_US.UTF-8

# Switch to 'ubuntu' user
USER ubuntu
WORKDIR /home/ubuntu
ENV HOME=/home/ubuntu
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# Increase inotify.max_user_watches (size)
RUN echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Run and install ros2:dashing stuff
RUN sudo apt install -y curl gnupg lsb-release
RUN curl -Ls https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
RUN sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN sudo apt update
RUN sudo apt install -y ros-dashing-desktop
RUN sudo apt install -y python3-argcomplete

# There was a version conflict with the package provided by apt so we install it via pip3
# RUN sudo apt intsall python3-colcon-common-extensions
# RUN pip3 install -U colcon-common-extensions # We install this later (after pip3 gets installed)

RUN sudo apt install -y python-rosdep python3-vcstool # https://index.ros.org/doc/ros2/Installation/Linux-Development-Setup/
RUN grep -F "source /opt/ros/dashing/setup.bash" ~/.bashrc || echo "source /opt/ros/dashing/setup.bash" >> ~/.bashrc
RUN grep -F ". /opt/ros/dashing/setup.bash" ~/.bashrc || echo ". /opt/ros/dashing/setup.bash" >> ~/.bashrc
RUN set +u

# Source ros dashing setup-file
RUN /bin/bash -c "source /opt/ros/dashing/setup.bash"
RUN echo "Success installing ROS2 dashing"

# Use WORKDIR instead of cd [...] && <command>
# Ref: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

# Install catkin library
RUN git clone https://github.com/ros/catkin.git
RUN sudo apt-get -y install cmake python-catkin-pkg python-empy python-nose python-setuptools libgtest-dev build-essential
WORKDIR /home/ubuntu/catkin
RUN mkdir -p build
RUN cmake -DCMAKE_BUILD_TYPE=Release .
RUN make
RUN sudo make install
WORKDIR /home/ubuntu
RUN /bin/bash -c ". /usr/local/setup.bash"
RUN /bin/bash -c ". .bashrc"
RUN grep -F "source /usr/local/setup.bash" ~/.bashrc || echo "source /usr/local/setup.bash" >> ~/.bashrc
RUN grep -F ". /usr/local/setup.bash" ~/.bashrc || echo ". /usr/local/setup.bash" >> ~/.bashrc

# Install yaml-cpp library
RUN git clone https://github.com/jbeder/yaml-cpp.git
WORKDIR /home/ubuntu/yaml-cpp
RUN mkdir -p build
RUN cmake DCMAKE_BUILD_TYPE=Release .
RUN sudo make install
WORKDIR /home/ubuntu
RUN /bin/bash -c ". /usr/local/setup.bash"
RUN /bin/bash -c ". .bashrc"
RUN grep -F "source /usr/local/setup.bash" ~/.bashrc || echo "source /usr/local/setup.bash" >> ~/.bashrc
RUN grep -F ". /usr/local/setup.bash" ~/.bashrc || echo ". /usr/local/setup.bash" >> ~/.bashrc

# Install doxygen, cpplint + python packages
RUN sudo apt-get install -y doxygen
RUN sudo apt-get install -y python3 python3-pip libboost-dev lcov
RUN sudo pip3 install colcon-lcov-result
RUN sudo apt-get -y install cmake python-catkin-pkg python-empy python-nose python-setuptools libgtest-dev build-essential
RUN sudo pip3 install cpplint

# Finish colcon-common-extensions
RUN pip3 install -U colcon-common-extensions

# Install googletest-suite (based on https://www.eriksmistad.no/getting-started-with-google-test-on-ubuntu/)
RUN sudo apt install libgtest-dev cmake
WORKDIR /usr/src/gtest
RUN sudo cmake CMakeLists.txt
RUN sudo make
RUN sudo cp *.a /usr/lib

# Install clang-format (https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
RUN sudo apt install clang-format

# Source again
RUN /bin/bash -c "source /opt/ros/dashing/setup.bash"

# Remove apt lists (for storage efficiency)
RUN sudo rm -rf /var/lib/apt/lists/*

CMD ["bash"]
