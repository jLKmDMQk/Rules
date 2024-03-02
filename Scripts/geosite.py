#!/usr/bin/env python3

from typing import List

import argparse

BASE_FILE_PATH = "./domain-list-community/data"

site_list: List[str] = []
include_list: List[str] = []


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("filename", help="the file to be download")
    args = parser.parse_args()

    include_list.append(args.filename.split('@')[0])
    category = args.filename.split('@')[-1]

    print(f"filename: {args.filename}")
    print(f"category: {category}")

    while len(include_list) > 0:
        filename = include_list.pop()
        with open(f"{BASE_FILE_PATH}/{filename}", "r") as f:
            r = f.read()
        lines = r.split('\n')
        for line in lines:
            if line.startswith('include:'):
                include_list.append(line.split(':')[-1].split(' ')[0])
            elif (not line.startswith('keyword:') and
                  not line.startswith('regexp:') and
                  not line.startswith('#') and
                  line.strip() != ''):

                if category == "all":
                    pass
                elif category == "@!cn":
                    if line.endswith(" @cn"):
                        continue
                else:
                    if line.endswith(" @!cn"):
                        continue

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
