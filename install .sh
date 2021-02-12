#!/bin/bash
apt-get install -y git &&
mkdir -p /home/sung/workspace &&
cd /home/sung/workspace &&
git clone https://github.com/tjdalsckd/OMG-Planner --recursive &&
conda create --name omg python=3.6.9 &&
conda activate omg &&
cd OMG-Planner &&
export OMG_HOME=$PWD &&
export VENV_OMG=~/anaconda3/envs/omg/bin/python3.6 &&
pip install -r requirements.txt &&
apt-get install libegl1-mesa-dev &&
apt-get install python-pyassimp &&
sudo apt-get install libassimp-dev &&
pip install pyassimp==4.1.3 &&

cd  $OMG_HOME &&
cd ycb_render &&
python setup.py develop &&
cd  $OMG_HOME &&
cd Sophus &&
mkdir build &&
cd build &&
cmake .. &&
make -j16 &&
sudo make install &&
cd  $OMG_HOME &&
cd layers &&
python setup.py install &&
cd  $OMG_HOME &&
cd orocos_kinematics_dynamics &&
cd sip-4.19.3 &&
python configure.py &&
make -j16; sudo make install &&
 
export ROS_PYTHON_VERSION=3 &&
cd ../orocos_kdl &&
mkdir build; cd build &&
cmake .. &&
make -j16; sudo make install &&
  
cd ../../python_orocos_kdl &&
mkdir build; cd build &&
cmake ..  -DPYTHON_VERSION=3.6.9 -DPYTHON_EXECUTABLE=$VENV_OMG/bin/python3.6 &&
make -j16;  cp PyKDL.so $VENV_OMG/lib/python3.6/site-packages/
