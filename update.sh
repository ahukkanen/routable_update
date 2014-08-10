#!/bin/bash

#
# A simple upgrade script to update routable.org DNS records.
# You could also call the API straight away but this is an
# effor to keep the load for the service minimal, so this
# script checks first whether the current DNS records match
# the current IP and only if they do not match, this calls
# the API.
#
# AUTHOR: Antti Hukkanen <antti.hukkanen@mainiotech.fi>
# COPYRIGHT: Copyright (c) 2014 Antti Hukkanen, Mainio Tech Ltd.
#
# LICENSE: MIT, please see the LICENSE document.
#

############ START OF CONFIGURATION ##########

# The routable hostname
# Only the name part of the URL, i.e. ROUTABLE_HOST.routable.org
ROUTABLE_HOST=example

# The key associated with the routable domain
ROUTABLE_KEY=jI9wjFieowOIfjwoeiOIJEFOewifoj0w983fj0w38wg70we7gf

# The full routable domain for the $ROUTABLE_HOST
ROUTABLE_DOMAIN=$ROUTABLE_HOST".routable.org"

# Routable API URL
ROUTABLE_API_URL="http://routable.org/api.php?cmd=update&hostname=%s&key=%s"

# URL which only outputs the requesting client's IP address
IP_RESOLVE_URL="http://ipecho.net/plain"

# The server where we check for the current value of the routable
# domain's records.
TARGET_NAME_SERVER="ns1.routable.org"

########## END OF CONFIGURATION #########

# Resolve current external IP
IP="`wget -qO- $IP_RESOLVE_URL`"

# Resolve the IP that is stored in the name server for the domain.
cmd="nslookup $ROUTABLE_DOMAIN $TARGET_NAME_SERVER"
NSIP=$( $cmd | grep "Address" | tail -1 | cut -d ' ' -f 2 )

if [ "$IP" != "$NSIP" ] ; then
  # The name server has a different IP stored than what the current
  # IP is, so we'll need to update the record through the routable
  # API.
  url=$(printf $ROUTABLE_API_URL $ROUTABLE_DOMAIN $ROUTABLE_KEY)
  wget -q -O /dev/null $url
fi
