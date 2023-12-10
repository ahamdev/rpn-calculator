# RPN Calculator (Reverse Polish Notation)

This calculator written in bash is interactive. It is mainly based on the language bc.

## Installation

Mac OS:
If you don't have bc installed on your Mac, please try to install it with brew :
```bash
brew install bc
```
Linux :
It should be by default installed

## Usage

```bash
bash rpn.sh
```
OR
```bash
./rpn.sh
```

## Examples
```bash
╔═══╗╔═══╗╔═╗ ╔╗    ╔═══╗     ╔╗         ╔╗       ╔╗        
║╔═╗║║╔═╗║║║╚╗║║    ║╔═╗║     ║║         ║║      ╔╝╚╗       
║╚═╝║║╚═╝║║╔╗╚╝║    ║║ ╚╝╔══╗ ║║ ╔══╗╔╗╔╗║║ ╔══╗ ╚╗╔╝╔══╗╔═╗
║╔╗╔╝║╔══╝║║╚╗║║    ║║ ╔╗╚ ╗║ ║║ ║╔═╝║║║║║║ ╚ ╗║  ║║ ║╔╗║║╔╝
║║║╚╗║║   ║║ ║║║    ║╚═╝║║╚╝╚╗║╚╗║╚═╗║╚╝║║╚╗║╚╝╚╗ ║╚╗║╚╝║║║ 
╚╝╚═╝╚╝   ╚╝ ╚═╝    ╚═══╝╚═══╝╚═╝╚══╝╚══╝╚═╝╚═══╝ ╚═╝╚══╝╚╝  

> 10
> 20
> *
--> Résultat : 200
> dump
••• Contenu de la pile :
200
> 20
> swap
••• Éléments intervertis.
> dump
••• Contenu de la pile :
20
200
> 

```
## Author
Aymen H.

## License

[Apache](http://www.apache.org/licenses/)
