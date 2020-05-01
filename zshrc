# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/viciopoli/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias emulator="/home/viciopoli/Android/Sdk/tools/emulator"
alias cl="clear"
alias py="python3"

#
# FLUTTER EXPORT
#
export PATH=~/flutter/bin:$PATH



#
# GOOGLE JAM COMPETITION
#

jam_template(){
    if [ -z "$*" ]; then
            echo "You need to provide the prj name."
    else
        if [ -e "$1.cpp" ]; then
            echo "File $1.cpp exists!"
            g++ -o $1 $1.cpp
            echo "Completed!"
            ./$1
        else
            echo "Creating $1.cpp"
            echo  "#include <bits/stdc++.h>" >> $1.cpp
            #echo  "#include <iostream>" >> $1.cpp
            #echo  "#include <string>" >> $1.cpp
            #echo  "#include <vector>" >> $1.cpp

            echo  "\n#define rep(a) for(int i=0; i<a;i++)" >> $1.cpp

            echo "using namespace std;" >> $1.cpp

            echo  "\n\nint main(){\n" >> $1.cpp
            echo "\tint T;" >> $1.cpp
            echo "\tcin>>T;" >> $1.cpp
            echo "\trep(T){\n" >> $1.cpp
            echo "\t\tint N;" >> $1.cpp
            echo "\t\tcin>>N;" >> $1.cpp
            echo "\t\tcout<<\"Case #\"<<(i+1)<<\": \"<<endl;" >> $1.cpp
            echo "\n\t}" >> $1.cpp
            echo "\treturn 0;\n}" >> $1.cpp
            
            
            echo "Completed!"
        fi
    fi
}


#
# OPENCV COMPILER HELPER
#

cmake_build(){
   cmake .
   make
}

init_opencv(){
    if [ -e "CMakeLists.txt" ]; then
        echo "File CMakeLists.txt exists!"
        cmake_build
        echo "Completed!"
    else
        if [ -z "$*" ]; then
            echo "You need to provide the prj name."
        else
            echo "Creating CMakeLists.txt"
            echo  "cmake_minimum_required(VERSION 2.8) \n
            project( $1 ) \n
            set(OpenCV_DIR /home/viciopoli/Installation/opencv/share/OpenCV) \n
            find_package( OpenCV REQUIRED ) \n
            include_directories( \${OpenCV_INCLUDE_DIRS} ) \n
            add_executable( $1.bin $1.cpp ) \n
            target_link_libraries( $1.bin \${OpenCV_LIBS} )" >> "CMakeLists.txt"
            echo "CMakeLists.txt sucessfully created"
            cmake_build
            echo "Completed!"
        fi
    fi
}

init_openpose(){
    if [ -e "CMakeLists.txt" ]; then
        echo "File CMakeLists.txt exists!"
        cmake_build
        echo "Completed!"
    else
        if [ -z "$*" ]; then
            echo "You need to provide the prj name."
        else
            echo "Creating CMakeLists.txt"
            echo  "cmake_minimum_required(VERSION 2.8) \n
                    project( $1 ) \n
                    list(APPEND CMAKE_MODULE_PATH "\${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules")

                    find_package(GFlags) \n
                    find_package(Glog) \n
                    find_package(OpenCV) \n
                    find_package(OpenPose REQUIRED) \n
                    include_directories( \${OpenPose_INCLUDE_DIRS} \${GFLAGS_INCLUDE_DIR} \${GLOG_INCLUDE_DIR} \${OpenCV_INCLUDE_DIRS} ) \n
                    add_executable( $1.bin $1.cpp ) \n
                    target_link_libraries( $1.bin \${OpenPose_LIBS} \${GFLAGS_LIBRARY} \${GLOG_LIBRARY} \${OpenCV_LIBS} )" >> "CMakeLists.txt"
            echo "CMakeLists.txt sucessfully created"

            mkdir -p cmake/Modules/
            cp ~/openpose/cmake/Modules/FindGFlags.cmake cmake/Modules/
            cp ~/openpose/cmake/Modules/FindGlog.cmake cmake/Modules/ 

            cmake_build
            echo "Completed!"
        fi
    fi
}


