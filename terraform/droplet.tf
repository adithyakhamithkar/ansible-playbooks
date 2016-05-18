resource "digitalocean_droplet" "web" {
    image = "ubuntu-16-04-x64"
    name = "web-3"
    region = "sgp1"
    size = "512mb"
    ssh_keys = ["69:ee:89:92:1c:8c:a2:a8:a0:44:08:29:e3:5a:5b:de"]

#  provisioner "local-exec" {
#    command = "sleep 30 && echo -e \"[webserver]\n web-03 ansible_ssh_host=${digitalocean_droplet.web.ipv4_address} ansible_ssh_user=root\" > ../inventory/template-env/hosts &&  ansible-playbook -i ../inventory/template-env/hosts ../commission-new-server.yml -e 'inventory=web-03'"
#  }
#}
