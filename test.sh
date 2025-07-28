#!/bin/sh

wget https://files.pythonhosted.org/packages/86/59/a451d7420a77ab0b98f7affa3a1d78a313d2f7281a57afb1a34bae8ab412/seaborn-0.13.2.tar.gz
tar -xf seaborn-*
mkdir build; cd build; cmake ..; cpack -G RPM --config CPackSourceConfig.cmake
FILE=$(ls ./python*.src.rpm)
rpmbuild --rebuild $FILE