#
#   ROS
#
source /opt/ros/melodic/setup.zsh
source /home/viciopoli/visensor_ws/devel/setup.zsh
#source /home/viciopoli/vulcano_ws/devel/setup.zsh
#source /home/viciopoli/vibagcreator_ws/devel/setup.zsh
#source /home/viciopoli/Desktop/SemesterPRJ/cvi-slam_ws/devel/setup.zsh

#
#   create VI Sensor Simulator workspace
#

vulkano_create(){
    #"sudo apt-get install libglm-dev"
    #wget -qO - http://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo apt-key add -
    #sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-1.2.131-bionic.list http://packages.lunarg.com/vulkan/1.2.131/lunarg-vulkan-1.2.131-bionic.list
    #sudo apt update
    #sudo apt install vulkan-sdk
}

vibag_create(){
    if [ -d "$HOME/vibagcreator_ws" ]; 
    then
        echo "A workspace in this position already exists"
    else
        mkdir -p $HOME/vibagcreator_ws/src
        cd $HOME/vibagcreator_ws
        catkin init
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release

        cd src
        check_apt_package "liblapacke-dev"
        check_apt_package "doxygen"
        git clone git@github.com:catkin/catkin_simple
        git clone git@github.com:ethz-asl/eigen_catkin
        git clone git@github.com:ethz-asl/Schweizer-Messer.git

        git clone git@github.com:VIS4ROB-lab/vi_bag_tools.git

        cd ..

        catkin build

        source $HOME/vibagcreator_ws/devel/setup.$(ps -p $$ -oargs=)

    fi
}


