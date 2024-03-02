#!/usr/bin/env python3

from typing import List

import requests
import argparse
import sys

BASE_URL = "https://raw.githubusercontent.com/v2fly/domain-list-community/master/data/"

site_list: List[str] = []
include_list: List[str] = []


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("filename", help="the file to be download")
    args = parser.parse_args()

    include_list.append(args.filename)

    while len(include_list) > 0:
        filename = include_list.pop()
        r = requests.get(BASE_URL + filename)
        if r.status_code != 200:
            print(f"Error: {r.status_code} url: {r.url}")
            sys.exit(1)
        lines = r.text.split('\n')
        for line in lines:
            if line.startswith('include:'):
                include_list.append(line.split(':')[-1].split(' ')[0])
            elif (not line.startswith('keyword:') and
                  not line.startswith('regexp:') and
                  not line.endswith(' @!cn') and
                  not line.startswith('#') and
                  line.strip() != ''):
                site = line.split(' ')[0]
                if len(site.split(':')) > 1:
                    if site.startswith('domain:'):
                        site = site.replace('domain:', 'DOMAIN-SUFFIX,')
                    elif site.startswith('full:'):
                        site = site.replace('full:', 'DOMAIN,')
                else:
                    site = f'DOMAIN-SUFFIX,{site}'
                site_list.append(site)

    print('\n'.join(site_list))


if __name__ == "__main__":
    main()
