#!/bin/bash

red="\e[31m"                    #Color variables to be used in the script                        
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
cyan="\e[36m"
endcolor="\e[0m"


printf $blue
figlet "Rot13"
printf $endcolor


function pathtest(){
read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please specify the path of the file you wish to encrypt/decrypt: $endcolor")" path
if [ -f $path ];
                then
                echo -e "$green[!] Path contains a file$endcolor\n"
		process
		else
                echo -e "$red[!] No file found in the specified path\n$endcolor"
                pathtest
fi

}

function process(){
read -p "$(echo -e "\n$cyan[?]$endcolor$yellow Please specify wheter you'd like to [$endcolor${red}E$endcolor$yellow]ncrypt or [$endcolor${green}D$endcolor$yellow]ecrypt the file contents: $endcolor")" file
read -p "$(echo -e "$cyan[?]$endcolor$yellow Please provide a name for the output file: $endcolor")" name
if [ -z $name ]
	then
	echo -e "$red[!] Name was not specified. Please specify a name" ; sleep 0.3
	process
	else
	echo -e "$green[+] Name registered ($endcolor$blue$name$endcolor$green)$endcolor" ; sleep 0.3 
fi
case $file in
E)
echo -e "$cyan[*]$endcolor$red File encryption was selected$endcolor"
echo -e "$cyan[+]$endcolor$blue Encrypting the file's contents as $name.encrypted.txt...$endcolor" ; sleep 0.3
cat $path | tr 'A-Za-z' 'N-ZA-Mn-za-m' > $name.encrypted.txt
echo -e "\n$cyan[*]$endcolor$yellow The file was encrypted with Rot13 as $endcolor$green$name.encrypted.txt$endcolor"
;;
D)
echo -e "$cyan[*]$endcolor$green File decryption was selected$endcolor\n"
echo -e "$cyan[+]$endcolor$blue Decrypting the file's contents as $name.decrypted.txt...$endcolor" ; sleep 0.3
cat $path | tr 'N-ZA-Mn-za-m' 'A-Za-z' > $name.decrypted.txt
echo -e "\n$cyan[*]$endcolor$yellow The file was decrypted with Rot13 as $endcolor$green$name.decrypted.txt$endcolor"
;;
*)
echo -e "$red[!] Invalid encryption/decryption input!$endcolor" ; sleep 0.3
process
;;
esac
read -p "$(echo -e "$cyan[?]$endcolor$yellow Would you like to encrypt/decyrpt another file? [Y/N] $endcolor")" choice
case $choice in
Y)
pathtest
;;
N)
echo -e "$green[*] Exiting...$endcolor" ; sleep 0.3
exit 1
;;

*)
echo -e "$red[!] Invalid input. Exiting...$endcolor" ; sleep 0.3
exit 1
;;
esac
}


pathtest
