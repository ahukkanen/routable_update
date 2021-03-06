Update script for routable.org
==============================

A simple upgrade script for the routable.org DynDNS service.

Check out the routable.org service, it's great:
http://routable.org/

This script tries to minimize the requests needed to make to their API,
saving some server load for the service itself. It does it by first
checking what the current DNS records hold for the domain name and
only calls the API if the current DNS records do NOT match with the
current IP of the machine.

This uses the following service for fetching the current IP:
http://ipecho.net/

Please note that you can use any service or even your own script to
fetch the current IP as long as the only output of the requested page
is the requesting client's IP address.

## Usage

For basic usage, all you need to do is to change the ROUTABLE_HOST and
ROUTABLE_KEY variables to match your own hostname and the corresponding
key for your hostname that was given to you when the hostname was created.

The script contains example values for both of these variables, so follow
those examples to set these variables. The example values match the API
example call from routable.org documentation.
 