#!/bin/sh
# https://unix.stackexchange.com/questions/14895/duplicate-entries-in-path-a-problem
addToPATH() {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

# Important for python pip packages installed with --user
addToPATH "$HOME/.local/bin"
