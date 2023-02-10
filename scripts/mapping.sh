#!/bin/bash
cd ../../..
cmds=("ros2 launch depthai_examples stereo_inertial_node.launch.py"
        "ros2 run serialport serialport_node"
	"ros2 launch imu_complementary_filter complementary_filter.launch.py"
	"ros2 run vins vins_node /home/tup/ros2_ws/src/TUP2023-Sentry-Framework/TUP2023-Sentry-Nav/VINS-Fusion-ROS2/config/oak-d-pro-400p/oak-rectfied.yaml"
	"ros2 run loop_fusion loop_fusion_node /home/tup/ros2_ws/src/TUP2023-Sentry-Framework/TUP2023-Sentry-Nav/VINS-Fusion-ROS2/config/oak-d-pro-400p/oak-rectfied.yaml"
	"ros2 launch octomap_server octomap_mapping.launch.xml"
	"ros2 launch vins vins_rviz.launch.xml"
	)
# OAK
for cmd in "${cmds[@]}";
do
echo Current CMD : "$cmd"
gnome-terminal -- bash -c "  source /opt/ros/galactic/setup.bash;cd $(pwd);source install/setup.bash;$cmd;exec bash;"
sleep 0.2
done
