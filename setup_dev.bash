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
    echo "5. Installer IntelliJ"
    echo "6. Installer PyCharm"
    echo "7. Installer DataGrip"
    echo "8 Installer VSCode"
    echo "9. Installer Java (OpenJDK 17)"
    echo "1.. Installer Git"
    echo "11. Installer MySQL"
    echo "12. Exécuter toutes les options"
    echo "0. Quitter"
    echo -n "Choisissez une option : "
    
}

# Fonction pour activer l'affichage du numéro de semaine
activer_affichage_semaine() {
    echo "executer la commande suivante (hors du terminal root) -> gsettings set org.gnome.desktop.calendar show-weekdate true"
}

installer_datagrip() {
    snap install datagrip --classic
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
    installer_datagrip
    installer_vs_code
    installer_java
    installer_git
    installer_my_sql

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
        7) installer_datagrip ;;
        8) installer_vs_code ;;
        9) installer_java ;;
        10) installer_git ;;
        11) installer_my_sql ;;
        12) executer_toutes_options ;;
        0) exit ;;
        *) echo "Option invalide. Veuillez choisir une option valide." ;;
    esac
    read -p "Appuyez sur Entrée pour continuer..."
done
