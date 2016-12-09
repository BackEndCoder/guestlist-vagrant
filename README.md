# Guestlist Vagrant Dev Box

Requires VirtualBox
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
