#!/usr/bin/env bash

# Install Nginx if it is not already installed
if ! [ -x "$(command -v nginx)" ]; then
    apt-get update
    apt-get -y install nginx
fi

# Create necessary directories if they do not exist
mkdir -p /data/web_static/{releases/test,shared}

# Create HTML file with Holberton School message
echo '<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>' > /data/web_static/releases/test/index.html

# Create symbolic link to the /data/web_static/releases/test/ folder
ln -sf /data/web_static/releases/test/ /data/web_static/current

# Set ownership of /data/ directory to the ubuntu user and group
chown -R ubuntu:ubuntu /data/

# Update Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static
sed -i '/listen 80 default_server;/a \\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# Restart Nginx
service nginx restart
