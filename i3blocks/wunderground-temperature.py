#!/usr/bin/env python
# -*- coding: utf-8 -*-

import urllib2
import json
import sys
import HTMLParser
import os


if len(sys.argv) != 3:
    print "Wrong arguments! Should be ./wunderground-temperature.py API COUNTRY-CITY"
    sys.exit(1)

API=sys.argv[1]
COUNTRY_CITY=sys.argv[2]
COUNTRY_CITY=COUNTRY_CITY.split("-")
COUNTRY=COUNTRY_CITY[0]
CITY=COUNTRY_CITY[1]

#print "api:",API,"cn:",COUNTRY,"city:",CITY

CITY=CITY.replace(' ', '%20')

url='http://api.wunderground.com/api/'+API+'/geolookup/conditions/q/'+COUNTRY+'/'+CITY+'.json'
f = urllib2.urlopen('http://api.wunderground.com/api/'+API+'/geolookup/conditions/q/'+COUNTRY+'/'+CITY+'.json')
json_string = f.read()
parsed_json = json.loads(json_string)
location = parsed_json['location']['city']
temp_c = parsed_json['current_observation']['temp_c']
print "%s °C" % (temp_c)
f.close()
