#!/bin/bash
#compile script for c_ish one
#compiles sub game and creates executable named 'cish_one'
#defaults to using gcc, but uses clang as a fallback or if user supplies '-c' as argument to script. 
#use argumnet --help to bring up help info

if [ "$1" == "--help" ]; then
	echo "compile script for c_ish one"
	echo "compiles sub game and creates executable names 'cish_one"
	echo "defaults to using gcc, but uses clang as a fallback or if user supplies '-c' to script."
	echo
	echo "options:"
	echo " -c 	use clang instead of gcc"
	echo "--help 	prints this page then exits"
	exit
fi

#make list of all .c files to include. file paths are writtent to file 'src_files'
find  "${PWD}/src" -type f > "${PWD}/src_files"

#if gcc is not installed or user suppplies '-c' flag, then use clang, otherwise default to gcc
if  ! (gcc -v >/dev/null 2>&1) || [ "$1" == "-c" ]; then
	echo "using clang instead of gcc"
	if (clang -v >/dev/null 2>&1); then
		clang @src_files @flags   #'src_files' is list of all .c files to include. 'flags' is a file which list all compiler flags to use
	else
		echo "sorry, clang doesnt seem to be installed"
		exit
	fi
else 	
	if (gcc -v >/dev/null 2>&1); then
		echo "using gcc"
		gcc @src_files @flags 
	else
		echo "sorry, gcc doesnt seem to be installed"
		exit
	fi	
fi