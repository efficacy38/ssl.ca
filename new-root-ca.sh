#!/bin/sh
##
##  new-root-ca.sh - create the root CA
##  Copyright (c) 2000 Yeak Nai Siew, All Rights Reserved. 
##

# Create the master CA key. This should be done once.
if [ ! -f ca.key ]; then
	echo "No Root CA key round. Generating one"
	openssl genrsa -out ca.key 4096
	echo ""
fi

# Self-sign it.
CONFIG="root-ca.conf"
cat >$CONFIG <<EOT
[ req ]
default_bits					= 4096
default_keyfile					= ca.key
distinguished_name				= req_distinguished_name
x509_extensions					= v3_ca
string_mask			    		= nombstr

[ req_distinguished_name ]
countryName					= Country Name (2 letter code)
countryName_default				= TW
countryName_min					= 2
countryName_max					= 2
stateOrProvinceName				= State or Province Name (full name)
stateOrProvinceName_default			= Taiwan
localityName					= Locality Name (eg, city)
localityName_default				= Hsinchu
0.organizationName				= Organization Name (eg, company)
0.organizationName_default			= Cai-Sian Jhuang homelab
organizationalUnitName				= Organizational Unit Name (eg, section)
organizationalUnitName_default			= ldapmaster
commonName					= Common Name (eg, MD Root CA)
commonName_default				= csjhuang.net
commonName_max					= 64
emailAddress					= Email Address
emailAddress_default    			= efficacy38@gmail.com
emailAddress_max				= 40

[ v3_ca ]
basicConstraints				= critical,CA:true
subjectKeyIdentifier				= hash
authorityKeyIdentifier				= keyid:isuser
EOT
# authorityKeyIdentifier get error
# if authorityKeyIdentifier = keyid:always
# ref https://stackoverflow.com/questions/19163484/adding-authoritykeyidentifier-to-a-certrequest

echo "Self-sign the root CA..."
openssl req -new -x509 -days 3650 -config $CONFIG -key ca.key -out ca.crt

rm -f $CONFIG
