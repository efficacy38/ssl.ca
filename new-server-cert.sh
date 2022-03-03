#!/bin/sh
##
##  new-server-cert.sh - create the server cert
##  Copyright (c) 2000 Yeak Nai Siew, All Rights Reserved. 
##

# Create the key. This should be done once per cert.
CERT=$1
if [ $# -ne 1 ]; then
        echo "Usage: $0 <www.domain.com>"
        exit 1
fi
if [ ! -f $CERT.key ]; then
	echo "No $CERT.key round. Generating one"
	openssl genrsa -out $CERT.key 4096
	echo ""
fi

# Fill the necessary certificate data
CONFIG="server-cert.conf"
cat >$CONFIG <<EOT
[ req ]
default_bits					= 4096
default_keyfile					= server.key
distinguished_name				= req_distinguished_name
string_mask						= nombstr

[ req_distinguished_name ]
countryName						= Country Name (2 letter code)
countryName_default				= TW
countryName_min					= 2
countryName_max					= 2
stateOrProvinceName				= State or Province Name (full name)
stateOrProvinceName_default		= Taiwan
localityName					= Locality Name (eg, city)
localityName_default			= Puli
0.organizationName				= Organization Name (eg, company)
0.organizationName_default		= Nation Chi Nan University
organizationalUnitName			= Organizational Unit Name (eg, section)
organizationalUnitName_default	= Pearl Lab
commonName						= Common Name (eg, www.domain.com)
commonName_default				= www.pearl.lab
commonName_max					= 64
emailAddress					= Email Address
emailAddress_default    		= efficacy38@gmail.com
emailAddress_max				= 40
EOT

echo "Fill in certificate data"
openssl req -new -config $CONFIG -key $CERT.key -out $CERT.csr

rm -f $CONFIG

echo ""
echo "You may now run ./sign-server-cert.sh to get it signed"
