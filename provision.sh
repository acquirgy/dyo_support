cd /vagrant &&
cp -n vagrant.yml.example vagrant.yml &&
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 &&
\curl -sSL https://get.rvm.io | bash -s stable &&
source ~/.bashrc &&
source ~/.bash_profile &&
rvm install ruby-2.1.3 &&
rvm use 2.1.3 &&
gem install bundler &&
bundle install
