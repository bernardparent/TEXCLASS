#!/bin/sh
filecheck="gitpull.sh"
if [ -f "$filecheck" ]; then
  git pull --tags origin master
else
 echo "gitpull must be run from the resume main directory."
fi

