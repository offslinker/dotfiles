#!/bin/sh

git fetch
for branch in `git branch -a | grep $1`; do
      git checkout $2 $branch
done
