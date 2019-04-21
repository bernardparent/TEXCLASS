#!/bin/sh


filecheck="gitpull.sh"
latexstypublic="../LATEXSTY_github"
tmpfile="UHFGHnhKJLJGHGGHKJkljk_tmpfile_from_gitnewversion_public.txt"

command -v git >/dev/null 2>&1 || { echo "ERROR: gitnewversion_public.sh requires git but it is not installed.  Aborting." >&2; exit 1; }


if [ -f "$filecheck" ]; then
  echo "Checking that the current directory is the LATEXSTY main directory. [OK]";
else
  echo "ERROR: gitnewversion_public.sh must be run from the LATEXSTY main directory. Exiting.";
  exit 1
fi

if [ $# -eq 1 ]; then
  echo "Checking arguments: $1 specified as new version to commit. [OK]";
else 
  echo "ERROR: gitnewversion_public.sh needs one argument: the new version string. Exiting.";
  exit 1
fi

if [ -n "$(git show-ref --tags $1)" ]; then
  echo "Checking that version $1 is found on main LATEXSTY git. [OK]"; 
else
  echo "ERROR: version $1 not yet committed. Please commit version $1 to private LATEXSTY before committing it to the public LATEXSTY." ;
  exit 1
fi

latesttag=$(git describe --tags `git rev-list --tags --max-count=1`);

if [ "$1" = "$latesttag" ]; then
  echo "Checking that the latest tag is $1 on the main LATEXSTY git. [OK]";
else
  echo "ERROR: The tag given $1 is not set to the latest tag $latesttag on the main LATEXSTY git. Exiting.";
  exit 1
fi


if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: Changes or untracked files reported by git on main LATEXSTY. Please commit changes to the private LATEXSTY before committing them to the public LATEXSTY.";
  exit 1
else
  echo "Checking that there is no changes or untracked files reported by git on main LATEXSTY. [OK]";
fi


if [ -d "$latexstypublic" ]; then
  echo "Checking that the $latexstypublic directory exists. [OK]";
else
  echo "The directory $latexstypublic does not exist. Cloning it from github.";
  git clone https://bernardparent@github.com/bernardparent/LATEXSTY "$latexstypublic"
  if [ -d "$latexstypublic" ]; then
    echo "Checking that the  $latexstypublic directory has been created properly by git. [OK]";
  else
    echo "ERROR: The directory $latexstypublic does not exist. Exiting.";
    exit 1
  fi
fi


touch "$latexstypublic/$tmpfile"
if [ -f "$tmpfile" ]; then
  echo "ERROR: The current directory is $latexstypublic, and not the main LATEXSTY directory. Exiting.";
  rm -f "$latexstypublic/$tmpfile"
  exit 1
else
  echo "Checking that the current directory is not $latexstypublic. [OK]";
  rm -f "$latexstypublic/$tmpfile"
fi


if [ -d "$latexstypublic/.git" ]; then
  echo "Checking that the $latexstypublic/.git directory exists. [OK]";
else
  echo "ERROR: The directory $latexstypublic/.git does not exist. Exiting.";
  exit 1
fi

echo "Pulling latest public LATEXSTY from github..";
rm -rf "$latexstypublic"/* 
cd $latexstypublic
git checkout master
git reset --hard
git pull --tags origin master
if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: Changes or untracked files reported by git on $latexstypublic. Can not proceed. Exiting.";
  exit 1
  #echo "Changes or untracked files on $latexstypublic. This may not be a source of concern."
else
  echo "Checking that there is no changes or untracked files reported by git on $latexstypublic. [OK]";
fi
cd -


rm -rf "$latexstypublic"/* 
rm -f "$latexstypublic"/.*
cp -a * "$latexstypublic"
cp .* "$latexstypublic"
cd "$latexstypublic"
./removeproprietary.sh

echo ' '
echo 'Calling git status to check what changes will be pushed..'
echo ' '
git status
echo ' '
echo -n "Add these changes in new version $1 on PUBLIC GITHUB? (y/N)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo Yes
else
    echo No
    exit 1
fi


if [ -f "$filecheck" ]; then
  if git show-ref --tags $1 ; then
    echo ERROR: Version $1 already committed. Exiting.
    exit 1
  fi
  if git ls-remote --exit-code --tags origin $1 ; then
    echo ERROR: Version $1 already committed on github. Exiting.
    exit 1
  fi
  echo 'Committing and pushing files to github..'
  git add -A .
  git commit -a -m "$1" 
  git tag -d $1 > /dev/null 2>&1
  git tag -a $1 -m "$1"
  git push --tags origin master
else
 echo "ERROR: couldn't find $filecheck in $latexstypublic directory. Exiting."
 exit 1
fi


echo '[done]'


