#!/bin/bash

#-----------------------------------------------------------------
# Nom du script : rpn.sh
# Description : Ce script lance une calculatrice RPN interactive
# Auteur : Aymen HAMDI
# Date de création : 25/11/2023
# Version : V1
# Usage : ./rpn.sh
#-----------------------------------------------------------------

set -eu

#Initialisation de la stack
stack=()

# Fonction qui affiche l'aide
function show_help {

    echo -e "\e[1m          AIDE\e[0m\n"
    echo -e "Liste des commandes :\n"
    echo -e " \e[34mhelp\e[0m : Afficher l’aide"
    echo -e " \e[34mclear\e[0m : Effacer l'historique des opérations"
    echo -e " \e[34mdump\e[0m : Afficher le contenu de la pile"
    echo -e " \e[34mdrop\e[0m : Effacer le contenu de la pile"
    echo -e " \e[34mexit, quit\e[0m : Quitter le programme"
    echo -e " \e[34mswap\e[0m : Intervertir les deux derniers éléments de la pile"
    echo -e " \e[34mdup\e[0m : Dupliquer la pile"
    echo -e " \e[34msum\e[0m : Faire la somme de toute la pile\n"
    echo -e "\e[31mOpérations arithmétiques\e[0m :\n\n + ou add (addition)\n - ou sub (soustraction)\n / ou div (division)"
    echo -e " * ou mul (multiplication)\n ** ou pow (puissance)\n % ou mod (modulo)\n sum (somme)\n"
    echo -e "Pour commencer, saisissez un à un deux chiffres ou deux nombres, suivis d'un opérateur :\n"

}

# Fonction qui affiche le contenu de la stack
# Variables :
#   stack
#------------------------------------------------------------------
function dump {
    echo -e "••• Contenu de la pile :" >&1
    printf "%s\n" "${stack[@]}"
}

# Fonction qui efface le contenu de la stack
# Variables :
#   stack
#------------------------------------------------------------------
function drop {
    stack=()
    echo "••• La pile a été vidée" >&1
}

# Fonction qui intervertit les deux derniers éléments de la stack
# Variables :
#   stack
#   tmp (Variable de stockage temporaire)
#------------------------------------------------------------------
function swap {
    
    local tmp=0

    if [ ${#stack[@]} -ge 2 ]; then
        
        tmp=${stack[-1]}
        stack[-1]=${stack[-2]}
        stack[-2]=$tmp
        echo "Éléments intervertis."
        
    else

        echo "××× Erreur : Il faut au moins deux éléments dans la pile pour utiliser swap" >&2

    fi
}

# Fonction qui duplique la stack
# Variables:
#   stack
#------------------------------------------------------------------
function dup {
    stack+=("${stack[@]}")
    echo "••• La pile a été dupliquée" >&1
}

# Fonction pour vérifier si la valeur saisie est un nombre
# Variables :
#   stack
#   regex (Pattern regex)
#------------------------------------------------------------------
function is_number {
    
    local regex='^[+-]?[0-9]+([.][0-9]+)?$'

    if [[ $1 =~ $regex ]]; then
        return 0
    else

        set +e
        return 1
        
    fi
}

# Fonction pour effectuer les opérations
# Variables :
#   stack
#   operator
#   first_operand
#   second_operand
#   result
#------------------------------------------------------------------
function calculate {

    if [ ${#stack[@]} -ge 2 ]; then

        local operator=$1
        local first_operand=${stack[-2]}
        local second_operand=${stack[-1]}

        local result=0

        # Gestion des opérations
        case "${operator}" in
            
            "+" | "add") result=$(bc -l <<< "$first_operand + $second_operand") ;;
            
            "-" | "sub") result=$(bc -l <<< "$first_operand - $second_operand") ;;
            
            "*" | "mul") result=$(bc -l <<< "$first_operand * $second_operand") ;;

            "**" | "pow") result=$(bc -l <<< "$first_operand ^ $second_operand") ;;

            "%" | "mod")

                if [ "$(echo "$second_operand == 0" | bc -l 2>/dev/null)" -eq 1 ]; then
                    echo "××× Erreur: Division par zéro" >&2
                    
                    set +e
                    return 1

                else

                    result=$(bc -l <<< "$first_operand % $second_operand")

                fi

                ;;
            
            "/" | "div")

                if [ "$(echo "$second_operand == 0" | bc -l 2>/dev/null)" -eq 1 ]; then

                    echo "××× Erreur: Division par zéro" >&2

                    set +e
                    return 1

                else 

                    result=$(bc -l <<< "scale=3; $first_operand / $second_operand")

                fi

                ;;

            "sum")

                for val in "${stack[@]}"; do
                    result=$(bc -l <<< "$result + $val")
                done
                stack=()
                
                ;;
    
            *)  echo "××× Erreur : Opérateur $operator non reconnu" >&2 ;;

        esac

        # Met à jour la stack avec le résultat
        stack=("${stack[@]:0:${#stack[@]}-2}" "$result")
        echo "--> Résultat : $result" >&1

    else
        echo "××× Erreur : Il faut au moins deux éléments dans la pile pour effectuer une opération" >&2
    fi

}

#Variable qui gère l'affiche de l'aide lors du premier lancement
first_run=true

if $first_run; then

    echo -e "\n\e[31m╔═══╗╔═══╗╔═╗ ╔╗    ╔═══╗     ╔╗         ╔╗       ╔╗        \e[0m"
    echo -e "\e[31m║╔═╗║║╔═╗║║║╚╗║║    ║╔═╗║     ║║         ║║      ╔╝╚╗       \e[0m"
    echo -e "\e[31m║╚═╝║║╚═╝║║╔╗╚╝║    ║║ ╚╝╔══╗ ║║ ╔══╗╔╗╔╗║║ ╔══╗ ╚╗╔╝╔══╗╔═╗\e[0m"
    echo "║╔╗╔╝║╔══╝║║╚╗║║    ║║ ╔╗╚ ╗║ ║║ ║╔═╝║║║║║║ ╚ ╗║  ║║ ║╔╗║║╔╝"
    echo "║║║╚╗║║   ║║ ║║║    ║╚═╝║║╚╝╚╗║╚╗║╚═╗║╚╝║║╚╗║╚╝╚╗ ║╚╗║╚╝║║║ "
    echo -e "╚╝╚═╝╚╝   ╚╝ ╚═╝    ╚═══╝╚═══╝╚═╝╚══╝╚══╝╚═╝╚═══╝ ╚═╝╚══╝╚╝  \n\n"
    show_help
    first_run=false
fi


# Boucle principale
while true; do
    
    read -rp "> " input

    case "$input" in

        "help") show_help ;;

        "dump") dump ;;

        "drop") drop ;;

        "exit" | "quit")
            
            echo "Fermeture..." >&1
            exit 0
            ;;

        "swap") swap ;;

        "dup") dup ;;
        
        "clear") clear ;;

        "+" | "add" | "-" | "sub" | "/" | "div" | "*" | "mul" | "**" | "pow" | "%" | "mod" | "sum") 
            
            calculate "$input"
            ;;

	    "") continue ;;
    
    	*)  

            is_number "$input"
            is_number_validation=$?
        
            if [ $is_number_validation -eq 0 ]; then
                stack+=("$input")
            else
                echo "××× Erreur : Entrée non valide" >&2
            fi
            ;;

    esac
    
done

