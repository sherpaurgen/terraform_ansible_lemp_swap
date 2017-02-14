File/Dir Structure
localhost roles # tree

    .
    ├── readme.md
    ├── site.yml
    └── webserver
        ├── files
        │   ├── createswap.sh
        │   └── nginxkeyadd.sh
        ├── handlers
        │   └── main.yml
        ├── tasks
        │   └── main.yml
        ├── templates
        │   ├── helloworld.conf.j2
        │   └── index.html.j2
        └── vars
            └── main.yml
            
    ansible-playbook --private-key=/root/key/privatekey.pem /etc/ansible/roles/site.yml
