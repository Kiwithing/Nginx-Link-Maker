# Nginx-Link-Maker

Do whatever you want with this. This is a little script to make my dev life a little easier. There's no warranty, and I'll fix it whenever I feel like it. Hopefully this will be useful to someone, somewhere. 

This script assumes your Nginx folder is set up at `/etc/nginx/` and websites are in `/var/www/html`.

## Setup

- Place `new-server-block` into `/etc/nginx/sites-available`
- Place `makelinks.sh` wherever you please
- Make sure `makelinks.sh` is executable
- Run `sudo makelinks.sh` or `sudo bash makelinks.sh` and follow the prompts.

## TODO List

  - [ ] Clean up code
  - [ ] Add a `breaklinks.sh` script to remove folders and disable Nginx sites
  - [ ] Adding a prompt to restart Nginx
  - [ ] Some failsafe measures
