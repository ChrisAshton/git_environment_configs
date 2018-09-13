#!/bin/bash
printf "
                          ***
This script will make your bash environment a wonderful place to use Git
and it will change your life forever. But be warned: there's no script for
reversing the changes yet.
"

function change_bashrc {
  printf "copying git-completion.bash and git-prompt.sh into home folder \n\n"
  sleep 1
  if grep -q "git-modified" ~/.bashrc; then
    printf "It appears your .bashrc file has already been changed by this script\n\n"
    sleep 1
    printf "exiting\n\n"
    sleep 1
    return
  fi
  cp git* ~/
  printf "modifying .bashrc file\n\n"
  sleep 1
  cat cat_into_bashrc >> ~/.bashrc
  chmod 644 ~/.bashrc
  printf "bash modifications complete. Restarting bash shell\n\n"
  sleep 1
  . ~/.bashrc
}

function change_bash_profile {
  printf "copying git-completion.bash and git-prompt.sh into home folder\n\n"
  sleep 1
  if grep -q "git-modified" ~/.bash_profile; then
    printf "It appears your .bash_profile file has already been changed by this script\n\n"
    sleep 1
    printf "exiting\n\n"
    sleep 1
    return
  fi
  cp git* ~/
  printf "modifying .bash_profile\n\n"
  sleep 1
  cat cat_into_bashrc >> ~/.bash_profile && printf "# git-modified" >> ~/.bash_profile
  chmod 644 ~/.bash_profile
  printf "bash modifications complete. Restarting bash shell\n\n"
  sleep 1
  . ~/.bash_profile
}

function test_for_file {

  if [ -e ~/.bash_profile ]; then
    printf "found bash_profile \n\n"
    change_bash_profile
  fi

  if [ -e ~/.bashrc ]; then
    printf "found bashrc \n\n"
    change_bashrc
  fi

  if ! [ -e ~/.bashrc ] && ! [ -e ~/.bash_profile ]; then
    printf "you have no bash_profile or bashrc"
    touch ~/.bash_profile
    change_bash_profile
  fi
}

function ask_first {
  read -p "Would you like to continue (y) or (n): " REPLY
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    printf "Loading git configs \n\n"
  else
    printf "please start this script when you are ready\n\n"
    sleep 1
    printf "exiting \n\n"
    sleep 1
    return
  fi
}

function moveGitFiles() {
    cp .git-completion.bash ~/
    cp .git-prompt.sh ~/
}

ask_first
test_for_file
moveGitFiles
