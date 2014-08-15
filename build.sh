#!/bin/bash
# Add K to path and trigger build
ver=`cat ~/.kre/alias/default.alias`

# Credits for determining OS: http://stackoverflow.com/a/17072017/2166409 
if [ "$(uname)" == "Darwin" ]; then
    userdir="Users"       
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    userdir="home"
fi

add_to_path="/"$userdir"/"$USER"/.kre/packages/"$ver"/bin"
export PATH=$PATH:/usr/local/bin:$add_to_path
directory="./"
temp=$directory"project.json"
counter=0
# If unable to find project.json, keep going up a directory till project.json found
while [ ! -f $temp ]
do
	let counter=counter+1
	if [ $counter -gt 3 ]
	then
		break
	fi
	directory=$directory"../"
	temp=$directory"project.json"
done
kpm build $directory
