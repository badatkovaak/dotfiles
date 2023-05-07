import os

software_list = ["git","vim","neofetch","flatpak","fish","htop"]
for i in software_list:
    os.system(f"sudo apt install {i} -y")
#os.system("curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish\n omf install l")
#os.system("flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo")
#os.system("curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh")





