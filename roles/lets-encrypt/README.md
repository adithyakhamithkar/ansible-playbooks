###URL used as a guide
https://vincent.composieux.fr/article/install-configure-and-automatically-renew-let-s-encrypt-ssl-certificate

###To start management ui
```
python /opt/letsencrypt-management-console/app.py
```

Notes:
```
ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
```
