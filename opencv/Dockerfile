# Use ros2dashing:latest as base
FROM maxkratz/ros2dashing:latest
LABEL maintainer="Max Kratz <account@maxkratz.com>"
ENV DEBIAN_FRONTEND=noninteractive

# Install related packages for Intel RealSense (based on https://github.com/intel/ros2_intel_realsense)
RUN apt-get update
RUN apt-get install -y ros-dashing-cv-bridge ros-dashing-librealsense2 ros-dashing-message-filters ros-dashing-image-transport
RUN apt-get install -y libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev
RUN apt-get install -y libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev
RUN apt-get install -y ros-dashing-realsense-camera-msgs ros-dashing-realsense-ros2-camera

# Increase git repo buffer size (for cloning opencv via https)
# (based on https://stackoverflow.com/questions/15240815/git-fatal-the-remote-end-hung-up-unexpectedly)
RUN git config --global http.postBuffer 524288000

# Recommend install way for opencv
WORKDIR /root
RUN mkdir opencv_build
WORKDIR /root/opencv_build
RUN git clone https://github.com/opencv/opencv.git
RUN git clone https://github.com/opencv/opencv_contrib.git
WORKDIR /root/opencv_build/opencv
RUN mkdir build
WORKDIR /root/opencv_build/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..
RUN make -j $(nproc)
RUN make install

# Reset workdir to home-folder
WORKDIR /root

# Source again
RUN /bin/bash -c "source /opt/ros/dashing/setup.bash"

# Remove apt lists (for storage efficiency)
RUN rm -rf /var/lib/apt/lists/*

CMD ["bash"]
