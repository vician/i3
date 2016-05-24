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
icon = parsed_json['current_observation']['icon']
symbol = "¿"
# Data from http://www.wunderground.com/graphics/conds/
# = Day =
# First line
if icon == "chanceflurries":
    symbol = "?☂❄"
elif icon == "chancerain":
    symbol = "?☂"
elif icon == "chancesleet":
    symbol = "?☂❄"
elif icon == "chancesnow":
    symbol = "?❄"
elif icon == "chancetstorms":
    symbol = "?ϟ"
# Second line
elif icon == "clear":
    symbol = "☼"
elif icon == "cloudy":
    symbol = "☁"
elif icon == "flurries":
    symbol = "☂❄"
elif icon == "fog":
    symbol = "☁"
elif icon == "hazy":
    symbol = "☁"
# Third line
elif icon == "mostlycloudy":
    symbol = "⛅"
elif icon == "mostlysunny":
    symbol = "⛅"
elif icon == "partlycloudy":
    symbol = "⛅"
elif icon == "partlysunny":
    symbol = "⛅"
elif icon == "rain":
    symbol = "⛆"
# Forth line
elif icon == "sleet":
    symbol = "☂❄"
elif icon == "snow":
    symbol = "❄"
elif icon == "sunny":
    symbol = "☼"
elif icon == "tstorms":
    symbol = "ϟ"
elif icon == "unknown":
    symbol = "?"
# = Night =
# First line
if icon == "nt_chanceflurries":
    symbol = "?☂❄"
elif icon == "nt_chancerain":
    symbol = "?☂"
elif icon == "nt_chancesleet":
    symbol = "?☂❄"
elif icon == "nt_chancesnow":
    symbol = "?❄"
elif icon == "nt_chancetstorms":
    symbol = "?ϟ"
# Second line
elif icon == "nt_clear":
    symbol = "☾"
elif icon == "nt_cloudy":
    symbol = "☁"
elif icon == "nt_flurries":
    symbol = "☂❄"
elif icon == "nt_fog":
    symbol = "☁"
elif icon == "nt_hazy":
    symbol = "☁"
# Third line
elif icon == "nt_mostlycloudy":
    symbol = "⛅"
elif icon == "nt_mostlysunny":
    symbol = "⛅"
elif icon == "nt_partlycloudy":
    symbol = "⛅"
elif icon == "nt_partlysunny":
    symbol = "⛅"
elif icon == "nt_rain":
    symbol = "⛆"
# Forth line
elif icon == "nt_sleet":
    symbol = "☂❄"
elif icon == "nt_snow":
    symbol = "☃"
elif icon == "nt_sunny":
    symbol = "☾"
elif icon == "nt_tstorms":
    symbol = "ϟ"
elif icon == "nt_unknown":
    symbol = "?"

print symbol, 
print " %s °C" % (temp_c)
print icon
f = open('/home/martin/.i3/weather_condition','w')
f.write(symbol)
f.write(" ")
f.write('%s' % temp_c)
f.write(" °C\n")
f.write(icon)
f.close()

#temp_string = "%s C" % (temp_c)
#icon_string = "%s" % (icon)
#
#if os.environ['BLOCK_BUTTON'] == "1":
#    os.system("notify-send '"+icon+" "+temp_string+"'")
