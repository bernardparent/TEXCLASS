#!/bin/sh


filecheck="gitpull.sh"
texclasspublic="../TEXCLASS_github"
tmpfile="UHFGHnhKJLJGHGGHKJkljk_tmpfile_from_gitnewversion_public.txt"

command -v git >/dev/null 2>&1 || { echo "ERROR: gitnewversion_public.sh requires git but it is not installed.  Aborting." >&2; exit 1; }


if [ -f "$filecheck" ]; then
  echo "Checking that the current directory is the TEXCLASS main directory. [OK]";
else
  echo "ERROR: gitnewversion_public.sh must be run from the TEXCLASS main directory. Exiting.";
  exit 1
fi

if [ $# -eq 1 ]; then
  echo "Checking arguments: $1 specified as new version to commit. [OK]";
else 
  echo "ERROR: gitnewversion_public.sh needs one argument: the new version string. Exiting.";
  exit 1
fi

if [ -n "$(git show-ref --tags $1)" ]; then
  echo "Checking that version $1 is found on main TEXCLASS git. [OK]"; 
else
  echo "ERROR: version $1 not yet committed. Please commit version $1 to private TEXCLASS before committing it to the public TEXCLASS." ;
  exit 1
fi

latesttag=$(git describe --tags `git rev-list --tags --max-count=1`);

if [ "$1" = "$latesttag" ]; then
  echo "Checking that the latest tag is $1 on the main TEXCLASS git. [OK]";
else
  echo "ERROR: The tag given $1 is not set to the latest tag $latesttag on the main TEXCLASS git. Exiting.";
  exit 1
fi


if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: Changes or untracked files reported by git on main TEXCLASS. Please commit changes to the private TEXCLASS before committing them to the public TEXCLASS.";
  exit 1
else
  echo "Checking that there is no changes or untracked files reported by git on main TEXCLASS. [OK]";
fi


if [ -d "$texclasspublic" ]; then
  echo "Checking that the $texclasspublic directory exists. [OK]";
else
  echo "The directory $texclasspublic does not exist. Cloning it from github.";
  git clone https://bernardparent@github.com/bernardparent/TEXCLASS "$texclasspublic"
  if [ -d "$texclasspublic" ]; then
    echo "Checking that the  $texclasspublic directory has been created properly by git. [OK]";
  else
    echo "ERROR: The directory $texclasspublic does not exist. Exiting.";
    exit 1
  fi
fi


touch "$texclasspublic/$tmpfile"
if [ -f "$tmpfile" ]; then
  echo "ERROR: The current directory is $texclasspublic, and not the main TEXCLASS directory. Exiting.";
  rm -f "$texclasspublic/$tmpfile"
  exit 1
else
  echo "Checking that the current directory is not $texclasspublic. [OK]";
  rm -f "$texclasspublic/$tmpfile"
fi


if [ -d "$texclasspublic/.git" ]; then
  echo "Checking that the $texclasspublic/.git directory exists. [OK]";
else
  echo "ERROR: The directory $texclasspublic/.git does not exist. Exiting.";
  exit 1
fi

echo "Pulling latest public TEXCLASS from github..";
rm -rf "$texclasspublic"/* 
cd $texclasspublic
git checkout master
git reset --hard
git pull --tags origin master
if [ -n "$(git status --porcelain)" ]; then
  echo "ERROR: Changes or untracked files reported by git on $texclasspublic. Can not proceed. Exiting.";
  exit 1
  #echo "Changes or untracked files on $texclasspublic. This may not be a source of concern."
else
  echo "Checking that there is no changes or untracked files reported by git on $texclasspublic. [OK]";
fi
cd -


rm -rf "$texclasspublic"/* 
rm -f "$texclasspublic"/.*
cp -a * "$texclasspublic"
cp .* "$texclasspublic"
cd "$texclasspublic"
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
  git remote set-url origin git@github.com:bernardparent/TEXCLASS
  git add -A .
  git commit -a -m "$1" 
  git tag -d $1 > /dev/null 2>&1
  git tag -a $1 -m "$1"
  git push --tags origin master
else
 echo "ERROR: couldn't find $filecheck in $texclasspublic directory. Exiting."
 exit 1
fi


echo '[done]'


