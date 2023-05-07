#! usr/bin/python

import os

os.system("sudo apt update\n sudo apt-get build-dep python3 -y\nsudo apt-get install pkg-config -y")
os.system("./configure --enable-optimizations")
a = input("you wish to proceed ?[y/N]")
if a == 'y' or a == 'Y':
    os.system("make\nmake test\nsudo make install")
