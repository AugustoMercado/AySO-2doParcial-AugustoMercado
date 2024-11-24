
Punto B: Ansible:


•Debemos tener dos VM, primero una que sera nuestro host y otra donde la utilizaremos para conectarnos a nuestro host.

-La primera maquina:
Nombre: vmAMN213 
ip:192.168.56.8

-La segunda maquina
Nombre: vmAnsDev213
ip:192.168.56.9

•Una vez iniciadas ambas vms.
en la vmAMN213 generamos una llave SSH:
-ssh-keygen
-Confirmar

Esta llave se encuentra en $HOME/.ssh/ id_rsa.pub
-cat .ssh/ id_rsa.pub (usamos cat para mostrar la llave y copiarla)

-Una vez obtenida la llave, lo que hacemos es copiarla en el host, dentro del archivo $HOME/.ssh/authorized.keys

-Luego debemos iniciar sesion desde vmAnsDev213 al host vmAnsDev213
 - ssh vagrant@192.1668.56.9

-Una vez dentro necesitaremos clonar el Repo: 
 - git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git

•Una vez dentro del host y copiado el repositorio, debemos modificar los arhivos Inventory y playbook

-Inventory solo debemos dejar el IP DEL HOST
192.168.56.9
- Playbook debemos modificar para que solo haga Update e install apache

---
- hosts: 
  - all
  tasks:
    - name: "Set WEB_SERVICE dependiendo de la distro"
      set_fact:
        WEB_SERVICE: "{% if ansible_facts['os_family'] == 'Debian' %}apache2
        {% elif ansible_facts['os_family'] == 'RedHat' %}httpd
        {% endif %}"

    - name: "Muestro nombre del servicio:"
      debug:
        msg: "nombre: {{ WEB_SERVICE }}"

    - name: "Run the equivalent of 'apt update' as a separate step"
      become: yes
      ansible.builtin.apt:
        update_cache: yes
      when: ansible_facts['os_family'] == "Debian"

    - name: "Instalando apache"
      become: yes
      package:
        name: "{{ item }}"
        state: present
      with_items:
        - "{{ WEB_SERVICE }}"

•Luego de guardar todo, debemos ejecutar ansible
 - ansible-playbook -i inventory playbook.yml

•Por ultimo, verificamos si apache se instalo correctamente:
 -sudo apt list --installed| grep apache

