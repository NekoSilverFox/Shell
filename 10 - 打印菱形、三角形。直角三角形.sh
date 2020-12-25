#!/bin/bash

MAX_NO=0
echo -n "Enter Number between (3 to 9) : "
read MAX_NO

if ! [ $MAX_NO -ge 5 -a $MAX_NO -le 9 ] ; then
        echo "Error! Please enter number between 3 and 9"
        return
fi

clear

echo
echo -e "\033[32m---------- Zadanie 1 ----------\033[0m"
echo
for (( i=1; i<=MAX_NO; i++ )) 
do
    for (( s=MAX_NO; s>=i; s-- ))
    do
        echo -n " "
    done

    for (( j=1; j<=i; j++ ))
    do
        echo -n " *"
    done

    echo
done

for (( i=MAX_NO-1;i>=1;i-- ))    
do
    for (( s=i; s<=MAX_NO; s++ ))
    do
        echo -n " "
    done

    for (( j=1; j<=i; j++ ))
    do
        echo -n " *"
    done
    echo ""
done

echo
echo -e "\033[32m---------- Zadanie 2 ----------\033[0m"
echo
for (( i=1; i<=MAX_NO; i++ )) 
do
    for (( s=MAX_NO; s>=i; s-- ))
    do
        echo -n " "
    done

    for (( j=1; j<=i; j++ ))
    do
        echo -n " *"
    done

    echo
done

echo
echo -e "\033[32m---------- Zadanie 3 ----------\033[0m"
echo
for (( i=MAX_NO; i>=1; i-- ))    
do
    for (( s=i; s<=MAX_NO; s++ ))
    do
        echo -n " "
    done

    for (( j=1; j<=i; j++ ))
    do
        echo -n " *"
    done
    echo ""
done

echo
echo -e "\033[32m---------- Zadanie 4 ----------\033[0m"
echo
for (( i=MAX_NO;i>=1;i-- ))    
do
    for (( j=1; j<=i; j++ ))
    do
        echo -n "* "
    done

    echo
done

echo
echo -e "\033[32m---------- Zadanie 5 ----------\033[0m"
echo
for (( i=MAX_NO;i>=1;i-- ))    
do
    for (( s=i; s<=MAX_NO; s++ ))
    do
        echo -n "* "
    done

    echo
done

echo
echo