#!/bin/bash

if [ $EUID != 0 ]; then
    sudo bash "$0" "$@"
    exit $?
fi

if [ -z "$SUDO_USER" ]; then
    current_user="$USER"
else
    current_user="$SUDO_USER"
fi

# Fonction pour afficher le menu
afficher_menu() {
    clear
    echo "Menu de Configuration pour les Nouvelles Installations Ubuntu"
    echo "1. Mise à jour des programmes"
    echo "2. Installer snap"
    echo "3. Installer Git"
    echo "4. Installer Java (17)"
    echo "5. Installer Discord"
    echo "6. Installer VSCode"
    echo "7. Installer IntellIj"
    echo "8 Installer PyCharm"
    echo "9. Installer DataGrip"
    echo "10. Installer MySQL"
    echo "11. Installer Python"
    echo "12. Installer Outils de Développement en C"
    echo "13. Installer Docker"
    echo "14. Installer VirtualBox"
    echo "15. Installer Node.js"
    echo "16. Installer CLion"
    echo "17. Installer FileZilla"
    echo "18. Afficher des commandes utiles"
    echo "19. Exécuter toutes les options"
    echo "0. Quitter"
    echo -n "Choisissez une option : "
}

mise_a_jour_des_programmes() {
    apt update -y
    apt upgrade -y
    apt autoremove -y
    echo "La mise à jour des programmes a été effectué avec succès."
}

installer_snap() {
    apt install snapd -y
    snap install snap-store
    echo "La mise à niveau des programmes a été effectué avec succès."
}

# Fonction pour activer l'affichage du numéro de semaine
afficher_utils() {
    clear
    echo "executer la commande suivante (hors du terminal root) -> gsettings set org.gnome.desktop.calendar show-weekdate true"
    echo "générer des clefs ssh de préférence : ssh-keygen -t ed25519 -C xxx -f ~/.ssh/xxx_ed25519"
    echo "envoyer la clef ssh-copy-id -i ~/.ssh/xxx_ed25519.pub user@adress"
    echo "fix : dual boot horaire (non root) -> timedatectl set-local-rtc 1"
    echo "fix : la carte graphique n'est pas utilisé -> apt install libnvidia-egl-wayland1"
    echo "fix : docker empeche certains connexion (utiliser l'ip 127.0.1.1 de préférence) : https://stackoverflow.com/questions/52225493/change-default-docker0-bridge-ip-address/52270884#52270884"
    echo "fix : sauvegarder les passphrases automatiquement avec 'AddKeysToAgent yes' dans le fichier config du dossier .ssh"
}

installer_datagrip() {
    snap install datagrip --classic
    echo "DataGrip a été installé avec succès."
}

installer_clion() {
    snap install clion --classic
    echo "CLion a été installé avec succès."
}

# Fonction pour installer Discord
installer_discord() {
    snap install discord 
    echo "Discord a été installé avec succès."
}

# Fonction pour installer Discord
installer_vs_code() {
    snap install code --classic
    echo "VSCode a été installé avec succès."
}


# Fonction pour installer IntelliJ (Community)
installer_intellij() {
    snap install intellij-idea-community --classic
    snap install intellij-idea-ultimate --classic
    echo "IntelliJ a été installé avec succès."
}

# Fonction pour installer PyCharm (Community)
installer_pycharm() {
    snap install pycharm-community --classic
    snap install pycharm-professional --classic
    echo "PyCharm a été installé avec succès."
}

# Fonction pour installer Java (OpenJDK 17)
installer_java() {
    apt install openjdk-17-jdk
    echo "Java (OpenJDK 17) a été installé avec succès."
}

installer_git() {
    apt install git-all
    echo "Git a été installé avec succès."
    echo "Configurer votre compte git avec les commandes suivantes :"
    echo "git config --global user.name \"username\""
    echo "git config --global user.email \"username\""
}

installer_my_sql() {
    apt install mysql-server
    echo "MySQL a été installé avec succès."
    echo "Doc pour l'installation et l'utilisation de MySQL sous linux : https://doc.ubuntu-fr.org/mysql"
    echo "Se connecter en SUDO : sudo mysql"
    echo "Créer un compte : CREATE USER 'nom_utilisateur_choisi'@'localhost' IDENTIFIED WITH mysql_native_password BY 'mot_de_passe_solide';"
    echo "Mettre les privilèges SUDO : GRANT ALL ON *.* TO 'nom_utilisateur'@'localhost';"
    echo "Reload les privilèges : FLUSH PRIVILEGES;"
    echo "Se connecter à votre compte : mysql -u nom_utilisateur -p -D votre_base"
}

installer_python() {
    apt install python3 python3-pip -y
    echo "Python et pip ont été installés avec succès."
}

installer_developpement_c() {
    apt install build-essential -y
    echo "Les outils de développement en C ont été installés avec succès."
}

installer_docker() {
    # Vérifier si la clé Docker est déjà installée
    if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
        # Si elle n'existe pas, alors l'ajouter
        apt install ca-certificates curl gnupg -y
        install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        chmod a+r /etc/apt/keyrings/docker.gpg
    fi

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update -y

    apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    
    systemctl start docker

    # add user to docker group
    gpasswd -a $USER docker
}

installer_virtualbox() {
    apt install virtualbox -y
    echo "VirtualBox a été installé avec succès."
}

installer_nodejs() {
    apt install nodejs npm -y
    echo "Node.js et npm ont été installés avec succès."
}

installer_fillezilla() {
    apt install filezilla -y
    echo "FileZilla a été installé avec succès."
}

executer_toutes_options() {
    mise_a_jour_des_programmes
    installer_snap
    installer_git
    installer_java
    installer_discord
    installer_vs_code
    installer_intellij
    installer_pycharm
    installer_datagrip
    installer_my_sql
    installer_python
    installer_developpement_c
    installer_docker
    installer_virtualbox
    installer_nodejs
    installer_clion
    installer_fillezilla
    mise_a_jour_des_programmes
    afficher_utils

    echo "Toutes les options ont été exécutées avec succès."

    read -p "Appuyez sur Entrée pour continuer..."

    exit
}

# Boucle principale
while true; do
    afficher_menu
    read option
    case $option in
        1) mise_a_jour_des_programmes ;;
        2) installer_snap ;;
        3) installer_git;;
        4) installer_java ;;
        5) installer_discord ;;
        6) installer_vs_code ;;
        7) installer_intellij ;;
        8) installer_pycharm ;;
        9) installer_datagrip;;
        10) installer_my_sql;;
        11) installer_python ;;
        12) installer_developpement_c ;;
        13) installer_docker ;;
        14) installer_virtualbox ;;
        15) installer_nodejs ;;
        16) installer_clion ;;
        17) installer_fillezilla ;;
        18) afficher_utils ;;
        19) executer_toutes_options ;;
        0) exit ;;
        *) echo "Option invalide. Veuillez choisir une option valide." ;;
    esac
    read -p "Appuyez sur Entrée pour continuer..."
done
