# Coursemate 

##Setup

1.Install Vagrant here https://www.vagrantup.com/downloads.html

2. Install VirtualBox here https://www.virtualbox.org/wiki/Downloads

3.clone the repo and cd into it.

4.Run `vagrant up`, take a while.

5. Run `vagrant ssh`.

you will be logged into the virtual box

6. `ls /vagrant`

7. bundle exec foreman start.

if erros, make sure redis is running, `sudo systemctl start redis.service`

Profit.