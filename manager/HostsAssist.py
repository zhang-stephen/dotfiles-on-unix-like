#-*-coding: utf-8-*-
#!/bin/python3

import requests, re, sys
from html.parser import HTMLParser

__all__ = ['get_ip_from_domain']

_src_url = r'https://{}.ipaddress.com/{}'

_headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 Edg/87.0.664.66'
}

_re_pattern = r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'

class ResponseHandler(HTMLParser):
    def __init__(self):
        super().__init__()
        self.ip = ''
        self.is_expected_ip = False

    def handle_data(self, data):
        if data == 'IPv4 Addresses':
            self.is_expected_ip = True
        
        if self.is_expected_ip and re.match(_re_pattern, data):
            self.ip = data
            self.is_expected_ip = False

def get_ip_from_domain(url: str):
    parts_of_url = url.split('.')
    url = '' if len(parts_of_url) <= 2 else url
    
    # target URL rule:
    # 1. XXXXX.yyy --> https://XXXXX.yyy.ipaddress.com/
    # 2. XXXXX.YYYYY.zzz --> https://YYYYY.zzz.ipaddress.com/XXXXX.YYYYY.zzz
    target_url = _src_url.format('.'.join(parts_of_url[-2:]), url)

    response = requests.get(target_url, headers = _headers)

    # HTML parsing
    parser = ResponseHandler()
    parser.feed(response.content.decode())
    parser.close()

    return parser.ip

if __name__ == '__main__':
    print(get_ip_from_domain(sys.argv[1]))

# EOF

