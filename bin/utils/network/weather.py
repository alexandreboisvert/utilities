#!/usr/bin/env python3
"""Get Weather from weather.gc.ca"""

# HTTP requests (easier than standard library)
import requests

# Parsing some simple XML
import xml.dom.minidom

# TODO This should be a setting in a configuration file...
# city URL for the XML
# Like: https://weather.gc.ca/rss/city/XXXXXXXXXXX.xml
city_url_xml = ""


def main():
    """Program Entrypoint"""
    response = requests.get(city_url_xml, headers={'User-Agent': 'mozilla'}, timeout=2)
    if response.status_code == 200:
        dom = xml.dom.minidom.parseString(response.text)
        entries = dom.getElementsByTagName("entry")
        print("MONTREAL WEATHER")
        for e in entries:
            print("  {}".format(e.getElementsByTagName("title")[0].firstChild.nodeValue))
    else:
        print("can't get weather from website, status code = {}".format(response.status_code))
    pass


if __name__ == "__main__":
    main()
