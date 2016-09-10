#!/bin/bash

# 1. Retrieve variables
echo -n "What is the name of a project? "
read PROJECT_NAME

echo -n "What is the name of a project in snake_case? "
read PROJECT_NAME_SNAKE

MODULE_NAME="$PROJECT_NAME_SNAKE" | sed -r 's/(^|_)([a-z])/\U\2/g'

echo -n "What is the ip address of develop server? "
read DEVELOP_ADDRESS

echo -n "What is the address of project git repository? "
read REPO_URL

# 2. Rename project directory
cd ..
mv project_prototype "$PROJECT_NAME_SNAKE"
cd "$PROJECT_NAME_SNAKE"

# 3. Replace project-dependant information with new variables
CURRENT_PATH="$( pwd )"
DPATH="$CURRENT_PATH/*.rb"

find "$CURRENT_PATH" -type f -name '*rb' -or -name '*.haml' | while read f;
do
  if [ -f $f -a -r $f ]; then
   sed -i "s/Project_Prototype/$PROJECT_NAME/g" "$f"
   sed -i "s/project_prototype/$PROJECT_NAME_SNAKE/g" "$f"
   sed -i "s/ProjectPrototype/$MODULE_NAME/g" "$f"
   sed -i "s/develop_server_address/$DEVELOP_ADDRESS/g" "$f"
   sed -i "s/project_repo/$REPO_URL/g" "$f"
  else
   echo "Error: Cannot read $f"
  fi
done

# 4. Install necessary ruby version, create gemset
source "$HOME/.rvm/scripts/rvm"
rvm install 2.3.1
rvm use 2.3.1
rvm gemset create "$PROJECT_NAME_SNAKE"
rvm gemset use "$PROJECT_NAME_SNAKE"
gem install bundler

bundle install

# 5. Add version control
rm -rf .git
git init
git add --all
git commit -m 'Initial commit - project initialized from project_prototype'
git remote add origin "$REPO_URL"