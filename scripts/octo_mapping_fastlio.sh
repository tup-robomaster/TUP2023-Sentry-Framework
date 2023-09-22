#!/bin/bash
cd ../../..
cmds=(" ros2 launch livox_ros_driver2 rviz_MID360_launch.py"
	"ros2 launch imu_complementary_filter complementary_filter.launch.py"
	"ros2 launch fast_lio mapping.launch.py"
	"ros2 launch octomap_server octomap_mapping_fastlio.launch.xml"
	)
# OAK
for cmd in "${cmds[@]}";
do
echo Current CMD : "$cmd"
gnome-terminal -- bash -c "  source /opt/ros/galactic/setup.bash;cd $(pwd);source install/setup.bash;$cmd;exec bash;"
sleep 0.5
done
