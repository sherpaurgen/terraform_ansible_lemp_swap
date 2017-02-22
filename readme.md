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
    
IN ansible configuration ansible.cfg make sure to have below lines to disbale ssh prompt for host key checks
[defaults]
host_key_checking = False


Two options - 
First is setting the environment variable ANSIBLE_HOST_KEY_CHECKING=False.

The second way to set it is to put it in an ansible.cfg file, and that's a really useful option because you can either set that globally (at system or user level, in /etc/ansible/ansible.cfg or ~/.ansible.cfg), or in an config file in the same directory as the playbook you are running.

To do that, make an ansible.cfg file in one of those locations, and include this:

[defaults]
host_key_checking = False
You can also set a lot of other handy defaults there, like whether or not to gather facts at the start of a play, whether to merge hashes declared in multiple places or replace one with another, and so on. There's a whole big list of options here in the Ansible docs.
