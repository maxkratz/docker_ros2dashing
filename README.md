# docker_ros2dashing

*Unofficial* ROS2 dashing Dockerfile with some goodies.

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
* [ROS2](https://index.ros.org/doc/ros2/Installation/Dashing/) dashing (thats the whole point ...)
* [python3](https://www.python.org/) (+pip3 with various ros packages)
* [colcon](https://colcon.readthedocs.io/en/released/)
* [catkin](https://github.com/ros/catkin)
* [yaml-cpp](https://github.com/jbeder/yaml-cpp)
* [doxygen](http://http://doxygen.nl/)
* [cpplint](https://github.com/cpplint/cpplint)