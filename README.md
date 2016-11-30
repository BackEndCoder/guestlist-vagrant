# Guestlist Vagrant Dev Box

Requires VirutialBox
Requires Vagrant

```bash
$ vagrant plugin install vagrant-vbguest
$ vagrant plugin install vagrant-env
```

Copy .env.example to .env and change its values to suit your local environment

```bash
$ cd ~/Boxes/guestlist
$ vagrant up
```

Due to windows having problems with rsync usage the nginx.conf file has to be injected manually into the guest. I call this 'guestlist' and place it /etc/nginx/sites-available/guestlist

```bash
sudo rm /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default
sudo ln -s /etc/nginx/sites-available/guestlist /etc/nginx/sites-enabled/guestlist
sudo /etc/init.d/nginx restart
```