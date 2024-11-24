•Debemos crear 3 particiones de 1G principales y 1 extendida 3G que contiene 2 lógicas +1.5G.

•creación 3 particiones principales (mismo proceso para las 3 primeras)
sudo fdisk /dev/sdc
n new
p partition
[enter]
[enter]
+1G

•creación 1 partición extendida
n new
e extended
[enter]
[enter]
+3G


•creación 2 particiones logicas dentro de extendida, hacer esto x2
n new
[enter]
+1G

-Swap de la 1ra particion

-sudo fdisk /dev/sdc
-t  (para cambiar el sistema)
-l  (para elegir la particion)
-L  (listado de fs)
-82 (el modo swap)
-w

-Destinamos la particion 1 como swap.
-sudo mkswap /dev/scd1

-Habilitamos la memoria swap
-sudo swapon /dev/sdc1

•Creamos PV, VG y LV:

-t  (cambiar el sistema de archivos de una partición, repetir para sdc2,sdc3,sdc5,sdc6)
-1  (elegimos partición 2,debemos hacer esto con la 3ra, 5ta y 6ta particion)
-L  (listado de fs)
-8e (elige fs linux lvm)
-w  (guardar)

-creamos volumen fisico.
sudo pvcreate /dev/sdc2 /dev/sdc3 /dev/sdc5 /dev/sdc6

/sudo pvs para ver los pv.

-creo volumen en grupo.
sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3

/sudo pvs para ver si se creo el grupo

sudo vgcreate vgDevelopers /dev/sdc5 /dev/sdc6

-creamos 3 volumenes logicos en vgDevelopers y 1 en vgAdmin.
- sudo lvcreate -L 1G vgDevelopers -n lvDevelopers
- sudo lvcreate -L 1G vgDevelopers -n lvTesters
- sudo lvcreate -L .9G vgDevelopers -n lvDevops

-sudo lvcreate -L 2G vgAdmin -n lvAdmin

/sudo lvs para comprobar 

-Formateo de LV y montaje:
formateo
 -sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevelopers
 -sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvTesters
 -sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevops
 -sudo mkfs.ext4 /dev/mapper/vgAdmin-lvAdmin

creamos punto de montaje
 -sudo mkdir /mnt/lvDevelopers
 -sudo mkdir /mnt/lvlvTesters
 -sudo mkdir /mnt/lvDevops
 -sudo mkdir /mnt/ldAdmin

montamos las particiones
 -sudo mount /dev/mapper/vgDevelopers-lvDevelopers /mnt/lvDevelopers
 -sudo mount /dev/mapper/vgDevelopers-lvTesters /mnt/lvTesters
 -sudo mount /dev/mapper/vgDevelopers-lvDevops /mnt/lvDevops
 -sudo mount /dev/mapper/vgAdmin-lvAdmin /mnt/lvAdmin

-Confirmamos que se levantaron las particiones 
 -df -h (muestra las particiones montadas y cuánto espacio tienen)
 -lsblk -f (da una vista más técnica de las particiones y volúmenes)

