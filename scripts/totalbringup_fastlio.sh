#!/bin/bash
cd ../../..
cmds=("ros2 launch global_user autoaim_bringup.launch.py"
	"ros2 launch perception_detector armor_detector.launch.py"
	"ros2 launch livox_ros_driver2 msg_MID360_launch.py"
	"ros2 launch dll dll.xml"
	"ros2 launch imu_complementary_filter complementary_filter.launch.py"
        "ros2 launch fast_lio mapping.launch.py"
	"ros2 launch grid_map_demos pointcloud2_to_gridmap_demo_launch.py"
	"ros2 launch nav2_bringup sentry_launch.py"
	)
# OAK
for cmd in "${cmds[@]}";
do
echo Current CMD : "$cmd"
gnome-terminal -- bash -c "  source /opt/ros/galactic/setup.bash;cd $(pwd);source install/setup.bash;$cmd;exec bash;"
sleep 0.2
done
