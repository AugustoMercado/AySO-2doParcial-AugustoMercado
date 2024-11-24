punto c

•creamos varios directorios y archivos

-Crear una carpeta docker
 -mkdir -p "docker"

-crear una carpeta llamada appHomeBanking y dentro los archios index y contacto (ambos html)
 -mkdir - "appHomeBanking"
 -vim index.html
 -vim contacto.html

-creamos un archivo dockerfile donde debemos colocar

FROM nginx
COPY appHomeBanking /usr/share/nginx/html

 -from le dice a la imagen que use la base nginx para crear la imagen.
 -Copy copia todo el contenido de appHomeBanking dentro de nginx/html, porque ahi adentro esta lo que va a mostrar 
  el navegador cuando corra la imagen.

•Nos logueamos en docker hub
 -docker login [usuario]
 -contaseña: token generado en docker hub o la contraseña de la cuenta

•Una vez logueamos podemos crear la imagen
 -docker build -t [nombredeusuario]/2parcial-ayso:v1.0 .

 -docker image list(para saber que la imagen se construyo)

•una vez construida debemos subir la imagen al repositorio de docker hub.
 -docker push [nombredeusuario]/2parcial-ayso:v1.0
 
 -para ver si se subio con exito, docker > profile > my profile > respositories

•Una vez subida la imagen, debemos corre la imagen

 -docker run -d -p 8080:80 [nombredeusuario]/2parcial-ayso:v1:0

 -docker container ls (para corroborar que esta corriendo)

•Y para saber si de verdad corre, debemos ingresar a los siguientes link y si se muestra el contenido es que corren.

 - http://192.168.56.2:8080/index.html

 - http://192.168.56.2:8080/contacto.html
