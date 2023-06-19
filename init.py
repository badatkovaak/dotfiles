import os

os.system("mkdir ~/pr && mkdir ~/pr/langs && mkdir ~/pr/code")
software_list = ["git", "vim", "neofetch", "flatpak", "fish", "htop"]
for i in software_list:
    os.system(f"sudo apt install {i} -y")
os.system("flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo")
a = input(
    """choose what you want to install:
q - qutebrowser,
d - discord,
c - chromium,
v - vscode
""")
if a.count("q") == 1:
    os.system("flatpak install flathub org.qutebrowser.qutebrowser")
if a.count("d") == 1:
    os.system("flatpak install flathub com.discordapp.Discord")
if a.count("c") == 1:
    os.system("flatpak install flathub org.chromium.Chromium")
if a.count("v") == 1:
    os.system("flatpak install flathub com.visualstudio.code")
if input("Do you want to install omf ?[y/n]").lower() == 'y':
    os.system("curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish\n omf install l")
# os.system("curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh")
