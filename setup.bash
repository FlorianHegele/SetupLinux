#!/bin/bash

if [ $EUID != 0 ]; then
    sudo bash "$0" "$@"
    exit $?
fi

# Récupérer le nom de l'utilisateur qui a exécuté le script
if [ -z "$SUDO_USER" ]; then
    current_user="$USER"  # Utilisateur standard
else
    current_user="$SUDO_USER"  # Utilisateur avec sudo
fi

# Fonction pour afficher le menu
afficher_menu() {
    clear
    echo "Menu de Configuration pour les Nouvelles Installations Ubuntu"
    echo "1. Mise à jour des programmes"
    echo "2. Mise à niveau des programmes"
    echo "3. Activer l'affichage du numéro de semaine"
    echo "4. Installer Discord"
    echo "5. Installer IntelliJ (Community)"
    echo "6. Installer PyCharm (Community)"
    echo "7. Installer Java (OpenJDK 19)"
    echo "8. Installer Git"
    echo "9. Exécuter toutes les options"
    echo "0. Quitter"
    echo -n "Choisissez une option : "
    
}

# Fonction pour activer l'affichage du numéro de semaine
activer_affichage_semaine() {
    echo "executer la commande suivante (hors du terminal root) -> gsettings set org.gnome.desktop.calendar show-weekdate true"
}

# Fonction pour installer Discord
installer_discord() {
    snap install discord 
    echo "Discord a été installé avec succès."
}

# Fonction pour installer Discord
installer_vs_code() {
    snap install code --classic
    echo "Discord a été installé avec succès."
}


# Fonction pour installer IntelliJ (Community)
installer_intellij() {
    snap install intellij-idea-community --classic
    echo "IntelliJ (Community) a été installé avec succès."
}

# Fonction pour installer PyCharm (Community)
installer_pycharm() {
    snap install pycharm-community --classic
    echo "PyCharm (Community) a été installé avec succès."
}

# Fonction pour installer Java (OpenJDK 19)
installer_java() {
    #apt install openjdk-19-jdk
    echo "Java (OpenJDK 19) a été installé avec succès."
}

installer_git() {
    apt install git-all
    echo "Git a été installé avec succès."
}

mise_a_jour_des_programmes() {
    apt update
    echo "La mise à jour des programmes a été effectué avec succès."
}

mise_a_niveau_des_programmes() {
    apt upgrade
    echo "La mise à niveau des programmes a été effectué avec succès."
}

# Fonction pour exécuter toutes les options
executer_toutes_options() {
    mise_a_jour_des_programmes
    mise_a_niveau_des_programmes
    activer_affichage_semaine
    installer_discord
    installer_intellij
    installer_pycharm
    installer_java
    installer_git
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
        2) mise_a_niveau_des_programmes ;;
        3) activer_affichage_semaine ;;
        4) installer_discord ;;
        5) installer_intellij ;;
        6) installer_pycharm ;;
        7) installer_java ;;
        8) installer_git ;;
        9) executer_toutes_options ;;
        0) exit ;;
        *) echo "Option invalide. Veuillez choisir une option valide." ;;
    esac
    read -p "Appuyez sur Entrée pour continuer..."
done
