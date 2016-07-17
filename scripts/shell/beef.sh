#!/bin/bash
clear
echo "======================================"
echo "          BeEF Installer              "
echo "======================================"
echo ""

echo "Atencao: Este script ira instalar um grande numero de dependencias incluindo o Ruby-RVM e suas dependencias."
echo ""
echo "Voce deseja continuar com a instalacao (Y/n)? "
read resp
if [ "$resp" = "n" ]
then
	echo "Bye!"
	exit
fi

  echo "Instalando os pacotes necessarios..."
  sudo apt-get update
  sudo apt-get -y install curl git
  sudo apt-get -y install build-essential openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion

  bash < <(gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && curl -sSL https://get.rvm.io | bash -s stable)

  echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc

  source ~/.bashrc
  source /usr/local/rvm/scripts/rvm

  rvm install 1.9.3
  rvm use 1.9.3 --default

  echo "Download BeEF.."
  git clone https://github.com/beefproject/beef.git
  cd beef

  echo "Instalando Ruby Gems"
  gem install bundler
  bundle install

  ./beef

  echo ""
  echo "=========================================="
  echo "          Instalacao Completa             "
  echo "=========================================="
  echo ""
