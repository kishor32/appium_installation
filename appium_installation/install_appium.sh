#!/usr/bin/env bash
###Installing Appium on Mac OS
###Author:: Kishor Jyoti Sarma

function install_utils(){
  VAL=$(which $1)
  if [ ${VAL} == "" ]; then
     echo "installing "$1"..."
     install_if_not_present $1
  else
     echo $1" already installed"
fi
}

function install_if_not_present(){
   case "$1" in
  "brew" )ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   ;;
  "node" )brew install $1
   ;;
  "appium" )npm install -g $1
   ;;
  "carthage" )npm install -g $1
   ;;
   "appium-doctor" )npm install -g $1
   ;;
   esac
}

PACKAGES=(
 brew
 node
 carthage
 appium
 appium-doctor
)

for packages in ${PACKAGES[@]}
  do
   install_utils ${packages}
done

function set_java_home(){
 if [ -z ${JAVA_HOME} ]; then
    echo "Setting up java home.."
    echo "export JAVA_HOME=/Library/Java/Home">>~/.bash_profile
    echo "export JAVA_HOME;">>~/.bash_profile
    echo "export PATH=\${JAVA_HOME}/bin:\$PATH">>~/.bash_profile
 else
    echo "Java Home is already set"
 fi
}

function set_android_home(){
 if [ -z ${ANDROID_HOME} ]; then
    echo "Setting up android home.."
    echo "export ANDROID_HOME=/Users/"${USER}"/Library/Android/sdk">>~/.bash_profile
    echo "export PATH=\$PATH:\${ANDROID_HOME}/tools:\${ANDROID_HOME}/platform-tool">>~/.bash_profile
 else
    echo "Android Home is already set."
 fi
}

function check_xcode_command_line_tools(){
  if [ -d "$(xcode-select -p)" ]; then
      echo "Xcode command line tools are already installed"
  else
     echo "Installing Xcode command line tools..."
     xcode-select --install
   fi
}

function check_appium_installation(){
echo "checking appium health.."
sleep 2
source ~/.bash_profile
appium-doctor --android && appium-doctor --ios
}
check_xcode_command_line_tools
set_java_home
set_android_home
check_appium_installation