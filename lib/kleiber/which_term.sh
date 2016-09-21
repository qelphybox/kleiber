#!/bin/bash

which_term(){
  term=$(ps -p $(ps -p $$ -o ppid=) -o args=);
  found=0;
  case $term in
    *gnome-terminal*)
      found=1
      echo "gnome-terminal"
      ;;
    *lxterminal*)
      found=1
      echo "lxterminal"
      ;;
    rxvt*)
      found=1
      echo "rxvt"
      ;;
    ## Try and guess for any others
    *)
      for v in '-version' '--version' '-V' '-v'
      do
          $term "$v" &>/dev/null && eval $term $v && found=1 && break
      done
      ;;
  esac
  # If none of the version arguments worked, try and get the
  # package version
  [ $found -eq 0 ] && echo "$term " $(dpkg -l $term | awk '/^ii/{print $3}')
}
