#!/bin/bash

<<<<<<< HEAD
=======
#-----------------------------------------------------------------
>>>>>>> origin/dev
# Nom du script : rpn.sh
# Description : Ce script lance une calculatrice RPN interactive
# Auteur : Aymen HAMDI
# Date de création : 25/11/2023
# Version : V1
<<<<<<< HEAD
#
# Usage : ./rpn.sh
=======
# Usage : ./rpn.sh
#-----------------------------------------------------------------
>>>>>>> origin/dev

set -eu

#Initialisation de la stack
stack=()

# Fonction qui affiche l'aide
function show_help {
<<<<<<< HEAD
    echo -e "Liste des commandes :\n"
    echo -e " \e[34mhelp\e[0m : Afficher l’aide"
    echo -e " \e[34mdump\e[0m : Afficher le contenu de la stack"
    echo -e " \e[34mdrop\e[0m : Effacer le contenu de la stack"
    echo -e " \e[34mexit, quit\e[0m : Quitter le programme"
    echo -e " \e[34mswap\e[0m : Intervertir les deux derniers éléments de la stack"
    echo -e " \e[34mdup\e[0m : Dupliquer la stack"
    echo -e " \e[34msum\e[0m : Faire la somme de toute la stack\n"
    echo -e " \e[31mOpérations arithmétiques\e[0m : +|add, -|sub, /|div, *|mul, sum\n"
}

# Fonction qui affiche le contenu de la stack
function dump {
    echo -e "Contenu de la pile :"
=======

    echo -e "\e[1m          AIDE\e[0m\n"
    echo -e "Liste des commandes :\n"
    echo -e " \e[34mhelp\e[0m : Afficher l’aide"
    echo -e " \e[34mclear\e[0m : Effacer l'historique des opérations"
    echo -e " \e[34mdump\e[0m : Afficher le contenu de la pile"
    echo -e " \e[34mdrop\e[0m : Effacer le contenu de la pile"
    echo -e " \e[34mswap\e[0m : Intervertir les deux derniers éléments de la pile"
    echo -e " \e[34mdup\e[0m : Dupliquer la pile"
    echo -e " \e[34mexit, quit\e[0m : Quitter le programme\n"
    echo -e "\e[31mOpérations arithmétiques\e[0m :\n\n + ou add (addition)\n - ou sub (soustraction)\n / ou div (division)"
    echo -e " * ou mul (multiplication)\n ** ou pow (puissance)\n % ou mod (modulo)\n sum (somme de toute la pile)\n"

}

# Fonction qui affiche le contenu de la stack
# Variables :
#   stack
#------------------------------------------------------------------
function dump {
    echo -e "\e[33m•••\e[0m Contenu de la pile :" >&1
>>>>>>> origin/dev
    printf "%s\n" "${stack[@]}"
}

# Fonction qui efface le contenu de la stack
<<<<<<< HEAD
function drop {
    stack=()
    echo "La pile a été vidée"
}

# Fonction qui intervertit les deux derniers éléments de la stack
=======
# Variables :
#   stack
#------------------------------------------------------------------
function drop {
    stack=()
    echo -e "\e[32m•••\e[0m La pile a été vidée" >&1
}