cvi-slam_create(){
    if [ -d "$PWD/cvi-slam_ws" ]; 
    then
        echo "A workspace in this position already exists"
    else
        CURREND_DIR=$PWD

        mkdir -p $PWD/cvi-slam_ws/src

        SOURCE_PATH=$CURREND_DIR/cvi-slam_ws/devel/setup.$(ps -p $$ -oargs=)

        cd $CURREND_DIR/cvi-slam_ws
        catkin init
        catkin config --merge-devel

        cd src

        git clone git@github.com:catkin/catkin_simple.git
        git clone git@github.com:ethz-asl/eigen_catkin.git
        git clone git@github.com:ethz-asl/gflags_catkin.git
        git clone git@github.com:ethz-asl/glog_catkin.git
        git clone git@github.com:ethz-asl/eigen_checks.git
        git clone git@github.com:ethz-asl/opencv3_catkin.git
        git clone https://github.com/ethz-asl/protobuf_catkin.git
        git clone git@github.com:ethz-asl/ethzasl_brisk.git
        git clone git@github.com:ethz-asl/suitesparse.git        
        git clone git@github.com:ethz-asl/ceres_catkin.git
        git clone git@github.com:ethz-asl/opengv.git
        git clone git@github.com:ethz-asl/yaml_cpp_catkin.git
        git clone git@github.com:ethz-asl/catkin_boost_python_buildtool.git
        git clone git@github.com:ethz-asl/schweizer_messer.git        
        git clone git@github.com:ethz-asl/minkindr.git
        git clone git@github.com:ethz-asl/doxygen_catkin.git
        git clone git@github.com:ethz-asl/aslam_cv2.git
        git clone https://github.com/VIS4ROB-lab/robopt.git
        git clone https://github.com/patriksc/estd.git
        git clone https://github.com/VIS4ROB-lab/v4rl_param_lib.git
        git clone https://github.com/VIS4ROB-lab/cvi_slam_dumper_pr.git

        #
        # EDIT FILES
        #

        # eigen_catkin

        cd eigen_catkin
        git checkout htwfnc-eigen33
        sed -i '13d' CMakeLists.txt
        sed -i '12aset(EIGEN_MINIMUM_VERSION 3.3.7)' CMakeLists.txt
        sed -i '88d' CMakeLists.txt
        sed -i '87a\ \ \ \ URL http://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2' CMakeLists.txt
        if [ ${UDIST} = "bionic" ]
        then
            sed -i '46aset(USE_SYSTEM_EIGEN "OFF")' CMakeLists.txt
        fi
        cd ..

        # ceres_catkin

        cd ceres_catkin
        sed -i '6afind_package(eigen_catkin REQUIRED)' CMakeLists.txt
        sed -i '7afind_package(Eigen3 3.3.7 EXACT REQUIRED)' CMakeLists.txt
        sed -i '8a' CMakeLists.txt
        sed -i '13a\ \ <buildtool_depend>eigen_catkin</buildtool_depend>' package.xml
        sed -i '17a\ \ <build_depend>eigen_catkin</build_depend>' package.xml
        cd ..

        # opengv
        
        cd opengv
        sed -i '162d' CMakeLists.txt
        sed -i '161a\ \ \ \ \ \ find_package(eigen_catkin REQUIRED)' CMakeLists.txt
        sed -i '162a\ \ \ \ \ \ find_package(Eigen3 3.3.7 EXACT REQUIRED)' CMakeLists.txt
        sed -i '164d' CMakeLists.txt
        sed -i '163a\ \ \ \ \ \ set(EIGEN_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/../../devel/include/eigen3)' CMakeLists.txt
        sed -i '164a\ \ \ \ \ \ include_directories(${EIGEN_INCLUDE_DIR} ${EIGEN_INCLUDE_DIR}/unsupported)' CMakeLists.txt
        sed -i '167d' CMakeLists.txt
        sed -i '166a\ \ \ \ \ \ message(WARNING "Eigen: " ${EIGEN_INCLUDE_DIR})' CMakeLists.txt
        cd ..

        # robopt

        cd robopt
        git checkout -b fix/preintegration origin/fix/preintegration
        cd ..

        # schweizer_messer
        
        cd schweizer_messer
        cd sm_boost; touch CATKIN_IGNORE; cd ..;
        cd sm_common; touch CATKIN_IGNORE; cd ..;
        cd sm_deprecation; touch CATKIN_IGNORE; cd ..;
        cd sm_doc; touch CATKIN_IGNORE; cd ..;
        cd sm_eigen; touch CATKIN_IGNORE; cd ..;
        cd sm_kinematics; touch CATKIN_IGNORE; cd ..;
        cd sm_logging; touch CATKIN_IGNORE; cd ..;
        cd sm_matlab; touch CATKIN_IGNORE; cd ..;
        cd sm_matrix_archive; touch CATKIN_IGNORE; cd ..;
        cd sm_opencv; touch CATKIN_IGNORE; cd ..;
        cd sm_property_tree; touch CATKIN_IGNORE; cd ..;
        cd sm_python; touch CATKIN_IGNORE; cd ..;
        cd sm_random; touch CATKIN_IGNORE; cd ..;
        cd sm_timing; touch CATKIN_IGNORE; cd ..;
        cd sm_value_store; touch CATKIN_IGNORE; cd ..;
        cd ..

        # aslam_cv2

        cd aslam_cv2
        cd aslam_cv_calibration; touch CATKIN_IGNORE; cd ..;
        cd aslam_cv_detector; touch CATKIN_IGNORE; cd ..;
        cd aslam_cv_frames; touch CATKIN_IGNORE; cd ..;
        cd aslam_cv_geometric_vision; touch CATKIN_IGNORE; cd ..;
        cd aslam_cv_matcher; touch CATKIN_IGNORE; cd ..;
        cd aslam_cv_pipeline; touch CATKIN_IGNORE; cd ..;
        cd aslam_cv_tracker; touch CATKIN_IGNORE; cd ..;
        cd aslam_cv_triangulation; touch CATKIN_IGNORE; cd ..;
        cd aslam_cv_visualization; touch CATKIN_IGNORE; cd ..;
        cd ..

        # cvi_slam_dumper_pr
        
        cd $CURREND_DIR/cvi-slam_ws/src/cvi_slam_dumper_pr
        cd cvislam/conf
        unzip ORBvoc.txt.zip
        
        cd ..
        sed -i '31d' CMakeLists.txt
        sed -i '31d' CMakeLists.txt
        sed -i '30aset(EIGEN_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/../../../devel/include/eigen3)' CMakeLists.txt
        sed -i '31aset(EIGEN_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/../../../devel/include/eigen3)' CMakeLists.txt
        
        cd /trd_party/v4rl_mesh_based_mapping_lib/include/mesh_based_mapping/
        sed -i '31a#include <vector>' mesh_based_mapping.hpp
        
        cd $CURREND_DIR/cvi-slam_ws/src/cvi_slam_dumper_pr/cvislam/src/redundancy_detection/

        sed -i '2401d' redundancy_detector_base.cpp
        sed -i '2401acovopts.algorithm_type = ceres::CovarianceAlgorithmType::SPARSE_QR;' redundancy_detector_base.cpp

        #
        # build workspace
        #

        cd $CURREND_DIR/cvi-slam_ws/
        catkin build cvislam

        source $CURREND_DIR/cvi-slam_ws/devel/setup.$(ps -p $$ -oargs=)
        
    fi
}

