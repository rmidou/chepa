from http.server import HTTPServer, SimpleHTTPRequestHandler
import os

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory="/var/www/static", **kwargs)

if __name__ == "__main__":
    http_server = HTTPServer(('0.0.0.0', 3000), Handler)
    print("Serveur démarré sur le port 3000")
    http_server.serve_forever()