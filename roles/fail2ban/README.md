Manually ban an IP
sudo fail2ban-client -vvv set <jail_name> banip <IP>

Block a subnet from accessing SSH:
iptables -I INPUT -p tcp -s XXX.XXX.XXX.XXX/XX --dport ssh -j REJECT --reject-with tcp-reset

Block a subnet from accessing SMTP (mail):
iptables -I INPUT -p tcp -s XXX.XXX.XXX.XXX/XX --dport smtp -j REJECT --reject-with tcp-reset

Block an IP address from HTTP:
iptables -I INPUT -p tcp -s XXX.XXX.XXX.XXX --dport http -j REJECT

Block an IP address from FTP (using DROP):
iptables -I INPUT -p tcp -s XXX.XXX.XXX.XXX --dport ftp -j DROP
