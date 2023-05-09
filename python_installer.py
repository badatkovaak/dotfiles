#! usr/bin/python

import os

os.system("sudo mv /usr/bin/python3 /usr/bin/python3.9")
os.system("sudo apt update &&  sudo apt-get build-dep python3 -y && sudo apt-get install pkg-config -y")
os.system("cd ~/Downloads/python && ./configure --enable-optimizations")
a = input("you wish to proceed ?[y/N]")
if a == 'y' or a == 'Y':
    os.system("make\nmake test\nsudo make install")
