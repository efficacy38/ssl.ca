#!/bin/sh
sudo install -o root -g root -m 0775 new-root-ca.sh /usr/local/bin/new-root-ca
sudo install -o root -g root -m 0775 new-server-cert.sh /usr/local/bin/new-server-cert
sudo install -o root -g root -m 0775 sign-server-cert.sh /usr/local/bin/sign-server-cert
