#!/bin/bash

# Init env "domain_name" from arg
DOMAIN_NAME=$1

# Install nginx and certbot
sudo apt update
sudo apt install -y nginx certbot python3-certbot-nginx

# Make dirs
if [ ! -d "/etc/nginx/sites-available" ]; then
  sudo mkdir -p /etc/nginx/sites-available
fi

if [ ! -d "/etc/nginx/sites-enabled" ]; then
  sudo mkdir -p /etc/nginx/sites-enabled
fi

# Make config 80 for nginx
cat <<EOF | sudo tee /etc/nginx/sites-available/$DOMAIN_NAME
server {
    listen 80;
    server_name $DOMAIN_NAME;

    # Только для получения сертификата
    location / {
        root /var/www/html;
        index index.html index.htm;
    }
}
EOF

# Create symlink
sudo ln -sf /etc/nginx/sites-available/$DOMAIN_NAME /etc/nginx/sites-enabled/

# Apply changes
sudo systemctl reload nginx

# Deploy TLS certificate
sudo certbot --nginx -d $DOMAIN_NAME --agree-tos --email email@myservermail.com --non-interactive

# Add config 443 for nginx
cat <<EOF | sudo tee /etc/nginx/sites-available/$DOMAIN_NAME
server {
    listen 80;
    server_name $DOMAIN_NAME;

    # Редирект с HTTP на HTTPS
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name $DOMAIN_NAME;

    ssl_certificate /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem;

    location / {
        proxy_pass https://127.0.0.1:8006;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_ssl_verify off;
    }
}
EOF

# Update symlink
sudo ln -sf /etc/nginx/sites-available/$DOMAIN_NAME /etc/nginx/sites-enabled/

# Apply configuration
sudo systemctl reload nginx

# Autorenew certificates in CRON
echo "0 3 * * * root certbot renew --quiet" | sudo tee -a /etc/crontab