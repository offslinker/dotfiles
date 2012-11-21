#!/bin/sh

git reset --hard
git checkout master
git pull
git checkout -b $1
