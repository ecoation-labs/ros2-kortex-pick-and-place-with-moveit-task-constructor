cmake_minimum_required(VERSION 3.8)
project(mtc_kinova_demo)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(moveit_task_constructor_core REQUIRED)
find_package(rclcpp REQUIRED)
find_package(moveit_ros_planning_interface REQUIRED)
find_package(graph_msgs REQUIRED)
find_package(rviz_visual_tools REQUIRED)
find_package(moveit_visual_tools REQUIRED) 

add_executable(minimal_mtc_tutorial src/minimal_mtc_tutorial.cpp)
ament_target_dependencies(minimal_mtc_tutorial moveit_task_constructor_core rclcpp)
target_include_directories(minimal_mtc_tutorial PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
$<INSTALL_INTERFACE:include>)
target_compile_features(minimal_mtc_tutorial PUBLIC c_std_99 cxx_std_17)  # Require C99 and C++17
install(TARGETS minimal_mtc_tutorial DESTINATION lib/${PROJECT_NAME})

add_executable(pick_and_place_mtc_tutorial src/pick_and_place_mtc_tutorial.cpp)
ament_target_dependencies(pick_and_place_mtc_tutorial moveit_task_constructor_core rclcpp)
target_include_directories(pick_and_place_mtc_tutorial PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
$<INSTALL_INTERFACE:include>)
target_compile_features(pick_and_place_mtc_tutorial PUBLIC c_std_99 cxx_std_17)  # Require C99 and C++17
install(TARGETS pick_and_place_mtc_tutorial DESTINATION lib/${PROJECT_NAME})

install(DIRECTORY launch DESTINATION share/${PROJECT_NAME})

ament_package()