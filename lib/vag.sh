#!/bin/bash

export GEMS_RKIS_DIR_PATH=${1}
case ${2} in
  'up' )
    vagrant up
    ;;
  'ups' )
    vagrant up && vagrant ssh -c "cd /vagrant && bundle install && ${*: 4} bundle exec rails s -p ${3}"
    ;;
  'upc' )
    vagrant up && vagrant ssh -c "cd /vagrant && bundle install && ${*: 4} bundle exec rails c -p ${3}"
    ;;
  'ssh' )
    vagrant ssh
    ;;
  'sshs' )
    vagrant ssh -c "cd /vagrant && bundle install && ${*: 4} bundle exec rails s -p ${3}"
    ;;
  'sshc' )
    vagrant ssh -c "cd /vagrant && bundle install && ${*: 4} bundle exec rails c"
    ;;
  'halt' )
    vagrant halt
    ;;
  'reload' )
    vagrant reload
    ;;
  'reloads' )
    vagrant reload && vagrant ssh -c "cd /vagrant && bundle install && ${*: 4} bundle exec rails s -p ${3}"
    ;;
  'reloadc' )
    vagrant reload && vagrant ssh -c "cd /vagrant && bundle install && ${*: 4} bundle exec rails c -p ${3}"
    ;;
  'destroy' )
    vagrant destroy --force
    ;;
  'provision' )
    vagrant provision
    ;;
esac