visensor_create(){
    UDIST=$(lsb_release -sc)
    echo "Ubuntu release: ${UDIST}"
    
    joy="ros-kinetic-joy"
    octomap="ros-kinetic-octomap-ros"
    if [ ${UDIST} = "bionic" ]
    then
        joy="ros-melodic-joy"
        octomap="ros-melodic-octomap-ros"
    fi
    apt_pack=("liblapacke-dev" 
            "python-wstool"
            "python-catkin-tools"
            "protobuf-compiler"
            "libgoogle-glog-dev"
            "libopenexr-dev"
            "libopenblas-dev"
            $joy
            $octomap)
    pip_pack=("catkin_tools" "OpenEXR")

    if [ -d "$HOME/visensor_ws" ]; 
    then
        echo "A workspace in this position already exists"
    else
        for i in "${apt_pack[@]}";do
            check_apt_package "$i"
        done

        for i in "${pip_pack[@]}";do
            check_pip_package "$i"
        done
        
        mkdir -p $HOME/visensor_ws/src
        cd $HOME/visensor_ws 
        catkin init
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release

        cd $HOME/visensor_ws/src
        git clone git@github.com:catkin/catkin_simple
        git clone git@github.com:ethz-asl/rotors_simulator
        git clone git@github.com:ethz-asl/mav_comm
        git clone git@github.com:ethz-asl/eigen_catkin
        git clone git@github.com:ethz-asl/glog_catkin
        git clone git@github.com:ethz-asl/mav_control_rw
        git clone git@github.com:VIS4ROB-lab/visensor_simulator.git
        cd visensor_simulator
        if [ ${UDIST} = "bionic" ]
        then
            git checkout blender_2.8
            cd $HOME/visensor_ws

            sed -i '10,15 s/^/#/' $HOME/visensor_ws/src/mav_control_rw/mav_nonlinear_mpc/CMakeLists.txt
            sed -i '19 s/^/#/' $HOME/visensor_ws/src/mav_control_rw/mav_nonlinear_mpc/CMakeLists.txt

            catkin build
        else 
            git checkout devel
            cd $HOME/visensor_ws
            catkin build visensor_simulator
        fi

        source $HOME/visensor_ws/devel/setup.$(ps -p $$ -oargs=)

        echo "Terminated\n
        \n
        \t try to run: roslaunch visensor_simulator uav_vi_blender.launch"
    fi
}

check_apt_package(){
    if [ $(dpkg-query -W -f='${Status}\n' $1 | grep -c "install ok installed") -eq 0 ]; then
        echo "Installing $1"
        sudo apt-get -y install $1
    else
        echo "$1 already installed"
    fi
}

check_pip_package(){
    if [ $(pip list | grep -c $1) -eq 0 ]; then
        echo "Installing $1"
        pip install -U $1
    else
       ls echo "$1 already installed"
    fi
}


#
#   add cuda
#
#export PATH=/usr/local/cuda-10.2/bin:$PATH 
#export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64:$LD_LIBRARY_PATH


#
#	MY EXPERIMENTS
#

alias viciohome="ssh viciohome.ddns.net -L 8080:localhost:8081"

alias wake_vicio="wakeonlan 30:8d:99:f4:cf:94"
