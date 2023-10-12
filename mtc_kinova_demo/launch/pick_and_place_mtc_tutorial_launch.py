from launch import LaunchDescription
from launch_ros.actions import Node
from moveit_configs_utils import MoveItConfigsBuilder


def generate_launch_description():
    moveit_config = MoveItConfigsBuilder("kinova_gen3_6dof_robotiq_2f_85_description").to_dict()

    # MTC Demo node
    pick_place_demo = Node(
        package="mtc_kinova_demo",
        executable="pick_and_place_mtc_tutorial",
        output="screen",
        parameters=[
            moveit_config,
        ],
    )

    return LaunchDescription([pick_place_demo])