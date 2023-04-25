

#!/bin/bash
export ROS_HOME="/home/tup/ros2_ws"
cd /home/tup/ros2_ws
# 设置需要启动和监视的ros命令
declare -a commands=("ros2 launch depthai_examples stereo_inertial_node.launch.py"
	"ros2 launch imu_complementary_filter complementary_filter.launch.py"
	"ros2 run vins vins_node /home/tup/ros2_ws/src/TUP2023-Sentry-Framework/TUP2023-Sentry-Nav/VINS-Fusion-ROS2/config/oak-d-pro-400p/oak-rectfied.yaml"
	"ros2 run loop_fusion loop_fusion_node /home/tup/ros2_ws/src/TUP2023-Sentry-Framework/TUP2023-Sentry-Nav/VINS-Fusion-ROS2/config/oak-d-pro-400p/oak-rectfied.yaml"
	"ros2 launch grid_map_demos pointcloud2_to_gridmap_demo_launch.py"
	"ros2 launch nav2_bringup sentry_launch.py"
	"ros2 launch perception_detector armor_detector.launch.py")

# 定义函数来启动ros命令
start_commands() {
  for cmd in "${commands[@]}"
  do
	gnome-terminal -- bash -c "  source /opt/ros/galactic/setup.bash;cd $(pwd);source install/setup.bash;$cmd;exec bash;"
  done
}

# 定义函数来监视ros进程是否在运行
watch_commands() {
  while true
  do
    for cmd in "${commands[@]}"
    do
      echo $cmd
      process_name=$(echo $cmd | awk '{print $1}') # 提取进程名
      if ! pgrep -f "$cmd" > /dev/null
      then
        echo "$cmd 未在运行, 重新启动"
	gnome-terminal -- bash -c "  source /opt/ros/galactic/setup.bash;cd $(pwd);source install/setup.bash;$cmd;exec bash;"
      fi
    done
    sleep 10 # 设置睡眠时间，以便在下一次检查之前给进程足够的时间运行
  done
}

# 启动ros命令和监视进程
start_commands
watch_commands

