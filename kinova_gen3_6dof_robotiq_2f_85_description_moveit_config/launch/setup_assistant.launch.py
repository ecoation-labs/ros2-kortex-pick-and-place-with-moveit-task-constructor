from moveit_configs_utils import MoveItConfigsBuilder
from moveit_configs_utils.launches import generate_setup_assistant_launch


def generate_launch_description():
    moveit_config = MoveItConfigsBuilder("kinova_arm", package_name="kinova_gen3_6dof_robotiq_2f_85_description_moveit_config").to_moveit_configs()
    return generate_setup_assistant_launch(moveit_config)
