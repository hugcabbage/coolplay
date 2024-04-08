#!/usr/bin/env python3
import json
import sys

from zhconv_rs import zhconv


def convert_name(data):
    if isinstance(data, dict):
        for key, value in data.items():
            if key == 'name':
                data[key] = zhconv(value, 'zh-Hans').replace(' ', '').replace('┃', '|')
            else:
                convert_name(value)
    elif isinstance(data, list):
        for item in data:
            convert_name(item)


def cc_json(file):
    with open(file, encoding='utf-8') as f:
        data = json.load(f)
    convert_name(data)
    with open(file, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=4)


def cc_md(file):
    with open(file, encoding='utf-8') as f:
        data = f.read()
    data = zhconv(data, 'zh-Hans')
    with open(file, 'w', encoding='utf-8') as f:
        f.write(data)


def main():
    file = sys.argv[1]
    if file.endswith('.json'):
        cc_json(file)
    elif file.endswith('.md'):
        cc_md(file)


if __name__ == '__main__':
    main()
