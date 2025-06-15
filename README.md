# docker_ros2dashing

*Unofficial* ROS2 dashing Dockerfile with some goodies.
Prebuild images can be found at [Dockerhub](https://hub.docker.com/r/maxkratz/ros2dashing).

[![Build Docker images](https://github.com/maxkratz/docker_ros2dashing/actions/workflows/build-and-push.yml/badge.svg)](https://github.com/maxkratz/docker_ros2dashing/actions/workflows/build-and-push.yml)


## Quickstart
After installing docker, just run the following command:

```sh
docker run -it maxkratz/ros2dashing:latest
```

## Dockerfile
The Dockerfile can be found at:
[https://github.com/maxkratz/docker_ros2dashing/blob/master/Dockerfile](https://github.com/maxkratz/docker_ros2dashing/blob/master/Dockerfile)


## What gets installed in this container?
Various packages are installed in this docker container:

* Some utility packages like git, wget, curl etc.
* [ROS2 dashing](https://index.ros.org/doc/ros2/Installation/Dashing/) (thats the whole point ...)
* [python3](https://www.python.org/) (+pip3 with various ros packages)
* [colcon](https://colcon.readthedocs.io/en/released/)
* [catkin](https://github.com/ros/catkin) (built from source)
* [yaml-cpp](https://github.com/jbeder/yaml-cpp) (built from source)
* [doxygen](http://http://doxygen.nl/)
* [cpplint](https://github.com/cpplint/cpplint)
* [googletest-suite](https://github.com/google/googletest) (built from source)
* [clang-format](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
* [opencv](https://opencv.org/) (built from source)
    * Only available with tag `opencv`.
* [intel-realsense packages](https://github.com/intel/ros2_intel_realsense)


## Issues & Contribution
If you find any problems, bugs or missing packages, feel free to open an [issue on github](https://github.com/maxkratz/docker_ros2dashing/issues).