# Fonction qui intervertit les deux derniers éléments de la stack
# Variables :
#   stack
#   tmp (Variable de stockage temporaire)
#------------------------------------------------------------------
>>>>>>> origin/dev
function swap {
    
    local tmp=0

    if [ ${#stack[@]} -ge 2 ]; then
<<<<<<< HEAD
        tmp=${stack[-1]}
        stack[-1]=${stack[-2]}
        stack[-2]=$tmp
        echo "Éléments intervertis."
    else
        echo "Erreur : Il faut au moins deux éléments dans la stack pour utiliser swap." >&2
=======
        
        tmp=${stack[-1]}
        stack[-1]=${stack[-2]}
        stack[-2]=$tmp
        echo -e "\e[32m•••\e[0m Éléments intervertis." >&1
        
    else

        echo -e "\e[31m×××\e[0m Erreur : Il faut au moins deux éléments dans la pile pour utiliser swap" >&2

>>>>>>> origin/dev
    fi
}

# Fonction qui duplique la stack
<<<<<<< HEAD
function dup {
    stack+=("${stack[@]}")
    echo "La pile a été dupliquée"
}

# Fonction pour vérifier si la valeur saisie est un nombre
=======
# Variables:
#   stack
#------------------------------------------------------------------
function dup {
    stack+=("${stack[@]}")
    echo -e "\e[32m•••\e[0m La pile a été dupliquée" >&1
}

# Fonction pour vérifier si la valeur saisie est un nombre
# Variables :
#   stack
#   regex (Pattern regex)
#------------------------------------------------------------------
>>>>>>> origin/dev
function is_number {
    
    local regex='^[+-]?[0-9]+([.][0-9]+)?$'

    if [[ $1 =~ $regex ]]; then
        return 0
    else
<<<<<<< HEAD
        set +e
        return 1
=======

        set +e
        return 1
        
>>>>>>> origin/dev
    fi
}

# Fonction pour effectuer les opérations
<<<<<<< HEAD

=======
# Variables :
#   stack
#   operator
#   first_operand
#   second_operand
#   result
#------------------------------------------------------------------
>>>>>>> origin/dev
function calculate {

    if [ ${#stack[@]} -ge 2 ]; then

        local operator=$1
        local first_operand=${stack[-2]}
        local second_operand=${stack[-1]}

        local result=0

        # Gestion des opérations
        case "${operator}" in
            
<<<<<<< HEAD
            "+" | "add") result=$(bc <<< "$first_operand + $second_operand") ;;
            
            "-" | "sub") result=$(bc <<< "$first_operand - $second_operand") ;;
            
            "*" | "mul") result=$(bc <<< "$first_operand * $second_operand") ;;
            
            "/" | "div")

                if [ "$second_operand" -eq 0 ]; then
                    echo "Erreur: Division par zéro." >&2
                    return
                else
                    result=$(bc <<< "scale=5; $first_operand / $second_operand")
                fi
            ;;
=======
            "+" | "add") result=$(bc -l <<< "$first_operand + $second_operand") ;;
            
            "-" | "sub") result=$(bc -l <<< "$first_operand - $second_operand") ;;
            
            "*" | "mul") result=$(bc -l <<< "$first_operand * $second_operand") ;;

            "**" | "pow") result=$(bc -l <<< "$first_operand ^ $second_operand") ;;

            "%" | "mod")

                if [ "$(echo "$second_operand == 0" | bc -l 2>/dev/null)" -eq 1 ]; then
                    echo -e "\e[31m×××\e[0m Erreur: Division par zéro" >&2
                    
                    set +e
                    return 1

                else

                    result=$(bc -l <<< "$first_operand % $second_operand")

                fi

                ;;
            
            "/" | "div")

                if [ "$(echo "$second_operand == 0" | bc -l 2>/dev/null)" -eq 1 ]; then

                    echo -e "\e[31m×××\e[0m Erreur: Division par zéro" >&2

                    set +e
                    return 1

                else 

                    result=$(bc -l <<< "scale=3; $first_operand / $second_operand")

                fi

                ;;
>>>>>>> origin/dev

            "sum")

                for val in "${stack[@]}"; do
<<<<<<< HEAD
                    result=$(bc <<< "$result + $val")
                done
                stack=()
                
            ;;
    
            *)  echo "Erreur : Opérateur $operator non reconnu" ;;
=======
                    result=$(bc -l <<< "$result + $val")
                done
                stack=()
                
                ;;
    
            *)  echo -e "\e[31m×××\e[0m Erreur : Opérateur $operator non reconnu" >&2 ;;
>>>>>>> origin/dev

        esac

        # Met à jour la stack avec le résultat
        stack=("${stack[@]:0:${#stack[@]}-2}" "$result")
<<<<<<< HEAD
        echo "Résultat : $result"

    else
        echo "Erreur : Il faut au moins deux éléments dans la stack pour effectuer une opération." >&2
=======
        echo "--> Résultat : $result" >&1

    else
        echo -e "\e[31m×××\e[0m Erreur : Il faut au moins deux éléments dans la pile pour effectuer une opération" >&2
>>>>>>> origin/dev
    fi

}

