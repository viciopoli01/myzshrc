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

alias cl="clear"
alias py="python3"
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
source /opt/ros/kinetic/setup.zsh

source /home/viciopoli/visensor_ws/devel/setup.zsh

alias pip=pip3.6


#
#   create VI Sensor Simulator workspace
#

visensor_create(){
    apt_pack=("liblapacke-dev" 
            "python-wstool"
            "python-catkin-tools"
            "protobuf-compiler"
            "libgoogle-glog-dev"
            "libopenexr-dev"
            "libopenblas-dev"
            "ros-kinetic-joy"
            "ros-kinetic-octomap-ros")
    pip_pack=("catkin_tools" "OpenEXR")

    if [ ! "~/visensor_ws" ]; then
        echo "a workspace in this position already exists"
    else
        for i in "${apt_pack[@]}";do
            check_apt_package "$i"
        done

        for i in "${pip_pack[@]}";do
            check_pip_package "$i"
        done
        
        mkdir -p ~/visensor_ws/src
        cd ~/visensor_ws 
        catkin init
        catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release

        cd ~/visensor_ws/src
        git clone git@github.com:catkin/catkin_simple
        git clone git@github.com:ethz-asl/rotors_simulator
        git clone git@github.com:ethz-asl/mav_comm
        git clone git@github.com:ethz-asl/eigen_catkin
        git clone git@github.com:ethz-asl/glog_catkin
        git clone git@github.com:ethz-asl/mav_control_rw
        git clone git@github.com:VIS4ROB-lab/visensor_simulator.git
        cd visensor_simulator
        git checkout devel
        cd ~/visensor_ws
        catkin build visensor_simulator

        source ~/visensor_ws/devel/setup.$0
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
        echo "$1 already installed"
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
