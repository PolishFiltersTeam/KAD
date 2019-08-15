#!/bin/bash

# Sciezka to miejsce, w którym znajduje się skrypt
sciezka=$(dirname "$0")

cd $sciezka/..

if [ "$CI" = "true" ] ; then
    ost_plik=$(git diff-tree --no-commit-id --name-only -r master)
else
    ost_plik=$(git diff -z --name-only | xargs -0)
fi


if [[ "$ost_plik" == *"sections"* ]]; then
    if [[ "$lista" != *" KAD.txt"* ]] ;then
        lista+=" "KAD.txt
    fi
fi

if [ "$lista" ] ; then
    $sciezka/VICHS.sh $lista
    git checkout gh-pages
    ./scripts/VICHS.sh ./assets/other/kadfakewhitelist.txt ./assets/other/kadfakewhitelist_suplement.txt
    cd ..
    if [ "$CI" = "true" ] ; then
        git clone git@github.com:PolishFiltersTeam/KADhosts.git
    fi
    cd ./KADhosts
    ./scripts/VICHS.sh ./KADhosts.txt ./KADhosts_without_controversies.txt ./KADhole.txt ./KADhole_Lite.txt
fi