<<<<<<< HEAD
=======
#Variable qui gère l'affiche de l'aide lors du premier lancement
>>>>>>> origin/dev
first_run=true

if $first_run; then

<<<<<<< HEAD
    echo -e "\e[31m╔═══╗╔═══╗╔═╗ ╔╗    ╔═══╗     ╔╗         ╔╗       ╔╗        \e[0m"
    echo -e "\e[31m║╔═╗║║╔═╗║║║╚╗║║    ║╔═╗║     ║║         ║║      ╔╝╚╗       \e[0m"
    echo -e "\e[31m║╚═╝║║╚═╝║║╔╗╚╝║    ║║ ╚╝╔══╗ ║║ ╔══╗╔╗╔╗║║ ╔══╗ ╚╗╔╝╔══╗╔═╗\e[0m"
    echo "║╔╗╔╝║╔══╝║║╚╗║║    ║║ ╔╗╚ ╗║ ║║ ║╔═╝║║║║║║ ╚ ╗║  ║║ ║╔╗║║╔╝"
    echo "║║║╚╗║║   ║║ ║║║    ║╚═╝║║╚╝╚╗║╚╗║╚═╗║╚╝║║╚╗║╚╝╚╗ ║╚╗║╚╝║║║ "
    echo -e "╚╝╚═╝╚╝   ╚╝ ╚═╝    ╚═══╝╚═══╝╚═╝╚══╝╚══╝╚═╝╚═══╝ ╚═╝╚══╝╚╝  \n\n"
    show_help
=======
    echo -e "╔═══╗╔═══╗╔═╗ ╔╗    ╔═══╗     ╔╗         ╔╗       ╔╗        "
    echo -e "║╔═╗║║╔═╗║║║╚╗║║    ║╔═╗║     ║║         ║║      ╔╝╚╗       "
    echo -e "║╚═╝║║╚═╝║║╔╗╚╝║    ║║ ╚╝╔══╗ ║║ ╔══╗╔╗╔╗║║ ╔══╗ ╚╗╔╝╔══╗╔═╗"
    echo -e "\e[31m║╔╗╔╝║╔══╝║║╚╗║║    ║║ ╔╗╚ ╗║ ║║ ║╔═╝║║║║║║ ╚ ╗║  ║║ ║╔╗║║╔╝\e[0m"
    echo -e "\e[31m║║║╚╗║║   ║║ ║║║    ║╚═╝║║╚╝╚╗║╚╗║╚═╗║╚╝║║╚╗║╚╝╚╗ ║╚╗║╚╝║║║ \e[0m"
    echo -e "\e[31m╚╝╚═╝╚╝   ╚╝ ╚═╝    ╚═══╝╚═══╝╚═╝╚══╝╚══╝╚═╝╚═══╝ ╚═╝╚══╝╚╝  \e[0m\n\n"
    show_help
    echo -e "Pour commencer, saisissez un à un deux chiffres ou deux nombres, suivis d'un opérateur :\n"
>>>>>>> origin/dev
    first_run=false
fi


# Boucle principale
while true; do
<<<<<<< HEAD

=======
    
>>>>>>> origin/dev
    read -rp "> " input

    case "$input" in

<<<<<<< HEAD
        "help")
            show_help
            ;;

        "dump")
            dump
            ;;

        "drop")
            drop
            ;;

        "exit" | "quit")
            echo "Fermeture..."
            exit 0
            ;;

        "swap")
            swap
            ;;

        "dup")
            dup
            ;;

        "+" | "add" | "-" | "sub" | "/" | "div" | "*" | "mul" | "sum")
=======
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
>>>>>>> origin/dev
            
            calculate "$input"
            ;;

<<<<<<< HEAD
	    "")
            continue
            ;;
    
    	*)
            is_number $input
            if [ $? -eq 0 ]; then
                stack+=("$input")
            else
                echo "Erreur : Entrée non valide." >&2
            fi
            ;;
=======
	    "") continue ;;
    
    	*)  

            is_number "$input"
            is_number_validation=$?
        
            if [ $is_number_validation -eq 0 ]; then
                stack+=("$input")
            else
                echo -e "\e[31m×××\e[0m Erreur : Entrée non valide" >&2
            fi
            ;;

>>>>>>> origin/dev
    esac
    
done

