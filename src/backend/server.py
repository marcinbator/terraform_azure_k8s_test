from http.server import BaseHTTPRequestHandler, HTTPServer
import json
import os
from urllib.parse import urlparse

class SimpleHandler(BaseHTTPRequestHandler):
    def _set_cors_headers(self):
        """Ustaw nagłówki CORS na podstawie konfiguracji"""
        frontend_url = os.getenv('FRONTEND_URL', 'http://localhost:8081')
        
        parsed_url = urlparse(frontend_url)
        allowed_origin = f"{parsed_url.scheme}://{parsed_url.netloc}"
        
        self.send_header('Access-Control-Allow-Origin', allowed_origin)
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        self.send_header('Access-Control-Max-Age', '3600')
    
    def do_OPTIONS(self):
        """Obsłuż preflight requests dla CORS"""
        self.send_response(200)
        self._set_cors_headers()
        self.end_headers()
    
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json; charset=utf-8')
        self._set_cors_headers()
        self.end_headers()
        
        text_content = os.getenv('TEXT_CONTENT', 'Default message from server')
        frontend_url = os.getenv('FRONTEND_URL', 'http://localhost:8081')
        
        response_data = {
            "title": "hello world",
            "text": text_content,
            "frontend_url": frontend_url,
            "server_info": "Python HTTP Server with CORS support"
        }
        
        json_response = json.dumps(response_data, ensure_ascii=False)
        self.wfile.write(json_response.encode('utf-8'))

def run(server_class=HTTPServer, handler_class=SimpleHandler):
    server_address = ('', 8080)
    httpd = server_class(server_address, handler_class)
    
    httpd.serve_forever()

if __name__ == '__main__':
    run()