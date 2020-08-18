#!/bin/bash

if (( $# != 1 )); then
    echo "Illegal number of parameters"
    exit 1
fi

dir=$(pwd)
cd "${0%/*}" #change to script directory, https://stackoverflow.com/questions/6393551/what-is-the-meaning-of-0-in-a-bash-script

git clone . "$dir/$1"
FILES=$(git ls-files | grep "\(^\.\|/\.\)")


cd "$dir/$1"

rm -rf .git
rm new_project.sh
rm Readme.md
git init
git add .
git mv workflow-template.Rproj "$1.Rproj"
for x in $FILES; do git add -f "$x"; done
git commit -m "initial clone of template"

sed -i -e "s/PROJECT_NAME/$1/g" main.Rmd

